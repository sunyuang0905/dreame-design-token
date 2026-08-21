import { readFileSync, writeFileSync } from 'node:fs'
import { dirname, join } from 'node:path'
import { fileURLToPath } from 'node:url'

const dir = dirname(fileURLToPath(import.meta.url))
const root = join(dir, '../../..')
const source = join(root, 'src/common/dreame/dreame-design-tokens.json')
const target = join(dir, '../lib/src/generated/tokens.g.dart')
const json = JSON.parse(readFileSync(source, 'utf8'))

function walk(node, path, out) {
  if (!node || typeof node !== 'object') return
  if (node.$value !== undefined || node.$modes) {
    out.set(path.join('.'), node)
    return
  }
  for (const [key, value] of Object.entries(node)) {
    if (!key.startsWith('$')) walk(value, [...path, key], out)
  }
}

const collections = {}
for (const name of ['Primitive', 'Semantic', 'Component']) {
  const entries = new Map()
  walk(json.collections[name].tokens, [], entries)
  collections[name] = entries
}

function rawValue(collection, path, mode) {
  const node = collections[collection].get(path)
  if (!node) throw new Error(`Missing token: ${collection}.${path}`)
  if (node.$modes) {
    const entry = node.$modes[mode] ?? node.$modes.Value ?? Object.values(node.$modes)[0]
    return { type: node.$type, value: entry.$value }
  }
  return { type: node.$type, value: node.$value }
}

function resolve(collection, path, mode, seen = new Set()) {
  const key = `${collection}.${path}.${mode}`
  if (seen.has(key)) throw new Error(`Circular token reference: ${key}`)
  seen.add(key)
  const entry = rawValue(collection, path, mode)
  const match = typeof entry.value === 'string' && entry.value.match(/^\{(Primitive|Semantic|Component)\.(.+)\}$/)
  return match ? resolve(match[1], match[2], mode, seen) : entry
}

function dartName(path) {
  const parts = path.split('.').map((part) =>
    part.replace(/^-([0-9]+)/, 'negative $1').replace(/[^A-Za-z0-9]+/g, ' '),
  )
  const words = parts.flatMap((part) => part.split(' ')).filter(Boolean)
  return words.map((word, index) => index === 0 ? word.toLowerCase() : word[0].toUpperCase() + word.slice(1)).join('')
}

function colorLiteral(value) {
  const hex = value.slice(1)
  if (hex.length === 6) return `Color(0xFF${hex.toUpperCase()})`
  if (hex.length === 8) return `Color(0x${hex.slice(6).toUpperCase()}${hex.slice(0, 6).toUpperCase()})`
  throw new Error(`Unsupported color: ${value}`)
}

function dartLiteral(entry) {
  if (entry.type === 'color') return { type: 'Color', value: colorLiteral(entry.value) }
  if (typeof entry.value === 'number') {
    return { type: 'double', value: Number.isInteger(entry.value) ? `${entry.value}.0` : String(entry.value) }
  }
  return { type: 'String', value: JSON.stringify(String(entry.value)) }
}

function emitClass(name, collection, mode) {
  const lines = [...collections[collection].keys()].map((path) => {
    const literal = dartLiteral(resolve(collection, path, mode))
    return `  static const ${literal.type} ${dartName(path)} = ${literal.value};`
  })
  return `abstract final class ${name} {\n${lines.join('\n')}\n}`
}

const output = `// GENERATED FILE. DO NOT EDIT.\n// Source: src/common/dreame/dreame-design-tokens.json\n\nimport 'package:flutter/material.dart';\n\n${emitClass('DreamePrimitiveTokens', 'Primitive', 'Value')}\n\n${emitClass('DreameSemanticLightTokens', 'Semantic', 'Light')}\n\n${emitClass('DreameSemanticDarkTokens', 'Semantic', 'Dark')}\n\n${emitClass('DreameComponentLightTokens', 'Component', 'Light')}\n\n${emitClass('DreameComponentDarkTokens', 'Component', 'Dark')}\n`

writeFileSync(target, output)
console.log(`wrote ${target}`)

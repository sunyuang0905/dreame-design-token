/**
 * Generate CSS variables from the Component → Semantic → Primitive token chain.
 * node generate-css-vars.mjs
 */
import { readFileSync, writeFileSync } from 'node:fs'
import { dirname, join } from 'node:path'
import { fileURLToPath } from 'node:url'

const dir = dirname(fileURLToPath(import.meta.url))
const json = JSON.parse(readFileSync(join(dir, 'dreame-design-tokens.json'), 'utf8'))

function cssName(parts) {
    return `--dreame-${parts.map((p) => {
        const value = String(p).toLowerCase()
        return value.startsWith('-') ? `negative-${value.slice(1)}` : value
    }).join('-')}`
}

function parseRef(value) {
    const m = String(value).match(/^\{([^}]+)\}$/)
    if (!m) return null
    const segs = m[1].split('.')
    return cssName(segs.slice(1))
}

function walk(node, path, out) {
    if (!node || typeof node !== 'object') return
    if (node.$type || node.$value !== undefined || node.$modes) {
        out.push({ path, node })
        return
    }
    for (const key of Object.keys(node)) {
        if (key.startsWith('$')) continue
        walk(node[key], path.concat(key), out)
    }
}

function formatLiteral(path, node) {
    const value = node.$value
    const type = node.$type
    if (type === 'color' || typeof value === 'string') {
        if (typeof value === 'string' && /[^A-Za-z0-9-]/.test(value) && !value.startsWith('#')) {
            return JSON.stringify(value)
        }
        return String(value)
    }
    if (type === 'float' || typeof value === 'number') {
        const kind = path[0]
        const sub = path[1]
        if (kind === 'space' || kind === 'radius' || kind === 'shadow' || (kind === 'font' && sub === 'size')) {
            return `${value}px`
        }
        return String(value)
    }
    return String(value)
}

function emitBlock(title, lines) {
    return `  /* ${title} */\n${lines.join('\n')}\n`
}

const primitive = []
walk(json.collections.Primitive.tokens, [], primitive)
const semantic = []
walk(json.collections.Semantic.tokens, [], semantic)
const component = []
walk(json.collections.Component.tokens, [], component)

const primLines = primitive.map(({ path, node }) => {
    return `  ${cssName(path)}: ${formatLiteral(path, node)};`
})

function modeLines(list, mode) {
    return list.map(({ path, node }) => {
        const entry = node.$modes[mode]
        const ref = parseRef(entry.$value)
        const value = ref ? `var(${ref})` : formatLiteral(path, { ...node, $value: entry.$value, $type: node.$type })
        return `  ${cssName(path)}: ${value};`
    })
}

const semLight = modeLines(semantic, 'Light')
const semDark = modeLines(semantic, 'Dark')
const compLines = modeLines(component, 'Light')

const out = `/* Generated from dreame-design-tokens.json. Do not edit by hand.
   node src/common/dreame/generate-css-vars.mjs
   Component → Semantic → Primitive. Dark mode overrides semantic references. */

page, :root {
${emitBlock('primitive', primLines)}
${emitBlock('semantic / light', semLight)}
${emitBlock('component', compLines)}}

page.theme-dark, :root.theme-dark, .theme-dark {
${emitBlock('semantic / dark', semDark)}}
`

writeFileSync(join(dir, 'css-vars.scss'), out)
console.log(`wrote css-vars.scss (${primitive.length} primitive, ${semantic.length} semantic, ${component.length} component)`)

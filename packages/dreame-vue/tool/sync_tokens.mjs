import { copyFileSync } from 'node:fs'
import { dirname, join } from 'node:path'
import { fileURLToPath } from 'node:url'

const dir = dirname(fileURLToPath(import.meta.url))
const root = join(dir, '../../..')

copyFileSync(
  join(root, 'src/common/dreame/css-vars.scss'),
  join(dir, '../styles/css-vars.scss'),
)
copyFileSync(
  join(root, 'src/common/dreame/dreame-design-tokens.json'),
  join(dir, '../tokens/dreame-design-tokens.json'),
)

console.log('synced Vue package tokens')

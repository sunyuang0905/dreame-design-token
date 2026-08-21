# Shadow Primitive

Shadow 使用两条光影轨道、四档尺寸。当前版本仅收录 Primitive 原子值；设计侧对应 8 个 Figma Effect Style。

| Effect Style | Color | X | Y | Blur | Spread |
|---|---:|---:|---:|---:|---:|
| `shadow/center/xs` | `blackAlpha/6` | 0 | 0 | 2 | 0 |
| `shadow/center/sm` | `blackAlpha/8` | 0 | 0 | 8 | 0 |
| `shadow/center/md` | `blackAlpha/10` | 0 | 0 | 16 | 0 |
| `shadow/center/lg` | `blackAlpha/12` | 0 | 0 | 32 | 0 |
| `shadow/soft/xs` | `blackAlpha/10` | 0 | 2 | 6 | -2 |
| `shadow/soft/sm` | `blackAlpha/12` | 0 | 4 | 12 | -4 |
| `shadow/soft/md` | `blackAlpha/16` | 0 | 8 | 24 | -8 |
| `shadow/soft/lg` | `blackAlpha/24` | 0 | 12 | 40 | -12 |

## Primitive 路径

- `Primitive.color.blackAlpha.6 / 10 / 24`
- `Primitive.shadow.offset.x.0`
- `Primitive.shadow.offset.y.0 / 2 / 4 / 8 / 12`
- `Primitive.shadow.blur.2 / 6 / 8 / 12 / 16 / 24 / 32 / 40`
- `Primitive.shadow.spread.0 / -2 / -4 / -8 / -12`

Center 轨用于 Widget 与卡片等平面悬浮；Soft 轨用于弹窗、面板和 Toast 等具有空间层级的界面元素。

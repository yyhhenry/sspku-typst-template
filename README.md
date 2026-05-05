# SSPKU Typst Template

北京大学软件与微电子学院通用 Typst 模板，适用于课程报告、读书报告、实验报告等多种文档类型。

## 特性

- 预设中文排版规范（宋体正文、黑体标题、首行缩进等）
- 自动生成页眉、页脚页码、标题页
- 中英文双语参考文献支持（GB/T 7714-2015 格式）
- 图表公式按章节自动编号
- 中文字号体系（初号至小七）

## 项目结构

```
sspku-typst-template/
├── lib.typ              # 统一导出入口
├── main.typ             # 示例文档（可直接修改使用）
├── ref.bib              # 示例参考文献
└── src/
    ├── fonts.typ        # 字号、字体族、颜色定义
    ├── styles.typ       # 排版规则与 sspku-document 函数
    └── references.typ   # 中英文双语参考文献处理
```

所有导出均通过 `lib.typ` 统一提供：

| 导出名 | 说明 |
|--------|------|
| `sspku-document` | 文档包装函数（页眉、页脚、标题页、章节编号） |
| `references` | 中英文双语参考文献 |
| `cn-font-size` | 中文字号字典（初号至小七） |
| `font-family` | 字体族字典（宋体、楷体、黑体、等宽及英文别名） |
| `font-color` | 预设颜色字典 |
| `ind` | 手动缩进，等价于 `h(2em)` |

## 使用方式

### 方式一：Fork 后直接使用

Fork 本仓库，直接修改 `main.typ` 即可开始编写。所有报告放在同一仓库中便于管理。

### 方式二：作为 Git Submodule 引用

```bash
git submodule add https://github.com/yyhhenry/sspku-typst-template.git
```

然后在你的 `.typ` 文件中导入：

```typst
#import "sspku-typst-template/lib.typ": cn-font-size, font-color, font-family, ind, references, sspku-document
```

具体用法参照 `main.typ`，其中包含了完整的文档结构、参考文献引用及编译命令。

### 安装字体（推荐）

安装 [typst-common-fonts](https://github.com/yyhhenry/typst-common-fonts) 以使用推荐的字体列表。

## 许可

MIT License

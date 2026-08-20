#import "@preview/cuti:0.2.1": show-cn-fakebold

#import "fonts.typ": cn-font-size, font-color, font-family

/// 中文段落缩进宽度。模板已通过 show 规则自动缩进，仅在图表标题、
/// 表格单元格等自动缩进失效的位置手动使用。
#let ind = h(2em)

/// 零高度的空段落。Typst 中首行缩进只作用于「前面有段落」的段落，
/// 因此在图表、代码块、列表等块级元素后插入它，使紧随其后的正文恢复缩进。
#let fakepar = context {
  let b = par[#box()]
  let t = measure(b + b)
  b
  v(-t.height)
}

/// 首行缩进规则：设置 2em 缩进，并在各类块级元素后补 `fakepar`，
/// 同时统一图（题在下）、表（题在上）、代码块（题在下）的题注位置。
#let indent-rules(body) = {
  set par(first-line-indent: 2em)
  show figure.where(kind: image): it => {
    rect(stroke: none)[
      #it.body
      #v(-0.5em)
      #it.caption
    ]
    fakepar
  }
  show figure.where(kind: table): it => {
    rect(stroke: none)[
      #it.caption
      #v(-0.5em)
      #it.body
    ]
    fakepar
  }
  show figure.where(kind: raw): it => {
    rect(stroke: none)[
      #it.body
      #v(-0.5em)
      #it.caption
    ]
    fakepar
  }
  show raw.where(block: true): it => {
    text(font: font-family.等宽)[#it]
    fakepar
  }
  show math.equation.where(block: true): it => {
    it
    fakepar
  }
  set list(indent: 2em)
  set enum(indent: 2em)
  show list: it => {
    it
    fakepar
  }
  show enum: it => {
    it
    fakepar
  }
  show terms: it => {
    it
    fakepar
  }
  show heading: it => {
    it
    fakepar
  }

  body
}

/// 重置图、表、代码块与公式的编号计数器，用于实现按章编号。
#let re-index = {
  counter(figure.where(kind: image)).update(0)
  counter(figure.where(kind: table)).update(0)
  counter(figure.where(kind: raw)).update(0)
  counter(math.equation).update(0)
}

/// 引用与编号规则：链接着色、图表公式按「章-序号」编号（每遇一级标题重置）、
/// 题注加粗、脚注按数字编号。
#let ref-rules(body) = {
  show link: it => text(fill: font-color.link-blue)[#underline[#it]]

  set math.equation(numbering: (..nums) => [(#counter(heading).get().at(0)-#nums.at(0))])
  set figure(numbering: (..nums) => [#counter(heading).get().at(0)-#nums.at(0)])
  show figure.caption: it => [
    #set text(size: cn-font-size.五号, weight: "bold")
    #it.supplement
    #context it.counter.display(it.numbering)
    #it.body
  ]
  set footnote(numbering: (..nums) => [#nums.at(0)])
  show heading.where(level: 1): it => {
    it
    re-index
  }

  body
}

/// 通用文档骨架：应用排版规则、绘制页眉页脚、重置页码与脚注计数、
/// 输出居中的标题块。
///
/// - 页眉：页眉文字，居中显示于横线上方。
/// - 标题：二号字标题。
/// - 署名：标题下方的署名区，自由内容，由调用方组织。
#let document-frame(
  页眉: [],
  标题: [],
  署名: none,
  body,
) = [
  #show: show-cn-fakebold
  #show: ref-rules
  #show: indent-rules

  #set page(
    footer: context {
      set text(fill: gray, font: font-family.宋体, size: cn-font-size.小五)
      align(center)[#counter(page).display("1")]
    },
    header: {
      align(center)[
        #text(fill: gray, font: font-family.宋体, size: cn-font-size.小五)[
          #页眉
        ]
        #v(-0.5em)
        #line(length: 100%, stroke: (paint: gray, thickness: 0.5pt))
      ]
    },
  )
  #set heading(numbering: "1.1 ", outlined: true)
  #show heading: it => {
    v(0.5em)
    it
    v(0.5em)
  }
  #counter(page).update(1)
  #counter(footnote).update(0)

  #align(center)[
    #text(size: cn-font-size.二号)[
      #标题
    ]

    #署名
  ]

  #body
]

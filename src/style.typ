#import "@preview/cuti:0.2.1": show-cn-fakebold

#import "font-style.typ": cn-font-size, font-color, font-family

#let ind = h(2em)


#let fakepar = context {
  let b = par[#box()]
  let t = measure(b + b)

  b
  v(-t.height)
}


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
  show raw.where(block: true): it => {
    text(font: font-family.等宽)[#it]
    fakepar
  }
  show math.equation.where(block: true): it => {
    it
    fakepar
  }
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

#let re-index = {
  counter(figure.where(kind: image)).update(0)
  counter(figure.where(kind: table)).update(0)
  counter(math.equation).update(0)
}

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

#let paper-study-report(
  姓名: [姓名],
  学号: [250xxx0xxx],
  日期: [2025年x月x日],
  页眉: [北京大学软件与微电子学院],
  标题: [通用课程报告模板],
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

    #text(size: cn-font-size.小四)[
      姓名：#姓名
      #h(2em)
      学号：#学号

      #日期
    ]
  ]

  #body
]

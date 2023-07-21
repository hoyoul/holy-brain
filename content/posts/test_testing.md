+++
title = "[test] testing!"
author = ["holy"]
description = "this is test"
date = 2023-07-20T00:00:00+09:00
draft = true
+++

## this is test {#this-is-test}

this is test!


## head level test (level1) {#head-level-test--level1}

main.css에 정의 되어 있다. level3 까지만 css 설정함.  .page &gt; .content
에서 수정하면 됨, head level1은 .page&gt; .content h2로 정의됨. level2는
.page&gt;.contents h3 등등


### head level test (level2) {#head-level-test--level2}

Nullam eu ante vel est convallis dignissim.


#### head level test (level3) {#head-level-test--level3}

Phasellus lacus.

<!--list-separator-->

-  head level test (level4)

    Fusce commodo.


## underline {#underline}

orgmode.css에 정의되어 있다.
<span class="underline">test</span>


## = test = {#test}

`test`


## priority {#priority}

C-c ,


### priority1 {#priority1}


### priority2 {#priority2}


## todo {#todo}

C-c C-t


### <span class="org-todo todo TODO">TODO</span> todo {#todo}


### <span class="org-todo done DONE">DONE</span> todo2 {#todo2}


## verse {#verse}

<div class="verse">

this is verse<br />

</div>


## note {#note}

<div class="note">

this is note

</div>


## source {#source}

```emacs-lisp
this is emacs lisp source
```


## tip {#tip}

<div class="tip">

this is tip

</div>


## warning {#warning}

<div class="warning">

this is warning

</div>


## important {#important}

<div class="important">

this is important

</div>


## attention {#attention}

<div class="attention">

this is attention

</div>


## example {#example}

```text
this is example
```


## table {#table}

| 온도      | -4 | -3 | -2 | -1 | 0 | 1 | 2 | 3 | 4  |
|---------|----|----|----|----|---|---|---|---|----|
| 아이스크림 판매량 | -6 | -4 | -2 | 0  | 2 | 4 | 6 | 8 | 10 |

보기 좋게 세로로 변경하자.

| 온도 | 아이스크림 판매량 |
|----|-----------|
| -4 | -6        |
| -3 | -4        |
| -2 | -2        |
| -1 | 0         |
| 0  | 2         |
| 1  | 4         |
| 2  | 6         |
| 3  | 8         |
| 4  | 10        |

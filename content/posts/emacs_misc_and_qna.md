+++
title = "[emacs] misc and qna"
author = ["holy"]
description = "옛날 자료 취합중"
date = 2023-08-06T00:00:00+09:00
draft = true
+++

## key 설정법 {#key-설정법}


### global key 설정 {#global-key-설정}

-   기본설정 global-set-key는 모든 buffer에 key를 설정한다는 뜻.

<!--listend-->

```text
(global-set-key (kbd "M-a") 'backward-char) ; Alt+a
(global-set-key (kbd "C-a") 'backward-char) ; Ctrl+a
(global-set-key (kbd "C-c t") 'backward-char) ; Ctrl+c t
(global-set-key (kbd "<f7> <f8>") 'whitespace-mode)    ; F7 F8
```

-   snippet처럼 사용도 가능
    ```text
    (global-set-key (kbd "M-0") "kyc1682@gmail.com")
    ```


### 특정모드에서 key설정 {#특정모드에서-key설정}

-   hook을 걸어서 local-set-key로 설정
    ```text
    (defun my-go-mode-hook ()
        (local-set-key (kbd "<f8>") 'dap-breakpoint-toggle)
    )
    (add-hook 'go-mode-hook 'my-go-mode-hook)
    ```


## cua mode 사용법 (세로 편집) {#cua-mode-사용법--세로-편집}

-   M-x cua-mode를 누르면 column editing이 가능하다.
-   C-enter를 누르면 region 선택이 가능하다.
-   region을 선택한 후, 문자를 입력하면 동일한 문자가 나온다.
-   유용한 기능으로 numbering을 붙이고 싶을 때는, M-n을 누르면 start
    number와 increase를 선택하고 formatting도 설정할 수 있다.


## ivy에서 candidates 선택 문제 {#ivy에서-candidates-선택-문제}

-   partially matching만 되도, 선택해야 한다. 어떨때는 새로운 file을
    만들거나, 새로운 node를 만들때 부분 매칭되는 candidate를 선택할
    수밖에 없는 경우가 있다. 이럴때는 C-M-j를 눌러서 완전히 일치되는것만
    보이게 만든다.


## general package {#general-package}

-   key를 binding한다.


## completion system {#completion-system}

-   completion system에 쓰이는 아래 패키지들은 모두 독립적이다. 필요에
    따라 쓰면 된다. completion system에 대해 설명을 하자면, 예를
    드는게 편하다. C-x C-f를 누르면 minibuffer에서 원하는 file을
    찾을려고 입력을 하면 candidates가 나온다. 이런것이 completion
    system이다. M-x를 눌러도 이런 candidate가 나온다. ido-mode,
    icomplete, helm같은게 이런 역할을 한다. 물론 ivy도 그렇다.
    여기서는 selectrum과 vertico를 설명한다. 둘다 completion이지만,
    orderless와 같이 사용된다.


### Selectrum {#selectrum}

-   기존의 ivy의 counsel-find-file이라던가, ivy-switch-buffer를 보면,
    minibuffer가 보여지고 자동완성기능이 있었는데, 이것을 selectrum이
    대신한다고 보면 된다.


### vertico {#vertico}

-   vertico도 selectrum처럼 자동완성기능을 도와준다고 보면 된다.


### orderless {#orderless}

-   spectrum에서 보여지는 minibuffer에서 candidate를 찾기 위해서
    문자열을 입력하면 이에 매핑하는 candidate를 찾아준다. 찾아주는
    방식이 orderless하다. 순서에 상관없다. 단어를 두개 입력하면
    두개가 포함된 candidate를 찾아주는 것이다. 완전히 일치하지 않고,
    부분적으로 일치하는 것을 찾아준다.예를 들어, C-h f에서 describe
    function에서 name buffer를 입력하면, name buffer가 들어간 모든
    function을 list해서 보여준다. regular expression도 사용할 수
    있다. 매우 빠르게 찾아줄 수 있다고 한다. Prec


### consult {#consult}

-   consult는 찾기기능이라고 보면된다. grep과 find를 사용할 수 있는데
    그 기능이 막강하다고 한다.dired buffer에서 특정 string을
    검색하기도 쉽다고 한다.


### embark {#embark}

-   embark는 dwim을 이용한 tool이라고 보면된다. doing what u
    think하는 도구다. context에 따라서 어떤 행동을 해야할 지가
    결정된다. 예를 들어서, region을 설정하고, C-.을 누르면 해야할
    action들이 보여진다. www.naver.com을 region선택하고 C-.을 누르면
    browser에서 볼 수 있다. dired buffer에서 특정 파일을 선택하고
    C-.을 선택하면 action들을 선택할 수 있다.


### marginalia {#marginalia}

-   minibuffer에서 보여지는 candidate에대한 부가설명이 나온다.
    meta정보라고하는 것을 볼 수 있다.


## Package system {#package-system}


### straight.el {#straight-dot-el}

-   straight는 기존의 package.el에서 사용했던, melpa나 elpa같은
    repository에서 package를 다운받아서 설치하는 구조를 바꿨다.
    straight를 사용하면 github에서 가져온다. 원하는 package를
    github에서 찾은후에 down받는다. use-package하고 연동해서
    사용하는데, use-package에서 ensure t를 하면, melpa나 elpa에서
    다운로드했다면, :ensure t대신에 :straight t를 사용하면 github에서
    가져온다.


## org 사용과 문제 [general] {#org-사용과-문제-general}


### org-babel source 외부버퍼에서 편집 {#org-babel-source-외부버퍼에서-편집}

-   org mode에서 소스블락에서 정렬이 잘 안된다. 이럴 경우, 아래와
    같이 버퍼를 만들어서 편집하는게 편하다.

<div class="note">

org-edit-special: C-c '

</div>


### foot note 사용법 {#foot-note-사용법}

-   주석을 달고자하는 문장을 선택한 후 C-c C-x f를 누르면
    footnote항목이 생긴다.


### math symbol 사용법 {#math-symbol-사용법}

-   $ $사이에 수식 사용
    ```text
    $\frac{a}{b}$
    ```


## org exporting문제들 [ipynb] {#org-exporting문제들-ipynb}


### org to ipynb or org to markdown exporting시 image size문제 {#org-to-ipynb-or-org-to-markdown-exporting시-image-size문제}

-   org에서 작성한 image를 ipynb나 markdown으로 export할 때 문제가
    있다. image size조정이 안된다.  image의 size를 조정할려면, org
    mode에서 option으로 html tag를 직접 기술할 수 밖에 없다.

<div class="note">

<img src="img/test.png" width="600px">

</div>

-   yasnippet에도 ipynb_image로 설정


### underscore to sub 문제 {#underscore-to-sub-문제}

-   org 문서를 ipynb로 exporting할 때, underscore가 sub로 변환된다.
-   org 문서를 html로 exporting할 때 똑같은 문제가 있었는데, 이것은
    option ^nil로 해결했지만, ipynb로 exporting할 때 적용되지
    않는다.
-   (setq org-export-with-sub-superscripts nil)로 아예 _ 가 sub로 변환되지 않게 했다.


## org exporting문제들 [html, reveal, latex] {#org-exporting문제들-html-reveal-latex}


### underscore 문제 {#underscore-문제}

<div class="note">

org mode에서 글을 쓸때 underbar를 사용하면, export할 때, superscript가 되는 문제가 있다. export할 때 아래와 같이 처리하면 된다.

</div>

<div class="tip">

\\#+OPTIONS: ^:nil

</div>


### color text 사용법 {#color-text-사용법}


#### org mode export html with colored text {#org-mode-export-html-with-colored-text}

John Kitchen이 만든 org-colored-tex.el을 사용하면, org mode에서
html로 export할 때 color를 사용할 수 있다고 한다.  사용법은
snippet을 만들었는데, text_color라는 snippet이다.

```text
[[color:green][text is green ]
```

아래는 참조

```text
[[https://kitchingroup.cheme.cmu.edu/blog/2016/01/16/Colored-text-in-org-mode-with-export-to-HTML/][참조]]
```


#### org mode export latex with colored text {#org-mode-export-latex-with-colored-text}

latex에서 color text를 표현하기 위해서는, 두가지를 해줘야 한다.

```text
1. #+MACRO: color @@latex:{\color{}@@@@latex:}@@ 를 org header에 추가해야 한다.
```

```text
2. latex snippet을 작성한다.
   {{{color(,this is colored text)}}}
@@latex:{\color{blue}@@ This text is in org but will come out blue.@@latex:}@@ And this text will be normal.
```


## Org presentation 사용법 {#org-presentation-사용법}


### reveal presentation 사용 {#reveal-presentation-사용}

org mode에서 presentation을 사용하는 가장 일반적인 방법이 reveal이다. 그런데 reveal은 setting을 해야 제대로 쓸 수 있다.
다음과 같이 설정한다.

```emacs-lisp
(use-package ox-reveal
:ensure ox-reveal)

(setq org-reveal-root "http://cdn.jsdelivr.net/npm/reveal.js")
(setq org-reveal-mathjax t)

(use-package htmlize
:ensure t)
```


### org-Beamer presentation 사용 {#org-beamer-presentation-사용}

-   org-beamer는 C-c e를 누를때 org export option에서 안보이면 우선
    org mode에서 M-x org-beamer-export-pdf를 실행해본다. 그러면
    export option에서 보일수 있다.


### org-tree-slides 사용 {#org-tree-slides-사용}


## Blog {#blog}


### hugo + org + github {#hugo-plus-org-plus-github}


## org export css {#org-export-css}


## ibuffer 사용법 {#ibuffer-사용법}

-   C-x C-b를 누르면 buffer list가 보이는데, 이게 너무 중구 난방이다.
    그래서 category화 한다. 이게 필요한 이유는, buffer들이 너무 많으면
    emacs가 느려질 수 있다. 안 사용하는 buffer는 지워주어야 한다.
-   [참고]<https://cestlaz.github.io/posts/using-emacs-34-ibuffer-emmet/>


## json format {#json-format}

-   json 데이터를 인터넷에서 구해서 copy &amp; paste할 때, 보기에 힘들다.
-   json-format이라는 함수를 emacs에 설정하고, json을 붙여넣은 후
    block을 정하고 M-x json-format을 호출하면 보기좋게 정렬된 것을 볼 수
    있다.
    ```text
    (defun json-format ()
    (interactive)
    (save-excursion
    (shell-command-on-region (mark) (point) "python -m json.tool" (buffer-name) t)
    )
    )
    ```

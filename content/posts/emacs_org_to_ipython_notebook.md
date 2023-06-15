+++
title = "[emacs] org to ipython notebook"
author = ["holy"]
description = "org에서 ipython notebook 만드는 법"
date = 2023-06-15T00:00:00+09:00
draft = true
+++

## org to .ipynb {#org-to-dot-ipynb}

emacs에서 ipython notebook을 직접 다루려면 [ein package]({{< relref "emacs_jupyter_noteboo_settings" >}})를 사용한다. 즉
notebook을 다운로드 받고 notebook형식을 유지한채 편집하고 다시
jupyter나 colab으로 보내는 패키지다. 그런데 org도 ipython notebook도
비슷하기 때문에 org를 notebook(.ipynb)으로 변환해서 colab이나
jupyter에서 사용할 수 있는데, 이것은 `ox-ipynb` 라는 package를 사용해야
한다. 굳이 이렇게 하는 이유는 emacs에서 org로 편하게 문서 작성하고 이것을
colab(gpu 지원)에서 실행할 수 있기 때문이다. 만일 gpu가 있는
computer를 사용하면 jupyter로 사용하면 된다.


## ox-ipynb 사용법 {#ox-ipynb-사용법}


### github 위치 {#github-위치}

John Kitchin이라는 교수가 만든 github이다. [from here](https://github.com/jkitchin/ox-ipynb)


### 설정 {#설정}

1.  .emacs.d/lisp폴더에 다운한다. lisp폴더는 down받은 elisp파일을
    모아놓은것이다. 내가 임의로 만든것이다.
2.  emacs에 설정
    ```emacs-lisp
    (add-to-list 'load-path "/Users/holy/.emacs.d/lisp/ox-ipynb")
    (require 'ox-ipynb)
    ```
3.  org문서를 작성후에 C-c e(export dispatcher)를 누르면 변환할 수
    있는 menu가 보인다. (org-&gt; jupyter notebook)

    <a id="figure--export dispatcher"></a>

    {{< figure src="/img/jupyter/ox-ipynb1.png" caption="<span class=\"figure-number\">Figure 1: </span>export dispatcher" width="600px" >}}


#### 사용법 {#사용법}

다운 받은 repo에는 [example.org]({{< relref "example" >}})라는 파일이 있다. 해당파일을 open해서
ipynb로 변환하면 된다.


#### 문제점 {#문제점}

org모드에서 사용되는 image가 ipynb로 변환될때, image size가 조절되지 않는다.


## org 문서작성 {#org-문서작성}

org로 문서를 작성할때, ipynb로 변환 염두에 두고 있다면, 기존 org와는
다르게 해야 할께 있다.


### code block {#code-block}

code block은 ipython을 사용한다. snippet을 만들었는데, ipython_codeblock로 했다.


### new cell {#new-cell}

cell을 만들 수도 있다.

<div class="verse">

#+ipynb-newcell<br>

</div>

ipython_cell로 snippet을 만들었다.


### table {#table}

table은 caption을 달 수 있는데, 이것도 snippet으로
만들었다. ipython_table이다.


### image {#image}

image도 snippet으로 만들었다. ipython_img


### html {#html}

html을 직접 입력할수 있다. ipython_html

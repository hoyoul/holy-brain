+++
title = "org mode test"
author = ["holy"]
date = 2023-04-25
draft = false
+++

org에서 사용되는 요소들


## text표현 {#text표현}


### bold(\*) {#bold}

**Nunc aliquet, augue** nec adipiscing interdum, lacus tellus malesuada massa, quis varius mi purus non odio.


### strikethrough(+) {#strikethrough--plus}

Etiam ~~laoreet~~ quam sed arcu.


### italic(/) {#italic}

Etiam vel _neque_ nec dui dignissim bibendum.


### underline(_) {#underline}

Praesent <span class="underline">fermentum</span> tempor tellus.


### verbatim(=) {#verbatim}

Nulla `posuere.`


### minus(-) {#minus}

Fusce -sagittis- libero non molestie mollis, magna orci ultrices dolor, at vulputate neque nulla lacinia eros.


## head1 {#head1}

head1 text


### head2 {#head2}

head2 text


#### head3 {#head3}

head3 text


## list {#list}


### ordered list {#ordered-list}

1.  list1
2.  list2
3.  list3


### unordered list {#unordered-list}

-   ulist1
-   ulist2
-   ulist3


## source {#source}


### text {#text}

```text
mov R9, R3
```


### emacs lisp {#emacs-lisp}

```emacs-lisp
this is lisp code block
```


### python code {#python-code}

```python
import numpy as np
import matplotlib.pyplot as plt

random_points = np.random.randint(0, 10, (100, 2))

plt.scatter(random_points[:, 0], random_points[:, 1])
plt.savefig(f)
return f
```


## image {#image}

<a id="figure--this is image name"></a>

{{< figure src="./img/agent.png" caption="<span class=\"figure-number\">Figure 1: </span>this is image caption" width="300px" >}}


## 나머지들 {#나머지들}

<div class="tip">

this is tip

</div>

<div class="test">

this is test

</div>

<div class="right">

this is right

</div>

<div class="note">

Pellentesque dapibus suscipit ligula.  Donec posuere augue in quam.
Etiam vel tortor sodales tellus ultricies commodo.  Suspendisse
potenti.  Aenean in sem ac leo mollis blandit.  Donec neque quam,
dignissim in, mollis nec, sagittis eu, wisi.  Phasellus lacus.  Etiam
laoreet quam sed arcu.  Phasellus at dui in ligula mollis ultricies.
Integer placerat tristique nisl.  Praesent augue.  Fusce commodo.
Vestibulum convallis, lorem a tempus semper, dui dui euismod elit,
vitae placerat urna tortor vitae lacus.  Nullam libero mauris,
consequat quis, varius et, dictum id, arcu.  Mauris mollis tincidunt
felis.  Aliquam feugiat tellus ut neque.  Nulla facilisis, risus a
rhoncus fermentum, tellus tellus lacinia purus, et dictum nunc justo
sit amet elit.

</div>

> this is quote

<div class="verse">

this is verse<br>

</div>

<style>.org-center { margin-left: auto; margin-right: auto; text-align: center; }</style>

<div class="org-center">

this is center

</div>

<div class="caution">

this is caution

</div>

```text
this is example
```

<div class="warning">

this is warning

</div>

<div class="attention">

this is attention

</div>

<div class="important">

this is important

</div>


## <span class="org-todo todo TODO">TODO</span> this is todo<span class="timestamp-wrapper"><span class="timestamp">&lt;2023-05-19 Fri&gt;</span></span> {#this-is-todo}


## <span class="org-todo todo DOING">DOING</span> this is doing {#this-is-doing}

<span class="timestamp-wrapper"><span class="timestamp">&lt;2023-05-18 Thu&gt;</span></span>


## <span class="org-todo todo REVIEW">REVIEW</span> this is review {#this-is-review}


## <span class="org-todo todo BLOCKED">BLOCKED</span> this is blocked {#this-is-blocked}


## <span class="org-todo done DONE">DONE</span> this is done {#this-is-done}


## tables {#tables}

| Name  | Phone | Age |
|-------|-------|-----|
| Peter | 1234  | 17  |
| Anna  | 4321  | 25  |


## tags <span class="tag"><span class="tagtest">tagtest</span></span> {#tags}


## priority A {#priority-a}


## priority B {#priority-b}


## priority C {#priority-c}


## checkbox {#checkbox}


### <span class="org-todo todo TODO">TODO</span> Organize party <code>[2/4]</code> {#organize-party}

-   [-] call people <code>[1/3]</code>
    -   [ ] Peter
    -   [X] Sarah
    -   [ ] Sam
-   [X] order food
-   [ ] think about what music to play
-   [X] talk to the neighbors


## source code {#source-code}

```html
<pre><code class='lang-py'>
    a = 3
    b = 4
    if 0 &lt;= (a + b) &lt;= 10:
    print("이것은 예제다...")
</code></pre>
```


## fieldset {#fieldset}

<fieldset>
  <legend><i class="far fa-star"></i> document summary </legend>
  <ol class="li">date: </ol>
  <ol class="li">author:</ol>
  <ol class="li">content:</ol>
</fieldset>


## blue block {#blue-block}

<div class="blueblock">

Lorem ipsum dolor sit amet, consectetuer adipiscing elit.  Donec
hendrerit tempor tellus.  Donec pretium posuere tellus.  Proin quam
nisl, tincidunt et, mattis eget, convallis nec, purus.  Cum sociis
natoque penatibus et magnis dis parturient montes, nascetur ridiculus
mus.  Nulla posuere.  Donec vitae dolor.  Nullam tristique diam non
turpis.  Cras placerat accumsan nulla.  Nullam rutrum.  Nam vestibulum
accumsan nisl.

</div>


## green block {#green-block}

<div class="greenblock">

IMPORTANT

</div>

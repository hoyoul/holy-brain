+++
title = "[emacs] jupyter notebook settings"
author = ["holy"]
description = "jupyter notebook을 emacs에서 사용하는 방법, 그리고 colab연결"
date = 2023-06-06T00:00:00+09:00
draft = false
+++

## python, ipython, jupyter notebook, google colab이란? {#python-ipython-jupyter-notebook-google-colab이란}


### python의 동작방식 {#python의-동작방식}

python은 REPL(Read Evaluate Print Loop)로 동작한다. shell에서 입력받은
code가 입력이 되고, 입력된 code가 python interpreter에 전해져서
실행되고 실행된 결과가 shell에 전달되는 동작 구조로 이루어져
있다. 그림으로 보면 다음과 같다.

<a id="figure--python 동작구조"></a>

{{< figure src="/img/jupyter/python_working.png" caption="<span class=\"figure-number\">Figure 1: </span>python 동작구조" width="600px" >}}

shell과 python은 local system에서 수행된다.


### ipython과 ipython notebook {#ipython과-ipython-notebook}

python이 개발된 이후에 ipython이란것도 비슷한 시기에 개발되었다.
ipython이 기존 python과 차별화하는 2가지 특징이 있는데, 하나는 code를
cell단위로 입력할 수 있고, server client구조를 가질 수 있다는
것이다. Read는 notebook의 코드조각(cell)형태다. cell에 입력한 input이
ipython에 전달되는데 ipython은 local에 있을 수도 원격에 있을 수도
있다. 이러한 개념을 그대로 가져다 사용한게 jupyter와 google
colab이다.


### jupyter와 jupyter notebook {#jupyter와-jupyter-notebook}

jupyter는 project이름이다. jupyter라는 project가 뭔지는 jupyter
홈페이지에 나와 있다.

```text
Project Jupyter is a non-profit, open-source project, born out of the
IPython Project in 2014 as it evolved to support interactive data
science and scientific computing across all programming
languages. Jupyter will always be 100% open-source software, free for
all to use and released under the liberal terms of the modified BSD
license.
```

요약하면 jupyter와 jupyter notebook은 ipython이 python에 대한
interpreter만 사용하는 것에 문제가 있다고 생각함. 여러 언어를
지원하기로 함. jupyter는 ruby나 R도 사용가능 하다. 인터페이스만
제공하는 형태로 변경한 것이다. 인터페이스를 kernel이라고
부른다. jupyter notebook도 server client 구조로 되어 있다. browser가
client가 되어서 browser내에서 code cell을 입력하거나 notebook을
만들고, 각 cell을 ipython(kernel)의 입력으로 보내고, 실행한 결과를
다시 browser에게 보내게 된다. 위에서도 말했듯이 server client의 구조를
갖고, 원격에 서버가 있을수도 있고 local에 서버가 있을수도 있다. 구조는
다음과 같다.

<a id="figure--jupyter working"></a>

{{< figure src="/img/jupyter/jupyter_working.png" caption="<span class=\"figure-number\">Figure 2: </span>jupyter working" width="600px" >}}


### Google colab {#google-colab}

google colab도 jupyter의 구조와 동일한 형태다. 그런데
programming언어는 python언어 하나만 사용 가능하다.  google의 cloud와
gpu를 사용할 수 있다. 이말은 사용되는 notebook들이 local이 아닌
cloud에 저장되어 있고, python code를 실행하는 ipython(kernel)도 원격에
있으며, gpu를 사용할수 있다는 것이다. jupyter의 server가 jupyter
server(hub)라는 이름으로 따로 있듯이, colab도 google colab server가
있다고 생각하면 된다. server가 따로 있다는 것은 python code를 실행할수
있는 kernel이 server에 있다는 말이다. 그리고,


### 요약 {#요약}

말을 복잡하게 했는데, python과 달리, ipython, jupyter notebook, google
colab은 아래 그림을 보면 직관적으로 이해할 수 있다. 우선 python을 보면
다음과 같다. shell에서 명령을 내리면 local에 있는 python interpreter가
실행해서 결과값을 보여준다.

<a id="figure--python"></a>

{{< figure src="/img/jupyter/python1.png" caption="<span class=\"figure-number\">Figure 3: </span>python" width="600px" >}}

<a id="figure--jupyter notebook explorer"></a>

{{< figure src="/img/jupyter/jupyter_notebook1.png" caption="<span class=\"figure-number\">Figure 4: </span>jupyter notebook explorer" width="600px" >}}

browser에서 notebook을 선택할 수 있다.

<a id="figure--jupyter notebook"></a>

{{< figure src="/img/jupyter/jupyter_notebook2.png" caption="<span class=\"figure-number\">Figure 5: </span>jupyter notebook" width="600px" >}}

notebook을 선택하면 위와 같이 code와 text가 섞여있는 문서가
나온다. 실행할 수 있는 code block을 cell이라고 부르며 cell을 실행하면
결과가 표시되는 문서다. python에서는 shell에서 code를 실행하고
실행결과도 shell에서 확인하지만, ipython계열은 browser에서 notebook의
cell을 실행하고 실행결과를 notebook에서 확인 한다. browser가 shell의
역할을 대신하는 것이다. python에서 shell은 local에 있는 python
interpreter과 통신하지만, browser를 사용하는 ipython계열에서는 실제
실행되는 python interpreter(kernel)은 원격에 있을수 있다. colab은
GCE라는 원격 server에 python interpreter가 있다. 그래서 GCE라는 원격
server가 gpu가 있으면 gpu를 사용할수 있는것이다.  그런데 가만 보면,
notebook이라는게 emacs의 org파일과 동일한 형태다.  code와 text가
섞여있고, code를 실행할수도 있다. 이런 것을 literate programming이라고
한다. emacs가 browser를 대신해서 client역할을 할수
있어보인다. emacs에서 notebook list를 보여주고, notebook을 선택해서
code를 실행하고 결과도 확인할 수 있을꺼 같다. 또한 org와 비슷하다고
했으니, org문서를 .ipynb로 변환하거나 .ipytnb를 org로 변환하는게
가능해 보인다.


## emacs에서 notebook 사용 {#emacs에서-notebook-사용}

jupyter나 colab은 server&amp;client구조고, `browser가 client역할` 을
한다. 원격에 있는 server에 접속해서 server가 가진 notebook list를
가져오고 notebook에 있는 code를 원격 server에 보내고, server가 실행한
결과를 browser에서 보여주는 것들은 emacs에서도 가능하다. 즉 `emacs가
client역할` 을 하는 것이다. emacs에서 원격서버에 접속해서 notebook
list를 가져오고 code를 원격에 보내고 결과를 emacs buffer에 보여주는
것이 가능하다. 이것을 가능케하는게 `ein이라는 package` 이다.  또한
`.ipynb라는 notebook과 org파일들은 구조가 거의 같다.` 그래서 org파일을
ipynb로 변환하고 ipynb를 org로 변환할 수 있는데, 이때 `ox-ipynb` 라는
package를 사용할 수 있다.


### ox-, ob- package들 {#ox-ob-package들}

참고로 emacs에서 ox-, ob-라는 prefix를 갖는 package들은 특정 기능을
수행한다. ox-는 org 문서변환을 하는 package들이다. 예를 들어서,
ox-latex는 org문서를 latex문서로 변환한다. ox-md도 org문서를 md파일로
변환을 한다. 그리고 ob-로 시작하는 package들은 babel과 관련이 있다.
ob- package는 code block에서 실행할 수 있게 해준다.  예를 들어서,
ob-ruby는 code block을 실행할 때 ruby interpreter를 사용한다.


## ein package {#ein-package}

ein을 사용하면, browser로 notebook list를 보고 notebook을 실행하듯이
emacs에서 할 수 있다고 보면 된다. 그렇게 하기 위해선, browser가 원격
server와 접속해서 하는것처럼 emacs도 ein을 사용해서 서버에 접속한 후,
notebook list를 가져오고, 가져온 notebook을 열어서 code cell을 실행할
수 있다. ein이 설치되어 있다면, .ipynb를 가진 파일을 dired에서 열면,
browser처럼 notebook이 emacs에서 보여질것이라고 생각한다. 그런데
아쉽게도 .ipynb파일을 선택해도 notebook이 보여지지 않는다. json 파일이
열린다. ein에서 notebook을 browser럼 보려면, 다음과 같이 해야 보인다.

```text
M-x ein:run 현재경로
```

위와 같이 ein:run으로 server에 접속하면, browser처럼 list를 가져오는
화면이 보이고, 그 화면에서 ipynb를 선택하면 browser에서 봤던것처럼
notebook이 보인다. 이것은 emacs에서 .ipynb파일에 대한 mode를 만들어서
ui를 만들지 않는다는것을 의미한다. 즉 emacs는 jupyter server를
실행시키고, 실행된 jupyter와 tramp로 통신하면서 jupyter server가 만든
notebook list화면을 가져와서 그대로 보여줄 뿐이다. notebook을 선택하면
선택된 notebook정보를 server에 보내면 notebook화면을 고스란히
emacs에게 전달해주고 emacs는 보여줄 뿐이다. 따라서 emacs에서 확장자가
.ipynb를 dired모드에서 click한다고 해서 notebook이 보이지 않는다. 이건
좀 실망이긴 하다. inferior mode는 맘에 들지 않기 때문이다.

<a id="figure--ein notebook"></a>

{{< figure src="/img/jupyter/ein_ipynb.png" caption="<span class=\"figure-number\">Figure 6: </span>ein notebook" width="600px" >}}

```emacs-lisp
(use-package ein
:ensure t)
```


### 사용법 {#사용법}


#### jupyter처럼 현재 위치에서 실행 {#jupyter처럼-현재-위치에서-실행}

console에서 jupyter notebook하면 현재 경로에 대해서 browser가 notebook
list목록을 보여주듯이 ein에서도 그렇게 할 수 있다.

```text
M-x ein:run
```


#### google colab 사용하듯이 {#google-colab-사용하듯이}

browser에서 google colab에 url 연결하면, notebook list를
가져온다. emacs에서도 가능할까? google drive나 colab에 연결하려면
oauth로 토큰을 받아서 사용해야 하는데, 이상하게 google의
project설정화면은 hang on상태다.

```text
M-x ein:notebooklist-login

url: https://colab.research.google.com
```


## ox-ipynb사용 {#ox-ipynb사용}

ein을 사용하면 emacs에서 notebook파일을 처리할 수 있다. notebook파일을
다뤄야 하는 이유는 gpu를 사용하는 colab이 notebook만을 처리하기
때문이다.  big data처리를 하거나 deep learning을 하는 python
프로그램은 gpu를 사용한다. 따라서 gpu서버에서 프로그램을 돌리기 원하는
emacs 사용자들은 ein의 도움을 받아서 emacs에서 notebook문서를 만들고
사용하는게 당연해 보인다.emacs에서 notebook을 만들고 gpu가 있는
colab에서 실행! 매우 당연해 보인다.  그런데 emacs에서는 notebook파일을
자주 사용하지 않는다. 불편하다. emacs 문서 작성의 키 바인딩은
org파일을 능숙하게 사용할 수 있게 되어 있다. notebook과 비슷한
구조이기도 한 org파일을 그대로 사용할 수 없을까? 이런 아이디어로
만들어진게 ox-ipynb다. org로 코드를 작성하고, 원격에 있는 gpu가 있는
server(colab)에서 실행하기 위해서 notebook으로 변환하자는 것이다.


#### 설정 {#설정}

1.  jkitchin이 만든것을 lisp폴더에 다운 <https://github.com/jkitchin/ox-ipynb>
2.  emacs에 설정
    ```emacs-lisp
    (add-to-list 'load-path "/Users/holy/.emacs.d/lisp/ox-ipynb")
    (require 'ox-ipynb)
    ```
3.  export dispatcher에서 확인 (org-&gt;notebook)


#### 사용법 {#사용법}

org와 ipynb 사용예제가 다운 받은 ox-ipynb에 있다. example.org와
변환된 example.ipynb가 sample로 있다.


#### 문제점 {#문제점}

org모드에서 사용되는 image가 ipynb로 변환될때, image size가 조절되지 않는다.
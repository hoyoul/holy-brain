+++
title = "[emacs] anaconda settings"
author = ["holy"]
description = "emacs에서 anaconda를 사용하는 방법"
date = 2023-06-07T00:00:00+09:00
draft = true
+++

## system 설정 {#system-설정}

emacs에서 anaconda를 사용하기 위해선, mac에 anaconda를 설치한다.
[여기(from here)](https://www.anaconda.com/)에서 다운받아서 설치하면 된다.


### virtual environment {#virtual-environment}


#### 개요 {#개요}

시스템에 하나의 python만 있으면 불편하다. 하나의 python에 여러
package들이 설치된 후 project를 만들게 되는데, 매번 새로운 project를
만들때마다 project에 맞는 package를 설치해야 하는데, 기존 설치된
package때문에 충돌도 일어날 수 있다. 따라서 project에 필요한 python과
package들을 묶은 환경이 필요하다. project기준으로 봐야
한다. 기본적으로 anaconda을 설치하면 default 환경은 base다.

<a id="figure--기본환경"></a>

{{< figure src="/img/python/anaconda1.png" caption="<span class=\"figure-number\">Figure 1: </span>기본환경" width="500px" >}}


#### 가상환경 만들기 {#가상환경-만들기}

가상환경을 만들려면, shell에서 conda명령어를 이용한다.

```text
conda create -n [가상환경이름]
conda create -n [가상환경이름] python=3.7
```


#### 가상환경 선택하기(활성화하기,비활성화하기) {#가상환경-선택하기--활성화하기-비활성화하기}

```text
conda activate [가상환경이름]
conda deactivate
```


#### 가상환경 정보보기 {#가상환경-정보보기}

현재 선택된 가상환경 목록 보기

```emacs-lisp

```


#### 가상환경 목록보기 {#가상환경-목록보기}

```text
conda info --envs
```


#### 가상환경 삭제하기 {#가상환경-삭제하기}

```text
conda remove --name [가상환경이름]
```


## anaconda emacs 설정 {#anaconda-emacs-설정}


### anaconda mode setting {#anaconda-mode-setting}

```emacs-lisp
(use-package anaconda-mode
  :ensure t
  )
```


### create new .py file {#create-new-dot-py-file}

```text
C-x C-f
HolaWorld.py RET
```


### Add the code {#add-the-code}

```text
print ("Hola World from Emacs")
```


### running it {#running-it}

```text
C-c C-p
C-c C-c
```

output

<a id="figure--anaconda2"></a>

{{< figure src="/img/python/anaconda2.png" caption="<span class=\"figure-number\">Figure 2: </span>anaconda2" width="500px" >}}


## conda emacs설정 {#conda-emacs설정}


### conda mode setting {#conda-mode-setting}

```emacs-lisp
(use-package conda
  :ensure t
  :init
  (setq conda-anaconda-home "/Users/holy/opt/anaconda3")
  (setq conda-env-home-directory "/Users/holy/opt/anaconda3/envs")
  :config
  (conda-env-autoactivate-mode t))
```


### check env list {#check-env-list}

```text
M-x conda-env-list RET
```


### activate env {#activate-env}

```text
M-x conda-activate RET
```


## company 설정 {#company-설정}

complete anything. 자동완성 기능


### company setting {#company-setting}

```emacs-lisp
(use-package company-anaconda
  :ensure t
  :config
  (eval-after-load "company"
    '(add-to-list 'company-backends '(company-anaconda :with company-capf))))

```

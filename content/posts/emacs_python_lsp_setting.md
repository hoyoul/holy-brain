+++
title = "[emacs] python lsp setting"
author = ["holy"]
description = "python lsp setting을 하려 한다. eglot(client), pyright(server)를 이용한다."
date = 2023-06-08T00:00:00+09:00
draft = true
+++

## lsp {#lsp}

lsp는 server client구조다.


## eglot {#eglot}

emacs python client를 말한다.


## pyls(server) {#pyls--server}

이게 가장 오래된 방식이다. google에서 만들었다. 그런데 지금은 관리되지
않는다. depreciated되었다고 한다.
<https://emacs-lsp.github.io/lsp-mode/page/lsp-pyls/>

그래서 pyright를 사용한다. pyright는 ms에서 만들었다.


## <span class="org-todo todo DOING">DOING</span> pyright 설치 {#pyright-설치}


### create env {#create-env}

```text
$ conda create -n pyright_env python=3.11 RET
```


### activate env {#activate-env}

```text
$ conda activate pyright_env
```


### install pyright on pyright env {#install-pyright-on-pyright-env}

```text
$ conda install -c conda-forge pyright RET
```

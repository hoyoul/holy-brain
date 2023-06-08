+++
title = "[emacs] python lsp setting"
author = ["holy"]
description = "python lsp setting을 하려 한다. eglot(client), pyright(server)를 이용한다."
date = 2023-06-08T00:00:00+09:00
draft = true
+++

## <span class="org-todo todo DOING">DOING</span> pyright 설정 {#pyright-설정}


### create env {#create-env}

```text
$ conda create -n pyright python=3.11 RET
```


### activate env {#activate-env}

```text
$ conda activate pyright
```


### install pyright on pyright env {#install-pyright-on-pyright-env}

```text
$ conda install -c conda-forge pyright RET
```

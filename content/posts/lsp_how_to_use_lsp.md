+++
title = "[lsp] how to use lsp"
author = ["holy"]
description = "how to use lsp"
date = 2023-09-08T00:00:00+09:00
draft = true
+++

## LSP mode(client) {#lsp-mode--client}

LSP는 server/client로 동작한다. client는 emacs다. emacs에서 lsp-mode를
적용하면 emacs는 lsp client가 된다. 그러면 server는 어디에 있는가?


## LSP server {#lsp-server}

LSP server는 system에 설치해야 한다. brew로 설치할 수도 있고, 각
언어의 package manager에서 설치할 수도 있다.


## LSP-ui (lsp-mode extension) {#lsp-ui--lsp-mode-extension}

LSP-mode라는 기본 기능에 추가하는 기능이다. flycheck와 같은 문법체킹
기능이나 pep8과 같은 style에 대한 정보, code lense와 같이 참조하는
symbol에 대한 정보를 오른쪽 side에 warning형식으로
보여준다. 개인적으로는 이런 정보를 좋아하지 않는다. 나는 설치를 하지
않는다. lsp-ui는 별도로 설치해야 한다.


## LSP-treemacs (lsp-mode extension) {#lsp-treemacs--lsp-mode-extension}

```text
lsp-mode + treemacs = lsp-treemacs
```

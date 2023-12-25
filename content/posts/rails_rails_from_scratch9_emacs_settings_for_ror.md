+++
title = "[rails] rails from scratch9 Emacs settings for ROR"
author = ["holy"]
description = "rails emacs설정"
date = 2023-08-04T00:00:00+09:00
draft = true
+++

## emacs for ror {#emacs-for-ror}


### Projectile-rails {#projectile-rails}


#### 설치 {#설치}

<https://github.com/asok/projectile-rails>

```text
(use-package projectile-rails
:ensure t
:config
(projectile-rails-global-mode)
(define-key projectile-rails-mode-map (kbd "M-p") 'projectile-rails-command-map)
)
```

projectile-rails를 설치하고, global mode로 설정한 후, key map을 binding한다.
default key map은 다음과 같다.

```text
(define-key projectile-rails-mode-map (kbd "C-c r") 'projectile-rails-command-map)
```


#### 사용법 {#사용법}

<!--list-separator-->

-  이동하는 명령어

    > M-p c : Controller로 이동
    > M-p v : View로 이동
    > M-p m : Model로 이동

<!--list-separator-->

-  만드는 명령어

    <div class="note">

    C-c r !g : generate

    </div>


### syntax check (rubocop) {#syntax-check--rubocop}


#### 설치 {#설치}

```text
(use-package rubocop
:ensure t)
```


### inf-ruby {#inf-ruby}

<div class="note">

Ruby Repl이다.

</div>

> M-x inf-ruby


### lsp 설치 {#lsp-설치}

lsp mode는 emacs client다. server가 특이한데, system에 설치된 ruby가
server역할을 할 수 있게 gem을 추가시켜야 한다는 것이다. 예를 들면
rubocop을 gem으로 설치해야만, lsp mode에서 rubocop을 사용할 수
있다. 아래는 client를 설치하는 것이고 server는 그 아래 있다.


#### client {#client}

```text
;; Install and configure 'lsp-mode' and 'lsp-ruby'
(use-package lsp-mode
  :ensure t
  :commands lsp
  :hook ((ruby-mode . lsp))
  :init
  (setq lsp-ruby-solargraph-use-bundler t)
  :config
  (add-to-list 'exec-path "/Users/hoyoul/.asdf/shims/ruby/") ; Add Ruby binaries to the exec-path
  )
```


#### server {#server}

```text
gem update rubocop
gem install solargraph
```

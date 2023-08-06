+++
title = "[rails] rails from scratch9 Emacs settings for ROR"
author = ["holy"]
description = "옛날자료 복원"
date = 2023-08-04T00:00:00+09:00
draft = true
+++

## Emacs Settings for ROR {#emacs-settings-for-ror}


### rbenv 설치와 사용법 {#rbenv-설치와-사용법}


#### [osx]에서 설치와 사용법 {#osx-에서-설치와-사용법}

-   설치

    > brew install rbenv
-   설치 가능한 ruby목록

    > rbenv install -l
    > rbenv install -L
-   설치된 목록 확인

    > rbenv versions
-   설치된 ruby에서 global설정

    > rbenv global 2.6.3


#### [emacs]에서 설치와 사용법 {#emacs-에서-설치와-사용법}

-   emacs에서 설치

    > (use-package rbenv
    > :ensure t)
-   emacs에서 설정

    > (setq rbenv-installation-dir "/opt/homebrew/rbenv")

&lt;&lt;&lt;&lt;&lt;&lt;&lt; Updated upstream
&lt;&lt;&lt;&lt;&lt;&lt;&lt; Updated upstream


### Projectile-rails {#projectile-rails}

> C-c r c : Controllers
> C-c r v : Views
> C-c r m : Models

<div class="note">

C-c r !g : generate

</div>

`=====`
`=====`
&gt;&gt;&gt;&gt;&gt;&gt;&gt; Stashed changes


### inf-ruby {#inf-ruby}

<div class="note">

Ruby Repl이다.

</div>

> M-x inf-ruby

&gt;&gt;&gt;&gt;&gt;&gt;&gt; Stashed changes
&lt;

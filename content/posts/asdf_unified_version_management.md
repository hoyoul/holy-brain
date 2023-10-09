+++
title = "[asdf] unified version management"
author = ["holy"]
description = "asdf 통합 버전 관리 시스템"
date = 2023-09-22T00:00:00+09:00
draft = true
+++

## asdf {#asdf}

asdf는 version manager다. 여러 programming 언어는 제 각기 version
manager를 가지고 있다. node는 nvm, ruby는 rvm, rbenv, python은 pyenv,
conda 등등, 각 언어들은 version manager를 가지고 있다. 그래서, 이것을
통합한 version manager로 asdf가 나왔다. 좀 아이러니한게 common
lisp에서 사용하는 package 관리자가 asdf이다.
[공식페이지](https://asdf-vm.com/) 참조.


## asdf 설치 {#asdf-설치}

```shell
# install dependencies
brew install coreutils curl git

# install asdf
brew install asdf

# add to shell
echo -e "\n. $(brew --prefix asdf)/asdf.sh" >> ~/.zshrc
```


## asdf plugin: plugin 이란, 그리고 설정 {#asdf-plugin-plugin-이란-그리고-설정}

asdf는 universal하다. 여러 언어의 version관리가 가능하다. plugin은
version관리할 언어를 나타낸다. 아래와 같이 manage할 plugin(언어)를
설정한다.

```shell
asdf plugin add nodejs
asdf plugin add ruby
```


## asdf list-all: 설치가능한 all version list보기 {#asdf-list-all-설치가능한-all-version-list보기}

plugin이 설치되었으면 해당 plugin의 설치가능한 version list를 볼 수
있다.

```shell
asdf list-all nodejs
asdf list-all ruby
```


## asdf install : 원하는 plugin version 설치 {#asdf-install-원하는-plugin-version-설치}

plugin을 설치했기 때문에, 원하는 version을 설치할 수 있다.

```shell
asdf install nodejs 18.16.1
asdf install ruby 3.2.2
```


## asdf list: 설치된 version 확인 {#asdf-list-설치된-version-확인}

```shell
asdf list nodejs
asdf list ruby
```


## asdf에서 사용 (local, global) {#asdf에서-사용--local-global}


## emacs에서 asdf 사용 {#emacs에서-asdf-사용}

asdf.el이라는 package를 설치한다.

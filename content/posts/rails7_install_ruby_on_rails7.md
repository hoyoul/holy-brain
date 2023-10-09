+++
title = "[rails7] install ruby on rails7"
author = ["holy"]
description = "ruby on rails7 설치하기"
date = 2023-09-22T00:00:00+09:00
draft = true
+++

## gorails로 설치 {#gorails로-설치}

[GoRails](https://gorails.com/setup/macos/13-ventura)에 보면 설치 과정이 쉽게 나와 있다. 이대로 따르면 된다.


### ruby 설치 {#ruby-설치}


#### asdf 설치 {#asdf-설치}

[참고](https://asdf-vm.com/guide/getting-started.html), asdf는 node.js와 ruby의 version관리를 할 수 있다. rvm이나 rbenv
대신 asdf로 ruby버전을 관리하는 이유는, node도 관리할 수 있기
때문이다. asdf page에 나온방식으로 설치할 수도 있꼬, gorails에서
설치한 방법으로 설치할 수도 있다.

<!--list-separator-->

-  asdf 공식

    prerequisite이 있다.

    ```shell
    brew install coreutils curl git
    ```

    그리고 asdf를 설치한다.

    ```shell
    brew install asdf
    ```

    asdf를 shell path에 등록한다.

    ```shell
    echo -e "\n. $(brew --prefix asdf)/libexec/asdf.sh" >> ${ZDOTDIR:-~}/.zshrc
    ```

<!--list-separator-->

-  gorails

    ```shell
    cd
    git clone https://github.com/excid3/asdf.git ~/.asdf
    echo '. "$HOME/.asdf/asdf.sh"' >> ~/.zshrc
    echo '. "$HOME/.asdf/completions/asdf.bash"' >> ~/.zshrc
    echo 'legacy_version_file = yes' >> ~/.asdfrc
    exec $SHELL
    ```


#### asdf에서 ruby, node 설치 {#asdf에서-ruby-node-설치}

plugin을 설치한다. 아래는 ruby와 nodejs를 version관리할 수 있는
plugin을 설치하는 것이다.

```shell
asdf plugin add ruby
asdf plugin add nodejs
```

현재 ruby의 추천은 3.2.2다. 3.2.2를 설치하자.

```shell
asdf install ruby 3.2.2
asdf global ruby 3.2.2

# Update to the latest Rubygems version
gem update --system
```

설치된 ruby version을 확인한다.

```shell
which ruby
#=> /Users/username/.asdf/shims/ruby
ruby -v
#=> 3.2.2
```

이제 node를 설치해보자.

```shell
asdf install nodejs 18.16.1
asdf global nodejs 18.16.1
which node
#=> /Users/username/.asdf/shims/node
node -v
#=> 18.16.1

# Install yarn for Rails jsbundling/cssbundling or webpacker
npm install -g yarn
```


### rails 설치 {#rails-설치}

7.0.6 최신 버전을 설치한다.

```shell
gem install rails -v 7.0.6
```

만일 permission문제가 있다면, sudo를 붙여서 사용한다.

```shell
rails -v
```


### database 설정 {#database-설정}


#### sqlite3 {#sqlite3}

sqlite3를 설치한다. mac에는 built-in database로 sqlite3가 이미
설치되어 있다. file기반의 단순한 db다. 이것이 특정 버전에선 문제가
있기 때문에 brew로 다시 설치하자.

```shell
brew install sqlite3
```


#### postgresql {#postgresql}

rails에서 db를 사용한다고 하면, sqlite3를 사용하진 않는다. 보통
mysql이나 postgresql을 사용한다. postgresql을 강추하기 때문에
postgresql을 설치하자.

```shell
brew install postgresql
```

postgresql이나 mysql은 데몬이다. local에서 computer가 시작하자마자
실행하려고 하면 brew service를 이용하면 된다.

```shell
brew services start postgresql
```


### final {#final}

최종적으로 몇몇 gem들은 system의 C를 사용한다. C의 header파일을
참조하는데, 이것의 위치가 mojave좀 바뀌었다. 그래서 그것에 대한 처리를
해준다. 나는 ventura를 사용하기 때문에 처리하지 않아도
될듯하다. 처리할려면 path를 변경해야 한다.

```shell
sudo installer -pkg /Library/Developer/CommandLineTools/Packages/macOS_SDK_headers_for_macOS_10.14.pkg -target /
```


## Test Program {#test-program}

새로운 project를 만든다. sqlite3를 사용하는 project는 다음과 같이
만든다.

```shell
rails new myapp
```

db와 연동하는 project일 경우, 다음과 같이 만든다.

```shell
rails new myapp -d mysql or
rails new myapp -d postgresql
```

그리고 project에 들어가서, server를 실행시키면 된다.

```shell
cd myapp
rails server
```


## ruby관련 emacs packages {#ruby관련-emacs-packages}

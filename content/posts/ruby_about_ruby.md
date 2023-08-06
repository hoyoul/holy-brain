+++
title = "[ruby] about ruby"
author = ["holy"]
description = "옛날 자료 취합"
date = 2023-08-06T00:00:00+09:00
draft = true
+++

## Shim {#shim}

<div class="attention">

shim은 단축어가 아니다. 원래 뜻은 건축자재(나무,금속)를 뜻한다. 예를
들어 나사와 볼트를 연결할 때 와꾸가 안 맞으면
헐렁헐렁하다. 연결하려는 두 물체 중간에 shim을 끼우면 와꾸가 맞게
된다. 이런 역할을 하는 소량의 금속이나 목재를 shim이라고
한다. computer에서 shim도 비슷하다.  shim은 intercept api library라고
정의하기도 하는데, 중간에서 변환을 하는 통역사하고도 비슷하다. 예를
들어보자.

<a id="figure--"></a>

{{< figure src="/img/ruby/noshims.png" caption="<span class=\"figure-number\">Figure 1: </span>no shims" width="600px" >}}

shim이 없는 경우 application은 window의 함수를 direct로 호출한다.

<a id="figure--"></a>

{{< figure src="/img/ruby/shims1.png" caption="<span class=\"figure-number\">Figure 2: </span>shims1" width="600px" >}}

shim이 중간에 삽입된 경우다. 이럴경우, application은 shim을 통해서
window의 함수를 간접적으로 호출한다. 함수호출시 사용되는 argument도
달라질 수 있다. 비슷하게 windows의 응답도 shim을 통해서
application으로 전달되게 된다.  shim은 중간에서 다른 code도 실행할 수
도 있다.

이런 shim기술은 ruby의 version관리나, python의 version관리에 쓰이는
기술이다.  ruby의 경우, rbenv, python의 경우는 pyenv다. ruby가 shim을
사용해서 version관리를 하는지 살펴보자.

</div>


## rbenv-simpler than below {#rbenv-simpler-than-below}

<div class="attention">

rbenv를 설명하기 전에 ruby와 irb를 설명하자. program은 곧장 cpu나
memory와 같은 hw에서 처리하지 않는다. hw에서 곧장 처리할 수 있게
메모리로, cpu로 밥상을 차려주는 작업이 필요하다. 이것을 하는게
interpreter고 compiler다. ruby로 만든 프로그램은 Ruby, Irb에 의해서
요리가 된다.  마치 주방장과 같다. 하나의 시스템에 여러명의 주방장을
둘려고 rbenv를 사용한다. rbenv를 사용해서 Ruby라는 주방장을 고용하고,
사용할 수 있다.

</div>


## rbenv {#rbenv}

<div class="attention">

ruby나 python의 package와 interpreter는 하위 호환성이 없다. 이 말은
package나 interpreter가 version up이 되었을 때 하위 version에서
사용했던 함수나 코드가 없을 수 있다는 것이다. c++ 이나 java와 같은
기존 언어와 다른 점이다. 그래서, python이나 ruby의 경우, version의
조합이 중요하다. 특정 ruby와 특정 package에서만 동작하는
application이 있을 수 있다는 말이다. 그래서 하나의 system에 하나의
ruby version과 gem(package)를 사용하는 ruby runtime환경을 가지면,
매우 비효율적이기 때문에, 한 system에서 여러개의 ruby runtime환경을
가질수 있도록 하는 방식의 version 관리자가 필요한데, 그것이 바로
rbenv이다.

</div>


### osx file system {#osx-file-system}

<div class="note">

우선 우리는 osx를 사용한다고 가정하자. 그리고 osx의 file system을
간단히 알고 있어야 한다.

osx를 사용한다면, osx(system)에서 제공하는 utility(실행 파일들)은 모두
/usr/bin에 위치하게 된다. 그리고 사용자가 외부로 부터 다운받은
실행파일들은 /usr/local/bin에 위치하게 된다. 그런데, 만일 brew라는
package관리자를 사용한다면, brew로 설치되는 package들은
/usr/local/Cellar/라는 폴더에 위치하고, 거기에서 실행파일들은
/usr/local/bin으로 복사된다. 참고로, Cellar(셀러)는 와인 셀러의 그
셀러다. 즉 포도주 저장소를 뜻한다. brew라는 단어가 술을 만들다는
뜻이기 때문에 Cellar라는 단어도 술과 관련된 단어다. cellar에 저장된
패키지를 우리는 install되었다고 말한다. 여튼 cellar의 package에서
실행파일들은 모두 /usr/local/bin으로 복사된다.

/usr/local/bin으로 복사하는 이유는 해당 폴더가 PATH라는 환경변수에
기술되어 있어서 어떤 경로에서도 실행할 수 있기 때문이다.  정리하면,
osx에서 사용되는 folder와 path를 이해해야 한다.

</div>


### rbenv 동작 메카니즘. {#rbenv-동작-메카니즘-dot}

\#+begin_note
rbenv를 사용하지 않고 ruby를 사용하는 경우를 보자.


#### 설치과정 {#설치과정}

ruby를 사용하기 위해서 brew install ruby로 설치한다.  그러면 ruby
interpreter는 system에 설치된다.

<a id="figure--"></a>

{{< figure src="/img/ruby/rb1.png" caption="<span class=\"figure-number\">Figure 3: </span>ruby 설치1" width="500px" >}}

cellar에 package가 설치되는 것을 볼 수 있다.

<a id="figure--"></a>

{{< figure src="/img/ruby/rb2.png" caption="<span class=\"figure-number\">Figure 4: </span>ruby 설치2" width="600px" >}}

ruby package는 해당 version아래  위와 같은 폴더 구조를 가지고 있다.

<a id="figure--"></a>

{{< figure src="/img/ruby/rb3.png" caption="<span class=\"figure-number\">Figure 5: </span>ruby 설치3" width="600px" >}}

위에서 bin폴더에는 실행파일이 위치되어 있는데, 이 실행 파일은
/usr/local/bin에 복사가 된다. /usr/local/bin 은 path환경변수에 설정된
경로다.  그래서 사용자가 어느 폴더에 있더라도 ruby, erb,irb,gem과 같은
ruby관련 실행 파일을 실행할 수 있다.

그런데, 이렇게 system에 ruby를 설치하게 되면, 다른 버전의 ruby는
설치할 수 없다는 문제가 있다.


#### 실행 과정 {#실행-과정}

사용자가 ruby라고 shell에서 치면, "/usr/local/bin/ruby"가
실행된다. system에 설치된 ruby가 실행되는 것이다.  이렇게 되면 ruby
interpreter는 system에 오직 하나의 version밖에 설치되지
않는다. rbenv를 사용하는 이유는 여러개의 ruby interpreter version을
설치하고 실행할 수 있게 하려는 것이다.

그러면 rbenv를 brew로 우선 system에 설치한다. 그리고 rbenv를 이용해서 여러개의 ruby interpreter를 설치할 수 있다. rbenv로 설치한 ruby중에서 사용자는 특정 ruby version을 선택할 수 있다.

\#+end_note


### rbenv 설치 {#rbenv-설치}

<div class="note">

brew install rbenv ruby-build

</div>


### rbenv 초기화 {#rbenv-초기화}

<div class="note">

rbenv가 설정된 ruby를 사용하기 위해서는 rbenv init를 사용해서 PATH환경
변수에 .rbenv/shims라는 폴더를 처음 참조할 수 있게 해야 한다. 그렇게
하기 위해서는

rbenv init를 실행하면 된다.

</div>


### rbenv 업그레이드 {#rbenv-업그레이드}

<div class="note">

brew upgrade rbenv ruby-build

</div>


### 사용할 ruby 설정(rbenv global) {#사용할-ruby-설정--rbenv-global}

<div class="note">

rbenv global version
사용할 ruby가 설정된다.

</div>


### rbenv rehash {#rbenv-rehash}

<div class="note">

brew로 rbenv를 설치하고, 초기화 과정을 거치면, PATH라는 환경변수에
현재 global로 설정된 ruby폴더의 실행파일들(/bin)을 사용할 수 있는
이유는, .rbenv/shims안에 ruby의 실행파일들이 이동했기 때문이다. 우리는
gem install package로 특정 package나 실행 파일을 .rbenv/ruby버전/bin에
설치 한다.  이렇게 설치되도, 아무 경로에서나 실행할 수는
없다. 아무경로에서 실행할 수 있게 하려면, rbenv rehash로
.rbenv/ruby버전/bin/의 파일들을 .rbenv/shims폴더로 이동 시켜야 아무
경로에서나 실행할 수 있다. 이것을 하는 명령어가 rbenv rehash란
명령어이다. 이것이 가능한 이유는 PATH에 .rbenv/shims가 걸려 있기
때문이다.

</div>


### rbenv 설치 문제 emacs([rbenv] could not locate .ruby-version or .rbenv-version) {#rbenv-설치-문제-emacs--rbenv-could-not-locate-dot-ruby-version-or-dot-rbenv-version}

<div class="note">

M-x rbenv-use 사용시, 다음과 같은
[rbenv] could not locate .ruby-version or .rbenv-version 이란 에러를 만나게 된다면,
ln -s _usr/local/Cellar/rbenv/1.1.2/bin_  ~/.rbenv/bin
을 해줘야 한다. 이렇게 하면 에러가 없어진다.

</div>


## ruby tutorial {#ruby-tutorial}

<div class="attention">

ruby의 framework인 rails를 설명.
[guide](https://guides.rubyonrails.org/getting_started.html)

</div>


### Guide Assumptions {#guide-assumptions}

<div class="note">

ruby언어가 익숙치 않다면,
[ruby language](http:https://www.ruby-lang.org/en/documentation/)

ruby관한 책은
[여기](https://github.com/EbookFoundation/free-programming-books/blob/master/free-programming-books.md#ruby)

</div>


### What is Rails? {#what-is-rails}

<div class="note">

Rails의 철학

-   Don't Repeat Yourself
-   Convention Over Configuration.

</div>


### Creating a New Rails Project {#creating-a-new-rails-project}

<div class="note">



</div>


## 참조 사이트 {#참조-사이트}

<div class="attention">

<https://withrails.com/2015/11/25/rbenv-%EC%9E%91%EB%8F%99%EC%9B%90%EB%A6%AC/>

</div>


## rails-new {#rails-new}

<div class="attention">

rails관련 명령어들은 rinari, projectile-rails에서 수행할 수 있으나,
 rails new로 project를 만드는 기능은 별도로 제공하지 않는다. 그래서
 별도의 package가 필요하다.  [rails-new github](https://github.com/zhangkaiyulw/rails-new)

</div>

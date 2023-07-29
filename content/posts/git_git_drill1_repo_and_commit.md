+++
title = "[git] git drill1 repo and commit"
author = ["holy"]
description = "이전에 작성한 git문서를 다시재작성"
date = 2023-07-27T00:00:00+09:00
draft = true
+++

## Git Explained {#git-explained}

이전에 작성했던 git관련 문서가 있다. 재작성할 필요를 느꼈다.
[옛날 문서]({{< relref "git_git_explained" >}})가 있지만,다시정리한다.

-   git drill repo and commit (현재문서)
-   [git drill local]({{< relref "git_git_drill2_local" >}})
-   git drill remote
-   git drill internals


## Git Introduction {#git-introduction}

<div class="attention">

Git은 Version Control System이다. 또한 Git은 version history라고
부른다. Git에서 commit이라는 자료구조는 version이라고 한다. history는
linked list로 구현한다. 따라서, linked list를 안다면 혹은 구현할 수
있다면, Git을 이해하는 건 쉽다. linked list를 기반으로 Git을 크게
4단계로 나누어서 설명할 것이다. 1단계는 git을 사용하기 위한 설치과정
및 commit이라는 version, 그리고 linked list소개, 2단계는 local
system에서 Git의 사용, 3단계는 remote system에서 Git의 사용, 4단계는
work flow다. 부록으로 Git 내부 명령어를 설명할 수도 있다. 1단계는
어디가도 있는 내용이라서 그냥 가볍게 읽고 넘어가면 된다.

</div>


## Git Drill-1단계(part 1: repo란 무엇이고, repo 준비) {#git-drill-1단계--part-1-repo란-무엇이고-repo-준비}

누군가가 repository가 무엇이냐고 묻는다면? 어떻게 대답할 수 있을까?
repo는 container다. repo라는 자신만의 file-system을 가지고 있고,
자신만의 file system의 변경사항들을 commit이란 형태로
저장한다. part1에서는 이런 repo의 생성을 다룬다. 새롭게 만들거나
이전에 있는것을 가져온다. 그런 것을 가능하게 하는 명령어, init과
clone을 배운다. repo가 만들어지면, 이 저장소에는 commit들이
저장된다. commit들에게 반드시 포함되어야 하는 정보가 있다. commit을
만든 사람과, email과 같은 정보인데, 이것은 hash라는 고유의 id를
만드는데도 관여한다. git configure라는 환경설정을 통해 이런 값들을
setting할 수 있다. 이렇게 하면 commit만 만들면 된다. 이것은 part2에서
하게된다.

```text
- git 설치 : system에 git program설치
        (1) git init : .git(repository)을 만든다.
        (2) git clone : .git(repository) 폴더를 server에서 가져온다.
        (3) git configure : git을 설정한다. commit에 자신의 정보를 넣기위해서 필요.
        (4) git ignore: git에서 처리하지 않을 파일을 기록
```


### git 설치(brew) {#git-설치--brew}

```text
brew install git
```

git을 system에 설치, 간단히 brew로 설치


### git init, git clone {#git-init-git-clone}

```text
git init
git clone URL
```

git init으로 현재 폴더안에.git(repository)이란 폴더를 만든다. 처음에는
commit도 없고, branch도 없다.  git clone URL에서 다른곳에 있는
.git폴더를 가져오는 것이다. git clone은 remote와 관련이 있기 때문에
3단계에서도 설명을 할 것이다.


### git configure {#git-configure}

```text
git config --global user.name "[name]"
git config --global user.email "[name]"
```

이제 저장할 공간도 확보했기 때문에 저장 하면 된다. 그런데, 좀 해주어야
할게 있다.  저장은 commit이란 형태로 저장되는데, 여기에는 어떤
사용자가 저장했는지, 언제 했는지 같은 meta data가 들어간다. 그 meta
data를 설정해야 한다. 사용자 이름,email주소를 적어주면 된다.


### git ignore {#git-ignore}

편집기에서 .gitignore이라는 파일을 열고 다음과 같은 내용을 쓴다.

```text
*.log
```

.gitigonre파일에서 특정 파일을 commit에 포함시키지 않는다. commit을
지금 몰라도 나중에는 알게 된다.  배제할 파일 목록은 다음을 참고하면
된다.  <https://gitignore.io/>


## Git drill - 1단계 (part2-commit 만들기) {#git-drill-1단계--part2-commit-만들기}

<div class="attention">

Part1에서 git을 사용해서 commit을 할 수 있는 준비가 되었다고
했다. commit은 git에서 다루는 가장 기본적인 단위다. commit은 동사로도
쓰이고 명사로도 쓰인다. commit은 독립적으로 존재하지 않고, 단방향
linked list 형태로 연결되어 있다.  commit은 git의 가장 fundamental한
요소다. part2에선 commit을 만들고, 이것이 어떻게 linked list로
연결되는가?에 대해서 알아본다.

</div>


### Commit {#commit}

part1에서 repo를 생성하거나 가져왔다. repo에는 commit들의 linked
list형태로 저장된다고 했다. 그러면 commit은 무엇이냐?라고 물을 수
있다. 뭐라고 말할 것인가? commit은 변경사항이다. repo가 가진 sub file
system의 변경사항을 압축한게 commit이다. 난 이렇게 밖에 답할 수 없을
듯 하다.


### commit 만들기 위한 조건. {#commit-만들기-위한-조건-dot}

git은 저장시스템(repository)에 commit을 linked list형태로 저장한다고
했다. commit은 변경사항을 저장한 것이라고 했다. 변경사항? 어떤
변경사항인가? repo가 가진 working directory의 변경사항을 뜻한다.
repo가 유지하는 working directory에서 변경된 파일이 있거나 추가된
파일이 있다면 그것이 변경사항이고 그것이 commit의 형태로 저장되는
것이다.

git은 변경사항을 항상 check해야 한다. monitoring하고 있어야
한다. 그래야 변경사항을 commit으로 저장할 수 있으니까 말이다. working
directory에서의 변경사항의 기준은 이전 commit이다. 처음 repo를
작성하면 이전 commit은 없기 때문에 새로 생성되는 모든 파일은 변경사항이
된다. git은 이 모든 것을 check하고 있다.


### [git status] {#git-status}

git이 이전 commit과 현재의 working directory의 차이를 monitoring하고
있다고 했다. 정말 git이 monitoring하는지 알수 있는 git 명령어가
제공된다. git status라는 명령어다.

```text
git status
```

<a id="figure--git status"></a>

{{< figure src="/img/git/git_status.png" caption="<span class=\"figure-number\">Figure 1: </span>git status" width="600px" >}}

git은 이전 commit과 현재의 working directory의 차이만 monitoring하고
있는지 알았는데, git status를 보니, 다양한 일을 하는 것 같다. 우선
그림에서 첫번째 주황색 박스를 보면, origin/main과 현재 main이 up to
date되었다는 정보를 가르쳐준다. 이 정보는 remote commit과 local에 있는
이전 commit의 비교를 의미한다. 두번째 box에는 git이 monitoring한
변경파일들이 보인다. 그런데 staged되지 않은 변경파일이라고
한다. 그러면 stage된 변경파일은 무엇인가? 이전 commit과 비교해서
변경된 파일들은 선택이 가능하다. 무조건 변경되면 다음 commit에
포함되는게 아니다. commit에 저장되는 파일들은 변경된 파일들 중에
선택된 파일들이라는 것이다. 선택되었다는 것은 `stage` 에 올라갔다
라고도 표현한다. 마지막 box는 untracked file이라고 한다. `untracked`
라는게 무엇인지 알아야 한다. git은 현재의 working directory와 이전
commit과 비교해서 변경된 파일들(changes)를 계속 monitoring한다고
했다. 그런데 만일 새로운 파일이 추가되었다면 그것은 changes에
해당할까? 변경된 파일에 해당하냐? 답은 아니다. 이전 commit에 없는
새로운 파일이기 때문에 변경된게 아니라 새로운 파일이다. 기존에 없던
새로운 파일. 그래서 그런 파일들을 `untracked file` 이란 용어를
쓴다. `changes` 를 이전 commit에서 변경된 파일들이라고 했듯이,
`untracked` 는 이전 commit에 없는 새로운 file을 의미한다. `untracked`
파일들도 다음 commit을 만들때 선택될 수 있다. 마치 changes가 선택되서
stage에 올라가듯 untracked file들도 선택되어 stage에 올라갈 수 있다.


### [git add] - 변경파일(changes),새파일(untracked)들은 선택되어 staged될 수 있다. {#git-add-변경파일--changes--새파일--untracked--들은-선택되어-staged될-수-있다-dot}

모든 changes들이 commit이 되는게 아니라, changes들 중 선택할 수 있다.
git에선 git add라는 명령어를 제공한다.  git add로 우린 원하는
changes(변경된 파일)을 선택해서 stage에 올릴 수 있다.

```text
git add test.txt
```

그런데, changes라는게 이전 commit과 지금의 working directory에서
변경되거나 새롭게 추가된 파일들인데, sub file system에서 엄청나게 많은
file들이 변경되거나 추가될 수 있다. 하나 하나 선택하는 건 힘들수
있다. 왜냐면, 프로그램을 하나 짜더라도 너무나 많은 파일이 사용되고,
협업을 하게 되면 파일의 수가 많아지는건 너무나 당연하다. 그래서 보통은
git add . 로 전체를 올린다.

```text
git add .
```


### [git commit] stage에 간택된 changes만 commit. {#git-commit-stage에-간택된-changes만-commit-dot}

이렇게 stage에 올린 후에 git commit -m
"message"를 입력하면 commit이란 형태로 repository에 저장된다.

```text
git commit -m "message"
```


### [git commit] branch와 HEAD의 역할 {#git-commit-branch와-head의-역할}

앞으로 나오게 될 말이기도 하지만, 최초의 commit이 만들어지면, 그 때
master(main)라는 branch와 Head가 만들어진다. master는 commit을
가리키고, Head는 master를 가리킨다. 물론, HEAD나 branch는 모두
commit을 가리킬 수 있는 일종의 pointer or tag라고 말할 수 있다. 하지만
HEAD는 보통 commit을 직접 가리키지 않는다. Head는 branch를
가리킨다. 왜 branch를 가리키는지 설명하기에 앞서서, branch에 대한
설명이 필요할 듯하다. branch는 commit을 가리키는데, 그 commit이 그냥
commit이 아니다. 입구 같은 commit이다. 모든 commit들이 linked list로
연결되는데, 어떤 commit뒤에 새로운 commit을 붙여야 하는지
모른다. 무조건 마지막 commit뒤에 새로운 commit을 붙이는 건만은
아니다. 그래서 branch는 새로운 commit이 붙여질 위치를
나타낸다. commit이 붙여지면, 붙여진 commit으로 branch는 이동한다. 이제
아까 설명하다 멈춘 HEAD에 대해서 말해보자. branch는 새로운 commit이
붙여질 입구다. 그런데 branch가 하나만 있는게 아니다. 그 입구라는게
10개가 될 수 있다. 10개 중에 어떤 branch를 선택하냐? 그것을 정해주는게
바로 HEAD다. HEAD가 branch를 선택하는 역할을 한다. 선택된 branch에
새로운 commit은 붙여진다.

```text
git add ./*
git commit -m "message"
```

그림으로 보면 다음과 같다.

<a id="figure--commit.png"></a>

{{< figure src="/img/git/commit.png" caption="<span class=\"figure-number\">Figure 2: </span>commit" >}}


### [git switch,git checkout] 'HEAD detached' 용어 {#git-switch-git-checkout-head-detached-용어}

HEAD detached라는 용어가 있다. HEAD는 branch를 가리킨다고 한다. 만일
HEAD가 branch가 아닌 commit을 가리키면 Head Detached라고
부른다. HEAD를 이동하는 명령어는 git switch과 git checkout이 있다.


### [git commit] 결과 [git log],[git status] {#git-commit-결과-git-log-git-status}

git commit을 했을때 순차적인 동작은 다음과 같다. commit이 만들어지고,
HEAD가 가리키는 branch는 새로운 commit으로 이동된다. branch가 이동되면
HEAD도 같이 이동된다. 이것을 확인하는 것은 git log라는 명령어이다. git
log는 만들어진 commit과 HEAD와 Branch를 보여준다.

```text
git log
```

<a id="figure--git log"></a>

{{< figure src="/img/git/git_log.png" caption="<span class=\"figure-number\">Figure 3: </span>git log" width="600px" >}}

stage에 올린것을 commit으로 만들었기 때문에 staged(cached)라고 불리는
영역은 깨끗해진다.

<a id="figure--clean git status"></a>

{{< figure src="/img/git/clean_git_status.png" caption="<span class=\"figure-number\">Figure 4: </span>clean git status" width="600px" >}}

stage가 깨끗해진다는 것은 이렇게 이해해도 된다. 새롭게 만들어진
commit에 있는 working directory는 현재 working directory와 동일하기
때문에 changes가 없는건 당연하다. 라고 이해할 수 있다.


### [git rm] stage에서 내리는법(unstage) {#git-rm-stage에서-내리는법--unstage}

```text
(use "git rm --cached <file>..." to unstage)
```

stage를 다른 말로 cached라고 부르기도 한다. git rm으로 stage에
올린것을 지우면 된다.


### [git reset] commit취소 그리고 이동 {#git-reset-commit취소-그리고-이동}

commit을 만들었는데, 잘못 만들었다. 취소하고 싶다. 이것은 좀 복잡한
내부처리 과정을 거친다. 취소라는 단어보단, 어떻게 보면 Head와
branch이동인데, 그냥 취소라고 하자. 두 가지 경우가 있다. 하나는 만든
commit이 최초의 commit인 경우와, 두번째는 만든 commit이 최초 commit이
아닌 경우다.


#### 최초 commit인 경우. {#최초-commit인-경우-dot}

commit을 삭제하면 이전의 상태로 가야 한다. 이전 상태는 아무것도 없는
상태, 그러면 HEAD와 Branch가 없어야 한다. 그리고 수정된 파일이나,
새롭게 만든 파일들은 그대로 working directory에 있어야 하고, git
status를 했을때 변경사항으로 보여져야 한다.

가장 쉬운 방법은 repo를 지우는 것이다. rm -rf .git으로 지워도 작성된
파일은 그대로 working directory에 남아있기 때문에 수정해서 새 commit을
만들면 된다.

```text
rm -rf .git
```

다른 방법도 있다. HEAD를 삭제하는 것이다. HEAD를 없애면 HEAD가
가리키는 branch도 없어진다. 이렇게 하는 git 명령어가 존재한다.

```text
git update-ref -d HEAD
```

이렇게 하면 현재의 HEAD를 날려버린다. 그러면 commit이 가졌던
변경사항들이 index에 있게 된다. 이것은 repo를 지웠을 때와 차이가
있다. repo를 지우면 잘못만든 commit이 가지고 있던 file들은 그대로 현
폴더에 있는 상태지만, HEAD만 지우면, 변경사항들은 index(stage)에
올려져 있다.


#### [git reset] 최초의 commit이 아닌 경우 {#git-reset-최초의-commit이-아닌-경우}

commit을 취소하면 HEAD와 branch가 이전의 commit으로 이동하고 취소된
commit이 가지고 있던 변경사항들이 stage에 있는것을 원할 것이다. 이 때
사용하는 명령이 reset이다. reset은 HEAD와 Branch를 함께 움직이는
명령어다. git switch와 checkout은 HEAD만 이동한다. 그래서 git switch나
checkout은 branch를 인자로 받아서 HEAD를 branch로 이동한다면, reset의
경우는 HEAD와 branch를 같이 이동하는 명령어다.

다시 요약하면, reset은 `HEAD와 Branch를 함께 이동` 시키는
명령어다. 이런 git reset은 3가지 경우가 있다. `이동하려는 commit과
현재 commit의 변경사항들` 을 어떻게 처리할까에 따라서 3가지 경우가
있는 것이다.

-   --soft:
    ```text
    git reset --soft cd23ed20deb
    ```
    가장 일반적인 경우다. 원하는 commit으로 HEAD와 branch를 이동 시키고,
    현재 commit과 이동할 commit간의 변경사항들을 `모두 stage영역` 에
    올려놓는 것이다.

-   --mixed(default):

    이동하려는 commit과 현재 commit의 차이를 그대로 `변경사항영역` 에
    놔둔다. 변경 사항들을 지우지 않는다. soft에서는 모두 stage에
    올려놨다면, mixed는 그대로 변경사항으로 남아 있는 것이다.

-   --hard

<!--listend-->

```text
git reset --hard cd23ed20deb
```

hard라는 단어에서 느끼듯이 이것은 현재 commit과 해당 commit간의 모든
변경 사항들은 무시한다. `stage에 올려놓거나 변경사항을 유지하지
않는다.` 즉 두 commit간의 차이점을 반영하지 않는다. git status를
했을때, 변경사항이나 stage영역이 깨끗한 것을 확인할 수 있다. 해당
commit을 commit했을 때, 당시 시점으로 이동하는것이다. commit한 당시
시점이기 때문에 git status를 했을 때 아무것도 안보이는 것은 당연한
일이다. --hard는 모든 변경했던 파일 정보가 사라지기 때문에 사용에
신중함이 필요하다.


### 상대 참조에 관해(HEAD^와 HEAD~n 그리고 commit hash) {#상대-참조에-관해--head-와-head-n-그리고-commit-hash}

git checkout,switch,reset은 HEAD와 branch를 특정 commit으로 이동하는
명령어이다. 특정 commit을 가리킬 때는 git log를 통해서 hash값을 알아야
이동 할 수 있다. hash값을 사용해서 처리하는것은 절대주소를 참조하는
것과 같이 불편하다. 그래서 상대 참조하는 방식이 있다.

```text
git switch main^
git switch main~3
git reset HEAD^
git reset HEAD~3
```

위와 같이 해서 commit이 가진 hash값을 직접 입력하지 않고 commit을
참조할 수 있다. Head와 branch 어떤걸로 해도 상관없다.


### summary {#summary}

git repo와 commit에 대해서 대충 다뤄봤다. commit에서 좀 설명해야 할
게 있는데, commit의 구조다. commit은 변경사항만 저장하는데, working
directory구조는 유지하면서 변경사항을 저장한다. 변경된 파일들을
나열해서 저장하는게 아니라, working diretory의 구조인 tree와
blob이라는 file형태로 저장한다. 그래서 commit을 보면 아래와 같이
tree와 blob을 볼 수 있다.

<a id="figure--git commit"></a>

{{< figure src="/img/git/makecommit.png" caption="<span class=\"figure-number\">Figure 5: </span>git commit과정" >}}

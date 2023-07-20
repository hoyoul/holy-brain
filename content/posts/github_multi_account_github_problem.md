+++
title = "[github] multi account github problem"
author = ["holy"]
description = "multiple github을 사용할때 git push,pull 안되는 경우"
date = 2023-06-16T00:00:00+09:00
draft = true
+++

## github의 통신 방법 {#github의-통신-방법}

통신방법은 http와 ssh 방식이 있다. git pull과 git push, git clone은
통신하는 명령어다. git clone할때 보면 http와 ssh가 있는 것을 볼 수
있다.


## github 인증 방법 {#github-인증-방법}

대부분 public repo이기 때문에 git pull시에는 인증이 필요없다. 그러나
git push는 github에 쓰는 것이기 때문에 인증이 필요하다. 인증은
통신하는 방법에 따라 다르다. http는 PAT라는 토큰으로 인증할수 있고,
ssh는 ssh자체에 인증이 필요하다.


## http로 통신 방법 {#http로-통신-방법}

http를 사용할 경우, git push때 github은 PAT를 요구한다. PAT를 입력해서
push를 하면 그 다음 부터 mac에서는 PAT가 osxkeychain에
보관된다. 보관되는 이유는 git config에서 credential helper로
osxkeychain을 설정했기 때문이다. 그런데 http방식의 문제는 multiple
github계정을 사용할 경우 매번 osxkeychain의 github 아이템을 매번
지우고 새로 입력해야하는 문제가 있다.


## ssh로 설정해서 통신 {#ssh로-설정해서-통신}

ssh를 설정하는 이유는 multiple account를 사용할 수 있기 때문이다.


## ssh키로 multiple accounts 설정 {#ssh키로-multiple-accounts-설정}


### ssh key 생성 {#ssh-key-생성}

-   hoyoul 계정

<!--listend-->

```sh
ssh-keygen -t rsa -C "hoyoul.park@gmail.com" -f ~/.ssh/id_hoyoul
```

-   holy2frege 계정

<!--listend-->

```sh
ssh-keygen -t rsa -C "holy2frege.nil@gmail.com" -f ~/.ssh/id_holy2frege
```

만들어진 key를 각 github에 등록한다.


### ~/.ssh/config 설정 {#dot-ssh-config-설정}

다음과 같이 설정한다. 여기서 host명이 중요하다. host명에 따라
github에서 repo를 clone할 때, 이 host명이 쓰이기 때문이다. 그래서
가능하면 github에서 복사한값과 유사하게 만든다. github.com이
github에서 복사한 값이기 때문에 -hoyoul로 postfix를 붙이는 방법을
사용한다.

```text
# 첫 번째 계정
Host github.com-hoyoul
    HostName github.com
    User hoyoul
    IdentityFile ~/.ssh/id_hoyoul

# 두 번째 계정
Host github.com-holy2frege
    HostName github.com
    User holy2frege
    IdentityFile ~/.ssh/id_holy2frege
```


### server 연결 test {#server-연결-test}

```text
ssh -T git@ host명
ssh -T git@holy2frege_github
ssh -T git@hoyoul_github
```

사용자를 git으로 하고, host명을 입력해서 server에 접속 유무를 test할
수 있다.


### ssh로 clone을 해서 사용한다. {#ssh로-clone을-해서-사용한다-dot}

github에서 clone을 한다. clone시에 http, ssh인지 github cli가 있는데,
ssh를 선택한다. 그런데 그 주소는 직접 github주소와 연결되어 있다. 이걸
좀 변경해야 한다. 어떻게 변경해야 하냐면, 이전에 ~/.ssh/config의
설정을 사용해서 github에 접근해야 한다. 따라서 github에서 복사한
주소는 아래와 같다면,

```text
git@github.com:hoyoul/holy-brain.git
```

지금의 github.com은 ssh/config에서 설정한 host명으로 바꿔야 한다.

```text
git@github.com-hoyoul:hoyoul/holy-brain.git
```


## braindump와 homepage에서 multiple 계정으로 인한 submodule trouble shooting {#braindump와-homepage에서-multiple-계정으로-인한-submodule-trouble-shooting}

multiple 계정을 사용하기 위해서 ssh방식으로 바뀌면서 homepage와
braindump의 submodule주소도 변경해야 한다. .gitmodules를 열고 url을
다음과 같이 바꾼다.

-   hoyoul braindump

<!--listend-->

```text
[submodule "public"]
        path = public
        url = git@github.com-hoyoul:hoyoul/hoyoul.github.io.git

```

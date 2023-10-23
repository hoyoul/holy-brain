+++
title = "[github] multi account github problem"
author = ["holy"]
description = "multiple github을 사용할때 git push,pull 안되는 경우"
date = 2023-06-16T00:00:00+09:00
draft = true
+++

## github 연결 방식 {#github-연결-방식}

local computer에서 github에 연결하는 방식은 크게 3가지가 있다. http,
ssh, github cli다. local에서 github을 사용한다는 것은 인증이 필수로
들어간다. http연결에는 PAT라는 token이, ssh연결에는 public key가
필요하다.


## multiple github account 문제점 {#multiple-github-account-문제점}

github은 host가 github.com하나다. 여기에 여러개의 계정이 있을때,
연결에 문제가 있다. 한번에 하나의 account만 접속이 된다는
것이다. 이것을 해결하는 가장 대중적인 방식은 ssh로 multiple
account처리를 하는 것이다.


## ssh키로 multiple accounts 설정 {#ssh키로-multiple-accounts-설정}


### ssh key 생성 {#ssh-key-생성}

ssh로 개인키와 공인키를 만들어야 한다. 옛날에는 rsa를 사용했는데,
지금은 간단한 방식을 사용한다. ed25519를 사용한다.
(참조:[여기](https://docs.github.com/ko/authentication/connecting-to-github-with-ssh/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent))

-   holy2frege 계정(main-blog)

<!--listend-->

```shell
ssh-keygen -t ed25519 -C "holy2frege.nil@gmail.com" -f ~/.ssh/id_holy2frege
```

-   hoyoul 계정(brain-dump)

<!--listend-->

```shell
ssh-keygen -t ed25519 -C "hoyoul.park@gmail.com" -f ~/.ssh/id_hoyoul
```

-   holytofrege 계정(portfolio)

<!--listend-->

```shell
ssh-keygen -t ed25519 -C "holytofrege@fastmail.com" -f ~/.ssh/id_holytofrege
```


### ssh public key 등록 {#ssh-public-key-등록}

~/.ssh폴더에 public key와 private key가 만들어진다. 여기서 public
key를 github에 등록한다. public key를 복사해서 붙여넣기 해야하는데,
아래처럼 따라하면 된다.

```emacs-lisp
cd ~/.ssh
```

위에 경로에 보면 pub라는 postfix를 가진 파일이 public key다. 이것을
에디터로 열어서 복사해서 github-&gt;settings-&gt;ssh &amp; gpg에 붙여넣는다.


### ~/.ssh/config 설정과 agent {#dot-ssh-config-설정과-agent}

매번 다른 github에 연결해서 push를 할때 key 인증이 실행되는데,
multiple account를 등록했기 때문에 중앙에서 이를 control할께
필요하다. agent가 그런일을 하는데,

```shell
eval "$(ssh-agent -s)"
```

이렇게 실행한다. config를 설정된 정보를 agent가 처리하는데, config를
설정하기전 미리 실행해도 상관없다. 이제 config를 설정하자.
다음과 같이 설정한다.

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
# 세번째 계정
Host github.com-holytofrege
    HostName github.com
    User holytofrege
    IdentityFile ~/.ssh/id_holytofrege
```

여기서 눈여겨 봐야 하는건, 첫번째 줄의 HOST다.

```text
Host github.com-holytofrege
```

이게 왜 중요하냐면 git clone할때, github의 repo를 들어가서 주소를
복사한 후

```text
git clone 주소붙여넣기
```

위와 같이 하는데, 이게 안된다. 이렇게 하면 안된다. 수정이 필요한데,
위에서 적은 HOST정보를 추가해야 한다.

```text
git clone git@github.com-holytofrege/adfasf/asdfa/
```

위와 같이 github.com 다음에 -holytofrege같이 host에 있는 정보를
붙여줘야 한다.


### server 연결 test {#server-연결-test}

위와 같이 config와 ssh agent가 떠 있는 상태에서 연결을 테스트
해보자. 기본적으로 아래와 같이 한다.

```emacs-lisp
ssh -T git@ host명
```

각 계정별 하는 법은 아래와 같다.

```text
ssh -T git@github.com-holy2frege
ssh -T git@github.com-hoyoul
ssh -T git@github.com-holytofrege
```

사용자를 git으로 하고, host명을 입력해서 server에 접속 유무를 test할
수 있다.

<a id="figure--ssh연결"></a>

{{< figure src="/img/github/ssh.png" caption="<span class=\"figure-number\">Figure 1: </span>ssh연결" width="600px" >}}


### ssh로 clone을 해서 사용한다. {#ssh로-clone을-해서-사용한다-dot}

이제 github에서 repo를 clone해보자. 이전에도 말했지만, repo를
clone시에 http, ssh인지 github cli가 있는데, ssh를 선택한다. 그리고
github주소를 변경해야 한다. 어떻게 변경해야 하냐면, 이전에
~/.ssh/config의 설정할 때 HOST에 있는 postfix를 추가하는 것이다. 예를
들어서, github에서 복사한 주소는 아래와 같다면,

```text
git@github.com:hoyoul/holy-brain.git
```

github.com옆에 postfix를 붙인다. ssh/config에서 설정한 host명으로
바꿔야 한다.

```text
git@github.com-hoyoul:hoyoul/holy-brain.git
```


## github profile 설정 {#github-profile-설정}

이제 계정에 접속해서 clone하는건 문제없이 된다. 그런데 commit을 push할
때 문제가 될 수 있다. git으로 commit을 만들때, username과 email주소가
원하는대로 안들어가는 문제다. 이것은 ~/.gitconfig에 있는 default
내용이 들어가기 때문이다. 물론 하나의 계정만 사용될때는 위의
config파일에 있는 username과 email을 사용해서 commit을 만들면 된다.
다음과 같이...

<a id="figure--git config"></a>

{{< figure src="/img/github/gitconfig.png" caption="<span class=\"figure-number\">Figure 2: </span>git config" width="600px" >}}

하지만, 여러개의 github계정을 사용하기 때문에 다른 계정에 대한 처리도
해줘야 한다. root에서 사용되는 계정 정보외에도 다른 계정의 정보도
적는다. 양식은 다음과 같다. root의 .gitconfig에 설정한다.

```text
[user]
   name = holy frege
   email = hoyoul.park@gmail.com

[includeIf "gitdir:~/Documents/Blogs/holy-brain"]
   path = ~/Documents/Blogs/holy-brain/.gitconfig
[includeIf "gitdir:~/Documents/Blogs/main-blog/"]
   path = ~/Documents/Blogs/main-blog/.gitconfig
[includeIf "gitdir:~/Documents/Blogs/portfolio/"]
   path = ~/Documents/Blogs/portfolio/.gitconfig
[includeIf "gitdir:~/Documents/Projects/Work/"]
   path = ~/Documents/Projects/Work/.gitconfig
```

나는 나머지도 동일한 이름과 email로 했다.


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

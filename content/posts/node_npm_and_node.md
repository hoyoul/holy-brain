+++
title = "[node] npm and node"
author = ["holy"]
description = "node의 간략한 사용법"
date = 2023-07-29T00:00:00+09:00
draft = true
+++

## node {#node}

node는 javascript interpreter로 봐도 된다. python 파일을 실행시키기
위해서 python interpreter가 있듯이 또 ruby를 실행시키기 위해서
ruby가 있는것과 비슷하다. 위 3가지 언어는 비슷하다.


## npm {#npm}

npm은 package관리자다. ruby에 gem이 있듯이, python에 pip가 있듯이
package를 설치하는 것은 동일하다. 하지만 package를 위한 project의
구조와 package의 의존성을 관리하는 방식, package를 배포하는 방식도
다르다. 여기서는 단순히 몇가지 명령어를 알아보자.


### npm init -y {#npm-init-y}

project를 위해서 폴더를 만들고, 폴더안에서 package init을 하면
package.json이 만들어진다. 이것이 현재 project가 의존하는 package를
나타내고 배포가 되었을때도 참조하는 package를 설치할 수 있게
해준다. package.json에는 entry point라고 해서 시작점에 해당하는 js를
기술하게 한다.


### npm install {#npm-install}

가장 많이 사용되는 명령어라고 할 수 있다. package를 설치하는
명령어다. project에서 npm install이라고 하면, package.json에 의존성
package를 모두 node_modules라는 폴더에 설치한다. npm install
[package명]은 특정한 package를 설치하고 package.json에 기록한다. pip
install과 같은거라고 보면 된다. pip install로 package를 설치한다고
해서 requirement.txt에 기술이 되지 않는데, 어떻게 보면 npm이 project의
제작과 배포에 더 편리하다고 볼 수 있다.


#### npm install [package명] -g {#npm-install-package명-g}

system에 package를 설치한다.


#### npm install --save [package명] {#npm-install-save-package명}

package.json에 기록된다. --save는 최신버전에서는 default이기 때문에
npm install package와 같다.  이렇게 기록되면 나중에 배포해서 npm
install할때 한큐에 설치할 수 있다.


#### npm install --save-dev [package명] {#npm-install-save-dev-package명}

이것은 현재 설치는 하지만, 개발할때만 사용한다.


#### npm uninstall [package명] {#npm-uninstall-package명}

package를 uninstall한다.


#### npm run {#npm-run}

package.json에 보면 다음과 같이 script가 정의되어 있다.

<a id="orgc2704a0"></a>

<img src="/img/nodejs/npm.png" alt="npm.png" width="600px" /> script를 실행하는 명령어가 npm
run이다. 여기에는 test라는 이름으로 script가 되어 있기 때문에 다음과
같이 실행한다.

```text
npm run test
```

에디터를 열고 다음을 추가해도 된다. 에디터를 사용하지 않는 방법도 있다.

```text
"start": "node index.js"
```

위와 같이 추가하고,

```text
npm run start
```

하면 된다.


## nvm {#nvm}

node도 python처럼 버전을 많이 탄다. 그래서 가상환경을 사용해야
한다. ruby에서 rvm이나 rbenv를 사용했던것과 동일하다. python의
pyvenv나 conda env와도 같다. 사용법은 단순하다.


### brew install nvm {#brew-install-nvm}

brew로 nvm을 설치한다. 그리고

```text
mkdir ~/.nvm
```

을 만들고 .zshrc에 다음을 추가한다.

```shell
export NVM_DIR="$HOME/.nvm"
 [ -s "/usr/local/opt/nvm/nvm.sh" ] && \. "/usr/local/opt/nvm/nvm.sh"  # This loads nvm
 [ -s "/usr/local/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/usr/local/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion
```

이것은 brew install nvm을 실행하면 설치하라고 나온다.


### nvm version {#nvm-version}

nvm의 version을 확인한다.


### nvm list {#nvm-list}

현재 설치된 node version들을 확인한다.


### nvm use {#nvm-use}

사용할 node를 선택한다.


### nvm install v18.17.0 {#nvm-install-v18-dot-17-dot-0}

현재 node의 최신버전은 v18.17.0이다. node -v로 확인할 수 있다. 만일 옛날 version이라면 새롭게 node를
설치한다.


## node로 이미 만들어진 project를 가져오면 해야할 것 {#node로-이미-만들어진-project를-가져오면-해야할-것}

가장 먼저 해야 할 것은 사용되는 node의 version에 node를 선택한다.

```text
nvm list
nvm use v18.17.0
```

그 다음, github에 서 가져온 project에서 npm install을 실행한다.

```text
npm install
```

node project를 가져올 경우, package.json에 의존성 package가 기술되어
있다. 개발을 위해선 위 명령어를 통해 모두 설치한다.

```text
npm start
```

npm start는 보통 node [entrypoint file]을 실행하는 것과 실행된다는
면에서만 같다. npm start가 다른건, script를 지정해주고 지정한 script가
실행된다는 것이다. 그냥 node main.js 이렇게 하면 실행은 되지만 node
project가 실행되는 건 아니다. node project의 실행은 pakcage.json에
다음과 같이 지정해 주어야 한다.

```shell
{
  "scripts": {
    "start": "node ."
  }
}
```


## 새롭게 node project를 하려면 {#새롭게-node-project를-하려면}

어떤 node project를 만들려면 우선 directory를 만든다. 그리고 그 안에서
다음과 같은 명령을 내린다.

```text
npm init
```

그러면 package.json이 만들어진다. 이렇게 하면 node project가
만들어진다. 필요한 package를 설치해서 사용한다.

```text
npm install color --save
```

--save는 default값이라서 생략해도 된다. 이렇게 설치하면 package.json에
  의존성 package로 등록된다.

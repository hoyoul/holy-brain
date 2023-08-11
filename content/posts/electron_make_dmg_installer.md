+++
title = "[electron] make dmg installer"
author = ["holy"]
description = "make dmg installer"
date = 2023-08-09T00:00:00+09:00
draft = true
+++

## dmg installer란? {#dmg-installer란}

우선 dmg installer가 뭔지 알아야 한다. dmg installer는 아래와 같은
모양이다.

<a id="figure--dmg installer"></a>

{{< figure src="/img/electron/dmginstaller.png" caption="<span class=\"figure-number\">Figure 1: </span>dmg installer" width="600px" >}}

mac에서 실행되는 app을 다른 사람에게 배포할때 사용하는 program을 dmg
installer라고 부른다. 간단히 말해서 dmg라는 설치 파일을 만드는 것이다.


## 내 의도 {#내-의도}

우리의 원래 계획은 electron으로 어플을 만들고, mac app으로 변환한 후,
dmg파일로 만들어 배포하는 것이다. swift로 mac app을 만들고 dmg로
만드는게 아니다. 여기서는 electron app으로부터 dmg파일을 만드는 과정을
나열한다.


## dmg installer만들기 {#dmg-installer만들기}

electron project를 만들고, mac app을 만들어야 한다. mac app을 만든 후
create-dmg로 dmg를 만들면 끝이다.


### node project부터 dmg 만들기 {#node-project부터-dmg-만들기}

electron project를 만들어야 한다. electron project를 만드는 법은
여러가지가 있다. 그중 node project를 만들고 이것으로부터 dmg를 만들자.


#### node project에서 mac app만들기 {#node-project에서-mac-app만들기}

<!--list-separator-->

-  electron package 설치및 start script작성

    폴더를 만든다. 그리고 최신 node를 nvm use v18.0.0으로 설정 후
    project를 만든다.

    ```text
    npm init
    npm install --save-dev electron
    ```

    electron을 만들기 위해서 electron을 설치한다. electron은 일반적인 node
    app과 달리 필수적으로 처리해줘야 하는게 있다. package.json을 열고
    "scripts":"test"부분을 다 지우고 아래와 같이 한다.

    ```text
    "scripts":{
          "start": "electron ."
          }
    ```

    이렇게 해야 npm start로 실행할 수 있다.

<!--list-separator-->

-  index.html 생성

    root에 만든다.

    ```html
    <!DOCTYPE html>
    <html>
      <head>
        <meta charset="UTF-8">
        <!-- https://developer.mozilla.org/en-US/docs/Web/HTTP/CSP -->
        <meta http-equiv="Content-Security-Policy" content="default-src 'self'; script-src 'self'">
        <meta http-equiv="X-Content-Security-Policy" content="default-src 'self'; script-src 'self'">
        <title>Hello World!</title>
      </head>
      <body>
        <h1>Hello World!</h1>
        We are using Node.js <span id="node-version"></span>,
        Chromium <span id="chrome-version"></span>,
        and Electron <span id="electron-version"></span>.
      </body>
    </html>
    ```

<!--list-separator-->

-  index.js 생성

    root에 만든다.

    ```js
    const { app, BrowserWindow } = require('electron')
    // include the Node.js 'path' module at the top of your file
    const path = require('path')


    // modify your existing createWindow() function
    function createWindow () {
      const win = new BrowserWindow({
        width: 800,
        height: 600,
        webPreferences: {
          preload: path.join(__dirname, 'preload.js')
        }
      })
      win.loadFile('index.html')
    }
    app.whenReady().then(() => {
      createWindow()
    })
    app.on('window-all-closed', function () {
      if (process.platform !== 'darwin') app.quit()
    })
    ```

<!--list-separator-->

-  preload.js 생성

    root에 만든다.

    ```js
    window.addEventListener('DOMContentLoaded', () => {
      const replaceText = (selector, text) => {
        const element = document.getElementById(selector)
        if (element) element.innerText = text
      }

      for (const dependency of ['chrome', 'node', 'electron']) {
        replaceText(`${dependency}-version`, process.versions[dependency])
      }
    })
    ```

<!--list-separator-->

-  npm start로 실행

    아래와 같은 app이 만들어진다.

    <a id="figure--electron app"></a>

    {{< figure src="/img/electron/elecapp.png" caption="<span class=\"figure-number\">Figure 2: </span>electron app" width="600px" >}}

<!--list-separator-->

-  electron forge 설치

    forge를 설치하면 electron app을 mac app으로 packaging할 수 있다.

    ```emacs-lisp
    npm install --save-dev @electron-forge/cli
    npx electron-forge import
    ```

<!--list-separator-->

-  make

    아래 명령을 실행하면 out폴더에 project.app이라는 mac app이 만들어 진다.

    ```emacs-lisp
    npm run make
    ```


#### mac app으로 dmg 만들기 {#mac-app으로-dmg-만들기}

out폴더에 eapp.app이라는 mac app을 forge로 부터 만들었다. 이것을
dmg파일로 만드는 것은 간단하다. 우선 create-dmg라는 program을 설치해야
한다.

```shell
brew install create-dmg
```

위와 같이 해서 설치한다. 설치한 create-dmg를 실행하면
끝이다. out폴더의 mac app으로 이동한 후

```emacs-lisp
create-dmg ./app이름
```

이렇게 하면 dmg 파일이 만들어진다.


### npx create-electron-app {#npx-create-electron-app}

electron dmg app을 가장 빠르게 만드는 방법이다.


#### electron app만들기 {#electron-app만들기}

npx를 사용하면 된다. npx로 electron app을 만들면 electron을
따로 설치할 필요가 없다. 또한 electron-forge도 설치할 필요가
없다. electron-forge는 mac에서 사용하는 app을 만들어주는
package다. project를 만들기 위해서 최신 node로 설정하자.

```text
nvm use v18.0.0
```

project를 만들자.

```sh
npx create-electron-app simpleapp
```

이렇게 하면 위에서 node project를 만드는 방식보다 훨씬 간단히 만들 수
있다. 왜냐하면 simpleapp이란 폴더를 따로 생성할 필요도 없기
때문이다. 거기에 electron을 설치하고, 필수로
index.js,index.html,preload.js를 기본적으로 만들어주기 때문이다. 다
만들어준다. electron으론으로 app을 만들때는 무조건 npx create로
만든다. 여기서 npm start만 해주면 된다.

```emacs-lisp
npm start
```

<a id="figure--npx"></a>

{{< figure src="/img/electron/npx1.png" caption="<span class=\"figure-number\">Figure 3: </span>npx" width="600px" >}}


#### mac app만들기 {#mac-app만들기}

이미 electron forge까지 설치되어 있기 때문에 mac app을 만드는 것도
쉽다.

```text
npm run make
```

이렇게 해주면, out폴더에 mac app이 만들어진다.


#### dmg만들기 {#dmg만들기}

create-dmg를 사용해서 만들면 된다. 만일 없다면 brew install
create-dmg로 설치한다. mac app이 위치한 폴더로 간다.

```text
create-dmg app이름
```

이렇게 하면 dmg installer가 만들어진다.

<a id="figure--dmg installer"></a>

{{< figure src="/img/electron/dmg_installer1.png" caption="<span class=\"figure-number\">Figure 4: </span>dmg installer" width="600px" >}}


## dmg installer 꾸미기 {#dmg-installer-꾸미기}

dmg installer를 만들기 위해선 create-dmg를 사용하면 된다. swift로 mac
app을 만들던, node로 mac app을 만들던, app이 있다는 가정하에 말을
한다.

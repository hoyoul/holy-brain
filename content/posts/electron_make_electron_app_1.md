+++
title = "[electron] make electron app-1"
author = ["holy"]
description = "예전 자료 취합"
date = 2023-08-05T00:00:00+09:00
draft = true
+++

## hello world {#hello-world}

모든 program이 그러하듯, hello world를 출력하는 앱을
만들자. basic_electron_app이라는 git repo를 만들고 시작하자.


### 시작 (app 만들기) {#시작--app-만들기}

[여기](https://www.electronjs.org/docs/latest/tutorial/quick-start)에는 electron.js의 공식문서다. 여기에서 나온대로 해보자.


#### npm init {#npm-init}

entry point는 main.js로 하고 project를 만든다.


#### npm install --save-dev electron {#npm-install-save-dev-electron}

electron을 설치한다.


#### start script 작성 {#start-script-작성}

package.json파일을 열고 script에 "electron ."을 추가한다. 다음과 같이
하면 된다.

<a id="figure--package.json"></a>

{{< figure src="/img/node/package1.png" caption="<span class=\"figure-number\">Figure 1: </span>package.json" width="600px" >}}


#### error {#error}

main.js를 찾을 수 없다는 에러가 나온다. 왜냐면 위에서 script에서
start가 하는것은 electron .을 통해서 entry point의 file을 찾는데,
package.json에 기술된 entry.js는 main.js이고 이것은 아직 파일에 없기
때문이다.

<a id="figure--package.json"></a>

{{< figure src="/img/node/package1.png" caption="<span class=\"figure-number\">Figure 2: </span>package.json" width="600px" >}}


#### error의 해결 {#error의-해결}

root폴더에 main.js를 만든다. error는 안나지만 아무런 동작도 하지 않는다.


#### index.html {#index-dot-html}

node package는 web app을 만든다. web app은 html문서로 만들어지는
DOM이라는 data에 js로 manipulation을 하는것이다. 기본 데이터인 DOM은
필수적이다. 따라서 html파일이 있어야 한다. web server를 만들던, web
client를 만들던, electron으로 어플을 만들던, DOM이란 data가 필요하다.

```html
<!DOCTYPE html>
<html>
  <head>
    <meta charset="UTF-8">
    <!-- https://developer.mozilla.org/en-US/docs/Web/HTTP/CSP -->
    <meta http-equiv="Content-Security-Policy" content="default-src 'self'; script-src 'self'">
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


#### unpacking  app and browserWindow module in main.js {#unpacking-app-and-browserwindow-module-in-main-dot-js}

html을 시각적으로 보여주는것은 browser를 사용한다. 그런데
electron에서는 자체적으로 html을 화면에 보여준다. 이렇게 하기위해서
electron에는 browserwindow라는 module이 있다. 화면에 보여줄 수 있는
module이다. 그리고 우리가 만드는 것도 app이다. 따라서 app의 life
cycle을 관리하는 app 모듈도 있다. android나 ios에서 만드는 app들이
life cycle이 있는것과 동일하다.  main.js에서 electron.js를 load해서
unpacking한다. app과 BrowserWindow라는 module을 unpacking해서 사용할
수 있다.

```js
const { app, BrowserWindow } = require('electron')
```


#### ready event in app {#ready-event-in-app}

app에서 ready event가 발생하면 createWindow()가 호출된다. 여기서
browserWindow객체를 만들고, index.html을 load해서 보여준다. 그런데,
createwindow()라는게 event handler는 아니다. ready event의 event
handler는 WhenReady()다. 여기서 createwindow()를 호출할 뿐이다.

```js
const createWindow = () => {
  const win = new BrowserWindow({
    width: 800,
    height: 600
  })

  win.loadFile('index.html')
}
```

그런데 promise를 resolve하기 위해서 중간에 WhenReady()를 사용한다.

```js
app.whenReady().then(() => {
  createWindow()
})
```

이렇게 하고 npm start로 실행하면 다음과 같은 window를 볼 수 있다.

<a id="figure--window"></a>

{{< figure src="/img/node/bw1.png" caption="<span class=\"figure-number\">Figure 3: </span>window" width="600px" >}}


#### app management (main process) {#app-management--main-process}

<!--list-separator-->

-  개요

    app이 만들어졌다면 app은 상태를 갖는다. app은 event에 반응하는 event
    handler들이 있는데, 이것은 개발자들이 구현해야 한다. 그런데 이것이
    platform마다 기술하는게 다르다. 위에서 ready event는 먼저
    살펴봤다. app이 생성되면 최초로 받는 event다. 이제 다른 event를
    살펴보자.

<!--list-separator-->

-  window all closed event

     window나 linux같은 platform에서는 window가 모두 close되면, app도
    exit하게 처리한다. 그래서 'window-all-closed'라는 event가
    존재한다. 모든 window들이 다 close되어 active한 window가 없게 된다면
    위에 말한 event가 fired되고, linux나 window platform은 app이 종료되게
    해주어야 한다. 반면 mac은 상관없다. 아래 보면 eventhandler이 app.on()
    코드가 있다. event handler를 electron.js framework에서는 on()로
    표현한다. event명은 인자로 주어진다. 여튼 event를 받으면 어떤 함수를
    수행하겠다? 이런 의미다.

    ```js
    app.on('window-all-closed', () => {
      if (process.platform !== 'darwin') app.quit()
    })
    ```

<!--list-separator-->

-  activate

    mac에서는 window all close event에는 어떤 반응을 하지 않아도
    된다. 반면에 mac에는 window나 linux와 달리, window가 없어도 app은
    여전히 살아 있다.  window나 linux에서는 열려진 window가 없다면 app이
    이미 종료되어 있다. 만일 activate라는 event를 받으면, mac의 경우
    window가 아예 없는 경우에서 받을 수도 있다는 말이다. 그래서 그런
    경우에 대한 처리를 해줘야 한다. 어떤 처리를 하냐면, 새롭게 window를
    만드는 것이다.

    ```js
    app.whenReady().then(() => {
      createWindow()

      app.on('activate', () => {
        if (BrowserWindow.getAllWindows().length === 0) createWindow()
      })
    })
    ```


#### Renderer process {#renderer-process}

<!--list-separator-->

-  개념

    app을 만들고, 만들어진 app이 life cycle을 가지며, event가 발생했을때
    event처리는 모두 main process의 역할이다. app을 만들때
    windowBrowser라는 module을 생성시키고, html을 인자로 받아서 window를
    만들지만, window에 내용을 rendering하는 것은 renderer라고 하는 별도의
    program이 있다. html문서가 DOM으로 만들어질때는 static한 text는 그대로
    출력되지만, js로 변경되는 부분은 renderer process에서 별도 처리 과정을
    거쳐서 화면에 보여진다. 그래서 app의 version정보가 출력이 안된
    것이다. 그냥 main process에서 version정보를 가져와서 DOM에 붙이는
    작업까지 다 해도 되는데 안한 이유는 access할 권한이 없기
    때문이다. DOM의 window객체와 Document객체에 접근할 수 있는 Renederer
    process는 preload.js를 호출하는데, 개발자는 이 js파일에서 DOM이 가진
    객체에 접근할 수 있다. 따라서, preload.js를 만들어야 한다.

<!--list-separator-->

-  preload.js

    preload는 js 문법이다. DOM을 load했을때는 replacetext라는 함수를
    만들었다. 이 함수는 html의 id의 값을 for-loop을 돌면서 replace한다. 이
    때, process는 nodejs의 내장객체다. process 객체를 통해서 node나 chrom,
    electron의 version을 구할 수 있다.

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

    preload.js에서는 DOM의 내용을 생성 변경할 수 있다. 이것은 app의 entry
    point인 main.js의 실행 흐름과는 다른 흐름을 갖는다고 했다. renderer
    process에 의해서 호출되고 사용되는데, 그렇게 하기 위해선 main.js에서
    windowBrowser객체가 생성될때, webPreferences에 path를 설정해서 load
    해서 실행하게 한다. main.js를 다시 작성하면 다음과 같이 된다.

    ```js
    const { app, BrowserWindow } = require('electron')
    // include the Node.js 'path' module at the top of your file
    const path = require('path')

    // modify your existing createWindow() function
    const createWindow = () => {
      const win = new BrowserWindow({
        width: 800,
        height: 600,
        webPreferences: {
          preload: path.join(__dirname, 'preload.js')
        }
      })

      win.loadFile('index.html')
    }
    // ...
    ```

    path를 load해서 path객체를 사용할 수 있게 한 후에 preload.js를
    BrowserWindow객체를 생성할 때 넘겨준다. BrowserWindow객체를 생성할때
    renderer에 해당하는 preload.js를 load하면, win.loadFile에서 html파일을
    load해서 DOM을 만든 이후에 rendering을 한다.

    코드를 잠깐 살펴보면 다음과 같다.

    ```js
    webPreferences: {
          preload: path.join(__dirname, 'preload.js')
        }
    ```

    __dirname은 root폴더를 의미한다. path.join은 concat해서 preload.js의
    path를 만들어낸다.


### 배포 {#배포}

Electron Forge를 사용해서 배포를 하는 게 가장 빠르다.


#### [step1] {#step1}

```text
npm install --save-dev @electron-forge/cli
npx electron-forge import
```


#### [step2] {#step2}

```text
npm run make
```

이렇게 하면, out 폴더에 zip파일이 만들어진다.

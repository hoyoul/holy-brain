+++
title = "[electron] make electron app-1"
author = ["holy"]
description = "예전 자료 취합"
date = 2023-08-05T00:00:00+09:00
draft = true
+++

## electron이란? {#electron이란}

electron은 system에서 동작하는 js interpreter와 browser를 연결해서
하나의 app으로 만든 것이다. system에서 동작하는 js interpreter를
node라고 부른다. node는 system에 설치된 js interpreter라서 local file
system도 접근하고, js로 된 파일도 해석한다. 마치 python이나 java를
system에 설치해서 사용하는 것과 같다. java a.java, python a.py를
실행하듯, node a.js를 실행하는 것이다. ui가 있는 program을 만들때,
java는 swing을 쓰고 파이썬은 qt를 사용해서 ui를 나타낸다. node는
chromium이라는 browser를 사용한다. browser의 ui화면을 사용하겠다는
것이다. electron의 entry point에서는 node가 실행할 js코드가 있는데
여기서는 browser를 생성하는 code가 있고, browser가 생성되면 2개의
process가 떠있게 된다. ui를 나타내는 browser process와 node의 main
process다. main process는 daemon처럼 계속 실행되는 형태다. while
loop가 돌고 있는 것이다. android나 ios app의 모든 app들의 종료는
사용자에 의해서 결정되기 때문에 무한 loop를 돌도록 설계
되었다. program의 code가 끝났다고 끝나는게 아니다. 무한 loop이 돌고
있어서 죽지 않는다. life cycle이 존재한다. electron도 똑같다. life
cycle이 있고 무한 루프를 돈다. event에 의해서 동작된다. 말이 길었지만,
electron은 다른 app과 비슷한 구조일 뿐이다. electron structure에 대한
좋은 그림이 있어서 가져왔다.

<a id="orgf5b2e38"></a>

<img src="/img/electron/electron_structure.png" alt="electron_structure.png" width="600px" />
참조주소: [다음](https://kadamon.tistory.com/30) 과 같다.


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

{{< figure src="/img/node/package1.png" caption="<span class=\"figure-number\">Figure 2: </span>package.json" width="600px" >}}


#### error {#error}

main.js를 찾을 수 없다는 에러가 나온다. 왜냐면 위에서 script에서
start가 하는것은 electron .을 통해서 entry point의 file을 찾는데,
package.json에 기술된 entry.js는 main.js이고 이것은 아직 파일에 없기
때문이다.

<a id="figure--package.json"></a>

{{< figure src="/img/node/package1.png" caption="<span class=\"figure-number\">Figure 3: </span>package.json" width="600px" >}}


#### error의 해결 {#error의-해결}

root폴더에 main.js를 만든다. error는 안나지만 아무런 동작도 하지 않는다.


#### main process {#main-process}

electron project에서 entry point로 지정된 js는 main process다. main
process는 android나 ios app처럼 죽지 않는 daemon이다. while true와
같이 무한 loop를 돈다. 그래서 life cycle이 있다. 그리고 ui를 위한
process인 renderer process를 생성한다. x window system하고도
비슷하다. x server에서 xclient라는 window창을 만들고 서로
통신한다. window도 ios도 android도 모두 비슷한 구조다. 각각의
window창은 xclient라고 봐도 된다. electron에서 main process는
browser를 생성한다. xclient라고 보면된다. browser는 xclient가 자신만의
xwidget으로 모양을 꾸미듯이 browser도 html,css,js로 모양을 꾸민다. x
server는 xclient를 관리하고 자신의 life cycle을 관리한다. electron도
똑같다. 자신의 life cycle과 browser통신하고 관리하는게 주임무다.

```js
const { app, BrowserWindow } = require('electron')
```

위의 코드는 main process에서 lifecycle을 위한 app과 browserwindow라는
client를 생성하기 위한 코드다.


#### ready event in app {#ready-event-in-app}

main process는 life cycle이 있다고 했다. main process는 무한 loop를
돌기 때문에 죽지 않는다. 대신에 life cycle이 있는데, 이것은 event
driven 방식이다. event를 받으면, 그것이 system에서 발생했던, renderer
process에서 발생했던, event가 발생하면 상태가 변하는 것이다. 그때 call
back함수를 처리하는 방식이다. app이 처음 시작할때 system이 app에게
ready event를 보낸다. 그때 main process는 createWindow()를 호출해서
browserWindow객체를 만든다. 즉 renderer process를 만들고 index.html을
load해서 보여준다.  ready event가 발생할 때 createWindow를 호출한다고
했는데, 그때 event handler는 WhenReady()다. 여기서 createwindow()를
호출한다.

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

이렇게 처리를 하면, npm start로 app을 실행하면 다음과 같은 window를 볼 수 있다.

<a id="figure--window"></a>

{{< figure src="/img/node/bw1.png" caption="<span class=\"figure-number\">Figure 4: </span>window" width="600px" >}}


#### app management (main process) {#app-management--main-process}

<!--list-separator-->

-  개요

    app이 만들어졌다면 app은 상태를 갖는다. app은 event에 반응하는 event
    handler들을 만들면 된다. 어떤 event가 있는지는 manual에 있고, 이것은
    개발자들이 구현해야 한다. 그런데 이것이 platform마다 다르다고 한다.
    여튼 app이 생성되면 최초로 받는 ready event는 위에서 처리했고, 이것을
    처리해야 뭔가를 볼수 있는것이다. 다른 event도 살펴보자.

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

-  activate event

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

-  index.html

    ui를 나타내는 browser process는 main process에서 생성한다. browser
    process는 renderer process라고 하는데 ui를 나타내기 위해서
    html,css,js가 필요하다.

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

    여기서는 chromium이라는 renderer process가 사용하는 html문서다. node의
    version,chromium의 version, electron의 version을 화면에 출력한다. 그런데 좀 이상하다.

    <div class="important">

    id로 version을 기술한 것은 js에서 처리하려고 하는데, js를 include하지
    않았다. 그렇다면 span의 값들인 version정보를 js에서 처리해서 보여줄
    생각이 없다는 의미인가?

    </div>

    여기서 js를 script src를 통해서 접근하지 않는데, renderer의
    preload.js에 대한 설명을 할려고 이런 예를 들었다. 이것에 대한
    설명은 계속 될 것이다.

<!--list-separator-->

-  preload.js

    app을 만들고, 만들어진 app이 life cycle을 가진다. 그것에 대한 처리,
    그리고 event가 발생했을때 event처리, 이 모든 것은 main process의
    역할이다.main process는 windowBrowser라는 chromium을 ready event를
    받으면 생성시켰다. 이렇게 생성된 process를 renderer process라고 하고,
    html,css,js로 화면을 구성한다.  html문서는 renderer인 chromium에
    의해서 DOM으로 만들어진다. 위에서 보면 DOM은 만들어졌을 것이다. 그런데
    chromium,node,electron의 version정보는 renderer process에서는 알수가
    없다. 왜냐 main process에서 사용되는 것들이기 때문이다. main
    process에게 요청해서 정보를 얻어서 화면에 보여줘야 한다. 그런데 그렇게
    할려면 서로 다른 process에서의 통신이기 때문에 IPC를 사용해서 정보를
    얻어오고 js에서 보여줘야 하는게 일반적 방식이다. 그런데 여기선
    preload.js에서 처리한다. 어떻게 preload.js에서 처리한단 말인가?
    preload.js는 main process가 renderer process에 보낸
    자객이다. preload.js를 생성하는건 main process다. 그리고 renderer
    process가 동작할때 thread로 분기해서 실행되기 때문에 renderer에 대한
    정보에도 접근할 수 있고 node에 대한 정보에도 접근할 수 있다. 나는
    spy라고 표현했지만, bridge라는 더 좋은 용어도 있다. 여튼 위의 예에서
    node,chromium,electron의 version을 화면에 보여줄려면, preload를
    이용해서 보여줄 수 있다. 그런데 preload의 사용은 많지 않고, ipcmain과
    ipc renderer 사이의 직접적인 통신으로 data를 주고 받는다고 한다.

<!--list-separator-->

-  preload.js

    preload는 spy다. chromium이 DOM을 load했을때 event가 발생한다. 이
    event를 preload.js에서 가로챈다. 이렇게 가로챌수 있는것은 chromium
    browser가 index를 load하고 초기화할때 preload.js도 같이 실행되기
    때문이다. chromium이 생성되고, index.html을 DOM으로 만들면 event가
    발생되고, preload.js에 event handler가 수행된다. 그런후 renderer의
    초기화 과정이 끝나면 preload.js도 수행된다. 이때 replacetext라는
    함수를 호출해서 버전 처리를 한다.이 함수는 html의 id의 값을 for-loop을
    돌면서 replace한다.

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

    preload.js가 main프로세스가 가지고 있는 node,chromium,electron의
    version정보에 접근할 수 있는 이유는, main process가 preload를
    renderer의 thread로 실행시키기 때문에 별도 연락하는 채널이
    있는것이다. 그것이 process다. process는 main process를
    가리킨다. 위에서 process를 통해서 version정보를 가져오는 코드를 확인
    할 수 있다. 아래는 main process에서 chromium을 생성할때 별도의
    thread로 preload를 실행 시키는 코드다.

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

    path를 지정하는 이유는 preload.js를 browser가 thread로 만들기 위해서
    필요한것이다. main process에서 BrowserWindow객체를 생성하고,
    browser객체가 preload를 thread로 만드는 것이다. 이렇게 해서 browser와
    main이 모두 접근할 수 있는 spy가 되는 것이다.


### 배포 {#배포}

Electron Forge를 사용해서 배포를 하는 게 가장 빠르다. electron forge는
mac app을 만드는 도구다. app파일이 만들어진다. 만일 window라면 exe라는
파일이 만들어진다.


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

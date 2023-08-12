+++
title = "[electron] drag n drop"
author = ["holy"]
description = "drag n drop"
date = 2023-08-11T00:00:00+09:00
draft = true
+++

## 의도 {#의도}

electron으로 drag n drop을 사용할 일이 많을 듯하다. file이나 url을
drag n drop으로 electron app에 넣는 것을 해보자. 이것은 [electron
principles]({{< relref "electron_basic_principles" >}})에 대한 이해가 필요하다.


### electron project 만들기 {#electron-project-만들기}

먼저 project를 만들자. nvm use v18.0.0으로 한후 만든다.

```shell
npx create-electron-app ddapp
```

index.html이 이미 src폴더 아래 만들어졌다. 다음 tag를 추가한다.

```html
<div id = "dropzone"></div>
```

동일한 위치에 style.css를 만든다.

```css
 * {
}

body{
    width: 100vw;
    height: 100vh;
}

#dropzone {
    border-radius: 10px;
    margin:10px auto;
    width: 70vw;
    height: 40vh;
    border: 30x dotted crimson;
}

```

renderer.js도 만든다.

```js
const dropzone = document.getElementById("dropzone")

dropzone.addEventListener("dragover", (e)=>{
    e.stopPropagation();
    e.preventDefault();
});
dropzone.addEventListener("drop", (e) => {
    e.stopPropagation();
    e.preventDefault();

    console.log(e)
})
```

여기까지 하면 renderer process를 만든것이다. 즉, main process는
package.json에 기술된 index.js이고, index.html,style.css.renderer.js는
renderer process가 된다. process와 main process에 대한 설명은 [여기]({{< relref "electron_basic_principles" >}})를
참조한다. 여기까지 하고 npm start로 실행시켜 보자.

<a id="figure--dd1"></a>

{{< figure src="/img/electron/dd1.png" caption="<span class=\"figure-number\">Figure 1: </span>dd1" width="600px" >}}

예상과 다르다. 위에서 기술한 index.html과 renderer.js가 실행되지 않고
개발자도구가 켜져 있다. 아무래도 이것은 main process에서 renderer
process를 실행하지 않는듯하다. renderer에 해당하는 index.html에서
css와 js연결이 잘못 되어 있고, main process에 보니 개발자 도구가 켜져
있다.  // mainWindow.webContents.openDevTools(); 그래서 주석처리하고
다시 실행했다.

<a id="figure--dd2"></a>

{{< figure src="/img/electron/dd2.png" caption="<span class=\"figure-number\">Figure 2: </span>dd2" width="600px" >}}

제대로 동작했다. 여기서 renderer js에 event handler를 만들었는데,
제대로 동작하는지 확인해 보자.


#### 개발자 도구와 refresh {#개발자-도구와-refresh}

그런데 개발 도구 창을 닫아버렸다. 개발 도구창을 f12누르면 나올 수
있도록 ipc처리를 해보자. renderer에서 f12를 누르면 main에게 알려서
개발도구창을 열게 하는 것이다. f5를 누르면 refresh도 하게 하자.

main process에 해당하는 index.js를 수정하자. ipcmain을 사용할 수 있게
하고 on함수를 사용하자.

```js
const { app, BrowserWindow, ipcmain } = require('electron');
```

ipcmain을 가져오고, 여기서 renderer가 보내는 message를 처리한다.

```js
//렌더러프로세스에서 보내는 메시지 처리
ipcMain.on('toggle-debug', (event, arg)=> {
    //디버기 툴 토글(on/off)
    win.webContents.toggleDevTools()
})
ipcMain.on('refresh', (event, arg)=> {
    //페이지 갱신
    win.reload();
})

```

renderer process에 해당하는 renderer.js도 수정해야 한다.

```js
const { ipcRenderer } = require('electron')
```

```js
// 키보드 입력
document.addEventListener('keydown', (event) => {
    if(event.keyCode==123){ //F12
        //메인프로세스로 toggle-debug 메시지 전송 (디버그 툴 토글시켜라)
        ipcRenderer.send('toggle-debug', 'an-argument')
    }
    else if(event.keyCode==116){ //F5
        //메인프로세스로 refresh 메시지 전송 (페이지를 갱신시켜라)
        ipcRenderer.send('refresh', 'an-argument')
    }
})

```

근데, 여기서 main process에서 renderrer process가 보내는 값에 따라
에러가 발생한다.
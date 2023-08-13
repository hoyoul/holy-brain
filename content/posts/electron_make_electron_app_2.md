+++
title = "[electron] make electron app-2"
author = ["holy"]
description = "app만들기"
date = 2023-08-05T00:00:00+09:00
draft = true
+++

## 예제 {#예제}

youtube에서 옛날꺼긴 하지만, 좋은 강의같은게 있어서 [참고](https://www.youtube.com/watch?v=KN2rg0PCjvA&list=PLqh5vK4CKWeZDGPhn5IMk3uZv2rQ5hNSK&index=4) 해보기로
한다. 내가 예젠에 electron을 사용할때와 version이 달라서 많은것이
바꼈다. 이 강의도 옛날꺼라서 지금과는 다르다.


## login 페이지 만들기 {#login-페이지-만들기}

codepen에 괜찮은 login [page](https://codepen.io/frytyler/pen/nJYVEO)가 있어서 이것을 적용하기로 한다. 이전에
작업하던 project에 styles.css를 만든다. 그리고 codepen에서 긁은 css를
붙인다. 그리고 index.html에 link를 걸자.

```html
<link rel="stylesheet" href="./style.css">
```

html의 div태그도 붙여준다. codepen에서 그냥 긁어서 붙여주면된다.

```html
<div class="login">
        <h1>Login</h1>
    <form method="post">
        <input type="text" name="u" placeholder="Username" required="required" />
        <input type="password" name="p" placeholder="Password" required="required" />
        <button type="submit" class="btn btn-primary btn-block btn-large">Let me in.</button>
    </form>
</div>
```

그리고 실행을 하면 다음과 같이 login화면이 나온다.

<a id="figure--login"></a>

{{< figure src="/img/node/first_electron1.png" caption="<span class=\"figure-number\">Figure 1: </span>login" width="600px" >}}


## require() is not defined 에러 {#require-is-not-defined-에러}

electron은 nodejs에서 동작하는 main process가 있고, chrom에서 동작하는
renderer process가 있다. 두개의 js interpreter는 다르다. nodejs는
common js라는 grammar를 사용한다. browser는 ES6라는 grammar를
사용한다. 대표적으로 js를 load할 때 nodejs에서는 require를
사용한다. ES6는 import를 사용한다. 그래서 renderer에 해당하는 html이나
js에선 import를 사용한다. 예를 들면, html에선

```js
<script type="module">
    import {init} from './test.js'
</script>
```

위와 같이 사용하고 js에선 바로 import module을 사용한다.

따라서 ES6 js 코드에서 require를 사용하면 require() is not defined
라는 에러가 난다. 왜냐면 ES6에서는 import를 사용하기
때문이다. 해결책은 처음에 project를 만들때 npx create-electron-app을
사용해서 만들면 es6문법을 사용하는 renderer의 html,js의 요소들을
commmon js로 바꿔준다고 한다. webpack과 같은 bundler에서 이렇게 통일된
작업을 한다고 한다. 나는 node에서 project를 만들어 사용했기 때문에
별도의 처리를 해줘야 한다.

```js
createMainWindow() {
    mainWindow = new BrowserWindow({
        webPreferences: {
            nodeIntegration: true, contextIsolation: false,
        },
});
```

위와 같이 해주면 된다고 한다. 에러는 없어졌지만 warning이 많아 졌다.


### warning1 {#warning1}

첫번째 warning은 CSP 관련 warning이다.

```text
node:electron/js2c/renderer_init:2 Electron Security Warning (Insecure Content-Security-Policy) This renderer process has either no Content Security
  Policy set or a policy with "unsafe-eval" enabled. This exposes users of
  this app to unnecessary security risks.

For more information and help, consult
https://electronjs.org/docs/tutorial/security.
This warning will not show up
once the app is packaged.
```

이것은 아래와 같이 preload.js에서 warning을 안보이게 처리했다.

```emacs-lisp
process.env['ELECTRON_DISABLE_SECURITY_WARNINGS'] = 'true'
```


### warning2 {#warning2}

그리고 다음 warning이 많다.  아래 warning이 많은데, 이것을 stack
overflow에는 [다음](https://stackoverflow.com/questions/61339968/error-message-devtools-failed-to-load-sourcemap-could-not-load-content-for-chr)과 같은 해결책을 준다.

```text
DevTools failed to load source map: Could not load content for file:///Users/fregeholy/hoyoul_projects/basic-electron/node_modules/parse5/dist/cjs/index.js.map: Unexpected end of JSON input
```

해결책은 그냥 개발자 도구에서 source map을 꺼두는 것이다. 이렇게 하면
warning이 다 없어진다.

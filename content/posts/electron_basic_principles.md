+++
title = "[electron] basic principles"
author = ["holy"]
description = "electron의 기본 구조."
date = 2023-08-11T00:00:00+09:00
draft = true
+++

## main process와 renderer process {#main-process와-renderer-process}

electron에는 2개의 process가 있다. main process와 renderer process라고
하는데, main process는 node process로 보면 되고, renderer는 chromium
browser process라고 보면 된다. 유명한 그림으로 다음과 같은 것이 있다.

<a id="figure--electron processes"></a>

{{< figure src="/img/electron/electron_principle1.png" caption="<span class=\"figure-number\">Figure 1: </span>electron process" width="600px" >}}


### main process {#main-process}

electron app은 entry point가 있다. 보통 main.js or index.js다.
package.json을 열어보면,main.js나 index.js가 start로 표시되어 있는
것을 확인할 수 있다. node가 entry point를 실행하고, main process가
된다. 이 process는 node process라서 system과 통신을 할 수
있다. system입장에선 하나의 system process이기 때문에 file에 접근도
가능한 것이다. electron app의 입장에선 main process가 app의 life
cycle도 책임지고 browserWindow로 window를 만드는데, window 관리도
한다. main process는 무조건 하나이상의 browserWindow를 갖게 되어
있다. 쉽게 생각하면 package에 정의된 main.js는 그냥 main process로
이해하면 된다.


### renderer process {#renderer-process}

main은 browserWindow로 window창을 만들뿐 창을 rendering하는것은
renderer process에서 한다. 창을 만든다는 것은 chomium browser를 실행만
시킨다는 것이다. 웹페이지와 웹페이지를 보여주는 내부 구성요소인
react나 vue, html,css,js는 chromium browser안에서 웹페이지를
만들뿐이다. renderer process가 뭐냐라는 질문에 그냥 간단히 project를
만들고, index.html,과 index.html을 사용하는 css,js 모두 renderer
process라고 생각하면 된다. package.json에서 main.js로 지정한것 이외의
것을 renderer process라고 생각하면 된다.


## <span class="org-todo todo TODO">TODO</span> IPC 통신 {#ipc-통신}

main process와 renderer process는 서로 통신을 한다.
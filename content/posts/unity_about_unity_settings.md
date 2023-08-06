+++
title = "[unity] about unity settings"
author = ["holy"]
description = "옛날 자료 취합중"
date = 2023-08-06T00:00:00+09:00
draft = true
+++

## 설치 {#설치}


### unityhub 다운 {#unityhub-다운}

-   [여기](https://unity.com/download#how-get-started)에서 unity hub를 다운받는다.

<a id="figure--"></a>

{{< figure src="/img/unity/unityhub1.png" width="600px" >}}


### unity 다운 {#unity-다운}

-   unityhub는 여러개의 unity가 설치될 수 있는 hub다. unity를 설치해보자.

<a id="figure--"></a>

{{< figure src="/img/unity/unity1.png" width="600px" >}}

-   unity version 선택

<a id="figure--"></a>

{{< figure src="/img/unity/unity2.png" width="600px" >}}

-   android, ios 추가 설치

<a id="figure--"></a>

{{< figure src="/img/unity/unity3.png" width="600px" >}}

-   unity 설치 진행

<a id="figure--"></a>

{{< figure src="/img/unity/unity4.png" width="600px" >}}


### android, ios 관련 설치 {#android-ios-관련-설치}

-   ios 는 xcode가 필요.
-   android는 android studio가 필요하다. xcode나 android studio가 없다면, 없는것을 설치한다.


## Project 실행 {#project-실행}

-   project 생성

<a id="figure--"></a>

{{< figure src="/img/unity/project1.png" width="600px" >}}

-   Project 만들기

<a id="figure--"></a>

{{< figure src="/img/unity/project2.png" width="600px" >}}

<div class="warning">

project를 만들수 없다. valid license가 없다는 에러가 나오면서 진행되지 않는다. License를 만든후 진행하면 만들어지는 것을 확인할 수 있다.

</div>


## License를 만들기 {#license를-만들기}

-   login
    license는 login을 해야 한다. login후 manual activation을 해도 된다.


## Project 실행 {#project-실행}

-   project 실행 화면

<a id="figure--"></a>

{{< figure src="/img/unity/project3.png" width="600px" >}}


## 사용법 {#사용법}


### emacs를 편집기로 사용 {#emacs를-편집기로-사용}

-   lsp C#(ommisharp)을 위해서 mono를 다운받는다.
    [여기](https://www.mono-project.com/download/stable/)에서 stable channel에서 다운받는다. 그리고 설치된 위치에서 다음을 설정해야 한다.
    -참조
    <https://elizadev.medium.com/using-unity-editor-with-emacs-9316eb441411>
    bin_dir=/Library/Frameworks/Mono.framework/Versions/Current/bin
    <https://github.com/OmniSharp/omnisharp-roslyn/issues/1948>


### C# code를 visual studio와 연동하기 {#c-code를-visual-studio와-연동하기}

<a id="figure--"></a>

{{< figure src="/img/unity/editor1.png" caption="<span class=\"figure-number\">Figure 1: </span>editor1" width="600px" >}}


### script 작성하기 {#script-작성하기}

<div class="note">

project창의 아래를 보면 좌측엔  project라는 메뉴가 보인다. 우측에는 asset창이 보인다. asset창에서 마우스  오른쪽 버튼을 누르고 create-&gt; c#script를 선택하면 script파일이 만들어진다.

</div>


### game과 scene {#game과-scene}

<div class="note">

scene은 전지적 시점에서 보는 영상이다.  카메라,조명, object를 설정하고 놓을수 있다. 반면 game에서는 camera에서 보는 영상이다.

</div>


### 도형추가방법 {#도형추가방법}

<div class="note">

아래 그림에서 +를 누르면, 3D object를 화면에 추가할 수 있다.

</div>

<a id="figure--"></a>

{{< figure src="/img/unity/object1.png" caption="<span class=\"figure-number\">Figure 2: </span>object" width="600px" >}}


## 2d 게임 만들기1 (roullette) {#2d-게임-만들기1--roullette}


### Project를 만든다. {#project를-만든다-dot}

<div class="note">

2d 게임으로 Roulette라는 이름으로 project를 만든다.

</div>


### 사용할 resource를 asset창에 drag &amp; drop한다. {#사용할-resource를-asset창에-drag-and-drop한다-dot}

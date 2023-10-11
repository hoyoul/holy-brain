+++
title = "[flutter] flutter UI basics"
author = ["holy"]
description = "flutter ui의 기본 구조."
date = 2023-09-01T00:00:00+09:00
draft = true
+++

## flutter란? {#flutter란}

flutter는 dart의 UI SDK다. UI관련 library와 gui programming을 가능하게
하는 framework임과 동시에 여러가지 tool을 가지고 있는 sdk다. flutter는
ios와 android라는 2개의 UI 와꾸를 가질 수 있게 설계되었다. flutter에서
개발해서 두개의 UI를 다 만들 수 있다.

<a id="figure--two uis"></a>

{{< figure src="/img/flutter/uis1.png" caption="<span class=\"figure-number\">Figure 1: </span>two uis" width="600px" >}}

왼쪽은 material desineged ui고 오른쪽은 ios designed guideline을 따른
cupertino다. material은 android 기기의 UI고, Cupertino는 IOS의
UI다. 기본적인 형태와 style이 각각의 UI마다 정해져 있다. 따라서, 어떤
theme를 사용하느냐에 따라서, 정해진 형태의 UI를 사용하게 된다. theme를
따르지 않고, 자신만의 UI를 만들고 싶다면 Material Designed 를 변형해서
사용한다. 그래서 flutter의 강의들은 모두 material designed UI를
가르친다.


## Material Designed UI의 사용 {#material-designed-ui의-사용}

custom designed의 app을 만들더라도 material designed를 사용하기
때문에, material designed app을 만들기 위한 default 처리과정이 있다.


### pubspec.yaml {#pubspec-dot-yaml}

```yaml
uses-material-design: true
```


### material design 구조 {#material-design-구조}

다음 그림 부터 보자.

<a id="figure--flutter ui structure"></a>

{{< figure src="/img/flutter/flutterui1.png" caption="<span class=\"figure-number\">Figure 2: </span>flutter ui structure" width="600px" >}}

Material designed UI를 만든다고 하면, 2개의 widget이
필수적이다. 첫번째 materialApp widget이다. runApp()에서
materialApp이라는 widget을 만들면, materialApp이란 widget을 flutter
framework에서 가져와서 보여주게 된다. materialApp이란 widget은
navigator를 가지고 있어서 root widget으로 지정되면, widget tree를
만들고, navigating을 할 수 있다. navigating을 할수 있다는 게
중요하다. 그런 widget이 별로 없기 때문이다. navigating이 가능하면,
여러 page를 가진 app을 만들 수 있고, 이동도 가능하다는 얘기다. 또한
material design이 가진 icon도 사용가능 하다. 두 번째로 scaffold라는
widget이다. scaffold는 page를 나타내는 widget이고, 머리 가슴 배로
구성되어 있다. [코딩애플](https://codingapple.com/unit/flutter-basic-layout-design/) 이란 곳에서 가져온 이미지를 보자.

<a id="figure--scaffold"></a>

{{< figure src="/img/flutter/scaffold1.png" caption="<span class=\"figure-number\">Figure 3: </span>scaffold" width="600px" >}}

scaffold를 사용하면 appbar, body, bottomsheet의 3개로 나눠진다. page의
구조가 거의 정해져 있다고 보면 된다. material design app을
만든다는것은 이렇게 이미 짜여진 모양의 app을 만든다는 것과 같다.

그래서, materialApp과 scaffold는 필수적 요소라고 보면 된다.


## layout {#layout}

materialApp과 scaffold가 기본적으로 있고, 우리가 하는 program은
widget을 body안에 배치하는게 주된 작업이다. UI programming이란것은
widget을 어떤 공간안에 배치하고 size를 정해주는 일이다. 옛날 부터 이런
UI programming에서 사용되어 왔던 전통적인 방법이 있었다. 전통적인
방법은 절대 좌표계를 사용하고, 여기에 widget의 location에 좌표값을
정해주는 방식이다. 예를 들어서, 'abc'라는 text를 (50,50)에
위치시켜라. 이런식이다. 그리고 size는 width 100px, height 100px로
해라. 화면에는 오직 하나의 절대 좌표계가 있고, 이 좌표계에 따라 page에
사용되는 widget을 배치하는 것이다. 그런데, 지금은 이런 방식은 사용되지
않는다. 왜냐하면 절대 좌표계를 사용하려면 전제 조건이 있다. screen의
size가 정해져 있어야 한다. 그래야만 의도한 ui화면이 그대로 나오기
때문이다. 여러개의 screen size를 가지고 있는 smartphone들에서 절대
좌표계는 사용될 수 없다. 상대 좌표를 사용하게 되고, layout,
constraints라는 용어가 나온다.
+++
title = "[flutter] flutter.dev1-get started (material app)"
author = ["holy"]
description = "flutter.dev1-get started"
date = 2023-09-12T00:00:00+09:00
draft = true
+++

## Get Started {#get-started}


### flutter란? {#flutter란}

flutter는 Dart의 GUI SDK다. SDK는 flutter framework + build tools를
합친 용어다. flutter라는 project를 만드는데 필요한 build tool과
framework가 다 포함되어 있다. library가 아니라 framework다.  그래서
dart에서 flutter로 GUI program을 만들면, inverse order의 callback
function이 정의되고 flutter framework에서 호출하는 식으로
만들어진다. 그리고 해당 app은 daemon이 되며 life cycle을 갖게
된다. flutter는 dart기반이라서 dart compiler,linktool도 다 포함되어
있어서 별도로 dart를 설치할 필요는 없다.  이것은 java에서 swing이란
sdk를 사용해서 GUI program을 작성하는 것과 비슷하다.


### flutter sdk 설치 {#flutter-sdk-설치}

[여기](https://docs.flutter.dev/get-started/install)에서 flutter를 설치하는 법이 다 나와 있다. sdk는 zip파일로 묶여
있다. 나는 Documents폴더에 압축을 풀었다. 그리고 PATH를 설정해서 build
tools를 사용할 수 있게 한다.


### flutter doctor {#flutter-doctor}

flutter doctor를 cmd창에서 실행하면 flutter를 사용할 수 있는 환경을
진단해준다. 지시대로 따른다.


## flutter 특징 {#flutter-특징}

flutter는 android app과 ios app을 만들 수 있다. 각각의 app은 고정화된,
어쩌면 천편일률적인, layout을 가지고 있다.  제각기 가지고 있는 이
형태는 os마다 다르다. android app은 material app 형태가 있다. 이
형태는 위에는 appbar가 있고, drawer도 있고, 아래 Bottom navigation
bar,floating action button을 가진 규격화된 app 모양을 가지고 있다. 즉
거의 모든 app들이 이런 위젯이 있다는 것이다. 또한 자신만의 color,
icon,font를 갖는다. 이것을 theme이라고 부른다. 또한 page를 이동하는
navigation도 자신만의 navigation방식이 있다. Navigator를
사용한다. 반면에 ios는 ios design guide line을 따르는 app모양을
갖는다. ios app은 UITabBar, UINavigationBar가 거의 모든 ios app에
있다는 것이다. 그래서 ios app을 만들때는 이런 형태로 만든다. 또한
navigating방식은 cupertinoPageRoute를 사용해서 navigating하는
방식,모양이 material과 다르다. ios만의 theme도 있다.


## flutter에서 어떻게 ios,android app을 만드는가? {#flutter에서-어떻게-ios-android-app을-만드는가}

flutter에서 만든 app은 android app, ios app을 만들수 있다고
했다. 그런데, android app들은 material design을 사용하는 자신만의
모양과 방식이 있고, ios app들은 자신만의 모양과 방식을 가지고 있는데,
어떻게 flutter에서 다른 형태를 갖는 두개의 app을 만들 수 있다는
것인가?


### flutter로 해결 {#flutter로-해결}

flutter는 platform specific한 코드를 만들 수 있다. 특정 앱에서 사용할
수 있는 widget도 별도로 가지고 있다. code상에서 android일때와 ios일때,
별도의 코딩을 해서 처리한다.


## flutter의 default app - material {#flutter의-default-app-material}

flutter에서 만드는 default app은 android app이다. 그래서 material
designed app을 만든다. material designed app을 만들기 위해서
materialApp이라는 root widget과 scaffold라는 app page의 layout을
담당하는 widget을 사용해야한다. root widget이란 것이 하는 주 역할은
navigator다. app은 여러개의 page로 구성되어 있다. page사이를 이동을
도와주는 것이 navigator다. root widget은 navigator로 여러 page를
관리할 수 있어야 한다. MaterialApp이라는 widget은 navigator가 있어서
이것을 관리할 수 있다.


### MaterialApp {#materialapp}

material.dart라는 library에는 runApp()가 정의 되어 있다. runApp()의
인자로는 widget이 들어갈 수 있다. 여기 들어가는 widget은 root widget이
된다. Text, Center, Container 등등 여러가지 widget들이 들어가면 root
widget이 될 수 있다. root widget이 된다는 말은 screen전체를 그
widget이 관리할 수 있다. screen에는 여러 page가 있는 app이 navigator를
사용해서 한 page씩 올려질 수 있고, stack을 사용하면 screen위로
여러개의 page가 올라가서 합성할 수도 있다. root widget은 screen을
지배한다. 그런데, text,center,container같은 widget은 screen을 지배할
수 없다. navigator기능이 없기 때문이다. navigator역할을 사용할
widget들은 몇개 없다. 그 중 하나가 MaterialApp이란 widget이다.

```dart
import 'package:flutter/material.dart';

void main(){
  runApp(MaterialApp(
      home: my_page
    )
  );
}
```

runApp()의 인자인 root widget을 MaterialApp으로 하면 여러 page를 갖는
app을 만들수 있다. 반면에, MaterialApp이 아닌, 일반 widget을 root
widget으로 한다면, single page widget만 만들 수 있다.


### scaffold widget {#scaffold-widget}

single page나 multi page로 된 app을 만들때, 그 app이 안드로이드
app이라면, 어떤 page를 만들더라도, 그 page는 android app만의 특징이
있다. appBar가 상단에 있고, appBar에서 menu를 누르면 drawer가 보이고,
floating button도 있고, 하단의 bottomsheet도 있다. 이런 특징을 갖는게
material gui guideline에 맞춘 page다. 이런 규격화된 android page를
만들기 위해서는, scaffold widget이 필요하다.


### app만들기 위한 기본 {#app만들기-위한-기본}

app은 single page로 구성된 app은 심사 조차 통과하기 힘듦. 지금의 app은
multi-page로 구성되어 있어야 한다고 보면 된다. multi-page app을 만들기
위해서 runApp의 인자인 root widget은 materialApp widget을 사용해야
한다. 그리고 각각의 page는 statelessWidget class를 만들던,
statefulWidget을 만들던, build함수에는 scaffold를 return하게
한다. 그래야 page의 layout을 material형태로 할 수 있기
때문이다. page에 해당하는 class를 만들고, materialApp에서 entry page를
정해주면 된다.
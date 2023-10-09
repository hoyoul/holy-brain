+++
title = "[flutter] Container widget"
author = ["holy"]
description = "container widget에 관해"
date = 2023-09-18T00:00:00+09:00
draft = true
+++

## container widget에 관해 {#container-widget에-관해}

container widget은 Align처럼 좌표계만 가지고 있거나, 가짜 영역을
만들지 않는다. container는 실제 자신만의 영역이 있다. 그래서,
primitive한 widget으로 생각해도 된다. 자신만의 영역과 자신만의 color로
영역도 표시할 수 있다. 그 영역은 width,height를 설정해서 fixed하게
설정할수도 있고, flexible하게 설정될 수도 있다. child가 있으면 child
size만큼의 크기를 갖는다. child가 없다면 부모의 layout에서 자신이
가질수 있는 크기만큼 다 갖는다. container는 primitive한 widget으로 볼
수도 있지만, primitive한 child widget을 꾸며주는 decorate하는
widget으로 볼 수도 있다. 왜냐면 child가 있는 경우, container widget은
child 크기만큼의 size를 가질뿐 아니라, child의 location을 따라가기
때문이다. 즉 child에 의존적이다. 그래서 child를 decorate하는
widget으로 container를 설명하기도 한다. [여기](https://youtu.be/c1xLMaTUWCY) 에서 container를
설명하는것은 decorate하는 container를 설명한다.


## container를 언제 사용할까? {#container를-언제-사용할까}

container는 text를 중앙에 배치하고 둥근 모서리를 갖는 모양으로
꾸미거나, row나 column등을 자식을 가지고 백그라운드 color를 적용하고,
둥근 모서리를 표현할 때 주로 사용할 꺼 같다. 아니면 주어진 화면 공간을
다 사용할 때 boxConstraint를 사용하거나 그 외에는 별로 사용할 일이
없을 듯하다.


## container의 속성들 {#container의-속성들}


### alignment {#alignment}

child의 위치를 정한다.

```dart
return Scaffold(
  body: Container(
    height: 200,
    width: 200,
    alignment: Alignment.topRight,
    color: Colors.blue,
    child: const Text('abcdddddddddd'),
  ),
);
```


### size 관련 {#size-관련}


#### width, height {#width-height}

width와 height를 double값으로 설정한다. 위의 예에서도 보인다.


#### BoxConstraint {#boxconstraint}

contrainer box를 크기 설정(constraints)한다. minWidth, minHeight,
maxWidth, maxHeight, expand를 사용할 수 있다. maxheight는 text를
줄바꿈을 할 수 있다.

```dart
constraints: BoxConstraint.expand()
```


### margin {#margin}

margin은 html에서의 margin과 같다. container의 dimension이 정해지면,
border의 외부영역이 margin영역이 된다. margin을 설정할 때는
Edgeinsets이란 class로 margin을 설정한다.


### decoration(border) {#decoration--border}

border는 decoration이라는 parameter에 BoxDecoration을 생성해서
설정한다. BoxDecoration에 border라는 named parameter가 있다.


### padding {#padding}

padding도 html에서의 padding과 같다. container의 dimension이 정해지면,
border의 안쪽과 content간의 간격이 padding이 된다.


### shape {#shape}


### shadow {#shadow}

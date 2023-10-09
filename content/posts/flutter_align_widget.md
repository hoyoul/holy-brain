+++
title = "[flutter] Align widget"
author = ["holy"]
description = "align widget에 대해서"
date = 2023-09-18T00:00:00+09:00
draft = true
+++

## Align widget에 대해서 {#align-widget에-대해서}

내가 느낀 align widget은 그냥 좌표계이다. 좌표계를 widget화 한
것이다. 좌표가 사용되는 이유는 child를 배치하기 위함이다. 그런데
align은 자신만의 공간이 없다. 보통 자식을 배치한다는 말에는, 자식이
자신의 영역안에 있다는 전제가 필요한데, align은 자신만의 영역,
dimension을 가지고 있지 않다는 것이다. 그래서 align은 자신의 부모의
공간에 좌표계역할만 한다. 부모공간의 좌표계 interface를 구현한것과
비슷하다.


## alignment 좌표계 {#alignment-좌표계}

```dart
void main(){
  runApp(
    Align(
      alignment: bottomLeft,
      child: Text("test"),
    )
  );
}
```

Align widget은 alignment속성을 이용해서 child의 위치를
정해준다. align의 좌표계는 중앙이 (0,0)이고 상하 좌우 -1,1의 값을
갖는다. 그림으로 보면 다음과 같다.

<a id="figure--align axis"></a>

{{< figure src="/img/flutter/align1.png" caption="<span class=\"figure-number\">Figure 1: </span>align axis" width="600px" >}}

좀 더 세밀한 location은 좌표값을 입력할 수 있다.

```dart
void main(){
  runApp(
    Align(
      alignment: Alignment(0.5,0.5),
      child: Text('test'),
    )
  );
}

```


## hightFactor와 widthFactor {#hightfactor와-widthfactor}

Align은 자신의 공간이 없기 때문에 부모의 공간에서 자식을
배치한다. 그런데 가상으로 Align에도 공간을 만들 수 있는게
hightFactor와 widthFactor를 가지고 있다. hightFactor와 widthFactor는
자식의 size에 곱해서 영역을 만들어 낸다. hightFactor만 설정하고
widthFactor를 설정하지 않을 경우, hight는 자식의 hight에 hightFactor를
곱하지만, width는 부모의 width를 그대로 가져온다.

```dart
void main(){
  runApp(MaterialApp(
      home: myApp()));
}
class myApp extends StatelessWidget{

 Widget build(BuildContext context){
   return Scaffold(
     body: Align(
       hightFactor: 2,
       child: Text("test"),
       ),
     );
 }
}
```

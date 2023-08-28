+++
title = "[dart] simple dart program analysis"
author = ["holy"]
description = "dart program 간단한 분석"
date = 2023-08-18T00:00:00+09:00
draft = true
+++

## dart program의 예 {#dart-program의-예}

```dart
import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Rebuild only when necessary'),
        ),
        body: const Align(
          alignment: Alignment.topCenter,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: 16),
              SizedBox(
                width: 300,
                child: Text('Flutter\'s algorithms for rebuilding and '
                  n                    'repainting widgets are linear in the worst case, '
                  'and typically sub-linear. Try clicking one of '
                  'buttons below -- they\'ll tell you exactly '
                  'when they rebuild!'),
              ),
              SizedBox(height: 16),
              ClickyBuilder(),
              SizedBox(height: 16),
              ClickyBuilder(),
              SizedBox(height: 16),
              ClickyBuilder(),
            ],
          ),
        ),
      ),
    );
  }
}

class ClickyBuilder extends StatefulWidget {
  const ClickyBuilder({Key? key}) : super(key: key);

  @override
  ClickyBuilderState createState() => ClickyBuilderState();
}

class ClickyBuilderState extends State<ClickyBuilder> {
  Color color = Colors.blue;

  String pad(int i) => i.toString().padLeft(2, '0');

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    return ElevatedButton(
      style: ElevatedButton.styleFrom(backgroundColor: color),
      child: Text('Built at ${now.hour}:${pad(now.minute)}:'
        '${pad(now.second)}'),
      onPressed: () => setState(() {
          color = getRandomColor();
      }),
    );
  }
}

final rng = Random();

const randomColors = [
  Colors.blue,
  Colors.green,
  Colors.red,
  Colors.orange,
  Colors.indigo,
  Colors.deepPurple,
  Colors.white10,
];

Color getRandomColor() {
  return randomColors[rng.nextInt(randomColors.length)];
}

```


## import {#import}

위 source code의 첫번째로 나오는 문법이 import다. 독해를 하기 위해선,
import가 무엇인지 알아야 한다.


### import 참조 link {#import-참조-link}

참조:<https://dart.dev/language/libraries>


### import &amp; library &amp; package {#import-and-library-and-package}


#### import {#import}

참조 문서에 보면, import와 library를 묶어서 설명한다. 이유는 둘다
긴밀한 관계가 있기 때문이다. 둘다 연관 지어서 알아야 한다. 우선 둘다
directive라고 한다. directive라는 것은 dart라는 언어에서 사용되는
문법적인 요소다. import와 library는 modular하게 만들고, shareable한
code를 만드는데 도움이 되는 directive라고 한다. 무슨 말일까?
import라는 지시자가 module을 만드는데 도움되지는 않을 꺼
같다. library가 module을 만드는데는 도움이 될꺼 같다. shareable하다는
것은 import의 역할 같다. import만 따로 떼어서 정리하면, 다음과 같다.

<div class="important">

import는 directive이고 code를 share할 수 있게 도와준다. 한마디로
library를 load한다. 다른 언어에선 module이라고 부르기도 하지만,
dart에선 library다. library를 load한다.

</div>

그러면 library는 creat modular가 library의 역할인거 같다.


#### library {#library}

```text
Libraries not only provide APIs, but are a unit of privacy:
identifiers that start with an underscore (_) are visible only inside
the library.
```

library는 API를 제공한다. 그리고 privacy한 단위로 봐야 한다는데,
privacy한 단위라는게 애매한데, :으로 부가 설명을 한다. \_으로 시작하는
identifiers들은 library에서만 보여진다고 한다. 말이 좀 어렵다. 그래서
library가 도데체 뭔데?라는 질문과 또 identifiers는 뭔데? 라는 질문을
할수 있다.

-   library: library 지시자다. 어떤 대상을 지시하는것이다. 그 대상은
    아직 뭔지 모르지만, 대상을 정해놓고 넌 library야 하면 library가 되는
    것이다. 이것도 추상적이긴 한데, 구체적으로 말한다면, dart file은
    무조건 library다. library 지시자가 없어도 library다.
-   identifiers: identifiers는 단어가 말하듯 identity를 나타낼 수 있는
    것이다. 보통은 symbol을 얘기한다. 즉 name이다. 정확하게 어떤 token을
    말하는지는 언어에서 정의한다. 구체적으로 말한다면 class를 정의할 때
    사용하는 name, function을 정의할 때 사용하는 name, value를 정의할 때
    사용하는 name을 identifier라고 한다.

정리하면, library는 하나의 단위고, 보통 dart파일을 한개를 말하고, 그
안에서 \_로 class나 function, 변수에 access 권한을 library에서만
동작하게 만들 수 있다는 것이다. 다른 곳에서 import로 A라는 dart
file,즉 library를 load해서 사용한다고 가정하자. A library의 \_가 붙은
class나 function, 변수는 사용할 수 없다는 것이다. 이게 unit of
privacy인거 같다.


#### package {#package}

package는 library를 배포한다. 자세한 설명은
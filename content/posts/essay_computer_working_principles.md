+++
title = "[essay] computer working principles"
author = ["holy"]
description = "computer 동작에대한 생각들"
date = 2023-07-10T00:00:00+09:00
draft = true
+++

## computer의 구조 {#computer의-구조}


### 자동 제어 구조의 시작 (memory) {#자동-제어-구조의-시작--memory}

컴퓨터는 전기를 사용하는 system이다. system은 전기를 사용하는
device들로 이루어진 집합이다. 컴퓨터를 설명하기 앞서서 간단한 전기적
device인 motor를 예를 들어 설명하려고 한다. 모터에 배터리를
연결하자. 배터리로 전원을 공급하면, 모터는 회전한다. 언제까지?
배터리에 전원이 닳을때까지 돈다. 여기에 모터와 배터리 사이에 스위치를
연결하면 사람이 스위치를 통해서 모터를 껏다 켰다 할수 있다. 즉 제어가
가능해진다. 이런 제어를 사람의 손으로 수동적으로 하지 않고 자동화 할
수 있을까? 즉, 껏다 켯다 껏다 껏다 껏다를 손으로 일일이 스위치를
눌러서 하는게 아니라, 껏다 켯다 껏다라는 정보들을 어딘가에 기록하고 그
기록된 값이 motor에 전달되서 자동으로 할 수 있냐는 말이다. 모터가 3d
printer의 부품이라고 할때, 사람의 손으로 스위치를 눌러서 motor를
이동시키고, 스위치를 눌러서 motor를 동작시키고 다시 스위치를 눌러서
motor를 중단하고 이동시키는 복잡한 작업을 계속할 수는 없다. 스위치는
mechanical한 부품이지만, 전기적인 관점에선 on/off 신호에
불과하다. 설명이 길었지만, 껏다 켯다 라는 정보를 전달하는 물리적
장치인 switch를 전기적 소자로 구현한 flip flop이란게 있다. flip flop은
on/off값을 가지지만, 0 or 1의 값을 가지고 있는 fswitch라고 생각하면
된다. flip flop은 하나의 switch를 나타내지만, 묶어서 memory란 형태로
만들면, 수백개 수천개 수만개의 스위치를 가질 수 있다. 이 말은, 이
수많은 스위치들이 수 많은 device와 연결되어서 수 많은 device를
자동제어할 수 있다는 것을 의미한다. 또한 메모리의 주소를
control(반복)해서 전기 신호를 반복해서 motor에게 전달할 수도 있다는
것을 의미한다. 즉 제어하는 모든 것들을 메모리에 올릴수 있기 때문에,
program이라는 개념이 나오게 된다. 그런데 궁금한 것이 motor를 제어하는
제어코드는 motor가 아닌 memory에 있었다. memory에서 motor로 그 신호를
전달해서 동작했는데, 그렇다면 memory를 제어하는 것도 다른 memory에
있는 것인가? 하는 것이다. memory를 제어하는 code들은 어디에 있는가?
memory를 제어하는 code들은 memory에 있는 것이 사실이다. memory를
동작시키는 코드가 메모리에 있다는 것은 memory가 자신의 출력을 입력으로
사용한다는 것인가? 그렇지 않다. 여기서 cpu라는게 나온다. memory는
자신을 제어하는 code들을 memory에 가지고 있지만, 그 code를, 전기신호를
입력받아야 한다. 스스로 하지 못한다. 다른 누군가가 입력으로 전달해야
한다. 그게 cpu다. cpu는 memory로부터 제어코드를 가져와서 memory를
control한다. 그럼 cpu를 제어하는 코드는 어디에 있는가? memory에
있다. cpu는 자신을 control하는 제어코드를 memory에 넣고 자신의
제어코드를 메모리로부터 입력받아서 실행한다. 이것을 보면 memory는
일종의 hub처럼 느껴진다. 연결된 device의 작동코드를 모두 가지고 있는
일종의 hub다. memory는 아래와 같이 binary code로 되어 있다.

<a id="figure--binary code"></a>

{{< figure src="/img/python/binary.png" caption="<span class=\"figure-number\">Figure 1: </span>binary code" width="600px" >}}

메모리에는 있는 수많은 bit는 각각의 switch다. 각 switch들은 연결된
device들의 동작 코드를 가지고 있다. 예를 들어서 motor가 연결되어 있고,
speaker, monitor, hdd, fdd, usb 수많은 device가 연결되어 있다면
memory의 어떤 영역은 speaker영역, 어떤 영역은 monitor영역, 어떤 영역은
hdd영역 이렇게 나누어져 있어야 한다. 그리고 각각의 영역에서 bit
sequence는 각 device마다 다르다. 예를 들어서 motor를 turn on하는
switch가 3개라고 하면 3bit로 표시되고, monitor에서 turn on하는
switch는 5개라서 5bit로 표시할 수도 있다.

switch라고 하면
flip-flop이라는 전기적 소자를 생각해도 되고, 손으로 누르는 switch를
생각해도 된다. 그러면 모든 device의 동작을 switch로 제어하다가
memory의 bit로 제어한다고 하면, memory에는 제어하는 switch만 있을까?
그렇지 않다. 예를 들어서 speaker를 보자. speaker에서 제어하는 code를
언뜻 생각하면, 껏다 켯다, 볼륨도 크게 작게하는 제어도
있지만, speaker가 재생하는 음악에 대한 data도 있다. 음악에 대한
데이터는 speaker를 제어하는 switch 정보를 가지고 있는 binary가
아니다. 따라서 컴퓨터의 메모리에는 2가지 영역으로 구분했다. device를
제어하는 code들의 영역과 data의 영역으로 나누어져 있다. 그러면, 이런
생각을 할 수 있다. 난 memory에 어떤 제어코드가 있던, 어떤 data가
있던간에 모두 binary로 되어 있단 말이지. 난 복잡한거 모르겠고,
memory에 임의로 내맘대로 bit로 된 data를 입력하고 싶어. 가능한가?
그리고 나는 궁금해. 컴퓨터는 내가 입력한 memory에 따라서 동작할까?

내앞에 컴퓨터가 있다. 컴퓨터는 memory에 제어코드와 data코드를 넣어주면
그것에 따라 자동으로 동작한다고 했는데, 그렇다면, 내 앞에 있는
컴퓨터에서 바로 입력하고 싶어! 어떻게 해야하지? 떠오르지
않는다. 키보드를 사용하면 되지 않나? 그런데 키보드를 연결하고 gui로된
os에서 키보드를 친다고 메모리에 입력이 되지 않는거 같다.  동작원리를
알고 있고 컴퓨터도 바로 앞에 있는데, 메모리에 binary code를 입력하는
방법을 모른다? 답답하네. 그렇다면 개념을 알아서 뭐하냐? 메모리에
binary데이터를 입력하려면, 현재 컴퓨터에서는 os를 알아야 한다.

arduino같은 컴퓨터는 좀 더 원시적이다.  arduino는 다른 컴퓨터와
연결해서 메모리에 데이터를 쓸 수 있다. arduino의 memory가 다른
컴퓨터의 메모리에 연결되는 것이다. 전기신호를 받아서 써진다. 이렇게
해서 메모리에 code를 쓸수 있다.

두번째 질문을 살펴보자. arduino의 메모리나 지금 사용하는 컴퓨터의
메모리를 임의의 binary로 마구 마구 입력했을때 컴퓨터가 동작할 것인가?
우선 code와 data영역의 memory는 다르다는 것을 알아야 한다. code영역을
보자. 모터를 제어하는 것은 껏다 켯다하는 정보 밖에 없다. 그래서 아무런
의미없이 binary 코드를 입력해놔도 모터는 그에 따라서 동작할
것이다. speaker를 보자. speaker는 좀 복잡하다. 껏다 켯다만 있는게
아니다. 데이터 영역에서 음악을 가져와서 입력으로 줘야 하고 볼륨도 컷다
작았다 할 수 있어야 한다. 데이터 영역에서 음악을 가져오는것도 위치를
정확히 지정해서 얼마만큼 가져올지도 정해줘야 한다. 이런 동작은
speaker가 켜져 있을 때만 동작한다는 조건도 있다. 따라서 메모리에
모터와 스피커가 연결되어 있을때, 메모리에 아무데이터가 넣어져 있다고
해도 컴퓨터는 동작할 수 없다. 왜냐면 메모리에 있는 전기 신호를 어떤
device에 주어야 할지도 모르기 때문이다. motor만 메모리에 물려 있을
때는 memory에 써져있는 데이터는 0,1만 있기 때문에 모터는
memory전기신호에 맞추어 동작할 것이다. 하지만, speaker도 연결되어
있다면 어떤 device 사용할지 선택부터 해야 한다. speaker를 선택했다
할지라도 speaker는 동작하지 않을 것이다. 왜냐면 speaker를 제어하는
코드는 구조를 갖고 있기 때문이다. speaker를 키고, 데이터를 가져오고,
볼륨 조절을 하는것은 순서가 정해져 있다. 순서에 맞는 제어코드를 실행할
때만 동작하기 때문이다. motor처럼 아주 단순한 전기소자가 아닌경우
제어하는 코드들은 수많은 스위치를 사용해서 제어하고, 스위치 제어에도
순서가 있다. 스위치 대신에 binary code를 사용한다고 해서 이것이 바뀌지
않는다. 또한 제어하는 bit를 묶어서 하나의 제어명령어를 만들수
있다. 따라서 코드 메모리에 있는 제어코드들은 순서도 있고 단위도 가질수
있다. 아무렇게나 메모리에 입력되서는 안된다. 각각의 device별로
자신만의 제어코드들이 존재한다. 좀 복잡하다. 수많은 device가 컴퓨터에
연결될텐데, 컴퓨터는 각각의 device를 선택했을때 device를 동작시키는
제어코드를 다 알고 있어야 한다.이말은 programmer들은 각각의 device가
갖는 제어명령어 형태를 알아야 해당 제어코드를 메모리에 입력하고
device를 동작할 수 있게 된다. 근데 이것은 현실적으로 불가능한
얘기다. 같은 speaker라해도 회사별로 speaker 제어명령어의 구조나 순서는
제 각각일수 있다. 100종류의 speaker별로 memory에 올려서 제어한다는
것은 비합리적이다. 그래서 중앙집권적 형태가 아닌 지방분권적형태를
사용한다. computer에 연결되는 device들은 모두 각자의 memory가 있고
동작키는 제어코드들이 함수별로 존재한다. 그리고 필요한 data만 컴퓨터로
부터 받는 형태로 바뀌게 된다. 모든 device는 컴퓨터의 입장에선 file의
형태로 추상화된다. 따라서 file을 열고 file에 data를 전달하거나,
file로부터 데이터를 전달 받고 file close만 한다. 이것은 각각의
device들이 스스로 자신의 메모리에 있는 제어코드를 실행한다. 컴퓨터는
device가 가진 제어코드를 처리하지 않고 device들이 자신을 제어하는
구조로 바뀌게 된다. 그러면 memory라는 전기소자를 제어하는 제어코드는
어디에 있는가? 각각의 device가 자신을 제어하는 memory를 가지고 있듯이
memory도 device다. 따라서 memory를 제어하는 제어코드는 자기 자신에
위치한다.


### memory code structure {#memory-code-structure}

다시 한번 정리해 보자. computer의 메모리는 code와 data영역이
있다. 여기서 code영역만 우선 보자. code 영역에 아무런 의미없는 binary
code를 입력하면, 컴퓨터는 동작하지 않았다. 왜냐하면 메모리의
제어코드는 cpu와 memory라는 device를 동작시키는 제어코드라서 각각
형식과 순서가 있기 때문이다. 이런 명령어의 순서와 형식을 갖춘 구조로
memory에 제어코드가 올라가 있어야만 실행할 수 있다.


### memory code for file i/o {#memory-code-for-file-i-o}

초창기 메모리의 제어코드는 cpu, memory뿐만 아니라, 모터, speaker,등
컴퓨터에 연결된 다양한 device에 대한 제어코드가 존재했었다.  그래서
해당 device에 대한 제어코드도 메모리에 있었다. 메모리에서 각 device의
제어코드를 device에 전달해서 실행시켰다. 그런데 지금은 특정 device에
대한 제어코드를 가지고 있지 않다. 컴퓨터는 device를 file로
본다. 그래서 file을 선택해서 데이터만 주고 받는다. device를 동작시키는
건 각자의 device에서 알아서 한다.


### memory data structure {#memory-data-structure}

모두 string으로 되어 있다. 여기서 의문이 들 수 있다. python file이나
stdin같은 buffer에 저장되는 것은 bytecode로 되어 있을 텐데, 그렇다면
python interpreter가 입력으로 받는 것은 byte값이지 string이 아니지
않냐? 이렇게 생각할 수 있다. 예를 들어서 다음과 같은 code가 a.py에
저장되어 있다고 하자.

```python
a = 3
```

이것의 bytecode는 다음과 같다.

<a id="figure--bytecode1"></a>

{{< figure src="/img/python/bytecode1.png" caption="<span class=\"figure-number\">Figure 2: </span>bytecode1" width="600px" >}}

a.py라는 file로 저장될때 위와 같이 저장될까? 그렇지 않다.
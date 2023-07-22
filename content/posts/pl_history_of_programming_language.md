+++
title = "[pl] history of programming language from calcuation to OOP"
author = ["holy"]
description = "oop언어를 이해못하는 사람이 많다. 그래서 글을 써보았다."
date = 2023-06-28T00:00:00+09:00
draft = true
+++

## 잡설 {#잡설}

최근 modern programming language중에는 oop언어가 아닌게
없다. functional language도 그렇고 c언어로 대표되는 절차형 언어도
oop를 모두 도입했다고 보면 된다. 가장 edge 언어는 oop언어라고 보면
된다. oop언어를 왜 사용하느냐? 라는 단도 직입적인 질문에, 세상의 모든
것은 객체로 나타낼수 있다. simulate될 수 있기 때문에 oop언어를
사용한다고 말한다면 너무 불친절 할 수 있다. 세상의 모든 것을
simulate되는 것이 도데체 무슨 상관 관계가 있는가? 이런 얘기를 하려면
역사를 좀 말해야 한다.


## 시작 {#시작}

시작을 말하려면 problem과 solving, 그리고 계산에 대해서 말해야
한다. 태초부터 인간은 호기심이 많아서, 현실의 문제를 해결하는데 계산을
사용했다. logic과 math가 그렇게 나온 학문이다. 문제를 해결하는 도구로
나온 logic과 math는 매우 비슷했지만, 달랐다. 그리고 독자적으로
발전되었다. logic의 계산은 reasoning으로 추론을 사용한다. rule of
inference로 계산을 한다면, 수학은 algebra, number theory를 근간으로
해서 계산을 한다. 예를 들면 4칙연산이다. logic은 인간의 언어로 부터
ambiguous를 제거해서 좀더 formal하다. 반면 math는 logic과 유사하지만,
사용하는 언어가 아주 달랐다.  인간이 문제를 해결하기 위해서 인간의
언어를 사용하는데, 인간의 언어자체는 계산에 맞지 않았기 때문에 비슷한
logic을 사용하던가, 전혀 다른 math를 사용해야 했다. 이것을 통합하려는
시도가 일어난다. logic과 math가 비슷했기 때문에 가능했다. 즉, logic이
axiom에서 시작되는 and,or,not같은 operator를 조립해서 강력한 함수를
만들어서 사용하듯이, math도 4칙연산으로 부터 강력한 함수를 만들어서
사용할 수 있다는 것이다. 둘다 foundation으로부터 쌓아올려진
학문이여서, 그 foundation을 다른 언어로 표현할 수 있다면, 통합이
가능한 것이다. logic에서 math를 통합하려는 시도가 나타났다. math의
강력한 계산능력을 logic으로 나타낼려는 시도다. 이렇게 하기 위해선
근간이 되는 algebra를 logic으로 나타내야 한다. 그래서 나타난 것이
first order logic이다. frege가 만든건데, frege는 계산을 위한 언어로
concept script를 제시한다. 이것은 FOL을 말한다고 보면된다. FOL은
algebra를 나타낼 수 있었다. 이것이 programming language의 시작이다. 즉
FOL로 수학을 나타낸것이다. 이것을 programming language라고
말한다. concept script가 programming language의 어원이 된다. 여튼
Programming language는 computer가 만들어지기 이전에 이미
만들어진것이다. frege이후, recursion을 도입한 괴델, 함수를 lambda로
표기한 church등에 의해 발달 되서 지금까지 왔다. church nuemerals를
보면 church또한 수학과 logic이 같음을 나타냈고, 그는 function으로
모든것을 나타냈다고 주장했다. 괴델도 recursion으로 모든것을 나타낼 수
있다고 했다. 이렇게 해서 programming language는 다양한 형태로
만들어진다. church처럼 function으로 모든것을 설명하거나, 아니면
logic으로 모든 것을 설명하는 prolog같은 형태의 언어도
만들어졌다. recursion을 사용한 괴델도 괴델numbering을 통해서 비슷한
얘기를 했다. 여튼 중요한 것은 computer가 만들어지기 전에 이미 만들어져
있었던 것이다. 여기서 갑자기 천재 한명이 나온다.turing이다.  turing은
church의 방식을 다른 방식으로 증명해 냈다. 그리고 그 방식은 machine을
이용하는 방식이다. 그리고 새넌의 놀라운 석사논문과 von neumann의
방식이 결합되서 computer라는 게 세상에 나오게 된다.

참조:<https://youtu.be/oippSXvxUlw>


## 대용량 데이터의 계산 {#대용량-데이터의-계산}

문제를 해결하기 위해서 programming language를 이용해서 명확히 기술할
수 있게 되었다. 컴퓨터가 발명되면서 기계적 방식의 계산이
가능해졌다. 실제 물리적인 기계로 계산이 되는것이다. 정신적인 영역에서
물리적인 영역으로 계산은 이동하게 된다. 이때부터 계산을 하는 물리적
device인 hw와 sw로 나눠지게 된다. 그리고 이 때 당시에 사람들이
focus하는 것은 얼마나 대용량의 데이터를 효율적으로처리할 수 있는가?에
관심을 가졌다. 우리가 지금 알고리즘과 data structure라고 부르는 것들은
이때 당시의 산물이다. coding test를 한다는 것은 얼마나 효율적으로
빠르게 대용량 데이터를 처리하냐에 focusing이 되어 있다. 여기에는
현실세계에서 사용되는 data를 programming이 제공하는 data로 변환하는
작업이 필수적으로 따라오게 된다. 인간이 처리하는 data는 매우복잡한
data다. 수학에서 사용하는 수치가 아니다. 인간이 문제를 해결하기위해
현실의 문제를 수치화 해서 수학으로 풀어왔다. 프로그램이 만들어져서
수학의 모든것을 표현할 수 있지만, computer는 또 다르다.  computer는
memory라는 device를 사용하기 때문에 모든 data는 선형으로 표시되며,
ordering을 갖는다. 수학과 다르다. 수학에서는 현실의 문제를 수치화 할때
set이나,tree,graph형태의 structure를 사용해서 표현할 수
있다. ordering이 없어도 표현하고 이를 푼다. 하지만, computer에서 모든
data는 선형적으로 저장되고 ordering이 존재한다. programming
language에서 이런 수치 데이터를 data structure라는 형태로 변환해서, 즉
전처리해서 사용한다. 어떻게 전처리해서 표현하느냐가 computer로
수행되는 program을 효율적으로 만들 수 있다.

여튼 우리가 지금하는 coding test는 이시대의 산물이다.어떻게 인간이
다루는 data를 수치화 하거나, program이 사용하는 data형태로 변형해서
주어진 computer에서 얼마나 효율적으로 동작하게 만드는가? 그것이
focusing되어 있다.


## GUI와 OOP의 등장 {#gui와-oop의-등장}

GUI가 등장하기 전까지 programming은 대용량 데이터의 효율적인 계산에
focus를 두었다. 하지만, os가 cli 방식에서 gui방식으로 변경되면서
programming의 paradigm이 변하게 된다. 계산에 focus를 두기 보다
재사용성에 focus를 두게 된다. 생각을 해보자. GUI OS에서 모든것은
window로부터 시작된다. button,title bar같은 widget으로 만들어져 있는
window는 programming의 단위가 되버린다. 어떤 program을 짜더라도 window
로 부터 시작된다. 매번 window를 만들어서 사용해야 할까?  재사용이
해결되지 않고는 GUI OS 자체를 사용할 수 없게 된다. 여기서 OOP라는
개념이 사용되어 window 재사용 문제가 해결된다.
smalltalk,c++,java,델파이같은 언어들은 기존의 pascal, c와 다르게
OOP방식으로 programming을 하고, GUI와 친화적이다. 왜냐면 GUI OS를
도입할때 생긴 재사용의 문제를 해결한 언어들이기 때문이다. 그런데
OOP언어를 설명할때, 이 세상 모든 것은 객체다. 모든것은 객체로 표현될수
있다고 한다. 이런 설명은 갑자기 나온건 아니다. 물론 system자체가
window라는 무거운 코드로 대체되면서, 무거운 코드를 재사용하기 위해서
나왔지만, 원래 그런 개념을 가진 언어가 있었다.  초창기 언어중 하나인
simula67에서 현실의 thing을 simulate하는것에 관심이 있었고 그 이전에
철학적으로 이 세상 모든 것은 object로 구성되어 있다는 Aristotle의
생각이 있었다. 그래서 세상의 모든 것을 흉내내는 simula에 방점을 찍은
언어와 개념이 OOP언어가 되는 것이다. 세상의 모든 것을 흉내낼 수 있다는
paradigm이 oop언어의 핵심적인 특징이 된것이다.

우리가 computer에서 자판기라는 현실에 존재하는 machine을
simulate(흉내)낼 수도 있다. 이때 대용량 데이터 처리는 관심이
아니다. 단지 현실의 존재를 얼마나 simulate하느냐이다. 모든 앱과 web
app들은 인간세상에 있는 존재들과 동일하다. 계산을 위한 programming이
아니라 존재를 위한 programming을 할 수 있는 것이다. 지금 핸드폰에 있는
app들은 모두 객체지향 프로그램으로 작성된것이다. 하나의 app은 하나의
존재고, 내부에는 수많은 레고블럭과 같은 존재로 구성되어 있다. 따라서
oop언어들은 계산이 아닌, simulate하기 위해서 만들어져 있다. 그래서
재사용성이 중요하고 상속이 중요하고 은밀성?이 중요한 것이다.


## <span class="org-todo todo TODO">TODO</span> class와 prototype {#class와-prototype}

java, python은 class중심적 사고관이라면 js의 prototype은 객체 중심적
사고관이다. js에서는 class가 없다. 객체만 있고, 객체간의 관계는 서로
협력하는 관계다. 상속의 개념이 없다. 이렇게 한발짝 더 나아간 moder oop는 js다.


## this와 self에 대해서 {#this와-self에-대해서}

java의 this와 self는 class의 method나 member변수에 사용된다. class는
빵틀이라고 흔히 설명된다. 객체의 원형(prototype)을 class라고 하기도
한다. class에서 객체에 대한 설계를 한다. person이라는 class를 만든다고
하면 person의 팔,다리를 나타내는 function과 variable을 만들게
된다. 1000명의 사람을 만들었다고 하자. 철수, 영희, 개똥이...개똥이의
팔은 영희의 팔과는 다르다. 각 instance에대한 접근을 하려면 self,this가
있어야 한다. 만일 self나 this를 사용하지 않는 method나 variable은
class가 가진 공통적인 기능과 요소에 불과하다.

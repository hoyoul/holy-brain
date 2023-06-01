+++
title = "how to program"
author = ["holy"]
date = 2023-04-25
draft = false
+++

[골드마크 참조]({{< relref "goldmark" >}})


## programming? {#programming}

-   Programming(프로그래밍을 짠다는 것)은 여러 방법으로 설명할 수
    있다. 여기선, 내가 이해하는 practical한 의미에서의 programming을
    말할려고 한다. 나에게 있어 program은 함수다. 함수는 무엇인가? 함수는
    2가지의 철학을 가지고 있다. 첫번째,함수라는 것은, 명령어라는
    turing기반의 철학과, 두번째, 함수라는 것은, 5w1h같은 question에 대한
    답을 만드는 proof기반(turing과 괴델)의 철학이다. 어떤 철학을 가지고
    있던, 내가 이해하는 practical한 의미로 program은
    function이다. 그리고 programming은 함수를 짜는 것이다. 다시 한번
    강조하면, program은 function이다.


## programming의 철학 {#programming의-철학}


### H/W 명령으로써의 program. {#h-w-명령으로써의-program-dot}

-   program(function)과 관련한 2가지의 철학, 명령으로써의 function과,
    질문으로써의 function에 대해 말하고자 한다. 사람은
    program(function)을 만든다. 그리고 만든 program(function)은
    computer가 실행한다. computer는 H/W로 만들어져 있다. cpu와 메모리
    그리고 여러 I/O장치로 이루어져 있다. computer가 가진 H/W를 이용하는
    명령의 철학으로 program을 이해할수 있다. 예를 들어,화면에
    출력해라. 디스크에서 데이터를 읽어라. wifi로 인터넷을 통해 data를
    전달해라. 이렇게 hw를 이용하는게 program이라고 생각하는 것이다. 두
    숫자의 합을 구해라. 이 같은 문제도 H/W를 사용한다는 철학에서는
    메모리에서 가져온 데이터를 cpu에서 더한 후 메모리에 써라와 같이
    일련의 hw명령어들의 순차적 수행으로 생각할 수 있다. 컴퓨터에게
    hw적인 명령을 지시하는것을 나열한게 program이다. program을 만들고
    컴퓨터에게 주면, 컴퓨터는 hw를 사용할 뿐이다.


### 질문으로써의 program. {#질문으로써의-program-dot}

-   H/W를 조작하는 명령으로써의 program이 아닌, 질문으로써의 program은
    다르다. H/W적인 명령이 아닌, 수학과 논리학적인 질문과 답을
    program으로 작성하고 computer에게 던져주면 computer가 그것에 대한
    응답을 할 뿐이다. 예를 들어서 두수의 합을 구하는 program을 보자.
    ```text
    sum(3,4)
    defun sum(X,Y)
    (+ X Y)
    ```
-   명령어로써의 위 프로그램을 이해할 수도 있다. 3과 4를 더해라는
    명령이고, 그값을 더하기 위해서 cpu의 +기능을 사용해서 2개의 수를
    더하라라는 명령의 형태로 이해한다. 하지만, 질문으로써 프로그램은
    동일한 프로그램도 다르게 해석한다. sum(3,4)는 y = sum(3,4)의 형태의
    질문으로 이해한다. 즉, 3과 4를 더하면 어떤값인가? 즉 y값은 무엇인가?
    란 질문이다. 그리고 그것에 대한 답도 만든다. 답을 만들때는 변수를
    사용해서 일반화를 한다. 비슷한 어떤 질문도 해결할수 있는 답을
    만든다. 이것은 proof와 같다. 여튼 H/W명령으로써의 program이라고
    이해하지 않는다. 그리고 답안 작성 방법도 다르다. H/W 명령으로 답안
    작성은 여러 명령을 순차적으로 나열한다. 그런데 질문과 이 질문의
    답으로써의 program은 다르다. 질문과 질문의 답으로써의 program은 어떤
    질문에도 그 답을 말할 수 있는 일반화를 해야 한다. 그래서 변수를
    사용한 일반화를 한다. 또한 proof와 마찬가지로 그 답이 참임을
    증명해야 한다. 이것은 program이라는것이 레고의 기초 블럭들로
    만들어진 구조물이고, 각각의 구조물을 분해하면 기초블럭들로
    만들어졌음을 보여줘야 한다. 그래야 이 program은 옳은, 문제가 없는
    program으로 판단할 수 있기 때문이다. axiom에 기반한 program이기
    때문이다. 그래서 recursion방식을 많이 사용한다. recursion으로
    만들어진 복잡한 구조물(무한도 포함)도 궁극엔 기초블럭으로
    이루어졌다는 것을 보여주기 쉽기 때문이다.
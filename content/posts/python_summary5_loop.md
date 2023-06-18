+++
title = "python_summary5 loop"
author = ["holy"]
description = "loop 와 condition에 대한 정리"
date = 2023-06-14T00:00:00+09:00
draft = true
+++

## Condition &amp; Loop {#condition-and-loop}

-   조건문은 if else, 반복문은 while-for
-   들여 쓰기: space 4칸, tab을 써도 된다.


### Conditional Statement {#conditional-statement}


#### if문 사용법1 - if,elif,else 사용법 {#if문-사용법1-if-elif-else-사용법}

-   if를 사용해서 원하는 조건을 만족하면 수행하게 한다.
-   example 1
    ```python
    score = 80
    if score > 60:
        print ("Over 60")
    if score > 70:
        print("Over 70")
    if score > 80:
        print("Over 80")

    ```

    -   위에서 보듯이 조건에 맞으면, 출력을 한다.
-   example 2

    -   example1에서 보면, 3가지 case가 있다. 이 중에 맞는 경우가
        2가지가 있다. 이럴 때, 만족하는 모든 case를 출력하지 않고
        하나를 만족하면 수행을 하지 않게 하고 싶다면, elif를 사용한다.

    <!--listend-->

    ```python
    score = 80
    if score > 60:
        print ("Over 60")
    elif score > 70:
        print("Over 70")
    elif score > 80:
        print("Over 80")
    ```
-   example 3
    -   만일 모든 조건을 만족하지 않을 때, 조건을 만족하지
        않습니다.라는 메시지를 내보낼려면 어떻게 해야 하는가? 이 때,
        else를 사용한다.
        ```python
        score = 10
        if score > 60:
            print ("Over 60")
        elif score > 70:
            print("Over 70")
        elif score > 80:
            print("Over 80")
        else:
            print("wrong value")
        ```


#### if문 사용법2 - false에 해당하는 것들 {#if문-사용법2-false에-해당하는-것들}

-   false에 해당하는 값들.
    ```python
    if False:
        print("This sentence does not show")
    if "":
        print("Empty is False")
    if 0:
        print("0 is False")
    if None:
        print("None is also False")
    ```


#### if문 사용법3 - 비교연산자와 논리연산자의 사용 {#if문-사용법3-비교연산자와-논리연산자의-사용}

-   example
    ```python
    a,b = 5,8
    if a == 5 and b ==6:
        print ("This is False")
    if not a < b < 9:
        print("This is False")
    if a + 3 == b:
        print("This is True")

    ```

    -   여기서, a,b = 5,8을 보는 순간, tuple의 unpacking임에 익숙해
        져야 한다. 생소하게 바라보면 안된다.


#### ternary operator 사용법 {#ternary-operator-사용법}

-   [value1] if [Condition] else [value2] 형태.
-   if else문인데, 생소하다.
-   condition이 참이면 value1을 거짓이면 value2를 반환
-   연산자이다.라고 강사가 말했는데, 왜 연산자인지 모르겠다.
-   연산자 운선순위에서 가장 아래에 위치한다.
-   햇갈리지 않게 하기 위해서 괄호를 사용한다.
    ```python
    value = 32
    "odd" if value % 2 else "even"
    ```
-   연산자라 다른 연산자와 같이 사용될 수 있다고 한다.
    ```python
    value =32
    print(("odd" if value % 2 else "even") + "_number")
    ```


### Loop {#loop}

loop의 기본 생각은 연산을 100번 200번 적용하는 방법이다. 함수를 100번
호출하겠다. 200번 호출하겠다. 같은 의미다. 이럴때 loop를 사용한다.


#### while {#while}

<!--list-separator-->

-  while 사용법

    -   기본 모양
        ```text
        ​- while <조건>:
             명령1
             명령2
        ```
    -   example

        -   조건을 만족하는 동안 수행한다.

        <!--listend-->

        ```python
        i = 1
        while i < 4:
            print(i)
            i = i+1

        ```


#### for {#for}

<!--list-separator-->

-  기본개념

    대용량 data인 list나 array를 처리하는 방법이다. 반복을 사용하는데, c나
    java와 달리, 객체에서 값을 꺼내서 반복한다. 객체의 index가 아닌 값을
    꺼낸다. 그래서 range라는 객체가 있다. range객체는 값을 index형태로
    만들어내기 때문에 for-loop에 많이 사용된다.

<!--list-separator-->

-  enumerate의 사용

    for는 객체로부터 객체를 꺼내기 때문에 index처리를 할때 enumerate를
    사용해서 index를 꺼낸다. dictionary의 경우는 key:value로 되어 있기
    때문에 enumerate로 index를 꺼낼수 없다. list를 사용하거나 string을
    사용할때 enumerate를 사용하면 유용하다.

<!--list-separator-->

-  list iterator

    -   example1: for loop은 객체에서 값을 꺼내서 연산을 한다. 객체에서 값을
        꺼내기 위해서 객체가 값을 저장하고 내부적으로 다음 원소를 가리킬 수
        있는 객체여야 한다. iterable한 객체여야 하는데, 그것이 list같은
        객체다.
        ```python
        for i in [0,1,2,3,4]:
            print(i)
        ```

        ```text
        0
        1
        2
        3
        4
        ```

    -   example2
        ```python
        for i in [0,1,2,3,4]:
            if i % 2:
        	print(i, "is odd")
        ```

        ```text
        (1, 'is odd')
        (3, 'is odd')
        ```

    -   example3: for loop을 돌리면 iterable객체에서 값을 꺼내오지 index를
        가져오지 않는다. index가 필요할때는 enumerate를 사용한다.
        ```python
        a = [5,3,2]
        for i,v in enumerate(a):
            print(i,v)
        ```

        ```text
        (0, 5)
        (1, 3)
        (2, 2)
        ```

<!--list-separator-->

-  range iterator

    range는 내부적으로 generator를 사용한다. generator는 함수다. 함수를
    사용해서 next item을 return하는 방식이라서 list처럼 모든 원소에
    해당하는 객체를 생성해서 사용하는것 보다 memory낭비가 적다. range의
    형태는 다음과 같다. stop-1에서 종료된다.

    ```text
    (1) range(stop)
    (2) range(start,stop)
    (3) range(start,stop,step)
    ```

    내부적으로는 stop에 도달하면 exception이 발생해서 loop를 끝낸다.

    -   example1

    <!--listend-->

    ```python
    for i in range(5):
        print(i,"번째")
    ```

    -   example2

    <!--listend-->

    ```python
    for i in range(1,6):
        print(i,"번째")
    ```

    -   example3

    <!--listend-->

    ```python
    for i in range(1,10,2):
        print(i,"번째")
    ```

<!--list-separator-->

-  string iterator, dictionary

    for-loop가 객체에서 값을 꺼내기 때문에 값을 저장하는 객체들은
    for-loop과 같이 사용할 수 있다. string, dictionary가 대표적이다.

    -   string
        ```python
        for c in "This is text":
            print(c)
        ```

        ```text
        T
        h
        i
        s

        i
        s

        t
        e
        x
        t
        ```

    -   dictionary
        ```python
        for key in {"text":1, "word":2}:
            print(key)
        ```

        ```text
        text
        word
        ```
    -   dictionary에 enumerate

    <!--listend-->

    ```python
    for key,value in enumerate({"text":1, "word":2}):
        print(key,value)
    ```

    ```text
    0 text
    1 word
    ```

    ```python
    for key,value in {"text":1, "word":2}.values():
        print(key)
    ```

    -   example5
        ```python
        for key in {"text":1, "word":2}.items():
            print(key)
        ```

        -   dictionary를 list로 바꾸는 이유는 in하고 같이 쓰일
            때이다. in은 for와 같이 쓰이기 때문에, dictionary를
            list형태로 바꿔야 한다. keys(),values()는 자주 변환되는
            형태다. 그런데 items()는 어디에 쓰일지 궁금하다. key와
            value를 tuple형태의 item list가 어디에 쓰일지도
            궁금하다. 이것을 강사가 설명한다. example6에 작성했다.

    -   example 6
        ```python
        for key, value in {"a":1, "b":2}.items():
            print(key,value)
        ```

        -   items()가 반환하는 tuple list를 어떻게 사용하는지
            궁금했다. tuple list의 형태로 되어 있는것을 꺼내서 쓸때는
            unpacking한다. tuple이기때문이다. tuple을 사용하는 방식은
            unpacking이기 때문이다. 그래서 위의 key, value in dictionary
            형태로 사용된다.


#### break &amp; continue {#break-and-continue}

<!--list-separator-->

-  break

    -   break를 사용하면, 여러개의 loop로 둘러싸여 있더라도 가장
        바깥쪽의 loop를 벗어날 수 있다. 강사 자료 오타. range문의 수정.
        ```python
        for i in range(1,100):
            if i % 17 == 0:
               break
            print(i)
        ```

<!--list-separator-->

-  continue

    -   continue문은 loop의 처음으로 되돌아간다.
    -   example
        ```python
        for i in range(100):
            if i % 17:
               continue
            print(i)
        ```

<!--list-separator-->

-  loop에서 else

    -   python의 loop에 있는 특별한 기능
    -   else를 loop와 같이 사용할 수 있다. 반복문이 끝났을 때 실행되는 block으로 보면된다.
    -   example
        ```python
        for i in range(10):
            print(i)
        else:
            print("loop complete with break")
        ```

        -   0-9까지 loop를 돌고 "loop complete with break"를 출력한다.

    -   example2
        ```python
        for i in range(10):
            print(i)
            if i > 5:
               break
        else:
            print("loop complete without break")

        ```

        -   else는 for block안에 있진 않다. 그래서 break문으로 for loop를
            벗어난다면, else블럭이 실행되야 한다고 생각하지만, 실행되지
            않는다. 이걸로 알 수 있는건 for block과 else블럭은 연관되어
            있다고 볼 수 있다.

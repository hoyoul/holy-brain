+++
title = "python_2"
author = ["holy"]
description = "python 2장 요약정리"
date = 2023-06-04T00:00:00+09:00
draft = false
+++

## [lecture2] variable &amp; operator {#lecture2-variable-and-operator}


### 변수와 assignment {#변수와-assignment}

-   변수는 lisp에선 symbol이라고 부르고, 모든 symbol은 동일한 형태의
    structure를 가졌다. symbol의 이름은 unique했다. symbol의 이름은
    address였기 때문이다. 하지만, python에서 변수는 type이 가리키는
    structure를 갖는다. 모두 동일한 모양이 아니다. 변수의 이름은
    unique한건 마찬가지 인 듯 하다. address이기 때문이다.


#### 변수와 assignment의 예 1 {#변수와-assignment의-예-1}

-   example
    ```python
    (1) a = 15
    (2) b = a
    (3) b
    print(b)
    ```
-   interpreter가 이것을 어떻게 해석할까?
    -   (1) 과정
    -   lvalue인 a를 보고 symbol table에서 찾는다. 없다면 a라는 이름을
        새로 만든다.
    -   rvalue인 15를 본다.
    -   =(assignment)를 실행한다. rvalue의 type이 int라는 것을 알고
        int객체를 만든다.
    -   int객체의 value에 15를 집어넣는다.
    -   int객체의 name에 a를 집어넣는다.
        -   이렇게 해서 하나의 객체를 만들었다.

    -   (2) 과정
    -   lvalue인 b를 보고 symbol table에서 찾는다. 없다면 b라는 이름을
        만든다.
    -   rvalue인 a를 보고 symbol table에서 찾아서 a를 꺼낸다. 없으면
        error가 발생된다.
    -   =(assignment)를 실행한다. int객체를 만들고, value로는 a값을
        , name이 b인 객체를 만든다.
    -   python interpreter가 객체의 value를 꺼낸다. 즉 eval한다.

-   즉 assignment의 역할이 무엇일까?
    1.  객체를 만드는 것이 아닌가? 즉 interpreter는 = 을 보고,
        rvalue와 lvalue를 보고 객체를 만들어야 한다는 걸 안다. 그러나
        무조건 객체를 만드는 것은 아니다. lvalue를 보고, 해당 symbol이
        symbol table에 있는지 여부를 확인한다. 없다면 객체를 만들려고
        한다. 만일 있다면, immutable인지 mutable인지 확인한다. 만일
        mutable이라면, 새로운 객체를 만들지 않고
        update한다. immutable이라면, 새로운 객체를 만든다. 이제 rvalue
        살펴본다. rvalue의 type을 확인하고 그 type에 맞는 객체를
        만든다. 위의 예를 보면, a = 15에서 a가 symbol table에 없기
        때문에, 객체를 생성해야 한다고 본다. 그리고 rvalue를 보고 int
        type임을 알수 있기 때문에 int객체를 만드는 것이다. 객체를
        만든후 name과 value에 값을 assign한다. 그리고 만든 객체의
        value는 rvalue인 15를 가리고 name은 lvalue인 a를
        가리킨다.


#### 변수와 assignment의 예2 {#변수와-assignment의-예2}

-   example2
    ```text
    a = b = 2
    ```
-   뒤에서부터 처리한다. 즉 name이 b, value가 2인 int객체를
    만든다. 그 다음 name이 2 value가 b를 가리키는 또 다른 int 객체를
    만든다.


#### literal object에 대해서 {#literal-object에-대해서}

-   3이나 5와같은 값도 객체다 literal object이다. 예를 들어서,
    아래와 같은 것이 가능하다.
    ```text
    4.0.real or (4).real
    ```
    4.0은 float객체가 만들어진 후 real이란 float의 method가
    수행되는 것이다.
-   나는 lisp의 symbol과 비슷하다는 가정아래 해석한다.

    <a id="figure--"></a>

    {{< figure src="./img/python/symbol1.png" caption="<span class=\"figure-number\">Figure 1: </span>lisp의 symbol1" width="500px" >}}
-   literal 객체의 assignment는 새로운 객체를 생성하고 객체의
    value가 literal object를 가리키는게 아니라 value의 값으로
    들어가는거 같다. 예를 들면 a =3의 경우, 새로운 객체가 만들어지고
    객체의 value로 3이란 객체를 가리키는게 아니라 3값이 직접 새로운
    객체의 value가 되는 것 같다.


### name(변수)와 assignment의 특징 {#name--변수--와-assignment의-특징}

-   숫자로 변수명을 시작할 수 없다.
-   대소문자를 구별한다.


#### assignment의 특징 {#assignment의-특징}

-   assignment는 return값이 없다. 그래서 함수형 언어에서는 권장하지
    않는다. 예를 들어,

<!--listend-->

```emacs-lisp
(a = 2) == 2
```

이것은 syntax error를 발생한다. a와 2를 갖는 객체를 만들지만, 그
객체를 return하지 않기 때문에 비교할 수 없다. 그런데, python에선,
객체를 return하게 할 수도 있다. 아래를 보자.

```text
(a := 2) == 2
```

이것은 어떻게 해석할 것인가? name이 a이고 value가 2인 객체를
return한다. ==은 rvalue, lvalue의 객체의 value를 비교한다.


### primitive data types {#primitive-data-types}

-   data type을 알아야 하는 이유는 한 가지다. 객체를 만들때, data
    type에 맞는 객체를 만들기 때문이다. 그리고 type에서 제공하는
    method와 member variable을 사용할 수 있기 때문이다.


#### numerals {#numerals}

-   int,float,complex
-   double은 없다. float가 double과 같다고 보면 된다.
-   example
    ```text
    float: 1.7, -5.7, 4.67e-3, 3e5
    complex: 1+8j, 1.6+8j
    ```


#### string {#string}

-   string
-   char type은 없다.
-   example
    ```text
    'text', "한글"
    ```


#### boolean {#boolean}

-   bool
-   example
    ```text
    True, False
    ```


#### None {#none}

-   일종의 null,
-   example
    ```text
    None
    ```


### 연산자 (operator) {#연산자--operator}

-   python이 객체 지향적 언어라고 하는데, 객체의 method를 사용하는게
    아니라, 객체와 객체 사이에 operator를 넣어서 연산하는게 이상해
    보일 수 있다. 그러나, operator는 method로 변환이 된다. 다음을
    참조 하자.
    참조:<https://www.pythonmorsels.com/everything-is-an-object/#manually-calling-dunder-methods>
    즉, 연산자는 어떻게 보면, 모든 객체에 내장된 멤버 함수로 봐도
    된다. Object 객체의 멤버 함수로 보는게 더 정확할 듯 하다.


#### 연산자의 종류 {#연산자의-종류}

<!--list-separator-->

-  arithematic operator

    -   + (덧셈), - (뻴셈) , \*(곱셈) , \*\*(거듭제곱), /(몫) , //(몫,정수),
        %(나머지)

<!--list-separator-->

-  bit operator

    -   ~(NOT): 이게 좀 계산법이 황당한데, 우선, 2진수로
        변환한다. 그리고 앞에 0을 붙인다. 양수이니까, 예를 들어,
        ```text
        5 => 101 => 0101
        ```
         그리고, ~연산을 적용한다. ~연산은 1010이다. 이게 답이다. 그런데,
        여기서 1을 빼주고 1의 보수를 취해서 값을 도출한다. 즉 1010에서
        1을 빼서 1001이 되고, 여기서 1의 보수를 취해 0110이 나오는데,
        원래 msb가 1이였기 때문에 -6값이 되는 것이다.
    -   | (OR): 2진수로 변환한 후 or연산을 하면 된다.
    -   &amp; (AND): 2진수로 변환한 후 and연산을 한다.
    -   ^ (XOR): 같으면 0, 다르면 1로 계산한다.
    -   &lt;&lt;, &gt;&gt; : shift연산은 곱셈과 나눗셈이 된다.

<!--list-separator-->

-  축약 가능

    -   example
        ```text
        (1) a = a + 1  =>  (2) a += 1
        ```
    -   두 식은 약간 다른 의미를 갖는다고 한다. in-place하고 out-place의
        개념을 설명한다. 둘다 assignment문이라서 object를 만들거라고
        생각하지만, (1)은 out-place라서 새로운 객체를 만들지만, (2)는
        in-place라서 기존 객체의 값을 update 시도를 먼저 하고 안될 경우
        새로운 객체를 만든다고 한다.
    -   bit 연산자도 축약에 사용할 수 있다.
        ```text
        a = 7 (1) a = a ^ 4  (2) a ^= 4
        ```

<!--list-separator-->

-  비교 연산자

    -   x &lt; y
    -   x &gt; y
    -   x &lt;= y
    -   x &gt;= y
    -   x == y : x,y value가 같다.
    -   x is y : x,y 주소가 같다.
    -   x != y : x, y value가 다르다.
    -   x is not y: x,y 주소가 다르다.
    -   x in X : x가 X에 포함된다.
    -   x not in X : x가 X에 포함되지 않는다.

<!--list-separator-->

-  boolean operator

    -   operand가 boolean type일때 수행한다. bit operator는 operand가
        arithematic이다.
        -   not
        -   AND
        -   OR

<!--list-separator-->

-  operator priority

    -   기본적으로 산술연산자 &gt; bit연산자 &gt; 비교연산자 &gt; 논리연산자의 순이다.


#### mutable vs immutable {#mutable-vs-immutable}

-   primitive data type은 값을 변경할 수 없는 immutable이다.

<!--list-separator-->

-  example1

    -   example
        ```text
        (1) a = 10
        (2) b = a
        (3) a += 1
        (4) a, b, a is b
        ```

        1.  python interpreter는 a = 10을 본다. 우선, lvalue인 a에 대해서
            symbol table에서 확인한다. 없다. 그리고 rvalue를 본다. int
            type이란 것을 알기에 int객체를 만들고, name과 value를
            설정한다.
        2.  python interpreter는 b = a를 본다. lvalue인 b가 symbol table에
            있는지 확인한다. 없다. rvalue인 a를 본다. symbol table에
            있다. 해당 객체의 type정보만 가지고 온다. int다. 이제 객체를
            만든다. b라는 이름과 a라는 값을 갖는 객체를 만들었다.
        3.  python interpreter는 a += 1을 본다. lvalue인 a를 symbol
            table에서 찾는다. a는 10의 값을 가지고 있는 immutable한
            객체다. rvalue를 본다. a가 가진 값과 1을 더해 11이란 값을
            만든다. 이제 객체를 만들어야 하는데, lvalue가 immutable하기
            때문에 update할 수 없다. 새로운 객체를 만든다.a라는 새로운
            객체를 만든다. 그러면 기존 a객체가 갱신된다.
        4.  여기서 확인해야 할 것은 b의 value다. b의 value는 a인것인가?
            아니면, a가 가진 값인가? 지금 봤을때는 a가 가진 address인거
            같다. 그래서 (3)까지 출력했을 때, a값은 새로운 객체의 11값을
            가지고, b의 경우는 옛날 객체인 a의 값인 10을 갖는다. 새로운
            a객체를 가르키지 않는다. 그리고 a is b는 false다. is라는
            함수는 a와 b의 값을 가져오기 때문이다.

<!--list-separator-->

-  example2

    ```text
    (1) a = [1,2,3]
    (2) b = a
    (3) a += [4]
    (4) a, b, a is b
    ```

    1.  python interpreter는 a = [1,2,3]을 본다. lvalue를 보고 symbol
        table에서 a를 찾는다. a는 없다. rvalue를
        본다. [1,2,3]이다. eval할 필요가 없다. 이제 객체를 만든다,
        name,value를 연결한다.
    2.  python interpreter는 b = a를 본다. lvalue의 b를 symbol
        table에서 찾는다. 없다. rvalue의 a의 type을
        확인한다. list다. list객체를 만들고,이름과 value를
        연결한다. 여기서 list객체를 만드는지는 잘 모르겠다.
    3.  python interpreter는 a += [4]를 본다. lvalue인 a를
        본다. symbol table에 있다. type을 보니 list다. 즉
        mutable하다. rvalue를 본다.a +[4]를 계산하자. a의 value인
        [1,2,3]의 append를 사용해서 [4]를 추가한다. [1,2,3,4]의 값이
        나왔다. 이제 여기서 객체를 만드는것이 아닌 a객체의 value를
        update한다.
    4.  a의 값은 [1,2,3,4]이고, b도 [1,2,3,4]이다. a is b는 True가
        된다.

<!--list-separator-->

-  example3

    ```text
    a = [1,2,3,4]
    b = a
    a = a + [5]
    a,b, a si b
    ```


### In-place operator에 대해서 {#in-place-operator에-대해서}

-   a +=1과 a= a+1의 차이: assignment와 operator의 차이
    -   python에서 모든 것은 객체다. 그리고 모든 function은 어떤 객체의
        method다. 그런데, 위에서 봤던 operator들은 method의 모양을 하고
        있지 않다. 그럼 operator라는 것은 무엇인가? 본질은
        method다. 즉, member method이다. 이것은 [여기](https://www.pythonmorsels.com/everything-is-an-object/)에서 확인할
        수있다. 이제 a += 1과 a = a+1에 대해 말해보자. a += 1에서 +=는
        operator임을 알수 있다. member function, 즉 method라는것은 해당
        객체의 값을 변경, update를 한다. 그런데 a 객체는
        immutable이다. integer literal이기 때문에 값을 변경하지
        못한다. 그래서 새로운 객체를 만들어낸다. 만일 a가 list와 같은
        mutable한 객체라면, 그 값은 변경이 될 것이다. 그리고 a = a +
        1의 경우는 assignment다. 즉, 새로운 객체를 만들어 내는 것이다.

    -   examples
        -   example1
            ```python
            a = 10
            b = a
            a += 1
            print(a)
            print(b)
            print(a is b)
            ```

        -   example2
            ```python
            a = 10
            b = a
            a = a + 1
            print(a)
            print(b)
            print(a is b)
            ```

        -   example2
            ```python
            a = [1,2,3,4]
            b = a
            a += [5]
            print(a)
            print(b)
            print(a is b)
            ```

        -   example2
            ```python
            a = [1,2,3,4]
            b = a
            a = a + [5]
            print(a)
            print(b)
            print(a is b)
            ```


### == 과 is {#과-is}

-   ==는 값을 비교, is는 객체의 이름(주소)를 비교
-   example1

    -   아래는 False가 나와야 정답인데, 이상하게 True가 나온다.

    <!--listend-->

    ```python
    a = 13453436
    b = 13453436
    print (a is b)
    ```

    -   아래는 True가 나온다.

    <!--listend-->

    ```python
    a = 13453436
    b = 13453436
    print (a == b)
    ```
-   example2
    -   이것도 제대로된 결과가 나오지 않는다. True,True,False,True가
        정답이라고 한다. print(b is 'long-long-text') 이 왜 false가
        나오는지 모르겠다.
        ```python
        a = 'text'
        b = 'long-long-text'
        print(a is 'text')
        print(a == 'text')
        print(b is 'long-long-text')
        print(b == 'long-long-text')
        ```
-   example3
    ```python
    a = True
    print(a is True)
    ```
-   example4
    ```python
    a = None
    print(a is None)
    ```


### Dynamic typing {#dynamic-typing}

-   type을 명시하지 않고, assign할 때, rvalue를 보고 type이 정해진다.


### implicit type conversion {#implicit-type-conversion}

-   bool -&gt; int -&gt; float -&gt; complex bool type은 int type으로
    conversion이 가능하고, int는 float로 conversion이 가능하다.
    ```python
    a = True
    a = a + 2
    print(a)
    a = a + 1.5
    print(a)
    ```

-   python interpreter가 a = True를 보고, Boolean 객체를 만들고,
    객체에 a라는 이름과 True라는 값을 맵핑한다.
-   python이 a = a + 2를 본다. lvalue인 a를 symbol table에서
    찾는다. 있다. rvalue를 계산한다. a의 value는 True이고, 2라는 값이
    넘어온다. 이때 boolean객체의 overriding된 + method가 True와 2라는
    값을 더해서 어떤일을 하는지는 정확히 모르겠다. 여튼 더하면 3이란
    값이 계산되고, assign을 적용해서, int객체를 만들고 a의 이름과
    3이란 값을 갖게 된다.
-   python interpreter가 a = a + 1.5를 보고 위의 과정과 비슷한 과정을
    거치게 된다.
-   example2
    형변환이 안된다.
    ```python
    a = 1
    a + None
    a + 'text'
    ```


#### explicit type conversion {#explicit-type-conversion}

-   complex를 float로, float를 int로, int를 str로 형변환을 할수
    있다. 이것은 강제 형변환을 해야 한다.
-   example
    ```python
    a = 12345
    float(a)
    complex(a)
    str(a)
    bool(a)
    ```
-   bool의 경우는 none,[],{} 등은 false값을 갖는다.
-   형변환의 또다른 예
    ```python
    print(int(75.75))
    print(str(75.75))
    print(bool('True'))
    ```
-   소수점 처리 방식
    -   소수점 버림: int(75.75)
    -   소수점 반올림: round(75.75), object의 method.
    -   소수점 올림: math.ceil


### type checking {#type-checking}

-   type이라는 method를 사용한다. 아무래도 object의 method인거 같다.
-   isinstance는 predicate이다.
-   example

<!--listend-->

```python
a = 123
type(a)
isinstance(a,float)
```

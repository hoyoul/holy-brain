+++
title = "python_summary2-assignment and variables"
author = ["holy"]
description = "python의 기초개념중 제일 중요한 assignment와 name을 다룬다. lisp관점에서 다루기 때문에 엉뚱하게 들릴 수 있다."
date = 2023-06-08T00:00:00+09:00
draft = true
+++

## [lecture2] variable &amp; operator {#lecture2-variable-and-operator}


### 변수 개념 {#변수-개념}

python에서의 변수를 lisp에선 symbol이라고 부르고, 일상생활에서는
name이라고 말한다. 일상생활에서 name은 중요하지 않다. 본질이
중요하다. 어떻게 부르던 본질은 변하지 않기 때문이다. 그러나, logic과
computer science는 말장난이기 때문에 name은 그 무엇보다도
중요하다. 그래서 변수, symbol, reference 등등 다양하게 부른다. 다르게
부르는 이유는 다르기때문이다. 언어가 다르고 쓰임새가 다르다. 하지만,
여기서 우리가 알아야 하는것은 name이 본질을 가리키는 것이 아니라,
가리키는것 자체가 본질이라는 것이다. logic과 cs에서는
그렇다. symbol이던 변수던 모든것을 가리킬수 있다. 그것이 class가
되었던, macro가 되었던, primitive datatype이 되었던, function이 되었던
method가 되었던 모든것을 가리킨다. 이것이 본질이다. first order
logic의 Frege가 말한 concept라는것은 어떻게 보면 가리키는 것이
본질이라는 것을 말하는지도 모르겠다.

python의 변수를 다루기 전에 lisp에서 변수에 해당하는 symbol을
살펴보자.  lisp에서 모든 symbol은 동일한 형태의 structure를
갖는다. 그림을 보자.

<a id="figure--the structure of symbol"></a>

{{< figure src="/img/python/symbol2.png" caption="<span class=\"figure-number\">Figure 1: </span>the structure of symbol" width="600px" >}}

symbol의 이름은 unique하다. python에서 변수는 type이라는 structure를
갖는다. type은 class이기 때문에 동일한 모양이 아니다. 변수의 이름은
unique한건 마찬가지다. python도 그림으로 표시하면 대략 이런 그림이
아닐까 한다.

<a id="figure--python symbol"></a>

{{< figure src="/img/python/python_symbol1.png" caption="<span class=\"figure-number\">Figure 2: </span>python symbol" width="600px" >}}

lisp은 gentle common lisp책을 참조했지만, python은 내 뇌피셜이다.

여튼 python의 변수나 lisp의 symbol이나, `"이름으로 모든것을 가리킬수
있다는게 중요하다."` 이름으로 객체도, class도 function도 method도
모든 것을 가리킬수 있다. 그게 본질이다. 여튼 그러면 어떻게 이름과
구조를 만들어서 가리킬 수 있는가? assignment가 그런 역할을 한다.


### assignment {#assignment}

assignment를 나타내는 문자가 있다. = 이라는 문자다. 그리고 사용법은
다음과 같다.

```text
lvalue(symbol) = rvalue
```

interpreter는 =이라는 문자를 보고 여러 과정을 통해서 이름과 구조를
만든다. python은 type이라는 구조를 갖는데, 그 구조라는게 결국 객체를
뜻하는 것이 아닌가? 대부분은 그렇다. 그러면 assignment는 객체를 만들고
이름필드에 lvalue를 넣는 것인가? 하지만 assignment가 무조건 객체를
만드는 것은 아니다. lvalue를 보고, 해당 symbol이 symbol table에 있는지
여부를 먼저 확인한다. 없다면 새로운 객체를 만들고, 만일 있다면,
symbol이 가리키는 객체를 가져와서 immutable인지 mutable인지
확인한다. mutable이라면, rvalue값을 update할 것이다. immutable이라면,
새로운 객체를 만든다.

새로운 객체를 만들어야 하는 상황은 lvalue가 symbol table에 없는 경우,
있어도 immutable이라서 만들어야 하는경우가 있다. 여기까지는 lvalue값에
따른 처리다. lvalue에 따라 새로운 객체를 만들어야 한다. 그래서 rvalue
살펴본다. rvalue의 type을 확인한다. type을 가져온 후 그 type에 맞는
객체를 만든다. 이런 과정을 예제로 구체적으로 확인해 보자.


### 변수와 assignment의 예 1 {#변수와-assignment의-예-1}

```text
(1) a = 15
(2) b = a
(3) b
print(b)
```

python interpreter가 위의 sentence들을 어떻게 해석할 것인가?

-   (1) 과정: interpreter는 lvalue를 보고 symbol table에서 찾는다. a라는
    이름은 symbol table에 없다. 그 다음 =(assignment)를 실행한다. a
    symbol이 symbol table에 없기 때문에 assignment는 객체를 만들기
    위해서 rvalue를 확인한다. rvalue는 literal 15이다. 그리고 15는 int
    type이다. int type의 class를 가져와서 객체로 만든다. int 객체의
    value에는 15를 넣고 name에는 a를 넣는다. 따라서 symbol table의 a는
    int 객체를 가리킨다.
-   (2)과정: interpreter는 lvalue를 확인한다. b라는 symbol은 symbol
    table에 없다. 따라서 객체를 만들기 위해서, assignment는 rvalue를
    확인한다. rvalue는 symbol table에 있다. assignment는 rvalue값 a를
    가져온다. a의 type에 맞는 객체를 생성하고, value에 a값을 넣고 b를
    name에 넣는다.
-   (3)과정: interpreter가 b를 보면, symbol table에서 찾는다. symbol
    table에 b라는 symbol이 있기 때문에 값을 evaluate한다.


### 변수와 assignment의 예2 {#변수와-assignment의-예2}

```text
a = b = 2
```

뒤에서부터 처리한다. 즉 b라는 symbol을 symbol table에서 찾는다. 없다면
rvalue값을 보고 객체를 만드는데, literal값 2이기 때문에 int객체를
만든다. 그 다음 a=b를 처리한다. a가 symbol table에 없기 때문에 symbol
table에 a라는 symbol을 등록하고, rvalue를 살핀다. rvalue b는 symbol
table에 있기 때문에, 그 값을 꺼내올 수 있다. b의 값은 2이기 때문에 int
객체를 만들고 그 객체에 2를 넣는다. 그림으로 보면 다음과 같다.

<a id="figure--symbol"></a>

{{< figure src="/img/python/symbol3.png" caption="<span class=\"figure-number\">Figure 3: </span>symbol" width="600px" >}}


### literal object에 대해서 {#literal-object에-대해서}

3이나 5와 같은 값도 객체다. literal value가 아니라 literal
object이다. 그렇기 때문에 아래와 같은 것이 가능하다.

```text
4.0.real or (4).real
```

4.0은 float객체고 real이란 float의 method다. ruby에서도 이렇게 하지만,
기존언어에서는 보기 힘들다.


### return하는 assignment {#return하는-assignment}


#### := {#90fbf1}

```text
(1) print((a = 2) == 2)
(2) print((a := 2) == 2)
```

함수형 언어는 모든 것이 함수다. 그리고 함수형 언어에서 모든 함수는
return값이 존재한다. python은 oop언어이지만, 함수형 언어를
지향한다. 그래서 많은 요소에 함수형언어의 특징을 가져온다. python에서
assignment는 symbol을 만들고 객체를 만들지만, return값이
없다. assignment는 함수가 아니고 python 또한 oop언어이기 때문에
이상해보이지 않는다. 그런데 python은 함수형언어처럼 assigment도 함수
처럼 처리한 대체 assignment를 지원한다. (1)의 경우에는 에러가 나지만,
(2)의 경우는 에러가 나지 않는다. (2)도 assignment다. 하지만
함수다. a라는 symbol을 만들고 2라는 값을 갖는 int객체를 만들고
return을 한다. 따라서 (2)는 True를 evaluate한다.


### primitive data types {#primitive-data-types}

data type을 알아야 하는 이유는 한 가지다. assignment로 객체를 만들때,
data type을 가져와서 객체를 만들기 때문이다. lisp의 경우 symbol과
symbol이 가리키는 객체는 universal한 하나의 structure지만, type이 있는
언어들은 assignment로 symbol과 type에 기반한 객체를 만들기
때문이다. 또한 type이 좋은 이유는 type에 이미 사용할 수 있는 method와
member variable이 pre-define되어 있다는 것이다.


#### python numerals {#python-numerals}

-   type: int,float,complex
-   double은 없다. float가 double과 같다고 보면 된다.

<!--listend-->

```text
int: 1,2,3
float: 1.7, -5.7, 4.67e-3, 3e5
complex: 1+8j, 1.6+8j
```

literal object는 바로 만들수 있다. 하지만 symbol이 없기때문에 참조할
수 없다.


#### string {#string}

python에는 char type이 없다. 문자들은 string type을 갖는다.


#### boolean {#boolean}

boolean literal object는 True,False인데 대문자를 사용한다는것에 유의하자.

```text
True, False
```


#### None {#none}

다른 언어에는 없는 None이라는 객체가 있다.

```text
None
```


### 연산자 (operator) {#연산자--operator}

python의 모든 것은 객체라고 했다. operator도 객체일까? +,-,/ 같은 것을
보면 함수같다. 그런데 oop언어에 함수는 없다. method만 있을뿐이다. 그럼
method일까? 사용법을 보면 method형태가 아니다.  method라면
객체.method형태로 사용할 것이다. 그럼 객체일까? 객체라면 +.abs()같은
method를 호출할수 있어야 하는데, 그런 것을 본적이 없다. operator는
과연 무엇일까? 내가 알고 있는 python의 모든 것은 객체란 말은
틀린것일까? 한가지 추론을 해본다. `연산자는 최상위 class인 Object의
 method가 아닐까?`

python에서는 class선언 없이 코딩을 하곤한다. 예를 들어서, 아래 코드만
봐도, print()를 바로 호출한다. entry point가 없다. oop의 경우, 대표격
언어인 java를 보자. java에서는 class를 만들고 class에 public static
void main()를 entry point로 해서 코드를 작성한다. c언어도 void
main()로 entry point를 만들고 그 안에서 코딩을 한다. 그런데 entry
point가 없다는게 신기하다. python이 oop언어라면, 아마도 print(3+4)를
둘러싸는 class가 있고, 그 class내의 entry point()가 있지 않을까 하고
생각한다. 다만 생략된 거 아닐까? 좀 찾아봤더니,
그렇다. 생략되었다. 아래의 print함수를 실행 시킬때는 python
temp.py처럼 파일명으로 실행되고, python은 main라는 이름을 python에게
전달한다. 전달된 이름은 '<span class="underline"><span class="underline">name</span></span>'이라는 private member변수를
세팅한다. 그리고 temp.py내에서는 if <span class="underline"><span class="underline">name</span></span> == main 아래에
print(3+4)가 있는 것이다.

```python
print(3+4);
```

위의 코드는 아래 코드처럼 되어 있는 것이다.

```python
 class temp{
   if __name__ == "main":
      print(3+4);
}
```

그런데 이것과 연산자와 무슨 상관이 있는가?라고 말할 수 있다. print()에
보면 3+4에 + operator가 쓰였다. 이것이 어떤 syntax에러도 없이 수행되는
이유는, 숨겨져 있는 temp라는 class가 있고, 이 class는 Object라는
최상위 class를 상속받는다. 즉 +라는 operator는 Object class에서 정의된
method이기 때문에, 사용할 수 있는 것이다. 그래서 `"내 생각은 + operator는
최상위 class Object의 method다."`

`그런데 위의 추론도 문제가 있다.` + operator가 Object의 method이고
숨겨져 있는 temp라는 class가 Object를 상속하기 때문에 + method를
사용할 수 있다. 그런데 method의 인자가 3,4이다. 어떤 method가 이렇게
중위표기법으로 구현되는가? `method의 중위 표기법 이상하지 않은가?`
temp가 Object를 상속받기 때문에 + method를 사용한다기 보다, 3이라는
literal 객체가 Object를 상속받기때문에 + method를 사용할 수 있었고,
원래 표기법은 3.+(4)인데 저렇게 쓴게 아닐까? 지금까지는 100% 정확하게
operator가 무엇인지는 모르겠다. python에서는 모든게 객체라고 했는데,
operator처럼 그 존재가 정확히 모르는것 중에 built-in function이란게
있다. `built-in function도 Object의 method인가?`

<div class="important">

gpt chat에 물어보면 operator와 built-in function은 python
interpreter에 의해 제공되는 pre-builtin된 함수라고 한다. python
interpreter는 python언어로만 작성되지 않았다. cpython이라고 해서
내부는 c,c++로 된 함수와 변수를 사용해서 만들어진다. python의
operator와 built-in function들(id,hash같은 함수), primitive data
type은 c,c++에서 정의된것을 wrapping해서 사용된다. python의 모든것은
객체라고 말할때, 이말은 python으로 만들어지는 모든게 객체일뿐
interpreter에 미리 정의된것은 객체가 아닐 수 있는 것이다.

</div>

참고로 위에서
__name__은 object의 private field고, underbar가 한개인 것은 protected
field이다. 그리고 python의 모든것이 객체라고 했는데, 참고자료가 있어서
attach했다.
(참조:<https://www.pythonmorsels.com/everything-is-an-object/#manually-calling-dunder-methods>),


#### 연산자의 종류 {#연산자의-종류}

<!--list-separator-->

-  arithematic operator

    <div class="attention">

    -   +(덧셈)
    -   -(뻴셈)
    -   \*(곱셈)
    -   \*\*(거듭제곱)
    -   /(몫)
    -   //(몫,정수),
    -   %(나머지)

    </div>

<!--list-separator-->

-  bit operator (비트 연산자)

    <div class="attention">

    -   &amp; (AND)
    -   | (OR)
    -   ~(NOT)
    -   ^ (XOR)
    -   &lt;&lt;, &gt;&gt;(SHIFT)

    </div>

    있다, 없다, 맞다, 틀리다의 정보는 bit로 나타낼 수 있다. 이런 정보는
    bit 1개로 되어 있지 않다. byte,kbyte,극단적으로 GByte까지 엄청난
    정보를 표현할 수 있다. 예를 들어서, 만명의 사람들을 일렬로 나열해서
    코에 점이 있다 없다를 bit로 나타냈다고 하자.그리고 A라고
    하자. 여기에는 사람을 나타내는 index정보와 점이 있다, 없다를 나타내는
    정보를 표현한다. 동일한 만명인 사람들에게서 한국사람이냐 아니냐로
    정보를 bit로 나타내고 B라고 하자. 한국사람이며 코에 점이 있는 사람을
    알려면 and연산을 하면된다. 간단히 계산할 수 있다. 이것이 연산자의
    힘이다. 한국사람이거나 코에 점이 있는 사람을 알고 싶다. 이것을 일일이
    사람들을 확인할 필요가 없다. or연산을 하면 된다. 코에 점이 있는
    사람들을 A라고 표시했는데, ~A라고 하면, 콤에 점이 없는 사람들을
    표현할 수 있다. 몇명 인지는 1의 수를 세면 된다. XOR은 한국사람이면서
    코에 점이 없거나, 코에 점이 있으면서 한국사람이 아닌 사람을 1로
    표시한다. Nand, Nor도 상황에 맞게 사용할 수 있다. and or not xor은
    있다,없다, 맞다,틀리다로 나타내는 명제를 수천개 수만개가 있어도
    나열한 후 계산하면 된다. 근데, 실수로 수만개의 data의 이런 정보를
    mega byte로 나타냈다고 하자. 그런데, 갑자기 한개의 bit를 추가해야
    한다면? A에서 한칸 shift하면 된다. shift라는 것은 데이터의 삽입을
    하기 위해서 사용된 연산인데, 10진수의 계산을 2진수로 변환후
    shift연산을 하면 곱셈과 나눗셈을 기계적으로 더빠르게 할 수
    있다. 그래서 shift는 원래의 의도인 data로서의 비트가 아니라 기계적
    계산을 위한 연산자로 볼 수 있다. and or not같은 logical operator를
    predicate logic에 한정지어서 말했는데, 실은 first order logic
    참,거짓,있냐? 없냐의 명제가 아닌 first order statement를 계산할 수
    있긴 하다. 물론, programmming language자체가 first order logic이고,
    세상의 모든 knowledge는 first order logic으로 처리할 수 있기 때문에,
    logical operator는 중요하긴 하다. 얘기가 옆길로 빠져서...쓸데 없는
    소리를 많이 했다.

<!--list-separator-->

-  연산자 축약

    아래는 연산자 축약이라고 부르는데, 연산자 축약이란 말도 첨들어보지만,
    코드는 익숙하기 때문에 용어는 그냥 넘어가자. 여튼 (1)하고 (2)가 같다는
    것은 누구나 알 수 있다. (1)을 (2)로도 변환할 수 있고 (2)를 (1)로도
    변환할수 있다고 알고 있다. 그런데 두 개의 연산은 내부에서는 다르게
    동작한다고 한다.

    ```text
    (1) a = a + 1  =>  (2) a += 1
    ```

    (1)의 경우는 out-place로 a라는 새로운 symbol과 무조건 새로운 객체를
    만든다. 반면에 (2)는 in-place라고 해서 새로운 객체를 무조건 만들지는
    않고 update할수 있는 객체라면 update를 하고 아니면 안한다고
    한다. 이것은 mutable과 immutable하고도 연관이 있는듯 하다. python은
    oop언어라서 모든게 객체다. 그중 primitive data type이라는게 있는데,
    primitive data type으로 만든 객체는 immutable하다. 즉 수정이
    안된다. update가 안된다는 말이다. (1)번이야 무조건 객체를 만드니
    객체를 새로 생성할지 안할지 고민할 필요가 없지만, (2)의 경우는
    mutable과 immutable을 따지기 때문에 알 필요가 있다. a += 1에서 +=을
    하나의 operator로 보자. lvalue에 해당하는 a를 symbol table에서
    찾는다. 만일 a=3이라는 식이 위에 있어서 a가 3이라는 int 객체를
    가리키고 있는 상황이라고 하자. 여기서 symbol table에서 찾은 lvalue a는
    int type의 객체(value 3을 가진)를 가리킨다. primitive type이다. 따라서
    update는 불가능하고 새로운 객체를 만들기 위해서 rvalue를
    본다. rvalue의 값을 보고 새로운 int객체를 만들게 된다. 결론적으로
    (1),(2)는 모두 새로운 객체를 생성하고 symbol이 가리키는
    모습이다. 그런데, 지금까지 설명한 게 맞는지 안맞는지를 확인할 수는
    없을까?

    ```python
    print('adfd')
    def foo(x):
      if x>0:
        return x+1

      else:
        return x-1

    return foo(3)
    ```

    ```python
    print("Hello, world!")
    ```

    ```python
    def foo():
        print("test")
        return 3;


    foo()
    ```

    ```python
    print("test")
    a = 3
    print(id(a))
    a = a+ 1
    print(id(a))
    ```

    ```text
    None
    ```

    참고로 비트 연산자들도 연산자 축약을 사용할 수 있다. 아래는
    xor연산자를 보여준다.

    ```text
    a = 7 (1) a = a ^ 4  (2) a ^= 4
    ```

<!--list-separator-->

-  비교 연산자

    ```text
    (1) x < y
    (2) x > y
    (3) x <= y
    (4) x >= y
    (5) x == y : x,y value가 같다.
    (6) x is y : x,y 주소가 같다.
    (7) x != y : x, y value가 다르다.
    (8) x is not y: x,y 주소가 다르다.
    (9) x in X : x가 X에 포함된다.
    (10) x not in X : x가 X에 포함되지 않는다.
    ```

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

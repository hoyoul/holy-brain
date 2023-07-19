+++
title = "[linear algebra-1] linear algebra introduction"
author = ["holy"]
description = "linear algebra의 생각"
date = 2023-06-14T00:00:00+09:00
draft = true
+++

## linear algebra에 대한 생각 {#linear-algebra에-대한-생각}


### 인과 관계(causation)와 상관관계(correlation) {#인과-관계--causation--와-상관관계--correlation}

어떤 변수와 다른 어떤 변수와의 연관성이 있을때 relation이 있다고
한다. 예를 들어, x가 증가하면 y도 증가한다던지 혹은 x가 증가하면 y가
감소한다. x가 감소하면 y는 증가한다. 등등. 이런 관계를 영어로는 좀 더
명확하게 표현할 수 있는것 같다. 예를 들면, describe variables in terms
of one another. 여튼 이런 관계는 수학적으로 표현할 수 있다. 인문학
분야에서도 이런 관계를 표현하는데, 좀 다르다.  인간관계, 상관관계와
같이 구분해서 표현하는데, 이것은 관계를 어떻게 해석하느냐의
문제다. 수학적으로는 어떤 변수의 값이 다른 변수의 값에 영향을 미치는
relation일 뿐이다.


### relation과 수학적 표현 {#relation과-수학적-표현}

relation은 집합으로 표현할 수도 있고 1차방정식, 2차방정식,
function으로도 relation으로 나타낼 수도 있다. 여튼 이렇게 수학적으로
나타낸 relation은 일종의 법칙과 같다. 예를 들어, 온도가 높아지면
아이스크림 판매량이 늘어난다.를 수학적으로 y = 3x +5처럼 나타낼 수
있다. 이렇게 수식으로 정의되면, 어떤 온도를 x에 집어넣으면 얼마만큼의
아이스크림이 판매될지 예측할 수 있다. 우리가 원하는건, 방정식을
만들고, data를 집어넣어서 예측을 하는 데 있다. 그럼 어떻게 방정식을
만들 수 있을까? data가 있다면 방정식을 만들 수가 있다.


### 관계, 예측, data, 방정식 {#관계-예측-data-방정식}

어떤 feature끼리의 관계가 있다면, 그 관계를 방정식으로 만들 수 있다면,
우리는 방정식을 통하여 어떤 data도 예측할 수 있다. 방정식을 만드는
방법은 data로 만든다.


### data로 방정식 만들기 {#data로-방정식-만들기}

참조:<https://pydata.tistory.com/29> intended: 온도가 올라갈때 마다
아이스크림 판매량을 예측하는 기계를 만들고 싶다.  매일 온도를
측정하고, 판매량을 기록했다. 이 data를 바탕으로 온도에 따라 아이스크림
판매량을 예측하는 기계를 만들고 싶다.

| 온도      | -4 | -3 | -2 | -1 | 0 | 1 | 2 | 3 | 4  |
|---------|----|----|----|----|---|---|---|---|----|
| 아이스크림 판매량 | -6 | -4 | -2 | 0  | 2 | 4 | 6 | 8 | 10 |

보기 좋게 세로로 변경하자.

| 온도 | 아이스크림 판매량 |
|----|-----------|
| -4 | -6        |
| -3 | -4        |
| -2 | -2        |
| -1 | 0         |
| 0  | 2         |
| 1  | 4         |
| 2  | 6         |
| 3  | 8         |
| 4  | 10        |

이 data를 통해서 온도에 따른 아이스크림 판매량을 예측하는 기계를
만드는 가장 간단한 방법은 방정식을 만드는 것이다. 예를 들면 x를 온도,
y를 판매량으로 하는 1차 방정식을 만드는 것이다. x와 y사이에 어떤
관계가 있다는 확신이 들기 때문이다. 그런데 반드시 1차 방정식이여야
하나? nonlinear한 2차방정식이나, 삼각함수나, 다른 방식을 사용할 수
없는가? 물론 있다. x와 y의 관계가 2차방정식의 모양을 가질 수도
있다.우선은 가장 간단한 1차방정식으로 이러한 기계를 만들 수 있는지
확인해 보자. 1차방정식은 모두 비슷한 모양이다.  y = mx +b 라는
방정식의 모양이다. 여기서 우리가 방정식을 만들기 위해서는, m과 b를
구해야 한다. 그래야 y=mx+b라는 기계를 만들고, 임의의 온도를 x에 넣었을
때 판매량을 알 수 있기 때문이다.

m = \\(\frac{\Delta y}{\Delta x}\\), b =&gt; what goes with x = 0

m을 생각해보면, x가 1씩 증가할 때 y의 증가량이다. 직관적으로 봤을때
값은 2씩 증가하는 것을 볼 수 있다. 따라서 m은 2로 할 수 있다. y = 2x
+b에서 b값을 찾아 보자. b는 x가 0으로 갈때, y값이다. 따라서 방정식은 y
= 2x + 2가 된다. 그런데 실제 data를 가지고 1차방정식을 만족하는 m과
b를 구할 수 있을까? 거의 없다고 본다. data의 row가 많아질수록 이렇게
딱 떨어지는 기계는 만들 수 없다.

이것에 대한 생각은 나중에 하고, 우리는 data를 통해서 방정식에 필요한
x의 계수 m과 y의 절편 b를 찾을 수 있음을 보였다. 물론 이렇게 딱
떨어지게 구하는 경우는 거의없다. 그런데, 다른 경우를 생각해 보자. 만일
판매량에 영향을 미치는 요소가 온도만 있는게 아니라, 습도, 해가
떠있는지 유무,등등... 데이터의 x에 해당하던 온도뿐 아니라,
A,B,C,D,...X까지 24개의 종류가 있다면, 우리는 데이터로 부터 각각의
계수 24개를 구해야 한다. 어떻게 할 것인가? 또한 첫번째 예는 운이
좋아서 구했지만, row가 엄청많다면 더 힘들 것이다. 어떻게 구해야 할지
머리속에 떠오르지 않는다.

이 때 필요한게 linear algebra다.

linear algebra를 설명하기 전에, 우리가 한것을 다시
overview해보자. 우리는 data로 방정식을 만들고, 만든 방정식에 임의의
온도를 넣었을때, 판매량을 예측할 수 있는 machine을 만드는
것이다. 이것을 비유하면, 마치 음식재료와 요리를 가지고 기계를 만들고,
그 기계에 음식재료를 넣는다면, 요리를 만들수 있다는 것과
비슷하다. 다시한번 말하면, X는 음식재료, Y를 음식이라고 하면, 그
정보를 가지고 음식만드는 기계를 만들고, 다른 재료를 넣더라도 비슷한
음식이 나오게 되는 것이다. 우리가 만드는 방정식은 기계다. linear
machine이라고 할 수도 있다.

결론은 우리가 원하는 기계는 여러가지 feature와 결과의 관계로
만들어진다. data로 부터 각각의 feature의 계수를 구하는데 있어 linear
algebra를 사용할 수 있다는것만 알아두자.


### 왜 linear Algebra인가? Non-linear algebra는 안되는가? {#왜-linear-algebra인가-non-linear-algebra는-안되는가}

위의 예에서 보면, 2개의 변수를 갖는 경우나 3개의 변수를 갖는 경우나
모두 값이 실수값 하나다.그런데 값이 실수값이 아닌, 다른형태라면,
그것은 non-linear가 될수 있다고 본다.아래에 그것과 관련한 질문을 한적이 있다.


### 왜 기계는 정해져 있는가? {#왜-기계는-정해져-있는가}

data가 주어지면, 우리는 기계를 만들고, 만든 기계로 예측을 한다고
했다. 그런데 주어진 data로 만드는 기계의 형태는 정해져 있다. linear
machine이다. Y= AX + BY + CZ의 형태다. 여튼 우리는 지금 linear한
기계만 생각한다.


## [강의 시작-1] Scalar, Vector, and Matrix {#강의-시작-1-scalar-vector-and-matrix}


### Scalar: 하나의 수를 나타낸다. {#scalar-하나의-수를-나타낸다-dot}

-   s \\(\in\mathbb{R}^1\\) : 그 수를 s라 할때, 이와같이 표시할 수
    있다. \\(\mathbb{R}\\) 이 실수를 나타내는 집합이기 때문이다.


### vector: ordered list of number다. {#vector-ordered-list-of-number다-dot}

-   x = \\(\begin{bmatrix} x\_1 \\\ x\_2 \\\ x\_3 \\\ \vdots \\\ x\_n \end{bmatrix} \in \mathbb{R}^n\\) , 여기서 vector는 n차원이다.
-   \\(\mathbb{R}^n\\) 은 실수를 나타내는 집합R이 n번 곱해진다는 얘기인가?
    n은 row의 개수를 말하는 거 같다.


### matrix: 2차원 array다. {#matrix-2차원-array다-dot}

-   \\(A = \begin{bmatrix} 1  \ 6  \\\ 3 \ 4 \\\ 5 \ 2  \end{bmatrix} \in \mathbb{R}^{3x2}\\)
-   3x2는 row의 개수와 column의 개수를 말하는 거 같다.


### matrix를 vector로 생각(column vector와 row vector) {#matrix를-vector로-생각--column-vector와-row-vector}

-   column: 원기둥
-   vector를 column vector라고도 부른다. 왜 column이란 이름이 붙였냐
    하면, matrix를 볼때, matrix의 column이 vector모양이고, matrix는
    column형태의 vector로 구성되었다고 생각했다. 모양을 보면, matrix는
    column에 해당하는 vector로 분해될 수 있어 보인다. 그래서, matrix에서
    vertical column을 column vector라고 불렀다.
-   row vector란건 원래 없었다. vector는 column형태이기 때문이다. 그런데
    column vector를 transpose연산을 하면 row vector matrix의 성분들을
    vector로 나눌 수 있기 때문에,row vector란 말이 생겼다.


### vector를 matrix로 생각. {#vector를-matrix로-생각-dot}

-   matrix를 vector로 보면, column vector가 합쳐진것, 혹은 row vector가
    합쳐진 것으로 볼 수도 있다.
-   vector를 matrix로 볼수도 있다.
-   \\(x = \begin{bmatrix} x\_{1}  \\\ x\_{2}  \\\ x\_{3} \\\ \vdots \\\ x\_{n}  \end{bmatrix} \in \mathbb{R}^n = \mathbb{R}^{n x 1}\\)
-   위에 처럼 vector를 n개의 row와 1개의 column인 matrix로 표시할 수도 있다.
-   그럼 row vector도 마찬가지로 아래와 같이 표시할 수 있다.
-   \\(x = \begin{bmatrix} x\_{1}  \ x\_{2}  \ x\_{3} \end{bmatrix} \in \mathbb{R}^n = \mathbb{R}^{1 x 3}\\)
-   즉 1개의 row와 3개의 column을 가진 matrix로 표시할 수 있다.


### Transpose 연산 {#transpose-연산}


#### row vector와 transpose {#row-vector와-transpose}

-   원래 row vector는 없었다. vector는 column의 모양을 하고 있었기 때문이다.
-   그런데, column형태의 vector를 row vector형태로 사용할 일은 많았다.
-   그래서 Transpose라는 연산을 통해서 row vector를 만들어
    사용했다. 지금도 마찬가지다. vector는 transpose해서 row vector로
    사용한다.
-   예를 들면 다음과 같다.
-   \\(X = \begin{bmatrix} x\_{1}  \\\ x\_{2}  \\\ x\_{3} \\\ \vdots \\\ x\_{n}  \end{bmatrix}^T = \begin{bmatrix} x\_{1}  \ x\_{2}  \ x\_{3} \ldots \x\_{n} \end{bmatrix} \in \mathbb{R}^{1 x n}\\)
-   n x 1의 column vector를 transpose해서 1 x n의 row vector를 만든 것이다.


#### transpose와 matrix {#transpose와-matrix}

-   vector를 row vector로 만들기 위해서 transpose연산을 취했지만,
    matrix도 transpose연산을 취할 수 있다.
-   아래를 보자.

    A = \\(\begin{bmatrix} 1  \ 6  \\\ 3 \ 4 \\\ 5 \ 2 \\\ \end{bmatrix} \in \mathbb{R}^{3 X 2}\\)

    A = \\(\begin{bmatrix} 1  \ 6  \\\ 3 \ 4 \\\ 5 \ 2 \\\ \end{bmatrix}^{T}\\) =&gt;  \\(\begin{bmatrix} 1  \ 3 \ 5 \\\ 6 \ 4 \ 2 \end{bmatrix}\\)

-   A matrix는 2개의 column vector로 보면 된다. 첫번 째 column vector가
    첫번 째 row vector로 transpose되고, 두번 째 column vector가 두번째
    row vector가 된다.


### Matrix notations {#matrix-notations}


#### Square Matrix {#square-matrix}

row와 column이 같은 matrix를 square matrix라고 부른다. 특별한 기호로
나타내진 않는다.

e.g., B = \\(\begin{bmatrix} 1  \ 6 \\\ 3 \ 4 \end{bmatrix}\\)


#### Rectangular Matrix {#rectangular-matrix}

row와 column이 같지 않은 matrix를 Rectangular Matrix로 부른다. 이것도
특별한 기호를 사용하지 않는다.

e.g., A = \\(\begin{bmatrix} 1  \ 6 \\\ 3 \ 4 \\\ 5 \ 2 \end{bmatrix}\\)


#### Transpose연산자 기호 {#transpose연산자-기호}

Transpose는 matrix 상단에 T를 표시해서 나타낸다.

e.g., \\(A^{T}\\) = \\(\begin{bmatrix} 1 \ 3 \ 5 \\\ 6 \ 4 \ 2  \end{bmatrix}\\)


#### component의 표시 {#component의-표시}

Matrix의 하나의 원소를 지칭하는 방법, index는 1부터 시작한다.
e.g., \\(\textbf{A}\_{ij}\\) , \\(\textbf{A}\_{21}\\) = 3


#### matrix에서 column vector와 row vector표시 {#matrix에서-column-vector와-row-vector표시}

<!--list-separator-->

-  row vector

    matrix에서 row vector는 row를 지정하고 column을 :로 표시한다. 그리고
    둘 사이 ,가 삽입된다.
    e.g.,\\(\textbf{A}\_{i,:}\\) \\(\textbf{A}\_{2,:} = \begin{bmatrix} 3 \ 4 \end{bmatrix}\\)

<!--list-separator-->

-  column vector

    matrix에서 column vector는 column을 지정하고 row를 :로 표시한다.그리고
    둘 사이 ,가 삽입된다.
    e.g.,\\(\textbf{A}\_{:,j}\\) \\(\textbf{A}\_{:,2} = \begin{bmatrix} 6 \\\ 4 \\\ 2  \end{bmatrix}\\)


### summary {#summary}

scalar가 무엇인지? vector가 무엇인지? matrix가 무엇인지를 배웠다. 어떤
응용에 있어서 그런 용어가 가진 역할이라던가 본질에 대한 의미라기
보다는 생김새, 모양 구조를 배웠다. 예를 들면, 숫자로 된 data가 낱개로
있을때는 scala, 어떤 구조로 organize되어 있으면, vector, matrix 용어로
부른다는 것이다. 아직까진 별다른 얘긴 없다.


## [강의 시작-2] vector/Matrix 덧셈 곱셈 {#강의-시작-2-vector-matrix-덧셈-곱셈}

위에서도 말했듯이 우리는 data로 1차원기계를 만들것이다. 수많은
음식재료가 나오기 때문에, 즉, 음식재료가 많기 때문에, matrix나
vector로 만들지 않으면 안된다. 데이터가 vector, matrix형태로
organize되어 있을때, 그것들을 가지고 어떤 처리, 계산을 할수 있어야
한다. 정확하게는 1차원기계의 계수와 절편을 계산해야 하기때문에
Matrix/vector에 대한 계산 방식을 알아야 한다. 그리고 vector는 계산에
있어서 matrix로 취급한다.


### 덧셈과 뻴셈 {#덧셈과-뻴셈}


#### addition {#addition}

덧셈은 같은모양의 matrix끼리만 할 수 있다.


#### scala 곱 {#scala-곱}

그냥 scalar값을 더하거나 뺀다. 더하거나 빼도 같은 모양이 된다.


#### 내적(inner product, dot product) {#내적--inner-product-dot-product}

내적을 계산하면, 앞 매트릭스의 column과 뒷 매트릭스의 row가
같아서 소멸되고, 앞의 매트릭스의 row와 뒤의 column으로 size가
정해진 매트리스가 새로 만들어진다. 예를 들어서, 100x30과 30x500의
matrix는 100 x 500의 matrix를 만들어 낸다. 내적은 matrix와
matrix를 곱해서 새로운 matrix를 만들어낸다는 것이다. 덧셈이나
scala곱은 기존의 matrix 크기를 변화시키지 않는다. 하지만, 내적은
다르다. 내적은 두개의 matrix를 기반으로 새로운 모양의 matrix로
만든다. 새로운 모양의 matrix가 기존의 matrix보다 클수도 작을수도
있다. 이럴땐 내적을 해야해!라던가 내적이 어떨땐 내적을 사용해! 뭐
이런건 나오지 않았다.


### 내적은 not commutative. {#내적은-not-commutative-dot}

commutative라는 말은 교환법칙이다. AB \\(\not=\\) BA. 강사는 3가지의
경우를 모두 예를 들어서 설명한다.

1.  AB는 계산이 되지만, BA가 계산이 안되는 경우
    \\(A \in \mathbb{R}^{2X3}\\) 고 \\(B \in \mathbb{R}^{3X5}\\) 이면, \\(AB
           \in \mathbb{R}^{2X5}\\) 이지만, $BA$는 만들 수 없다.
2.  AB와 BA계산이 되지만, size가 안맞는경우
    \\(A \in \mathbb{R}^{2X3}\\) 고 \\(B \in \mathbb{R}^{3X2}\\) 이면, \\(AB
           \in \mathbb{R}^{2X2}\\) 이지만, \\(BA \in \mathbb{R}^{3X3}\\) , 따라서, \\(AB \neq BA\\).
3.  AB와 BA계산도 되고 size도 맞지만 계산이 다른 경우

    eg., \\(\begin{bmatrix} 1 \ 2 \\\ 3 \ 4 \end{bmatrix}\\) \\(\begin{bmatrix} 5 \ 6 \\\ 7 \ 8 \end{bmatrix}\\) = \\(\begin{bmatrix} 19 \ 22 \\\ 43 \ 50 \end{bmatrix}\\)

    \\(\begin{bmatrix} 5 \ 6 \\\ 7 \ 8 \end{bmatrix}\\) \\(\begin{bmatrix} 1 \ 2 \\\ 3 \ 4 \end{bmatrix}\\) = \\(\begin{bmatrix} 23 \ 34 \\\ 31 \ 46 \end{bmatrix}\\)

    값이 다른것을 알 수 있다.


### other properties {#other-properties}


#### Distributive {#distributive}

A(B+C) = AB + AC :commutative같은 경우 성립이 안되는 경우를 모두
보여주었다. 분배 법칙의 경우도 조건이 있는거 아닌가? A의 column과
B row 가 같아야 하고, A의 column과 C의 row가 같아야 만 저 식이
성립되는거 아닌가? 어째든 성립이 된다고 가정하면, 결과는 어떻게
될까? 성립이 되면,AB라는 매트릭스와 AC라는 매트릭스가 만들어지고
두 매트릭스가 size도 같다면, 하나의 매트릭스가 결과값으로 나올
것이다. 그러나 반드시 하나의 매트리스가 된다는 보장은 없다. AB +
AC인 상태가 될 수있다.


#### Associative {#associative}

A(BC) = (AB)C Associative도 A의 column과 B의 row가 같으면 위
계산이 가능하다. 결합법칙은 괄호의 연산이 가능하다면 순차적으로
풀면된다. 내적으로 연결된 계산을 할땐 어떤순서로 해도 상관없다는
뜻이다.


#### Property of Transpose {#property-of-transpose}

\\((AB)^{T} = B^{T}A^{T}\\) 내적의 transpose를 transpose의 내적으로
바꿀수도 있고, transpose로 된 matrix의 내적을 묶은후 transpose할
수 있다. transpose는 size의 경우 뒤바뀜이 일어나고 1st row가 1st
column으로 이동한다.


## [강의시작 2-1] Linear System {#강의시작-2-1-linear-system}

Linear System: 연립방정식과 그에 따른 연산을 포함한다. Linear
system에선 여러개의 Linear Equation을 Matrix를 사용해서 풀수 있다.


### Linear Equation {#linear-equation}

이전에 말했듯이 우리가 Linear Algebra를 사용하는 이유는 요리재료와
음식이 주어질때, 이 정보를 가지고 Linear Equation이란 기계를
만든다고 했다. Linear Equation 기계의 형태는 대략적으로 정해져
있다. 왜냐면 Linear Algebra를 사용하기 때문이다. 우리는 위에서
음식재료가 하나일때는, 하나의 음식재료 가지고 y = ax +b라는 형태의
기계를 만든다고 했다. 그 기계를 만든다는 것은 a와 b를 구하는
것이라고 했다. 아래 표에서 보듯이 음식재료 X가 Y라는 음식이
주어지면 방정식의 계수와 절편을 푸는것이다.

| X | -4 | -3 | -2 | -1 | 0 | 1 | 2 | 3 | 4  |
|---|----|----|----|----|---|---|---|---|----|
| Y | -6 | -4 | -2 | 0  | 2 | 4 | 6 | 8 | 10 |

그리고 여러종류의 음식재료가 있을때는, 예를 들어
2개의 음식 재료 W,X가 있고, 만들려는 음식이 Y 일 때는,

| W | -2 | -1 | -5 | -1 | 0 | 5 | 3 | 7 | 1  |
|---|----|----|----|----|---|---|---|---|----|
| X | -4 | -3 | -2 | -1 | 0 | 1 | 2 | 3 | 4  |
| Y | -6 | -4 | -2 | 0  | 2 | 4 | 6 | 8 | 10 |

Y = aW + k1꼴의 방정식과 Y = bX + k2이란 방정식을 둘다 만족시키는
계수(a,b)와 절편(k1,k2)을 찾아야 한다.

음식재료가 3개일때도 보자.

| V | -2 | -1 | -5 | -1 | 0 | 5 | 3 | 7 | 1  |
|---|----|----|----|----|---|---|---|---|----|
| W | -2 | -1 | -5 | -1 | 0 | 5 | 3 | 7 | 1  |
| X | -4 | -3 | -2 | -1 | 0 | 1 | 2 | 3 | 4  |
| Y | -6 | -4 | -2 | 0  | 2 | 4 | 6 | 8 | 10 |

Y = aV ~~k1 라는 꼴의 기계, Y= bW +k2라는 기계, Y= cX +k3라는
기계를 모두 만족시키는 하나의 기계를 만들어야 한다. 최종기계는
어쩌면, Y = aV + k1 = b~~ k2, Y = aV +bW + cX + k꼴의 기계의 a,b,c 그리고 k 절편을
구하는것일 지도 모른다.


### linear algebra의 적용(linear system과 linear equation) {#linear-algebra의-적용--linear-system과-linear-equation}

linear system: set of linear equations,연립방정식을 뜻한다. 우리는
이 linear system을 풀면된다. 즉 여러개의 linear equation이 모인
linear system을 matrix, vector형태로 표시하고 이를 계산해서 각각의
linear equation의 계수와 절편을 구한다. 그러면 우리가 표를
사용해서 계수와 절편을 구하려고 equation을 만들었는데, 변수와
계수를 변경한다. 왜냐면 우리가 원하는건 계수였기 때문에 계수가
변수가 된다. 그리고 우리는 matrix형태로 data(table)을 표현할 수
있어야 한다. 그리고 절편은 없다고 생각하자. 식을 간단하게 하기
위해서이다. 우리에게 주어지는 것은 음식재료와 음식을 가지고 기계를
linear algebra 기계의 계수를 구해보자.  예를 들어 보자. 이건
강사의 예제다. 강사는 4가지 정보(data)를 바탕으로 얼마나
오래사는지를 예측하고 싶어한다. 우리는 linear machine을 만들어야
한다. 아래는 data다. 이것으로 linear machine을 만들어 보자.

| Person_ID  | 1       | 2      | 3       |
|------------|---------|--------|---------|
| Weight     | 60kg    | 65kg   | 55kg    |
| Height     | 5.5ft   | 5.0ft  | 6.0ft   |
| Is_smoking | yes(=1) | No(=0) | Yes(=1) |
| life-span  | 66      | 74     | 78      |

위 data를 가지고 linear machine(값을 예측하는 기계)을 만드는데는
process가 필요하다.

1.  위 data를 linear system으로 구성한다.
2.  linear system을 풀면 linear machine의 계수를 알수 있다.
3.  계수만 알면 linear machine이 만들어 지는 것이다.


#### linear system을 만들자. {#linear-system을-만들자-dot}

linear system은 linear equation으로 구성된다.linear equation으로
만들기 위해서 표를 transpose하자. transpose하면 matrix로 표현하기
쉽다.

| Person_ID | Weight | Height | Is_smoking | life-span |
|-----------|--------|--------|------------|-----------|
| 1         | 60kg   | 5.5ft  | yes(=1)    | 66        |
| 2         | 65kg   | 5.0ft  | No(=0)     | 74        |
| 3         | 55kg   | 6.0ft  | Yes(=1)    | 78        |

\\(60x\_{1} + 5.5x\_{2} + 1x\_{3} = 66\\)
\\(65x\_{1} + 5.0x\_{2} + 0x\_{3} = 74\\)
\\(55x\_{1} + 6.0x\_{2} + 1x\_{3} = 78\\)

이렇게 linear combination을 통해 linear system을 만들었다. 이제
matrix/vector형태로 만든다.

\\(\begin{bmatrix} 60 \ 5.5 \ 1 \\\ 65 \ 5.0 \ 0 \\\ 55 \ 6.0 \ 1\end{bmatrix}\\) \\(\begin{bmatrix} x\_{1} \\\ x\_{2} \\\ x\_{3}  \end{bmatrix}\\) = \\(\begin{bmatrix} 66 \\\ 74 \\\ 78 \end{bmatrix}\\)  이렇게 보면 Ax = b의 형태다.

matrix는 대문자, vector는 소문자로 표시한다. 여기서 좀
tweak(조금 고치다;튜닝)을 하면, 아래와 같이 볼 수도 있다.

\\(a^{T}\_{1}x = 66\\)
\\(a^{T}\_{2}x = 74\\)
\\(a^{T}\_{3}x = 78\\)

이제 여기까지하면 data를 가지고 linear system을 만들었다고 볼
수 있다.


#### linear system 풀기 {#linear-system-풀기}

<!--list-separator-->

-  prerequisite for solving linear system

    linear system을 푼다는 것은 계수인 x vector를 구하는
    것이다. 그런데 풀기위해선 행렬 계산법에 대해 몇가지 개념들을
    알아야 한다. 그중 Identity matrix를 먼저 살펴보자.

<!--list-separator-->

-  Identity Matrix

    항등 행렬로 부른다. 항상 등식이 성립하는 matrix다. diagonal
    entry들이 모두 1인 square matrix다. I라고 표시하고 다음과 같이
    size를 표시한다.

    \\(I\_{n} \in \mathbb{R}^{n X n}\\)

    e.g., \\(I\_{3}\\) = \\(\begin{bmatrix} 1 \ 0  \ 0 \\\ 0 \ 1 \ 0 \\\ 0 \ 0 \ 1 \end{bmatrix}\\)

    이 matrix의 특징은 이 matrix에 곱해지는 matrix의 결과는
    자기자신이라는 것이다. 예를 들어보자.

    e.g., \\(\begin{bmatrix} 1 \ 0  \ 0 \\\ 0 \ 1 \ 0 \\\ 0 \ 0 \ 1 \end{bmatrix}\\) \\(\begin{bmatrix} x\_{1}  \\\ x\_{2} \\\ x\_{3}  \end{bmatrix}\\) = \\(\begin{bmatrix} x\_{1}  \\\ x\_{2} \\\ x\_{3}  \end{bmatrix}\\)

    3x3과 3x1로 3x1의 vector가 계산되지만, 그 vector가 자기자신임을
    알 수 있다. vector도 matrix의 일종이다.

<!--list-separator-->

-  Inverse Matrix

      Identity matrix를 통해서 Inverse Matrix의 개념이 생겼다고 한다.
    Inverse Matrix도 Identity matrix처럼 squared matrix다. 어떤
    matrix가 있을 때, 그 matrix의 inverse matrix를 내적하면 자기
    자신이 된다.

    -   inverse matrix

        -   square matrix
        -   \\(A \in \mathbb{R}^{n X n}\\)
        -   \\(A^{-1}A\\) = \\(AA^{-1}\\) = \\(I\_{n}\\)

        특이한 것은 \\(A^{-1}\\) 를 구할때, A와 I를 알고 있기 때문에, A와
        I를 적당히 처리해서 구할 수 있을거라고 생각하지만, 구할 수
        없다. 예를 들어 \\(AA^{-1}\\) = \\(I\_{n}\\) 이니까, 양변에 \\(A^{-1}\\) 을
        내적해서 구할수 있지 않을까 하고 생각하는데, 구할 수
        없다. inverse matrix는 구하는 공식이 있다.

        e.g., \\(A\\) = \\(\begin{bmatrix} a \ b \\\ c \ d \end{bmatrix}\\) 라 하자.

        \\(A^{-1}\\) = \\(\frac{1}{ad - bc}\\) \\(\begin{bmatrix} d \ -b  \\\ -c \ a  \end{bmatrix}\\)

        e.g., \\(A\\) = \\(\begin{bmatrix} 1 \ 2 \\\ 3 \ 4 \end{bmatrix}\\) 라 하자.
        \\(A^{-1}\\) = \\(\frac{1}{4 - 6}\\) \\(\begin{bmatrix} 4 \ -2  \\\ -3 \ 1  \end{bmatrix}\\) = \\(\begin{bmatrix} -2 \ 1  \\\ \frac{3}{2} \ - \frac{1}{2}  \end{bmatrix}\\)

        즉, A에서 ad-bc를 계산한 후, diagonal의 component들을 바꿔주고
        나머지는 -값을 해준다.

        여기서 한가지 특이한건, matrix는 transitive하지 않다고 했다. 즉
        교환법칙이 성립하지 않는다. AB와 BA는 같지 않았다. 하지만, A와
        A의 역행렬은 교환법칙이 성립하는 것을 볼 수 있다.

<!--list-separator-->

-  Solving linear system

    이제 linear system을 풀기 위한 준비가 되었다. data를 가지고
    우리는 linear system을 만들었다. 그 구조는 다음과 같았다.

    \\(Ax = b\\)

    \\(\begin{bmatrix} 60 \ 5.5 \ 1 \\\ 65 \ 5.0 \ 0 \\\ 55 \ 6.0 \ 1\end{bmatrix}\\) \\(\begin{bmatrix} x\_{1} \\\ x\_{2} \\\ x\_{3}  \end{bmatrix}\\) = \\(\begin{bmatrix} 66 \\\ 74 \\\ 78 \end{bmatrix}\\)

    \\(Ax = b\\) 에서 계산을 위한 matrix인 Identity와 Inverse matrix를
    사용해서 푼다. 풀이 과정은 다음과 같다.

    \\(Ax = b\\)
    \\(A^{-1}Ax = A^{-1}b\\)
    \\(I\_{n}x = A^{-1}b\\)
    \\(x = A^{-1}b\\)

    이제 적용해 보자. 우리의 linear system에서 \\(A^{-1}\\) 을 구해보자.

    \\(A^{-1}\\) = \\(\begin{bmatrix} 0.0870  \ 0.0087  \ -0.0870 \\\ -1.1304 \ 0.0870 \ 1.1314 \\\ 2.0000 \ -1.0000 \ - 1.0000  \end{bmatrix}\\)

    이제 \\(x = A^{-1}b\\) 을 계산하면 된다.

    \\(x = A^{-1}b\\) = \\(\begin{bmatrix} 0.0870  \ 0.0087  \ -0.0870 \\\ -1.1304 \ 0.0870 \ 1.1314 \\\ 2.0000 \ -1.0000 \ - 1.0000  \end{bmatrix}\\) \\(\begin{bmatrix} 66 \\\ 74 \\\ 78 \end{bmatrix}\\) = \\(\begin{bmatrix} -0.4 \\\ 20 \\\ -20  \end{bmatrix}\\)

    이렇게 하면 linear system을 풀었다.

<!--list-separator-->

-  linear machine

    우리는 linear system을 계산해서 linear machine의 계수를
    구했다. 이제 linear machine을 완성시키자.

    linear machine coefficients = \\(\begin{bmatrix} -0.4 \\\ 20 \\\ -20  \end{bmatrix}\\)

    | Person_ID | Weight | Height | Is_smoking | life-span |
    |-----------|--------|--------|------------|-----------|
    | 1         | 60kg   | 5.5ft  | yes(=1)    | 66        |
    | 2         | 65kg   | 5.0ft  | No(=0)     | 74        |
    | 3         | 55kg   | 6.0ft  | Yes(=1)    | 78        |

    (life-span) = -0.4 x (Weight) + 20 x (Height) -20 x (Is_smoking)

<!--list-separator-->

-  linear system의 한계? rectangular matrix의 inverse matrix

    linear system을 풀기 위해서, 우리는 Identity Matrix와 Inverse
    matrix를 배웠고 또 활용했다. 그런데 Identity matrix와 Inverse
    Matrix는 모두 square matrix다. Rectangular matrix는 역행렬이
    존재하지 않는다. 그래서 위의 계산방식으로 사용할 수 없다. 그러면
    linear system을 풀수 없다는 얘기인가? 그렇지 않다. 그것에 대한
    얘기를 할것이다. 물론 programming상에선 알아서 구해주기 때문에
    걱정하지 않아도 된다.


### Non-Invertable Matrix A for Ax = b {#non-invertable-matrix-a-for-ax-b}

위에서 data를 가지고 linear machine을 만들었다. linear machine을
만드는 과정에서 역행렬을 사용했다. 그런데 역행렬을 만들 수 없는
경우가 있다. 이전에도 말했듯이 rectangular matrix도 역행렬을 만들
수 없다. 그런데 square matrix도 역행렬을 만들 수 없는 경우가
존재한다. 예를 들어보자.

eg., \\(A = \begin{bmatrix} 1 \ 2 \\\ 3 \ 6 \end{bmatrix}\\)

위 matrix는 square matrix이다. 그러나 ad-bc가 0이다. 따라서
역행렬이 존재하지 않는다. ad -bc를 계산하지 않아도, 위 matrix의
column vector는 한개 feature의 data다. 즉 2개 feature data라고 볼
수 있는데, 이 2개의 data가 같은 data로 볼 수 있다. 첫번 째
column에 2를 곱하면, 두번 째 column과 같아진다. 이런경우 역행렬을
구할 수 없다고 볼 수 있다.

어떤 matrix가 주어졌을때, 역행렬이 존재하는지 안 하는지를
판별하는게 ad -bc가 0인지를 계산했는데, 이것을 A의
determinant라고 한다. 보통은 다음과 같이 표시한다.

\\(det  A\\)

그러면, 3X3 matrix에서 determinant를 구할 수 있을까? 구할 수
있다. 4X4...등등.. 강사는 그림으로 알켜줬지만, 난 여기에 적진 않겠다.


#### 역행렬 존재의 의미. {#역행렬-존재의-의미-dot}

linear system에서 data행렬이 3x3의 square행렬이고, 역행렬이
존재해서 linear machine의 계수를 구할 수 있었다. 그런데, 우리가
받는 data가 3개의 feature를 갖고, 3개의 값만 있지 않다. 정방행렬
형태의 data는 일부러 만든것이고, 실제는 rectangular data일 확률이
더 높다. 또한 정방행렬의 data가 주어진다고 해도 판별식이
0인경우가 많다. 판별식이 0이면 역행렬이 존재하지 않기 때문에 위의
방식으로 해를 구할 수가 없다. inverse matrix로 해를 구할수 없다고
해서, 해가 없다라고 말한다면, 그것은 맞는 것일까? 그렇지
않다. 정방행렬에서 판별식이 0인 경우는 해가 없을수도 있지만,해가 무수히
많을 수도 있기 때문이다. 아래 예를 보자.

eg., \\(\begin{bmatrix} 1 \ 2 \\\ 3 \ 6  \end{bmatrix}\\) \\(\begin{bmatrix} x\_{1} \\\ x\_{2} \end{bmatrix}\\) = \\(\begin{bmatrix} 4  \\\ 12  \end{bmatrix}\\)

위 matrix는 판별식(determinant)가 존재하지 않는다. ad-bc가
0이다. 따라서 inverse matrix가 존재하지 않는다.그러면 이 linear
system의 해는 없는것인가? 아니면 해가 무수히 많은 것인가? 위
matrix 곱을 풀어서 보자.

\\(x\_{1} + 2x\_{2} = 4\\)
\\(3x\_{1} + 6x\_{2} = 12\\)

두 equation들은 동일하다. 왜냐면 3을 윗방정식에 곱했을 때 같은
동일한 직선이기 때문이다. 우리가 해라고 말하는건 위에서 풀어쓴 두
직선의 교점을 얘기한다. 두직선의 교점은 무수히 많다. 따라서
matrix곱의 해는 무수히 많다. 즉 해는 무수히 많다.

그럼, 해가 없는 경우를 살펴보자.
위 방정식을 그대로 이용하자.

\\(x\_{1} + 2x\_{2} = 4\\)
\\(3x\_{1} + 6x\_{2} = 13\\)

이 경우도 판별식은 0이다. 따라서 역행렬로 해를 구할수는
없다. 따라서 matrix곱을 풀어써보자. 두개를 직선으로 본다면 동일한
직선이 아니다. 따라서 해가 무수히 많지도 않다. 판별식이 0이
아니고 역행렬이 있다면, unique한 해를 가질텐데 그렇지도
못하기 때문에, 따라서 이 경우는 해가 존재하지 않는다.

강사는 2개의 video를 참조영상으로 제공했다. mit 선형대수 강좌 18,19다.
[여기1](https://ocw.mit.edu/courses/18-06-linear-algebra-spring-2010/resources/lecture-18-properties-of-determinants/)
[여기2](https://ocw.mit.edu/courses/18-06-linear-algebra-spring-2010/resources/lecture-19-determinant-formulas-and-cofactors/)

이게 무슨 의미인가? data를 사용해서 기계를 만들려고 할려면
matrix곱을 풀어야 한다. 그런데, matrix곱형태의 계산은 어렵다는
것이다. matrix곱 해결방법으로 흔히 쓰이는 inverse matrix로 양변에
곱해서 해결할려는 시도는 한계가 있다는 것이다. 첫번째 한계는
sqaure matrix만 역행렬이 존재한다는 점이다. 두번째 한계는 sqaure
matrix라고 해도, 판별식이 0이 되는 경우, 역행렬을 양변에 곱해서
해를 구하는 계산은 할수 없다는 점이다. 세번째로, matrix의 크기가
커지면, 판별식 자체 계산이 힘들다는 것이다. 설사, 위의 세가지
경우를 벗어나, square matrix이고, 역행렬이 존재하고, 그리고
계산이 가능하다 할지라도, 해가 1개만 unique하는 경우만 답을 구할
뿐이다. 우리는 해가 한개인,unique한 해를가지고, 기계를 만들 수도
있지만, 해가 여러개 되는 경우에도 기계를 만들어야 하고, 혹은 해가
없는 경우에도 기계를 만들어야 한다. 따라서 우리는 square matrix에
구애 받지 않는 rectangular matrix곱의 해를 구하는 방법과, 해가
없는경우, 해가 무수히 많은 경우의 처리를 생각해야 한다.


### Rectangular matrix의 계산 {#rectangular-matrix의-계산}

data를 제공 받아서,우리는 linear machine을 만든다고 했다. 그러기
위해선 linear machine의 coefficients가 필요했다. 이것이
matrix곱에서의 x벡터(가중치 벡터)를 의미한다. x벡터를 data로 부터
구했을때, 새로운 data의 예측이 가능했다. 그런데 matrix곱형태의
해를 구하는 계산이 역행렬을 곱하는 식으로는 안된다는 점과, 해가
없을때, 해가 무수히많을때를 해결해야 한다.

우선 해를 따져보자. Rectangular한 data가 주어질때, rectangular
matrix가 가진 모양의 특징이 있다. 모양에서 해의 개수를
예측가능하다는 것이다. m: 방정식수(data수) n:feature라고 했을때,
다음과 같이 일반적으로 예측할 수 있다.

1.  m &lt; n : 보통은 해가 무수히 많다.

    | Person_ID | Weight | Height | Is_smoking | life-span |
    |-----------|--------|--------|------------|-----------|
    | 1         | 60kg   | 5.5ft  | yes(=1)    | 66        |
    | 2         | 65kg   | 5.0ft  | No(=0)     | 74        |

    일반적인 얘기다. 100% 이렇다라고 말할 수는 없다. 여튼 이런
    경우를 under-determined system이라고 부른다고 한다.

2.  m &gt; n : 보통은 해가 없다.

    | Person_ID | Weight | Height | Is_smoking | life-span |
    |-----------|--------|--------|------------|-----------|
    | 1         | 60kg   | 5.5ft  | yes(=1)    | 66        |
    | 2         | 65kg   | 5.0ft  | No(=0)     | 74        |
    | 3         | 55kg   | 6.2ft  | Yes(=1)    | 78        |
    | 4         | 55kg   | 6.4ft  | Yes(=0)    | 78        |
    | 5         | 55kg   | 6.0ft  | Yes(=1)    | 78        |
    | 6         | 55kg   | 5.8ft  | Yes(=1)    | 78        |

    이 경우도 일반적인 얘기다. 보통 해가 없는경우가 많고,
    over-determined system이라고 부른다.


#### oh my god! {#oh-my-god}

나는 Rectangular matrix도 역행렬을 구하는 다른 방식이 있을 줄
알았다. 그런데 그 설명은 아직 없다. 해를 구하는 계산을 설명하기에
앞서서, 해가 1개인지, 해가 무수히 많은지 아니면 존재하지 않는지에
대해서 먼저 고민해야 한다.

해가 unique하다는 것은 기계를 1대 만들수 있고, 그 기계로 예측을
할수 있기 때문에, 제일 좋은 케이스다. 그런데 해가 없다는 것은
data를 가지고 machine을 만들지 못한다는 얘기가 된다. 두번째 해가
무수히 많다는 얘기는 우리가 구할려는 x벡터가 어떤값을 가져도
상관없다는 얘기가 된다. x벡터(가중치벡터)가 1000개 2000개 존재할
수 있다는 얘기도 된다. 1000개 2000개 무한하게 많은 기계를 만들수
있다는거다. 그런데, 주어진 data에 대한 각각의 기계의 값은
동일하나, 새로운 data에 대한 각 기계마다 예측값이 다 다를
것이다. 이게 문제다. 그러면, 해가 없는 경우, 해가 많은 경우는
어떻게 해야 하나? 해가 없는경우, 기계를 만들 수 있는가? 어떻게
기계를 만들것인가? 해가 많은 경우, 어떤 기계를 선택할 것인가? 하는
문제가 있다.

machine learning과 deep learning은 이런 문제를 해결하기 위한
solution을 준다.

해가 없는 경우를 보자. 예를들어 1000개의 equation을 모두 만족하는
해가 없다고 할때, 근사화된 해를 선정한다. 근사화된 해라는 것은
예를 들어, 어떤 계수들을 가질때, 결과오차율의 합이 제일 작다면,
그것을 해로 정한다.

해가 무수히 많은 경우는 regularization이란 기법을
사용한다. regularization은 보통 risk management라고 부른다. 많은
해 중에서, 가장 risk가 적은 해를 선택하겠다는 것이다. 예를 들면,
아래의 표를 통해서 우리는 여러개의 해를 구했다고 치자.

| Person_ID | Weight | Height | Is_smoking | life-span |
|-----------|--------|--------|------------|-----------|
| 1         | 60kg   | 5.5ft  | yes(=1)    | 66        |
| 2         | 65kg   | 5.0ft  | No(=0)     | 74        |

해는 가중치라고 했다. weight, height, is_smoking에 대한 가중치
벡터가 해가된다. 이 해가 여러개 있다고 치자. 어떤해는 height에
150, 다른 어떤해는 20이라는 값을 갖는다면, 150의 가중치를
갖는다는것은 결과에 지대한 영향을 준다. 혹은 키에 민감한 반응을
보여주는 machine이라고 말할 수 있다. 우리는 해가 여러개 있는 경우,
하나를 선택하는 것이다. 이것에 대한 선택은 어떤 법칙은 없다. 다만
민감도(risk)를 따져서 선택할 뿐이다.


## 내가 질문한 내용. {#내가-질문한-내용-dot}

오피스아워에서 질문했던건데요. 해결되었습니다. 제가 말도 잘못하고, 잘
모르다보니 이상한 말을 많이 하게 되네요. 여튼 문제는
해결됐습니다.아래는 제가 생각했던,질문가졌던 내용과 배경을
말해봤습니다.

[질문배경] 저는 우리가 하는게 수치data로 방정식과 같은
수학적 formula를 만들고, 만든 방정식에 수치data를 입력해서 값을
예측하는 모델을 만든다고 생각했습니다. 마치 음식재료와 요리를 넣어서
음식만드는 기계를 만든다고요. 그래서 간단한 표(data)에서 방정식을
만들어봤습니다. 1차방정식을 아래표에서 계산 하면, 기울기는 x의
증가량과 y의 증가량을 구해서 2를 구했고, y절편은 x가 0일때니까 2를
구했습니다. 그래서 y = 2x +2로 방정식을 만들었는데요.

| X | -4 | -3 | -2 | -1 | 0 | 1 | 2 | 3 | 4  |
|---|----|----|----|----|---|---|---|---|----|
| Y | -6 | -4 | -2 | 0  | 2 | 4 | 6 | 8 | 10 |

만일 음식재료가 많을 경우(아래와 같은표)는 위의방식대로 만들기
어렵다. 그래서 linear algebra를 사용한다고 생각했습니다.

| W | -2 | -1 | -5 | -1 | 0 | 5 | 3 | 7 | 1  |
|---|----|----|----|----|---|---|---|---|----|
| X | -4 | -3 | -2 | -1 | 0 | 1 | 2 | 3 | 4  |
| Y | -6 | -4 | -2 | 0  | 2 | 4 | 6 | 8 | 10 |

그런데 여기서 생각한게 음식재료가 많아봤자(A, B, C ...W,X) 결국에는
Aa+Bb+Cc…와 같은 linear한 방정식만 만드는것 같아요. 여기서
non-linear한 방정식을 만드는 것은 없을까? 하다가 그러면 위에처럼
1차방정식을 data로 유도하듯이 2차방정식을 어떻게 유도하는지를 알고
싶었어요. 그런데 찾아보니
<https://sciencing.com/quadratic-equations-table-10001169.html> 이
방식이 있더라구요. 여기선 data가 ordered pair형식으로 되어
있더라구요. 그래서 table에 있는 data가 아래와 같은 형태로 되어 있다면
non linear하다고 생각했습니다.

| X | (-4,2) | ( -3,4) | (-2,1) | (5,-1) | (0,2) | (1,2) | (2,3) | (3,3) | (4,4) |
|---|--------|---------|--------|--------|-------|-------|-------|-------|-------|
| Y | -6     | -4      | -2     | 0      | 2     | 4     | 6     | 8     | 10    |

그런데 결론적으로 제가 잘못생각했습니다. 여기서 tuple의 모양은 의미가
없고, tuple을 vector로 생각해서 vector를 넣는 tensor로
non-linear처리가 가능하다는 강사선생님이 말씀하셨는데, 즉 저기의
tuple모양은 vector로 봐도 된다고 하신것과 다름없다고
생각됩니다. 그리고 한동훈님이 말씀하신 것도 일맥상통한거 같습니다. 즉
저기의 tuple모양이던 list모양이던 vector로 치환될 수 있다. 따라서 굳이
tuple같이 따질 필요가 없다. 이말이 맞는거 같습니다.


### 여기서 또 질문 {#여기서-또-질문}

어떤 data가 있고, 그 data를 사용해서 방정식을 만들고, 만든 방식으로
예측한다. 그런데 왜 1차방정식만을 생각할까? 음식재료가 있고, 요리가
있을때, 서로간의 관계를 왜 1차 방정식기계만으로 한정하냐는
말이다. 다른 기계는 없을까? 2차방정식도 그중에 하나고, 다른형태의
기계도 만들 수 있는거 아닌가?

| X | -4 | -3 | -2 | -1 | 0 | 1 | 2 | 3 | 4  |
|---|----|----|----|----|---|---|---|---|----|
| Y | -6 | -4 | -2 | 0  | 2 | 4 | 6 | 8 | 10 |


### 여기서 또 질문 {#여기서-또-질문}

우리가 해야하는건 data가 주어지면, data로부터 기계를 만드는
것이다. 기계는 1차방정식의 형태다. 1차방정식은 여러 형태가 있지만,
음식재료가 A와 같다면, 우리는 y= Av+Bw+CX+D의 기계를 만들어야
한다. 그러면 어떻게 linear algebra를 사용해서 이런 기계를 만들 수
있을까? 그리고 data가 주어질때, A가 아닌 B의 형태로 주어졌을때, 동일한
data이지만 모양만 transpose한것이라면, 만들어지는 기계는 동일한
것인가? 라는 질문을 던질 수도 있다.

| V(음식재료) | -2 | -1 | -5 | -1 | 0 | 5 | 3 | 7 | 1  |
|---------|----|----|----|----|---|---|---|---|----|
| W(음식재료) | -2 | -1 | -5 | -1 | 0 | 5 | 3 | 7 | 1  |
| X(음식재료) | -4 | -3 | -2 | -1 | 0 | 1 | 2 | 3 | 4  |
| Y(음식) | -6 | -4 | -2 | 0  | 2 | 4 | 6 | 8 | 10 |

| W(음식재료) | X(음식재료) | Y(음식) |
|---------|---------|-------|
| -2      | -4      | -6    |
| -1      | -3      | -4    |
| -5      | -2      | -2    |
| -1      | -1      | 0     |
| 0       | 0       | 2     |
| 5       | 1       | 4     |
| 3       | 2       | 6     |
| 7       | 3       | 8     |
| 1       | 4       | 10    |

+++
title = "[linear algebra-2] linear independence"
author = ["holy"]
description = "linear independence"
date = 2023-06-14T00:00:00+09:00
draft = true
+++

## summary of lecture 14 and about lecture 15 {#summary-of-lecture-14-and-about-lecture-15}

lecture 14에서 배운것은 다음과 같다. 우리는 주어진 data로부터
machine을 만든다. 즉 linear system이라는 연립방정식의 형태로
만드는데, matrix곱의 형태다. data에 해당하는 matrix와 해에 해당하는
가중치 벡터의 곱의 형태로 나타내진다. 즉, 가중치 벡터의 값을 계산할
수 있다면, machine을 만들게 되는 것이다. 가중치 벡터의 값을 계산하기
위해서 역행렬을 양변에 곱하는 방식을 설명했었는데, 이건 squared
matrix에만 해당하기 때문에, Rectangular matrix에는 적용이 안되는것을
보았다. 설사 주어진 data가 sqaured matrix형태라고 할지라도, ad-bc가
0이되면, 역행렬을 구할수 없어서 해를 구하지 못했다. 그리고 역행렬을
구할 수 없는것을 자세히 살펴보니, 해가 없거나, 해가 무수히 많은
경우가 있는 것을 알았다. 우리의 최종 목표는 해가 unique하다면, 그
해로 machine을 만드는 것이고, 해가 없다면, 주어진 data를 만족 시키는
가장 그럴싸한 가중치 벡터를 정하는 것이다. 그리고 해가 무수히 많은
경우, 어떤 해를 선택하느냐?는 민감도에 따라 선택할 수 있다고
했다. lecture 15에서 예상되는 강의는, 주어진 data로부터 linear
system을 만들때,rectangular matrix의 곱 형태로 주어질때, unique한
해를 구하거나, 해를 못구하는 경우, 해가 무수히 많은 경우를 판단하는
방법을 배울거 같다. lecture 14에서는 squared matrix의 unique한 해를
구하는 방법과, 판별식에 따라 해가 무수히 많은 경우와 해가 없는
경우를 예를 들어서 살펴봤기 때문이다. 이번장에선 좀 더 일반적인
형태일 수도 있는 rectangular matrix 곱의 처리에 대해서 배울거 같다.


## Linear Combinations {#linear-combinations}


### 개요 {#개요}

갑툭튀로 linear combination이 나온다. linear combination이 나온것은
Rectangular matrix 곱을 처리하기 위한 한 방편이기
때문이다. matrix곱으로된 linear system이 주어졌을때, 해가
있는지,없는지조차 알수 없고, 있다면 어떻게 구해야하는지도 못하는
상황이다. 그래서 linear combination을 사용하는 것 같다.

우선, 기본 개념에 대해 말해보자. vector들의 기본연산은 vector들의
덧셈과 scalar와 vector의 곱이다. 이것을 조합해서 \\(cv + dw\\) 형태로
나타낸것을 linear combination이라고 한다.

vector의 addition은

<div class="attention">

\\(v + w\\)

</div>

vector의 linear combinations은

<div class="attention">

\\(cv + dw\\)

</div>

vector의 addition은 vector의 linear combination중 c와 d가 1인
경우를 뜻한다.


## Linear System의 변경. {#linear-system의-변경-dot}

data가 주어졌을 때, Linear machine을 만드는데 필요한 coefficients를
구하기 위해서 Linear system을 만들었다. Linear System은 matrix로
만들었었다.

| Person_ID | Weight | Height | Is_smoking | life-span |
|-----------|--------|--------|------------|-----------|
| 1         | 60kg   | 5.5ft  | yes(=1)    | 66        |
| 2         | 65kg   | 5.0ft  | No(=0)     | 74        |
| 3         | 55kg   | 6.0ft  | Yes(=1)    | 78        |

\\(\begin{bmatrix} 60 \ 5.5 \ 1 \\\ 65 \ 5.0 \ 0 \\\ 55 \ 6.0 \ 1\end{bmatrix}\\) \\(\begin{bmatrix} x\_{1} \\\ x\_{2} \\\ x\_{3}  \end{bmatrix}\\) = \\(\begin{bmatrix} 66 \\\ 74 \\\ 78 \end{bmatrix}\\)   Ax = b의 형태다.

이전 장에서 matrix곱 형태로 된, 위와 같은 방정식의 해를 구하는
방식은 역행렬은 한계가 있어서 안된다고 했다. 또한 해가 있는지
없는지도 기존의 역행렬 방식엔 한계가 있다고 했다. 이 상황에서
matrix곱형태의 방정식을 강사는 linear combination형태로 바꿀 수
있다고 말한다. 해가 있는지 없는지도 모르고 있다고 해도 어떻게
구해야 하는지 모르는 상태에서 linear combination으로 표현하는 게
rectangular matrix곱을 처리하는데 어떤 도움이 되는것일까?

\\(\begin{bmatrix} 60 \\\ 65 \\\ 55 \end{bmatrix}\\) \\(x\_{1}\\) + \\(\begin{bmatrix} 5.5 \\\ 5.0 \\\ 6.0 \end{bmatrix}\\) \\(x\_{2}\\) + \\(\begin{bmatrix} 1 \\\ 0 \\\ 1 \end{bmatrix}\\) \\(x\_{3}\\) = \\(\begin{bmatrix} 66 \\\ 74 \\\ 78 \end{bmatrix}\\)

여튼, linear combination으로 바꿨다. 이전의 matrix와 vector의
곱보다 더 직관적으로 방정식처럼 보이긴 한다.

\\(\begin{bmatrix} 60 \\\ 65 \\\ 55 \end{bmatrix}\\) \\(x\_{1}\\) + \\(\begin{bmatrix} 5.5 \\\ 5.0 \\\ 6.0 \end{bmatrix}\\) \\(x\_{2}\\) + \\(\begin{bmatrix} 1 \\\ 0 \\\ 1 \end{bmatrix}\\) \\(x\_{3}\\) = \\(\begin{bmatrix} 66 \\\ 74 \\\ 78 \end{bmatrix}\\)  =&gt; \\(a\_{1}x\_{1} + a\_{2}x\_{2} + a\_{3}x\_{3} = c\\) 의 형태다.

linear combination을 풀어쓰면 아래와 같이 볼 수 있는데, 이것은
matrix곱을 풀어쓴 형태와 같다. 즉 matrix의 곱을 linear
combination으로 나타내도 동일한 식이라는 뜻이다.

\\(60x\_{1} + 5.5x\_{2} + 1x\_{3} = 66\\)
\\(65x\_{1} + 5.0x\_{2} + 0x\_{3} = 74\\)    =&gt; matrix곱을 풀어쓰면 동일하다.
\\(55x\_{1} + 6.0x\_{2} + 1x\_{3} = 78\\)

여기서 linear combination으로 표현하나 matrix곱으로 표현하나
동일한 식인건 알았다. 그러면, linear combination으로 표현을 하면
해가 있는지 없는지 여부, 혹은 해가 있다면 구할 수 있다는 것인가?


## span {#span}

강사는 span이란 개념을 이어서 설명한다. span과 linear combination과
어떤 연관이 있는지 모르겠지만, span이란 개념을 알아야 한다고
한다. span은 vector들을 원소로 하는 무한 집합이라고 한다. 그러면,
span이란 집합은 어떻게 만들어지고, 도데체 span이 무엇인가? 어떤
집합인가? 라는 질문을 할 수 있다. span은 어떤 vector들이 주어질때,
그 vector에 모든 선형결합을 적용해서 만들어지는 집합이다. 예를
들어보자.

eg., 어떤 vector가 있다.

\\(\begin{bmatrix} 1 \\\ 2 \\\ 3 \end{bmatrix}\\)

이 vector의 linear combinations는 실수를 곱해서 나오는 모든
vector들의 집합이다. 그리고 그 무한 집합을 이 vector의 span이다라고
말한다. 즉 vector가 원점에서 해당점으로의 선분이라고 하면, 이 벡터의
linear combinations는 직선을 나타내는데, 그것이 span이다. 즉 linear
combinations의 집합이 span이다.

eg., 두개의 vector가 있다고 하자.

\\(\begin{bmatrix} 1 \\\ 2 \\\ 3
   \end{bmatrix}\\) \\(\begin{bmatrix} 4 \\\ 5 \\\ 6 \end{bmatrix}\\)

이 두 vector에 취할 수 있는 모든 계수를 곱해서 linear
combinations형태로 만든다. 아래와 같이 만들면 무한집합이 만들어
진다.

\\(c\_{1}\\) x \\(\begin{bmatrix} 1 \\\ 2 \\\ 3 \end{bmatrix}\\) + \\(c\_{2}\\) x \\(\begin{bmatrix} 4 \\\ 5 \\\ 6 \end{bmatrix}\\)

즉, 위 두개 vector의 span은 d\\(c\_{1}\\) 과 \\(c\_{2}\\) 에 모든 실수를
넣었을때 얻을수 있는 모든 vector들의 집합이다.

구체적으로 예를 들면, \\(c\_{1}\\) 과 \\(c\_{2}\\) 의 값이 (0,0)이라고 할때,

\\(\begin{bmatrix} 0 \\\ 0 \\\ 0 \end{bmatrix}\\)

\\(c\_{1}\\) 과 \\(c\_{2}\\) 의 값이 (1,1)이면

\\(1\\) x \\(\begin{bmatrix} 1 \\\ 2 \\\ 3 \end{bmatrix}\\) + \\(2\\) x \\(\begin{bmatrix} 4 \\\ 5 \\\ 6 \end{bmatrix}\\) =  \\(\begin{bmatrix} 5 \\\ 7 \\\ 9 \end{bmatrix}\\)

이렇게 계속 vector들이 만들어지고, 만들어지는 vetor들의 집합을
span이라고 한다.

span of { \\(\left{ \begin{bmatrix} 1 \\\ 2 \\\ 3 \end{bmatrix} , \begin{bmatrix} 4 \\\ 5 \\\ 6 \end{bmatrix} \right }\\) }로 표시된다.

지금 까지 진행상황을 보면, matrix곱으로 된 방정식에선, 해가있는지,
없는지도 모른다. 즉 계산조차 안되는 상황이다. 이런 상황에서 강사는
matrix의 곱을 linear combination으로 표현하고 span을 갑자기
배웠다. span을 배우는 이유는 기하학적인 의미와 linear
combination과의 관계가 있기 때문이다. matrix곱을 linear
combination으로 표현하는데, linear combination은 span을 나타내기
때문이란다. 방정식은 Ax = b꼴로 나타내는데, A라는 matrix를 linear
combination으로 표현할 수 있고, linear combination을 기하학적으로
해석하기 위해서 span이란 개념이 도입된다는 것이다.


## span의 기하학적 의미 {#span의-기하학적-의미}

span이라는게 주어진 vector나 vector들을 linear combination을 해서
나오는 vector들의 집합이라고 했다. 이 span이라는 것을 기하학적으로
생각해 보자. 주어진 vector가 하나라고 하자. 좌표공간에서 vector
한개는, 원점을 기준으로 하는 하나의 선분으로 볼수도 있고, 하나의
점으로 볼 수도 있다. 이 벡터의 linear combinations라는 것은 실수를
곱해서 나오는 결과들이다. 이것들의 집합이 span이 된다. 한개 vector의
span이란 기하학적으로는 원점과 주어진 벡터의 점을 통과하는 직선으로
볼 수도 있고, 주어진 벡터라는 선분을 통과하는 직선으로 볼 수
있다. 한개 벡터의 linear combinations들은 주어진 벡터 선분의 길이를
늘리거나 줄일뿐이다.

따라서, 만일 어떤 방정식이 주어졌다고 생각하자. matrix곱의
형태다. 이것을 linear combination으로 풀어쓸 수 있었다. 좌변은
linear combination의 형태고, 우변은 vector다. 이런 형태를 어떻게
해석할 것인가? 우변의 vector가 좌변의 linear combination으로
표현된다는 것은 좌변의 column vector들의 span의 원소라고 말할 수
있다. 이것이 의미하는 바는 이방정식에서 해는 존재한다가 된다. 만일
linear combination형태로 만들수 없다면 해는 없다라고 말해도 된다.

구체적인 예를 들어보자. 우리가 어떤 data로 부터 matrix곱 형태의
방정식을 얻었다고 하자.

<div class="important">

\\(\begin{bmatrix} 1 & 4 \\\ 2 & 5 \\\ 3 & 6  \end{bmatrix}\\) \\(\begin{bmatrix} x\_{1} \\\ x\_{2} \end{bmatrix}\\) =  \\(\begin{bmatrix} 5 \\\ 7 \\\ 9 \end{bmatrix}\\)

</div>

이것의 좌변을 linear combination형태로 바꾸자.

<div class="important">

\\(\begin{bmatrix} 1 \\\ 2 \\\ 3 \end{bmatrix}\\) x \\(x\_{1}\\) + \\(\begin{bmatrix} 4 \\\ 5 \\\ 6 \end{bmatrix}\\) x \\(x\_{2}\\) = \\(\begin{bmatrix} 5 \\\ 7 \\\ 9 \end{bmatrix}\\)

</div>

여기서 기하학적으로 보면 \\(\begin{bmatrix} 1 \\\ 2 \\\ 3 \end{bmatrix}\\)
와 \\(\begin{bmatrix} 4 \\\ 5 \\\ 6 \end{bmatrix}\\) 로 이루어지는
span안에 \\(\begin{bmatrix} 5 \\\ 7 \\\ 9 \end{bmatrix}\\) 가 포함되는지
여부는 \\(x\_{1}\\) 과 \\(x\_{2}\\) 로 구할 수 있다.  \\(x\_{1}\\) 과 \\(x\_{2}\\) 이
1이되면 식도 만족하고 span안에 포함된다고도 말할수 있다.


## Matrix곱을 linear combination으로 변경(column) {#matrix곱을-linear-combination으로-변경--column}


### linear combination의 장점 {#linear-combination의-장점}

다시 한번 review하면, 우리는 data를 가지고 linear system을
만들었다. 그런데 linear system을 matrix 형태로 계산을 해서 해를
구했다. matrix를 계산한다는 것은 inverse matrix와 내적을
사용했다. Identity matrix의 개념도 들어가게 된다. 그런데 이
방식으로는 rectangular matrix곱에는 적용되지 않는다. 해가 있는지
없는지도 계산할수 없다. 그래서 다른 대안으로 linear system을
matrix가 아닌, linear combination으로 나타냈고, 여기서 해를 계산할
수도 있지만, 계산이 아닌 기학학적인 의미를 따져서 해가 있는지
없는지 여부를 기하학적으로 따질 수 있게 되었다.

linear combination으로 표현하는것의 또다른 장점은 계산량에서 잇점이
있다고 한다. 예를 들어보자. 우리가 data로부터 matrix 형태의 linear
system을 만들었다고 가정하자.

eg., \\(\begin{bmatrix} 1 \ 2 \\\ 3 \ 6 \end{bmatrix}\\) \\(\begin{bmatrix} x \\\ y \end{bmatrix}\\) = \\(\begin{bmatrix} 4  \\\ 12  \end{bmatrix}\\)

이 matrix multiplication은 matrix의 row vector와 column vector의
내적으로 계산될 수 있다.

\\(1 x + 2y =4\\)
\\(3x +6y = 12\\)

계산은 (2번의 곱셈 + 1번의 덧셈) x 2배가 사용된다. 즉 6번의
계산량이 있다.그런데 linear combination으로 나타낸다면 계산량은
어떻게 될까?

\\(\begin{bmatrix} 1 \\\ 3  \end{bmatrix}\\) x + \\(\begin{bmatrix} 2 \\\ 6  \end{bmatrix}\\) y = \\(\begin{bmatrix} 4  \\\ 12  \end{bmatrix}\\) =&gt; \\(ax + by =c\\)

위와 같이 linear combination으로 계산하면, 계산량은 절반이
된다. vector를 통째로 1개로 본다. 그러면 2번의 곱과 1번의 덧셈만
하면 된다. 이것은 좀 어패가 있긴하다. 그러면 matrix의 계산은
Matrix를 한개를 통으로 본다면, 1번의 계산일 뿐이기 때문이다.


### matrix의 곱을 linear combination으로 변환 {#matrix의-곱을-linear-combination으로-변환}


#### matrix와 vector곱 형태 {#matrix와-vector곱-형태}

여튼 강사가 말하고자 하는것은 matrix로 표현된것을 linear
combination으로 변환된 형태로 사용하고 싶은 것이다. 그러면 matrix
multiplication들이 linear combination으로 변환되는 과정을 예를 들어
보자.

eg.,  \\(\begin{bmatrix} 1 \ 1 \ 0 \\\ 1 \ 0 \ 1 \\\ 1 \  \llap{-} 1 \ 1  \end{bmatrix}\\) \\(\begin{bmatrix} 1  \\\ 2  \\\ 3  \end{bmatrix}\\) =&gt; \\(\begin{bmatrix} 1 \\\ 1 \\\ 1 \end{bmatrix}\\) 1 + \\(\begin{bmatrix} 1 \\\ 0 \\\ 1 \end{bmatrix}\\) 2 + \\(\begin{bmatrix} 0 \\\ 1 \\\ 1 \end{bmatrix}\\) 3

위의 모양은 linear combination을 나타내는 전형적인 모양이라고
한다. 즉 matrix와 column의 곱으로 나타내지면, matrix는 column으로
분해되고, column은 가중치이기 때문에, 분해된 matrix column과
가중치로 linear combination을 만들어낸다.


#### matrix와 matrix의 곱형태를 linear combination으로 변환 {#matrix와-matrix의-곱형태를-linear-combination으로-변환}

<!--list-separator-->

-  예시1

    eg., \\(\begin{bmatrix} 1 \ 1 \ 0 \\\ 1 \ 0 \ 1 \\\ 1 \ \llap{-}1 \ 1  \end{bmatrix}\\) \\(\begin{bmatrix} 1 \ \llap{-}1 \\\ 2 \ 0 \\\ 3 \ 1  \end{bmatrix}\\) =&gt; 3x3x3x2 =&gt; 3x2형태다. \\(\begin{bmatrix} a\_{1} \ b\_{1} \\\ a\_{2} \ b\_{2} \\\ a\_{3} \ b\_{3}  \end{bmatrix}\\)

    이것을 \\(\begin{bmatrix} a \ b \end{bmatrix}\\) 꼴이라고 생각하자. a,b is vector.

    linear combination의 결과는 column vector다. matrix의 곱 결과
    matrix가 나왔지만, 나온 matrix를 보면, 2개의 column vector로
    이루어져 있다고 보고, 각 column vector인 \\(a\\) 와 \\(b\\) 를 linear
    combination으로 나타낼 수 있다면 좌변의 matrix의 곱을 linear
    combination형태로 변환이 가능하다는 얘기가 된다.

    이전의 matrix와 vector의 곱을 linear combination으로 나타낸것을
    기억해 보자. 좌변 matrix의 각각의 column vector에 vector를 계수로
    해서 linear combination을 나타냈었다.

    eg.,  \\(\begin{bmatrix} 1 \ 1 \ 0 \\\ 1 \ 0 \ 1 \\\ 1 \  \llap{-} 1 \ 1  \end{bmatrix}\\) \\(\begin{bmatrix} 1  \\\ 2  \\\ 3  \end{bmatrix}\\) =&gt; \\(\begin{bmatrix} 1 \\\ 1 \\\ 1 \end{bmatrix}\\) 1 + \\(\begin{bmatrix} 1 \\\ 0 \\\ 1 \end{bmatrix}\\) 2 + \\(\begin{bmatrix} 0 \\\ 1 \\\ 1 \end{bmatrix}\\) 3

    그러면, 비슷하게, 좌측의 matrix로부터 column vector로 분해하고,
    우측의 matrix는 가중치로 생각하면 된다. 위에서는 가중치가 한개의
    vector였다면, 아래에서는 가중치가 2개의 vector라고 보면된다. 그
    결과가 [a b]형태가 되는 것이다.

    \\(\begin{bmatrix} 1 \ 1 \ 0 \\\ 1 \ 0 \ 1 \\\ 1 \ \llap{-}1 \ 1  \end{bmatrix}\\) \\(\begin{bmatrix} 1 \ \llap{-}1 \\\ 2 \ 0 \\\ 3 \ 1  \end{bmatrix}\\)  , 이것이 아래와 같이 변한다.

    \\(a = \begin{bmatrix} 1 \\\ 1  \\\ 1 \end{bmatrix}\\) 1 +\\(\begin{bmatrix} 1 \\\ 0 \\\ -1 \end{bmatrix}\\) 2 + \\(\begin{bmatrix} 0 \\\ 1 \\\ 1 \end{bmatrix}\\) 3

    \\(b = \begin{bmatrix} 1 \\\ 1  \\\ 1 \end{bmatrix}\\) -1 +\\(\begin{bmatrix} 1 \\\ 0 \\\ -1 \end{bmatrix}\\) 0 + \\(\begin{bmatrix} 0 \\\ 1 \\\ 1 \end{bmatrix}\\) 1

<!--list-separator-->

-  예시2

    eg., 3X3행렬과 3X3행렬의 곱을 linear combination으로 똑같이 나타낼
         수 있다. 결과는 아래와 같은 형태이기 때문에,

    \\(\begin{bmatrix} a \ b \ c
            \end{bmatrix}\\)

    계산과정은 같다. 좌측은 column vector로 분해되고, 우측은 가중치를
    나탄내다고 볼 수 있다.

    즉, 결론적으로 말하면, matrix multiplication은 linear
    combination으로 나타낼 수 있다는 것이다.


## matrix의 곱을 linear combination으로 표현하기2 (row) {#matrix의-곱을-linear-combination으로-표현하기2--row}


### 개요 {#개요}

matrix의 곱으로 표현된 식을 linear combination으로 나타낼 수 있다고
했다. 그런데 linear combination에서 vector는 column vector를 말하는
거지, row vector를 말하는 게 아니다. row vector로 linear
combination을 만들수 있을까?

row vector와 column vector간에는 관계가 있다. 무턱대고 matrix와
matrix의 곱을 row vector의 계산식으로 표현할려고 시도 할 수 있는데,
강사는 row vector와 column vector의 transpose한 관계가 있고 그
관계를 이용하는게 쉽게 matrix의 곱을 row vector linear
combination로 나타낼 수 있다고 한다. 사담이지만 강사는 처음에
vector라는 단어가 column vector를 의미한다고 했다. row vector라는
단어는 애초부터 없다고 했다. 그런데, column vector에 transpose한
연산을 적용 시켜서 나온 결과도 모양이 다른 vector이기에 row
vector라고 불렀다고 했다.


### column vector의 transpose {#column-vector의-transpose}

그런 transpose라는 연산에 대해서 살펴보자. row vector linear
combination은 transpose를 이용한다고 하니 transpose를 알 필요가
있다. column vector의 transpose는 row vector다. item의 column이
row가 되고 row가 column이 되기 때문이다. 즉, item의 row와 column이
바뀌는 게 transpose다.

<div class="important">

\\(item\_{i,j}\\) =&gt; \\(item\_{j,i}\\)

</div>

```text
1(1,1) => 1(1,1)
2(2,1) => 2(1,2)
3(3,1) => 3(1,3)
```

\\(\begin{bmatrix} 1 \\\ 2  \\\ 3 \end{bmatrix}\\) =&gt; \\(\begin{bmatrix} 1 \ 2 \ 3 \end{bmatrix}\\)


### matrix의 곱의 transpose {#matrix의-곱의-transpose}

matrix 곱에 대한 transpose연산 법칙이 아래와 같이 존재한다.

\\((AB)^{T} = B^{T}A^{T}\\)


### row vector combination {#row-vector-combination}

transpose를 사용하는게 matrix곱의 row linear combination을 쉽게
만드는 방법이라고 했는데, 위의 transpose의 교환법칙을
이용한다.

<div class="important">

\\((AB)^{T} = B^{T}A^{T}\\)

</div>

윗식에서 A와 B의 matrix곱에 대한 transpose할것이다. 그리고 다시
transpose한다면 원래 식과 동일한 계산이된다. 즉 transpose를
두번해서 원식으로 돌아올 수 있기에 다른 식은 아니다. 그런데 왜
transpose를 하는가? transpose를 하면 row vector linear
combination형태가 나오기 때문이다. 다음 예를 보자.

\\(A =\\) \\(\begin{bmatrix} 1 \ 1 \ 0 \\\ 1 \ 0 \ 1 \\\ 1 \ \llap{-}1 \ 1  \end{bmatrix}\\) , \\(B =\\) \\(\begin{bmatrix} 1  \\\ 2  \\\ 3  \end{bmatrix}\\)

A와 B의 곱을 transpose 해보자.

\\(\left(AB \right)^{T}\\) =  \\(\left( \begin{bmatrix} 1 \ 1 \ 0 \\\ 1 \ 0 \ 1 \\\ 1 \ \llap{-}1 \ 1 \end{bmatrix} \begin{bmatrix} 1  \\\ 2  \\\ 3 \end{bmatrix} \right)^{T}\\) =&gt; transpose하면 교환 법칙에 의해서  \\(\begin{bmatrix} 1 \ 2 \ 3 \end{bmatrix}\\) \\(\begin{bmatrix} 1 \ 1 \ 1 \\\ 1 \ 0 \ \llap{-}1 \\\ 0 \ 1 \ 1  \end{bmatrix}\\)

이 나오게 되는데, 이런 형태의 matrix곱이 row vector linear
combination을 만들수 있게 해준다. column vector로 linear
combination을 만들때는 왼쪽의 matrix에서 column vector를 분해하고,
우측의 matrix는 가중치 matrix였다. 여기서는 반대다. 왼쪽의
matrix가 가중치를 나타내고, 오른쪽 matrix에서 row vector를
분해한다. 이렇게 분해된 row vector와 가중치를 linear
combination으로 나타낼 수 있다. 아래가 바로 row vector linear
combination이다.

1 x \\(\begin{bmatrix} 1 \ 1  \ 1  \end{bmatrix}\\) + 2 x \\(\begin{bmatrix} 1 \ 0 \ \llap{-}1 \end{bmatrix}\\) + 3 \\(\begin{bmatrix} 0 \ 1 \ 1 \end{bmatrix}\\)

이것은 원래의 matrix곱의 계산결과하고는 다르다. 같게 하기 위해선,
transpose를 해야 한다. 원래의 matrix 곱에 transpose를 한건 단
하나의 이유, row vector linear combination을 만들기
위해서였다. 이렇게 만든 후 다시 transpose하면 column vector가
나오는게 그게 matrix곱의 결과다.

우리가 지금 한것은 matrix와 column vector의 곱은 row vector
combintation으로도 계산할 수 있고, column vector combination으로
계산할 수 있다는 것이다.


## 일반적 형태의 matrix곱을 row vector linear combination으로 나타내기. {#일반적-형태의-matrix곱을-row-vector-linear-combination으로-나타내기-dot}

아래와 같은 matrix 곱이 있다고 하자.

\\(\begin{bmatrix} 1 \ 2 \ 3 \\\ 4 \ 5 \ 6 \end{bmatrix}\\) \\(\begin{bmatrix} 1 \ 1 \ 0 \\\ 1 \ 0 \ 1 \\\ 1 \ \llap{-}1 \ 1 \end{bmatrix}\\)  = \\(\begin{bmatrix} 6 \ \llap{-}2 \ 5 \\\ 15 \ \llap{-}2 \ 11 \end{bmatrix}\\)

이것을 row vector linear combination으로 나타내기 위해선, 우선
matrix의 곱에 transpose를 한다.

\\(\begin{bmatrix} 1 \ 1 \ 1 \\\ 1 \ 0 \ \llap{-} 1 \\\ 0 \ 1 \ 1  \end{bmatrix}\\)  \\(\begin{bmatrix} 1 \ 4 \\\ 2 \ 5 \\\ 3 \ 6 \end{bmatrix}\\) =&gt; 3x3 3x2 =&gt; 3x2, \\(\begin{bmatrix} a\_{1} \ a\_{2} \\\ b\_{1} \ b\_{2} \\\ c\_{1} \ c\_{2}  \end{bmatrix}\\) =&gt; \\(\begin{bmatrix} a \\\ b \\\ c \end{bmatrix}\\) a,b,c 3개의 row vector.

row vector로 linear combination을 만들기 위해서 좌측의 matrix는
가중치가 되고, 우측 matrix는 row vector로 분해가 된다고
했다. 가중치와 row vector로 표현된 linear combination이 각각 결과의
a,b,c row vector가 된다. 즉 row vector combination에선 가중치
matrix도 row vector들이 분해된 row vector 각각에 적용된다. column
vector에선 column vector가중치들이 column vector각각에 적용된것과
같다. 아래와 같이 a,b,c를 구한 후 transpose하면 원식과 같게 된다.

\\(a =\\) 1 \\(\begin{bmatrix} 1 \ 4 \end{bmatrix}\\) + 1 \\(\begin{bmatrix} 2 \ 5 \end{bmatrix}\\) + 1 \\(\begin{bmatrix} 3 \ 6 \end{bmatrix}\\)

\\(b =\\) 1 \\(\begin{bmatrix} 1 \ 4 \end{bmatrix}\\) + 0 \\(\begin{bmatrix} 2 \ 5 \end{bmatrix}\\) + -1 \\(\begin{bmatrix} 3 \ 6 \end{bmatrix}\\)

\\(c =\\) 0 \\(\begin{bmatrix} 1 \ 4 \end{bmatrix}\\) + 1 \\(\begin{bmatrix} 2 \ 5 \end{bmatrix}\\) + 1 \\(\begin{bmatrix} 3 \ 6 \end{bmatrix}\\)


## matrix곱과 linear combination {#matrix곱과-linear-combination}

matrix와 matrix의 곱은 linear combination으로 나타낼 수 있다. row
combination으로 할 수도 있고, column combination으로 나타낼 수도
있었다. row combination은 계산 방식도 column combination과 반대고,
마지막에 transpose를 해주는것도 잊으면 안된다.


## outer product {#outer-product}

inner product와 outer product라는 용어에 대해 알아 볼 필요가 있다.

-   inner product: 두개의 vector를 곱했을때, 결과가 scala이면 inner
    product라고 부른다.

    \\(\begin{bmatrix} 1 \ 2 \ 3 \end{bmatrix}\\) \\(\begin{bmatrix} 1 \\\ 1  \\\ 1 \end{bmatrix}\\) =&gt; \\(\begin{bmatrix} 6 \end{bmatrix}\\)

-   outer product: 두개의 vector를 곱했을 때, matrix형태를 가지면서
    차원이 커질 때, outer product라고 부른다.

    \\(\begin{bmatrix} 1 \\\ 1  \\\ 1 \end{bmatrix}\\) \\(\begin{bmatrix} 1 \ 2 \ 3 \end{bmatrix}\\) =&gt; \\(\begin{bmatrix} 1 \ 2 \ 3 \\\ 1 \ 2 \ 3 \\\ 1 \ 2 \ 3  \end{bmatrix}\\)

내적과 외적은 vector에서 사용하는 용어다. matrix에는 내적이나
외적이란 용어가 없다. 여기서, vector의 연산인 outer product를
소개하는 이유는, 행렬의 곱셈에 outer product가 사용될 수
있기때문이다. 다음과 같이 matrix곱이 있다고 하자.

\\(\begin{bmatrix} 1 \ 1 \\\ 1 \ \llap{-}1 \\\ 1 \ 1 \end{bmatrix}\\) \\(\begin{bmatrix} 1 \ 2 \ 3 \\\ 4 \ 5 \ 6 \end{bmatrix}\\)

matrix와 matrix의 곱을 계산하는 방식은 위에서 배웠듯이 matrix의
column vector와 row vector의 내적을 계산해서 구할 수 있다. 그 다음은
linear combination으로 변환한 후 계산해도 된다. 그런데, 때에
따라서는 outer product형태로 변환해서 계산하면 간단히 계산할 수
있다고 한다. 아래는 outer product형태로 변환해서 계산하는거라고
하는데, 엄청 간단한것을 볼 수 있다.

\\(\begin{bmatrix} 1 \ 1 \\\ 1 \ \llap{-}1 \\\ 1 \ 1 \end{bmatrix}\\) \\(\begin{bmatrix} 1 \ 2 \ 3 \\\ 4 \ 5 \ 6 \end{bmatrix}\\) =&gt;  \\(\begin{bmatrix} 1 \\\ 1  \\\ 1 \end{bmatrix}\\) \\(\begin{bmatrix} 1 \ 2 \ 3 \end{bmatrix}\\) + \\(\begin{bmatrix} 1 \\\ \llap{-}1 \\\ 1 \end{bmatrix}\\) \\(\begin{bmatrix} 4 \ 5 \ 6 \end{bmatrix}\\)

행렬의 곱을 column linear combination으로 표현할때는 column
vector들과 column 가중치를 곱해서 column형태로 나타냈고, row linear
combination의 경우는, row 가중치를 row vector에 곱해서 row vector를
만들어 냈다. 그런데 outer product는 column vector와 row vector의
곱으로 나타낸다. 매우 간단하게 계산되는것 같다.


## rank-1 {#rank-1}


### rank1과 기저 벡터 {#rank1과-기저-벡터}

rank-1이란 말은 기저벡터가 1개라는 뜻이다. 아래는 matrix
곱이다. 따라서, outer product의 합으로 계산할 수도 있고, linear
combination으로 계산할 수도 있다. 그런데 계산을 하는게 아니라,
기하학적으로 어떤 의미가 있을까? 그리고 전형적 outer product의
모양이기도 하다.

\\(\begin{bmatrix} 1 \\\ 1  \\\ 1 \end{bmatrix}\\) \\(\begin{bmatrix} 1 \ 2 \ 3 \end{bmatrix}\\) =&gt; \\(\begin{bmatrix} 1 \ 2 \ 3 \\\ 1 \ 2 \ 3 \\\ 1 \ 2 \ 3  \end{bmatrix}\\)

위의 계산을 column vector기준으로 말할 수도 있고, row vector기준으로
말할 수 있다. column vector기준으로 말한다면, column vector에 1을
곱해서 나온 vector와 2를 곱해서 나온 vector, 3을 곱해서 나온
vector의 결과가 결과 matrix에 있다고 볼수있다. 이것을 기하학적으로
다음과 같이 설명할 수 있다.

\\(\begin{bmatrix} 1 \\\ 1 \\\ 1 \end{bmatrix}\\) 은 하나의 선분이다.

여기에 1을 곱하거나, 2, 3을 곱해서 나오는 vector들은 하나같이 해당
vector의 span에 포함된다. ...,-3,-2,-1,0.5,1,2,3... 이런 실수를
곱해서 나오는 vector들은 모두 원래 vector를 늘이거나 줄이거나 할
뿐이다. 따라서 vector 선분을 포함하는 직선인 span에 다 포함되게
되어 있다.

여기서, 좌변의 column과 가중치를 곱해서 나오는게 matrix의
column요소라고 본다면, 좌변의 column을 기저 vector라고
부른다. 또한 결과 matrix는 rank가 1인 matrix라고 부른다.


### 동일한 예제 {#동일한-예제}

\\(\begin{bmatrix} 1 \\\ 1  \\\ 1 \end{bmatrix}\\) \\(\begin{bmatrix} 1 \ 2 \ 3 \ 4 \end{bmatrix}\\)  =&gt; \\(\begin{bmatrix} 1 \ 2 \ 3 \ 4 \\\ 1 \ 2 \ 3 \ 4 \\\ 1 \ 2 \ 3 \ 4  \end{bmatrix}\\) =&gt; 결과 matrix의 각 column vector는

옆과 같이 만들어진다.   \\(\begin{bmatrix} 1 \\\ 1  \\\ 1 \end{bmatrix}\\) 1 , \\(\begin{bmatrix} 1 \\\ 1  \\\ 1 \end{bmatrix}\\) 2 , \\(\begin{bmatrix} 1 \\\ 1  \\\ 1 \end{bmatrix}\\) 3 , \\(\begin{bmatrix} 1 \\\ 1  \\\ 1 \end{bmatrix}\\) 4

이것도 기학학적인 측면에서 살펴보면, 좌변의 column에 가중치를 곱해서
나오는 vector들이 matrix를 구성한다. matrix를 구성하는 column
vector는 좌변 column vector의 span에 포함되기 때문에, 좌변의 column
vector는 기저벡터가 되고 우변의 matrix는 rank1 이라고 말할 수 있다.

그런데 이것은 위에서도 말했지만, column vector기준으로 설명한
것이다. row vector기준으로 설명하면 어떻게 될까?

좌변의 [1 2 3 4] 벡터에 1을 곱한것들이 우변의 matrix의 row vector를
구성한다. 따라서 [1 2 3 4]이란 vector는 기저벡터로 볼 수 있고,
기저벡터의 span에 우변 matrix를 구성하는 row vector들이 모두
포함되기 때문에 rank1 matrix라고 볼 수 있다.

그런데 왜 갑자기 rank-1이란 matrix를 소개했을까? 우리가 지금배우고
있는것과 무슨 연관이 있는 것일까? 우리는 matrix곱을 linear
combination으로 나타낼 수 있고, span을 통해서 해가 있는지 없는지도
알수 있다고 했다. matrix의 곱을 linear combination으로 나타낼때,
matrix의 column 개수만큼, column vector와 가중치의 곱으로
나타냈었다. 그리고 각각의 column vector는 eigen vector에 해당한다고
설명했다. 하지만, 위에서든 outer product예나 rank-1 matrix의 경우는
matrix가 여러개의 eigenvector가 아닌 1개의 eigenvector로도 나타낼 수
있음을 보여준다.


## 실제 데이터의 응용 {#실제-데이터의-응용}

강사는 여기서 예를 든다. 만일 우리에게 어떤 data가 큰 matrix형태로
주어진다고 하자. 500x 2400의 크기를 갖는 matrix다. 그리고 방정식이
아래와 같이 주어진다 하자.

\\(\begin{bmatrix} 1 \ 1 \ \ldots \ 0 \\\ 1 \ 0 \ \ldots \ 1 \\\ \vdots \ \ \vdots \\\ \ 1 \ 1 \ \ldots \ 1  \end{bmatrix}\\) \\(\begin{bmatrix} x\_{1} \ x\_{2} \ \ldots \ x\_{2400} \end{bmatrix}\\) = \\(\begin{bmatrix} y\_{1} \\\ y\_{2} \\\ \vdots \\\ y\_{500} \end{bmatrix}\\)

이것을 linear combination로 표현한다면, 2400의 column과 가중치를
곱하는 식을 만들수 도 있다. 그리고 2400개의 eigenvector가 있다고
말할수 있을것이다.

그런데, 이 matrix가 어떤 2개의 matrix곱으로 표시될 수 있다고
하자. 예를 들면, 500X2로 된 matrix와 2x2400의 임의 matrix로
표시된다고 하자. 두개의 matrix의 곱은 500x2400의 matrix가 된다는 건
확인할 수 있다. 그림으로 표시하면 아래와 같다.

\\(\begin{bmatrix} 1 \ 1 \ \ldots \ 0 \\\ 1 \ 0 \ \ldots \ 1 \\\ \vdots \ \ \vdots \\\ \ 1 \ 1 \ \ldots \ 1  \end{bmatrix}\\) = \\(\begin{bmatrix} 1 & 3 \\\ 2 & 3 \\\ \vdots & \vdots \\\ 3 & 5 \end{bmatrix}\\) \\(\begin{bmatrix} 1 & 2 & \ldots & 3 \\\ 4 & 5 & \ldots & 6 \end{bmatrix}\\)

우변의 2개의 column이 어떤 matrix와 곱해서 좌변이 만들어진다는 것은
우변 2개의 column vector가 기저 벡터고 기저벡터에 가중치에 해당하는
matrix를 곱해서 좌변이 나온다고 볼 수 있다. 위에서도 기저벡터와
rank1 matrix 설명과 동일한 것이다. 좌변의 matrix는 rank2라고 말할
수 있는데, 이것을 factorization이라고 해서, matrix를 인수 분해
한다고 말한다. 그런데 이렇게 big table이 주어졌을 때, matrix곱의
방정식을 무조건 linear combination으로 나타내는게 아니라,
pre-processing처럼, matrix factorization을 하면 해당 방정식을 더
쉽게 분석할수 있다는 의미에서 이것을 배우는거 같다. 이렇게 matrix
factorization을 해서(인수분해해서) 우변과 같이 만들기는 쉽지 않다.

여튼,이게 추천시스템에도 쓰이고, 여러 논문 주제에 쓰인다고 한다.


## style transfer {#style-transfer}

어떤 image가 주어질때, 특정한 style로 고흐, 피카소같은 style로
변경시킬 수가 있는데, 이때, matrix factorization이 사용된다.


## 복습 {#복습}


### 개요 {#개요}

어떤 data가 주어지고, data로 부터 예측하는 machine을 만들어야 한다.

| person ID | Weight | Height | Is_Smoking | Life-span |
|-----------|--------|--------|------------|-----------|
| 1         | 60kg   | 5.5ft  | yes(=1)    | 66        |
| 2         | 65kg   | 5.0ft  | No(=0)     | 74        |
| 3         | 55kg   | 6.0ft  | Yes(=1)    | 78        |

위와 같은 data가 주어지면, 주어진 data로부터 matrix equation을 만들
수 있다.

\\(\begin{bmatrix} 60 \ 5.5 \ 1 \\\ 65 \ 5.0 \ 0 \\\ 55 \ 6.0 \ 1  \end{bmatrix}\\) \\(\begin{bmatrix} x\_{1} \\\ x\_{2}  \\\ x\_{3} \end{bmatrix}\\) = \\(\begin{bmatrix} 66 \\\ 74  \\\ 78 \end{bmatrix}\\)

matrix equation을 inverse matrix와 identity matrix를 사용해서
x벡터의 값을 구할 수 있다면, 우리는 data를 가지고 기계를 만들수 있게
된다. 만든 기계로 새로운 데이터에 적용을 해서 나온 값으로 예측을
하면 된다. 물론 여기에 한계는 있다고 했다. squared matrix에서만
inverse matrix와 identity matrix로 해를 구할 수 있고, rectangular
matrix에서는 이 방법으로는 해를 구할수 없다는거...또한 squared
matrix라고 할지라도 해를 구할수 없는 경우가 있다는거... 최종적으로
해가 있는지도 없는지도 계산으로 알기가 쉽지 않다. 그래서 이 방식은
안쓰인다고 봐도 되는 거 같다.

따라서 강사는 윗 방법에는 관심이 없고, matrix의 곱을 linear
combination으로 나타낼려고 한다. 그리고 나타낸 linear
combination에서 다른 개념들을 적용시킬려고 한다.

\\(\begin{bmatrix} 60 \\\ 65  \\\ 55 \end{bmatrix}\\) \\(x\_{1}\\) + \\(\begin{bmatrix} 5.5 \\\ 5.0  \\\ 6.0 \end{bmatrix}\\) \\(x\_{2}\\) + \\(\begin{bmatrix} 1 \\\ 0 \\\ 1 \end{bmatrix}\\) \\(x\_{3}\\) =  \\(\begin{bmatrix} 66 \\\ 74  \\\ 78 \end{bmatrix}\\)

linear combination으로 나타내면 해가 있는지 없는지를 기하학적인
해석이 가능하다. linear combination으로 나타낸 3개의 column vector로
만들어지는 span에 결과 vector가 포함되면 해가 있는 것이고, 포함되지
않으면 해가 없다고 해석하는 것이다.

즉, \\(\begin{bmatrix} 66 \\\ 74  \\\ 78 \end{bmatrix}\\) 이 span = \\(\begin{Bmatrix} \begin{bmatrix} 60 \\\ 65  \\\ 55 \end{bmatrix},  \begin{bmatrix} 5.5 \\\ 5.0  \\\ 6.0 \end{bmatrix} , \begin{bmatrix} 1 \\\ 0 \\\ 1 \end{bmatrix} \end{Bmatrix}\\) 에 포함 여부가 해의 존재를 알려준다.

만일 결과 vector가 span에 포함된다면, 거기서 해가 unique할 수도, 아니면
무수히 많을수도 있다. 만일 해가 unique하다면, 3개의 vector는 linear
independent하다. 해가 무수히 많다면, 3개의 vector는 linear
dependent하다.


### 선형 독립(linear independence) {#선형-독립--linear-independence}

선형 독립과 선형 의존은 vector들간의 관계를 나타낸다. 어떤 vector
2개가 주어졌다고 가정하자. 여기서 span을 알아야 한다. 한 개의
vector는 선분이고, 그 vector의 span은 직선이라고 했다. 두개
vector의 span도 말할수 있다. 두개의 vector를 linear
combinations들로 만들어지는 수많은 점들은 하나의 평면을 만들수
있는데, 그 평면이 두 vector의 span이 된다. span의 개념이 linear
dependent와 linear independent의 속성을 나타내는데에 쓰인다.

\\(\begin{bmatrix} 1 \\\ 0 \\\ 2 \end{bmatrix}\\) , \\(\begin{bmatrix} 1 \\\ 2  \\\ 3 \end{bmatrix}\\)

앞의 vector로 만들어지는 span에 뒤에 vector가 포함된다면, linear
dependent하다. 반면에 앞 vector의 span에 뒤의 vector가 포함되지
않는다면, linear independent하다고 한다. 3개의 vector가
있는경우에도 똑같이 해석할 수 있다. 하나의 vector에 2개의 vector가
포함된다면 linear dependent하다. 두개의 vector의 linear
combinations안에 마지막 vector가 포함되도 linear
dependent한것이다. 여튼, 그런데 이것을 계산할 수 있을까?  첫번째
vector의 span을 모두 나열하고, 두번째 vector가 그 span에 포함하는지
안 하는지 계산할 수 있는가? 가우스 소거법으로 가능하다고 하는데,
강의에선 설명하지 않는다.

그런데 이 모양을 보면, 지금껏 우리가 배워왔던 개념과 어떤 공통된
부분이 있다. 우리는 data를 사용해서, matrix곱으로 된 방정식을
만들었다. 그리고 matrix곱을 linear combination으로 만들었다. 좌변의
linear combination은 eigenvector와 가중치들의 곱의 합으로 되어
있었다. 그런데 좌변의 eigenvector들의 관계를 설명하기 위해서,
선형독립과 선형의존을 얘기하는 것같다. 이전에 matrix
factorization에서도 큰 matrix를 linear combination으로 나타내면
엄청나게 많은 column곱으로 나타낼수 있지만 작은 matrix곱으로
표현되는 경우도 보았다. outer product에서도 matrix는 여러개의
column과 가중치가 아닌, 한개의 column vector와 row vector의 곱으로
나타낼 수 있었다. 즉 eigen vector가 적으면 적을수록 해가 있는지
없는지 판단하고, 해를 구하는데 있어서도 계산이 적어질
것이다. 여기서 선형독립과 선형의존은 linear combination으로
나타내지는 좌변의 eigenvector의 수를 줄이기 위한 처리과정으로
보인다. 즉 eigenvector가 2개 있을때, 2개 vector가 선형독립인지,
선형의존인지를 알게 된다면, eigenvector의 수는 줄어들 것이다.

강사는 practical한 정의를 다음과 같이 내린다.

-   Given a set of vectors \\(v\_{1}, \ldots , v\_{p} \in R^{n}\\), check
    if \\(v\_{j}\\) can be represented as a linear combination of the
    previous vectors \\(\\{ v\_{1},v\_{2},\ldots, v\_{j-1} \\}\\) for j=1,...p

-   위의 의미는 vector가 p개 주어질때, 선형 독립과, 선형 의존을
    확인하기 위해선, 첫번째 vector에 대한 span에 두번째 vector가
    포함되는지 여부를 확인한다. 포함이 되지 않는다면, 세번째 vector가
    첫번째,두번째 vector의 span에 포함되는지 여부를 확인하는 작업을
    p개까지 한다. p개까지 했을때, 모두 이전 span에 포함되지 않는
    vector들이라면 각각은 선형독립이고, 만일 이전 vector들의 span에
    포함되는게 하나라도 있다면, 선형 의존이 된다는 말이다.


### 선형독립 formal한 정의 {#선형독립-formal한-정의}

위에서, 선형 독립과, 선형의존의 의미를 얘기했었다. 2개의 vector가
있을때, 하나의 vector의 span안에 다른 vector가 포함된다면 선형
의존이라고 했고, 포함되지 않는다면 선형 독립이라고 했다. 선형종속과
선형독립은 span의 개념에 대한 이해가 필요했었다. 그런데 선형독립과
선형종속을 이해해야 하는 이유는 무엇인가? 선형종속과 독립을 말할수
있다면, matrix곱으로 표현된 방정식의 해를 직접 구할수는 없어도 해가
있는지 없는지 여부, 해가 있다면 unique한지 무수히 많은지를 알수
있다고 한다. 이런 개념적인 설명말고, 우리가 지금 알려고 하는것에
촛점을 맞춰보자.

matrix 곱에 대한 방정식은 linear combination을 사용한 방정식으로
바꿀수 있고, 그 방정식의 해가 있는지 여부는 span의 포함여부로
확인할 수 있다고 했다. 그런데 다음과 같은 경우를 생각해보자. 어떤
linear combination가 0 vector와 같다는 방정식이 있다고 하자.

\\(\begin{bmatrix} v\_{1} \ v\_{2} \ \ldots \ v\_{3} \end{bmatrix}\\) \\(\begin{bmatrix} x\_{1} \\\ x\_{2} \\\ \vdots \\\ x\_{p} \end{bmatrix}\\) =  \\(\begin{bmatrix} 0 \\\ 0 \\\ \vdots \\\ 0 \end{bmatrix}\\)

\\(x\_{1}v\_{1}\\) + \\(x\_{2}v\_{2}\\) \\(\ldots\\) + \\(x\_{p}v\_{p} = 0\\)

이 방정식의 해는 존재하는가? 반드시 존재한다. 해가 0벡터가 되면
식을 만족하기 때문이다. 즉 위방정식의 해는 최소 1개 이상
존재한다. x가 0벡터이면 최소 1개의 해가 존재한다.

\\(x =\\) \\(\begin{bmatrix} x\_{1} \\\ x\_{2} \\\ \vdots \\\ x\_{p} \end{bmatrix}\\) = \\(\begin{bmatrix} 0 \\\ 0 \\\ \vdots \\\ 0 \end{bmatrix}\\)

unique하게 존재하는가? 만일 0벡터가 아니면서 윗식을 만족하는
vector가 존재한다면, 0벡터 말고 또 다른 해가 있다는 뜻이다. 이것을
선형 독립과 선형 종속의 개념으로 설명할 수 있다고 한다.  어떻게
설명할 수 있을것인가? 0벡터가 아닌 해가 있다고 가정한다.

\\(x =\\) \\(\begin{bmatrix} x\_{1} \\\ x\_{2} \\\ \vdots \\\ x\_{p} \end{bmatrix}\\) = \\(\begin{bmatrix} 0 \\\ 0 \\\ 1 \\\ \vdots \\\ 3 \\\ \vdots\\\0 \end{bmatrix}\\)

위와 같이 어떤 vector가 만족한다고 하자. 즉 해가 0벡터와 위 vector
2개의 해를 갖는다는 것이다. 그러면 저 해가 진짜 해인지 아닌지를
어떻게 판별할 것인가? 강사는 말한다. 저 해에서 0이 아닌값을 갖는
item이 30번째에 있고, 30번 이후로는 0값을 갖는다고 하자. 그러면
p가 100인경우에 원래 식이 바로 아래식으로 바뀐다.

\\(x\_{1}v\_{1}\\) + \\(x\_{2}v\_{2}\\) \\(\ldots\\) + \\(x\_{100}v\_{100} = 0\\)

\\(x\_{1}v\_{1}\\) + \\(x\_{2}v\_{2}\\) \\(\ldots\\) + \\(x\_{30}v\_{30} = 0\\)

윗 식에서 \\(v\_{30}\\) 만을 남겨둔 채 모두 이항한다.

\\(v\_{30} =\\) \\(-(x\_{1}/x\_{30})v\_{1}\\)  \\(-(x\_{2}/x\_{30})v\_{2}\\) \\(\ldots\\) \\(-(x\_{29}/x\_{30})v\_{29}\\)

그러면 \\(v\_{30}\\) 은 \\(v\_{1}\\) 부터 \\(v\_{29}\\) 벡터들의 linear
combination형태로 나타내지고 \\(v\_{1}\\) 부터 \\(v\_{29}\\) 의 span에
\\(v\_{30}\\) 이 포함되면 선형독립이 되어 해가 존재하는게 된다.


## Geometric understanding of Linear Dependence {#geometric-understanding-of-linear-dependence}

<a id="figure--geometric"></a>

{{< figure src="./img/geom1.png" caption="<span class=\"figure-number\">Figure 1: </span>geometric" >}}

위 그림에서 보면 \\(x\\) 라는 vector가 있다. 그리고 \\(v\_{1}\\) 과 \\(v\_{2}\\)
라는 vector가 보인다. 우리가 \\(v\_{1}\\) 과 \\(v\_{2}\\) 의 계수를 어떻게
설정하면 x라는 점을 가리킬까? 가 해를 구하는 거라고 보면된다. 위에서
\\(v\_{1}\\) 과 \\(v\_{2}\\) 의 span은 하나의 plane영역을 뜻하기 때문에, 그
영역에 x가 있으면 해가 있다고도 말한다.

근데 여기서 생각해봐야 할께 있다. 우리가 matrix곱에서 linear
combination을 만들었는데, 2개의 vector가 좌변에 linear
combination으로 있다고 하자. 위에서 말한 v1과 v2가 좌변에
있는것이다. 그리고 우변에 x라는 vector가 있다고 하자. 그러면, x라는
vector는 v1과 v2로 만들어지는 span에 포함되어 있는것이다. 즉 v1과
v2라는 linear combination으로 만들어진다. v1과 v2라는 eigenvector로
이루어진 평면에 x가 있기 때문에 해가 있다고 말하고, 그 해는 linear
combination의 계수에 해당하는 2,3이 된다.

그런데 만일 v3란 vector가 좌변에 있다고 하자. v3란 vector가 v1과
v2로 이루어진 평면에 속한 vector라고 하자. 즉 선형 종속된
경우다. 이럴경우, x라는 vector가 v1과 v2를 늘이거나 줄여서 평행
사변형으로 그 값이 정해질 수도 있지만, v1과 v3를 사용해서 그 값이
정해질 수도 있다. 예를 들면, v1=5, v2=0, v3=3, 또 v2와 v3로 표현될
수도 있다. v1=0, v2=20, v3=5 라고 하자.이것은 해를 나타내는 벡터가
(2,3,0)도 있을 수 있지만, (5,0,3),(0,20,5)라는 해를 가질수도 있다는
것이다. 어차피 좌변의 vector가 선형종속적이기 때문에 최소 하나의
eigenvector가 중복이 되는 것이다. 따라서 2개의 eigenvector로
나타내는 평면에 있기 때문에, x를 나타내는 평행사변형이 여러개가 될
수 있는 것이다.

이제 선형독립을 생각해보자. 좌변의 linear combination을 이루는
v1,v2,v3가 선형독립이라면 x를 나타내는 육면체는 하나만 존재한다. 즉
해가 한개만 존재한다. linear combination의 좌변에 있는 vector가 선형
종속일때는 여러 평행사변형이 만들어져서 여러개의 해를 가졌다면,
선형독립인 경우 단 하나의 해를 갖는다.


## Subspace and Basis {#subspace-and-basis}

subspace란 개념의 정의는 닫혀진 linear combination의 subset을
말한다. span의 부분집합 정도로 이해하면 된다고 한다. subspace는
선형결합에 대해서 닫혀있다는 개념이 있다는게 특이하다.

-   Definition: A subspace H is defined as a subset of \\(R^{n}\\) closed
    under linear combination:

닫혀있다는, 집합에서 어떤 연산을 수행한 결과가 집합에 포함될 경우
닫혔다고 한다. 자연수에서 + 연산은 닫혀있다. -연산은 열려 있다.

예를 들어보자. subspace는 우선 a subset of \\(R^{n}\\) 이다. 따라서,
\\(R^{3}\\) 에서 하나의 subset을 생각해보자.

\\(\begin{Bmatrix} \begin{bmatrix} 1 \\\ 2  \\\ 3 \end{bmatrix}, \begin{bmatrix} 4 \\\ 5 \\\ 9 \end{bmatrix} \end{Bmatrix}\\) \\(\in R^{3}\\)

이 subset이 linear combination에 대해 닫혀 있는가? 여기서 두
vector를 더하면

\\(\begin{bmatrix} 5 \\\ 7 \\\ 12 \end{bmatrix}\\) 는 위 subset에 포합되어 있지 않다.

따라서, 닫혀있지 않다. 그래서 이것은 subspace는 아니다.

span의 경우는 항상 닫혀있다. 따라서 span은 subspace이다.


## Basis of a subspace {#basis-of-a-subspace}

Basis는 기저 벡터라고도 한다. subspace를 이루는 vector들의 집합을
말한다. subspace를 span이라고 봐도 된다고 했다. 왜냐하면, 어떤
vector가 주어졌을때, 그 주어진 vector의 linear combination해서 얻게
되는 vector들의 집합이 닫혀있기 위해선 span이여야 하기
때문이다. 또한 기저 vector들은 서로 선형 독립인 특징을 가져야
한다. 선형독립이라는 것은 기저벡터의 linear combinations에 다른
기저벡터가 포함되지 않는 경우를 말한다.

예를 들어보자.

\\(\begin{bmatrix} 1 \\\ 2  \\\ 3 \end{bmatrix}\\) \\(x\_{1}\\) + \\(\begin{bmatrix} 4 \\\ 5  \\\ 6 \end{bmatrix}\\) \\(x\_{2}\\) + \\(\begin{bmatrix} 5 \\\ 7  \\\ 9 \end{bmatrix}\\) \\(x\_{3}\\)

어떤 linear combination의 위와 같을때, 여기의 basis는 무엇인가?

\\(\begin{bmatrix} 1 \\\ 2  \\\ 3 \end{bmatrix}\\) ,  \\(\begin{bmatrix} 4 \\\ 5  \\\ 6 \end{bmatrix}\\)  이다.

왜냐하면,

\\(\begin{bmatrix} 5 \\\ 7  \\\ 9 \end{bmatrix}\\) 는  \\(\begin{bmatrix} 1 \\\ 2  \\\ 3 \end{bmatrix}\\) 과 \\(\begin{bmatrix} 4 \\\ 5  \\\ 6 \end{bmatrix}\\) 을 더해서 만들어지기 때문이다.

즉 2개의 vector의 span에 포함되는 vector이다. basis는 2개 vector일
뿐이다.

어떤 subspace가 주어진다면, 그 subspace는 하나의 직선으로 주어질수도
있고, 평면으로 주어지거나 육면체로도 주어질 수 있을 것이다. 여기서
basis를 찾을 수 있을것인가? 그리고 basis는 모두 unique한가?라는
질문을 할 수 있다.

<a id="figure--geometric 2"></a>

{{< figure src="./img/geom2.png" caption="<span class=\"figure-number\">Figure 2: </span>geometric 2" >}}

예를 들어서 위의 그림을 보면 하나의 subspace가 주어졌다. 이
subspace를 span하는 basis는 unique한가?가 질문이다. 그 질문에 대해서
강사는 unique하지 않다고 한다. subspace에 포함되는 임의의 벡터 v1을
선택하고, v1과 다른 방향을 갖는 아무 벡터를 선택해도, 두 벡터를
span해서 subspace를 만들수 있기 때문에 unique하지 않다고 한다. 즉
여러개의 기저벡터가 있을수 있다. 다만, 중요한것은 subspace를
span하는 기저벡터의 개수는 정해져 있다고 한다. 어떤 basis를
사용하더라도 해당 subspace를 만들어내는(span)할 수 있는 기저벡터의
수는 정해져 있다고 한다. 이 정해진 subspace를 span하는 기저벡터의
개수를 dimension이라고 부른다.


## Dimension of subspace {#dimension-of-subspace}

위에서도 얘기했듯이 subspan을 이루는 기저벡터는 정해져 있지
않다. 예를 들어 평면을 만드는 subspace의 기저벡터는

\\(\begin{bmatrix} 1 \\\ 2  \end{bmatrix}\\), \\(\begin{bmatrix} 2 \\\ 1  \end{bmatrix}\\) 이 될수도 있고,  \\(\begin{bmatrix} 4 \\\ 8  \end{bmatrix}\\), \\(\begin{bmatrix} 8 \\\ 4  \end{bmatrix}\\) 이 될수도 있는 것이다.

다만, 평면인 subspace를 span하는 기저벡터의 수는 2개다.라고 말할
수는 있다. 이 정해진 개수를 dimension이라고 부른다.

우리가 3차원공간에서 가장 큰 subspace인 \\(R^{3}\\) 를
생각해보자. 이것이 subspace가 되려면, 조건이 있었다. linear
combination에 대해서 닫혀있어야 한다. 그리고 기저벡터는 linear
independence해야 한다.

우선 \\(R^{3}\\) 가 subspace가 될 첫번째 조건을 살펴보자.  linear
combination에 대해 닫혀있다는 것은 어떤 vector가 \\(R^{3}\\) 에 속해
있다면, 기저벡터의 linear combination으로 나타낼 수 있다는
뜻이다. 기저벡터는 여러개가 있지만, 가장 간단한 것은 다음과 같은것이
있다.

\\(\begin{bmatrix} 1 \\\ 0 \\\ 0 \end{bmatrix}\\) ,   \\(\begin{bmatrix} 0 \\\ 1 \\\ 0 \end{bmatrix}\\) ,   \\(\begin{bmatrix} 0 \\\ 0 \\\ 1 \end{bmatrix}\\)

3차원 공간상의 모든 vector를 기저 벡터로 모두 표현(linear
combination으로 표현) 할 수 있어야 subspace가 된다. 예를 들어보자.

\\(\begin{bmatrix} 1 \\\ 2  \\\ 5 \end{bmatrix}\\)

위 vector는 기저벡터로 표현될 수 있다.

\\(\begin{bmatrix} 1 \\\ 2  \\\ 5 \end{bmatrix}\\) = 1 \\(\begin{bmatrix} 1 \\\ 0 \\\ 0 \end{bmatrix}\\) + 2 \\(\begin{bmatrix} 0 \\\ 1 \\\ 0 \end{bmatrix}\\) + 5 \\(\begin{bmatrix} 0 \\\ 0 \\\ 1 \end{bmatrix}\\)

따라서 subspace가 될 조건 linear combination에 대해서 닫혀있다는 만족한다.

두 번째로, subspace의 기저벡터들이 linear independence해야
한다는것은, 기저벡터 중 어떤 하나의 span에도 다른 기저벡터가
포함되면 안된다. 위의 3개의 기저벡터들은 다른 span에 포함되지
않는다.

\\(R^{3}\\) 에서의 basis와 마찬가지로 \\(R^{5}\\) 에서 basis도 동일한
기저벡터를 구할 수 있다.

여기서 말할려는건, subspace와 span은 같다라는 것과 subspace를
이루는 기저벡터의 수는 정해져 있다는 것이다.


## column space {#column-space}

column space라는 용어가 있다. matrix가 있을때, matrix를 이루는
column들을 기저벡터로 하는 space를 생각할 수 있는데, 그것을 column
space라고 부른다. A matrix의 column space는 Col A라고 쓴다. 예를
들어보면,

\\(A = \begin{bmatrix} 1 \ 1 \\\ 1 \ 0 \\\ 0 \ 1 \end{bmatrix}\\) =&gt; col A = span \\(\begin{Bmatrix} \begin{bmatrix} 1 \\\ 1 \\\ 0 \end{bmatrix} , \begin{bmatrix} 1 \\\ 0 \\\ 1 \end{bmatrix} \end{Bmatrix}\\)

그런데, 우리가 data로 부터 machine을 만들때, matrix곱의 형태를
linear combination 형태로 변형했었다. 그리고 변형된 linear
combination의 column들은 eigenvector로 생각하고, 그 eigenvector들이
선형 독립이라면, unique한 해가 한개 존재한다고 말했다. 우리가 linear
combination형태로 변형하지 않아도, matrix곱형태에서 matrix의
column들이 eigenvector라고 말할 수도 있다. 그것을 용어로써 말한다면,
col A, 즉 A matrix의 column space라고 말할수 있다. linear
combination으로 모양을 바꾸기전에 column space를 말할수 있다는
것이다.

여튼 위의 matrix를 볼때, A의 column space를 말할 수 있는데, column
space는 span하고 똑같은 말이라고 했다. 그런데 단순히 어떤 matrix가
주어졌을때, column space라고 말하면서, matrix를 구성하는 column
vector들을 eigenvector라고 하면서 span 표기법으로 나타낼 수 있는가?
안된다. span으로 나타낼려면, 그리고 span과 subspace가 동일하게
쓰일려면, 2가지 조건을 만족해야 했다. 첫번째, basis에 대한
선형독립인가? basis를 사용해서 만들어지는 span집합에 linear
combination이 닫혀 있는가?이다. 두가지 조건이 만족하는지 살펴보자.

A = span \\(\begin{Bmatrix} \begin{bmatrix} 1 \\\ 1 \\\ 0 \end{bmatrix} , \begin{bmatrix} 1 \\\ 0 \\\ 1 \end{bmatrix} \end{Bmatrix}\\)

위에서 두개의 vector는 같은 방향이 아니다. 따라서 선형독립이다. 같은
방향이라는것은 하나의 기저벡터에 실수배를 했을때 배율로
맞아떨어지면, 같은 방향이다. 위 두개 vector는 서로 방향이 다른 선형
독립인 vector들이다. 그리고 두개의 basis를 가지고 linear
combination으로 만들어지는 vector들은 위 span에 포함될
것이다. 따라서 위와 같이 matrix가 주어질때, column space를 위와 같이
말해도 된다. 어떤 matrix가 주어질때, column space를 matrix의 column
vector로 eigenvector로 하기 위해서는 두 vector가 선형독립이어야
위처럼 column space를 말할수 있다. 만일 matrix의 한 column vector가
다른 column vector의 실수배가 되거나, linear combination으로 나타낼
경우, 즉, 선형의존성이 있다면, column space는 의존하는 vector는 제외가
된다. 그런 예를 살펴보자.

\\(A = \begin{bmatrix} 1 \ 1 \ 2 \\\ 1 \ 0 \ 1 \\\ 0 \ 1 \ 1  \end{bmatrix}\\) , 여기서 \\(\begin{bmatrix} 2 \\\ 1 \\\ 1 \end{bmatrix}\\) = \\(\begin{bmatrix} 1 \\\ 1 \\\ 0 \end{bmatrix}\\) + \\(\begin{bmatrix} 1 \\\ 0 \\\ 1 \end{bmatrix}\\)

어떤 matrix A가 주어졌다고 하자. A의 column vector들을 가지고 무조건
아래처럼 column space로 만들수 없다.

A = span \\(\begin{Bmatrix} \begin{bmatrix} 1 \\\ 1 \\\ 0 \end{bmatrix} , \begin{bmatrix} 1 \\\ 0 \\\ 1 \end{bmatrix}, \begin{bmatrix} 2 \\\ 1 \\\ 1 \end{bmatrix} \end{Bmatrix}\\)

위에서 봤듯이, A matrix의 마지막 column vector는 다른 2개의 column
vector들의 linear combination으로 표현된다. 즉 선형 종속적인
vector이기 때문이다.

\\(\begin{bmatrix} 2 \\\ 1 \\\ 1 \end{bmatrix}\\) = \\(\begin{bmatrix} 1 \\\ 1 \\\ 0 \end{bmatrix}\\) + \\(\begin{bmatrix} 1 \\\ 0 \\\ 1 \end{bmatrix}\\)

따라서 A의 column space인 col A는 다음과 같다.

A = span \\(\begin{Bmatrix} \begin{bmatrix} 1 \\\ 1 \\\ 0 \end{bmatrix} , \begin{bmatrix} 1 \\\ 0 \\\ 1 \end{bmatrix} \end{Bmatrix}\\)

여기서 dimension은 어떻게 되는가? dimension은 space, 즉 span과
관련한 용어다. 위와 같은 span이 있다면, span의 dimension은 basis의
개수라고 했다. 즉, eigenvector의 개수 이기 때문에 2가된다.

그런데 궁금한것은 어떤 matrix가 주어졌을 때, 그것의 dimension 계산을
어떻게 하는가? 즉 linear independent한 vector의 개수를 어떻게 찾아
내는가?  그것에 대한 얘기는 하지 않는다. 다만, 어떤 matrix가
주어졌을때, 그 matrix가 10개의 column vector로 구성된다고 해도,
dimension은 10보다 작을것이다. 라고 말 할수 있다는것만 얘기했다.


## Rank of matrix {#rank-of-matrix}

matrix의 특징을 나타내는 개념중에 rank가 있다. rank는 matrix의
dimension을 얘기한다. 아래와 같이 나타낼 수 있다.

<div class="important">

rank A = dim col A

</div>

어떤 matrix가 주어졌을 때, column space를 구하는데, column space는
matrix를 구성하는 column vector들이 선형독립의 특성을 갖는 column
vector를 span하는 space라고 했고, dimension은 선형독립인 column
vector의 개수라고 했기 때문에 위와 같은 식으로 나타낼 수 있다.

Rank의 개념은 matrix factorization과 outer product의 개념과도 연관
지을 수 있다. 예를 들어, 우리가 어떤 matrix가 주어지고 rank도
주어진다면 matrix를 factorization할 수 있다. 4개의 column을 가진
matrix가 rank가 2라면 우리는 2개의 column을 갖는 matrix와 2개의
row를 갖는 matrix곱으로 나타낼 수 있다.

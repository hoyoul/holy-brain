+++
title = "[모두의딥러닝] chapter6 퍼셉트론"
author = ["박 호열"]
date = 2022-03-06T00:00:00+09:00
draft = false
+++

[test]({{< relref "howtoprogram" >}})


## (1) Perceptron {#1--perceptron}

<a id="figure--perceptron"></a>

{{< figure src="/img/everyone_deepLearning/chapter6/perceptron.png" caption="<span class=\"figure-number\">Figure 1: </span>perceptron" width="600px" >}}

-   Perceptron의 구조는 뉴런이란 구조와 비슷하지만, chapter5에서 봤던
    sigmoid함수의 구조와 비슷하다. sigmoid함수를 보면, exponential의
    인자로 직선의 방정식이 들어가는 합성함수의 구조였다. 마찬가지로
    Perceptron도 비슷한 구조로 되어 있다. 직선의 방정식이 a에서 w로
    변경되고, 개수가 늘어난 차이만 있다.
-   Perceptron은 Logistic Regression의 확장판으로 보면 된다.


## (2)가중치, 가중합, 바이어스, 활성화 함수 {#2--가중치-가중합-바이어스-활성화-함수}

-   용어에 대한 정리가 필요하다.

<img src="./img/everyone_deepLearning/chapter6/math.png" width="400px">

-   가중치(weight): sigmoid의 입력으로 들어가는 직선의 방정식의 기울기로 보면 된다.
-   bias: sigmoid함수의 입력으로 들어가는 직선의 방정식의 절편으로 보면 된다.
-   가중합(weight sum): 가중치합을 통해서, 직선의 방정식이 만들어진다.
-   활성화 함수(activate function): Logical Regression을 보면
    sigmoid함수는 직선의 방정식의 scala값이 입력으로 들어가서
    0~1사이의 값을 출력한다. sigmoid를 다른 함수로도 변경이 가능하다.


## (3) XOR문제 {#3--xor문제}

-   Linear Regression이나 Logistic Regression은 모두 선긋기 문제다.
-   Perceptron은 Logistic Regression의 확장판이라서 선을 긋는다.
-   이런 Perceptron이 해결할 수 없는 문제가 있다.

    <img src="./img/everyone_deepLearning/chapter6/xor1.png" width="600px">
-   위 표를 그래프로 나타내면 다음과 같다.

    <img src="./img/everyone_deepLearning/chapter6/xor2.png" width="600px">
-   XOR을 분류하는 선을 그을수가 없다. (Multi-Layer Perceptron이 해결)

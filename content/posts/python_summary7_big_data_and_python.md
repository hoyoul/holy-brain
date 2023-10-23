+++
title = "python_summary7 big data and python"
author = ["holy"]
description = "python은 big data, 즉 대용량의 data를 처리하는 기능이 있다. 그 기능들중 일부는 아주 오래전부터 사용하던 것도 있고 아닌것도 있다."
date = 2023-06-17T00:00:00+09:00
draft = true
+++

## 대용량 data의 처리 {#대용량-data의-처리}

대용량 data의 처리에서 `대용량 data는 string이나 array, list` 같은
data collection에 있는 data를 말한다. `처리는 검색과 변환`
이다. 처리하는 방식은 for-loop와 while과 같은 전통적 방식과 functional
language에서 사용하는 방식으로 나누어 질 수 있다. 전통적방식은 기계식
방법이다. 절차형방식의 programming에서 건너온 개념이라서 몇가지
functional language와 다른 특징이 있다. 첫번째 machine에 해당하는
함수가 입력과 출력이 없어도 된다. functional language의 machine인
function은 입력과 출력이 필수다. 반면 전통적 방식 중 for-loop은 입력은
주어지지만 출력은 없어도 된다. 따라서 list comprehension으로 출력을
list로 만들어주는 방식으로 python에서는 개선했다. 그리고 while의 경우
입력과 출력이 없어도 된다. 그리고 for-loop은 데이터의 개수는
대용량이지만, machine은 1개다. 그래서 데이터가 10개라면 10번 machine을
켜서 순차적으로 실행한다. while은 조건이 True면 무한정 기계를
돌린다. 그런데 공통점은 하나의 machine이 한번 수행하는 것이다. 반면에
functional language에서 처리하는 방식들은 machine을 한개만 사용하지
않는다. 그래서 전동적 방식은 하나의 processor만 이용하지만,
processor가 여러개인 경우, functional language에서 사용하는 방식은
여러개의 machine을 동시에 수행할 수 있다.그렇기 때문에 매우
효율적이다.


## for-loop {#for-loop}

대용량의 data를 처리하는데 가장 오래된 것은 for-loop이다. for-loop은
데이터를 하나하나 꺼내는 부분과, 데이터를 처리하는 함수가 합쳐진
structure다. 아주 오래전 부터 대용량의 데이터를 처리하는
방식이다. for-loop에서 한개의 data 입력을 받아서 한개의 data 출력을
return하는 function을 보면 누군가는 이렇게 질문할 수 있을꺼
같다. array나 list를 함수의 입력으로 주면 되지 않나? 그런데 함수가
입력만 array나 list로 받을뿐 처리는 함수내부에서 for-loop를 돌려서
처리한다. 데이터의 처리라는것은 입력받은 data를 다른 data의 형태로
변환하는것을 의미한다. 기본적인 함수는 하나의 data(datum)를 받고
하나의 data를 return하는 것이다. primitive data가 있는 것처럼
primitive data를 처리하는 primitive function이 있는데 예를들면, and,
or, not, +, -,/ 같은 것들이 있다. 이 함수들이 2개의 인자를 갖는다고
생각할 수 있겠지만, 1개의 인자를 갖는 함수라고 본다. 그림으로 보면
다음과 같다.

<a id="figure--for-loop"></a>

{{< figure src="/img/python/forloop1.png" caption="<span class=\"figure-number\">Figure 1: </span>for-loop" width="600px" >}}

list나 array같은 대용량의 data를 처리하는 가장 오래된 방법이다. 대용량
데이터에서 순차적으로 data를 꺼낸다. 꺼낸 데이터를 머신에 넣고 결과를
만든다. machine은 하나만 쓴다. 이게 일반적인 for-loop
machine이다. for-loop의 block이 machine에 해당하는 함수다. 일반적인
사용법은 아래와 같다.

```python
arr = [9,8,7,6,5,4,3,2,1]
for i in arr:
    print(i)

```

```text
9
8
7
6
5
4
3
2
1
```

continue를 사용해서 filtering효과를 낼수 있다. 즉 데이터에서 홀수만
출력하고 짝수는 출력하지 않는다.

```python
arr = [9,8,7,6,5,4,3,2,1]
for i in arr:
    if i % 2 == 0:
        continue
    print(i)
```

```text
9
7
5
3
1
```

break를 사용해서 machine을 중간에 멈출 수도 있다.

```python
arr = [9,8,7,6,5,4,3,2,1]
for i in arr:
    if i == 7:
        break
    print(i)
```

```text
9
8
```


## while {#while}

대용량 data를 처리할 때, 전통적인 방식인 for-loop와 더불어 while이
있다. while은 함수라는 machine을 사용하지만, 그 machine이 반드시
입력과 출력이 있어야 한다는 보장을 하지 않는다.


## list comprehension {#list-comprehension}

for-loop을 개량한 방식이다. for-loop이 한개의 machine을 통해서 나온
결과를 별도의 list나 array에 집어넣어야 한다. 이런 불편함을 없앤게
list-comprehension이다. 이미 list안에서 for-loop을 실행하기 때문에
결과를 위한 별도의 list나 array를 만들지 않아도 된다. list
comprehension의 모양은 다음과 같다.

```text
newlist = [expression for item in iterable if condition == True]
```

expression은 결과가 오고, 그다음 for와 if가 온다.

```python
arr = [9,8,7,6,5,4,3,2,1]
temp = [results for i in arr]
print(temp)
```


## map &amp; filter {#map-and-filter}

functional language에선 for-loop을 사용하지 않았다. list나 array같은
대용량 data를 machine 하나만 사용해서 순차적으로 처리하는 방식이
비효율적이기 때문이다. 데이터 개수만큼 machine을 만들어서 동시에
처리한다. 이게 더 효율적이고 빠르다. machine을 data 갯수만큼 만들기
위해서 lambda function을 사용한다. 그러면 한방에 계산할 수 있다.

filter는 if문을 사용해서
filtering효과를 줄 수 있다. 동작방식을 그림으로 보면 다음과 같다.

<a id="figure--map & filter"></a>

{{< figure src="/img/python/map.png" caption="<span class=\"figure-number\">Figure 2: </span>map &amp; filter" width="600px" >}}


## reduce {#reduce}

map&amp; filter처럼 여러개의 machine을 사용한다. machine이 한개의 입력만


## recursion {#recursion}


## regular expression {#regular-expression}

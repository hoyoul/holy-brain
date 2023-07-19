+++
title = "lecture9-Advanced-Data-Structure"
author = ["holy"]
description = "python에서 자주 사용하는 data structure."
date = 2023-06-05T00:00:00+09:00
draft = false
+++

## Stack {#stack}

```python
a = [1,10]
a.append(4)
a.append(20)
print(a.pop())
print(a.pop())
```

-   stack은 FILO(First In First Out)
-   python에서 stack은 list를 사용하면 된다.
-   list에서 제공하는 append와 pop을 사용한다.
-   list의 시작주소와 마지막 노드 주소를 가지고 있기 때문에 삽입과
    삭제는 O(1)이 걸린다.


## Queue {#queue}

```python
a = [1,0]
a.insert(0,20)
a.insert(0,15)

print(a)
print(a.pop())

```

-   Queue는 FIFO이다. python에선 list의 내장함수를 이용해서 사용할 수
    있다.
-   insert()로 0번 position에 입력하면 값들이 계속 shift된다.
-   pop()은 마지막 position에서 값을 꺼낸다.
-   강사는 queue를 list를 사용하면, insert와 pop시 속도가 O(n)이
    된다고 한다. python의 list는 dynamic array라고 한다. 근데 또 끝에
    있는것을 pop()할때 O(n)이라고 하는데, 그러면 list 맞는거 같은데...
-   내 생각에 list로 구현된 queue의 경우, pop()은 O(n)이
    맞는듯하다. 왜냐하면 deque를 설명할 때, tail의 위치를 유지하고
    있어서 pop()을 할때 O(1)이 걸린다는 얘길한다.
-   강사는 linked list를 사용해서 queue를 만들어야 한다고 한다.


## deque {#deque}

```python
from collections import deque
queue = deque([10,5,2])

queue.appendleft(16)    #왼쪽 삽입
queue.pop()             #오른쪽 삭제

queue.append(20)        #오른쪽 삽입
queue.popleft()         #왼쪽 삭제

print(queue)
print(deque(reversed(queue)))     #deque 뒤집기 O(n)
```

-   deque는 linked list로 이루어진 double queue라고 한다.
-   stack은 삽입과 삭제가 한방향에서만 일어난다.
-   queue라는 것은, 삽입과 삭제가 서로 다른방향에서 일어난다.
-   dequeue는 양방향에서 삽입과 삭제가 일어날 수 있다.


## priority queue(heapq) {#priority-queue--heapq}


### priority queue의 장점 {#priority-queue의-장점}

priority queue는 매우 자주 사용되는 자료 구조라고 한다. queue에
입력된 data중에서 최소,최대값을 빠르게 구하고 싶다면, priority
queue를 사용해야 한다고 한다. min/max함수를 써서 주어진 collection의
최소, 최대를 찾을수도 있다. 하지만, O(n)의 속도가 걸린다고
한다. 내부가 정렬되어 있다면, binary search로 O(log n)이
걸릴것이다. 그럼 삽입할때 마다, 정렬을 해줘야지 search시에 O(log
n)을 유지하는데, 정렬을 하는데에 O(NlogN)이 걸리기 때문에 그닥
효율적이지 못하다고 한다. priorty queue를 사용하면, 이것을
해결한다고 하는데, 뭔말 하는지 모르겠다. priority queue는 python에서
heapq라고 한다.


### heapq 사용법 {#heapq-사용법}

```python
import heapq
queue = [5,2,8,4]
heapq.heapify(queue)     #초기화, tree로 변경 O(N log N)
print(queue)
print(queue[0])

heapq.heappush(queue,3)
print(queue)
print(queue[0])

heapq.heappush(queue,6)
print(queue)
print(queue[0])

item = heapq.heappop(queue)
print(item, queue[0])

item = heapq.heappushpop(queue,7)
print(item, queue[0])
```

heap이란 자료구조 별도로 있다. max heap과 min heap이 있는데, max
heap은 부모 노드값이 자식보다 큰 tree를 말하고, min heap은 부모
노드값이 자식보다 작은 tree를 말한다. python의 heapq는 min
heap이다. 내부적으로 완전 이진 tree를 사용하고 있다. 사용하고 있는
tree와 배열간에는 다음과 같은 관계가 있다고 한다.

```text
heap[k] <= heap[2*k+1] and heap[k] <= heap[2* k+2]
```


## Defaultdict {#defaultdict}


### 개요 {#개요}

dictionary는 기본적으로 없는 key로 접근했을 때 key error를 발생한다.

```python
d = {"first": 0}
print( d["second"])
```

이것을 방지하기 위해서, key가 없을 때, default값을 반환하는 get()를
제공한다.

```python
d = {"first": 0}
print( d.get("second", "없어요"))
```

defaultdict()는 위에 get()가 사용하는 방식처럼 미리 default값을
dictionary에 정의한 것이다. 그래서 key가 없더라도 에러를 출력하지
않고 기본값을 출력한다.


### 사용예 {#사용예}

defaultdict가 어떨때 사용하면 좋은지에 대해서 강사는 예를
든다. 만일 우리가 어떤 text북에서 나오는 모든 글자를 counting하고
싶다고 하자. 어떻게 programming할 것인가?

```python
text = """Lorem ipsum dolor sit amet, consectetuer adipiscing elit.
Donec hendrerit tempor tellus.  Donec pretium posuere tellus.
Proin quam nisl, tincidunt et, mattis eget, convallis nec, purus.
Cum sociis natoque penatibus et magnis dis parturient montes,
nascetur ridiculus mus.  Nulla posuere.  Donec vitae dolor.  Nullam
tristique diam non turpis.  Cras placerat accumsan nulla.  Nullam
rutrum.  Nam vestibulum accumsan nisl."""

characters ={}
for char in text:
    count = characters.get(char, None)
    if count is None:
        characters[char] = 0
    characters[char] += 1
print(characters)
```

program을 작성하기 위해서, 입력은 무엇인지, 입력에 대해 어떤 처리를
해야 하고, 그 처리 결과를 어떻게 할지를 생각해야 한다. 입력은
text문자열이다. text문자열을 어떻게 처리할 것인가? text문자열을
하나씩 꺼낼것이다. text문자열은 유한개이다. 따라서 for loop을
사용할 것이다. text문자입력에서 하나씩 꺼낸 문자를 어떻게 처리 할
것인가? 그 문자를 counting해야 한다. 어떻게 counting할 것인가?
dictionary를 사용해서, 해당 문자와 counting을 저장하고
싶다. 해당문자와 그 문자의 occurs를 같이 저장해야겠다는 idea를
도출하는게 중요하다. 문자와 occurs를 쌍으로 저장하려면 tuple도
있고, dictionary도 있다. tuple을 사용하려면, list같은 data
structure가 또 필요하다. 그래서 dictionary를
사용하겠다. dictionary는 쌍으로된 많은 data를 저장할 수 있기
때문이다. text에서 문자 하나를 꺼내서 dictionary에 있는지 없는지를
검사한다. 만일 있다면, occurs를 증가시킨다. 없다면 dictionary의
key로 등록하고 occurs를 1로 counting한다. 그런데 위의 코드는 내
생각과 다르다. 위의 코드에선, key에 해당하는 문자가 있는지 없는지
검사하지 않는다. 무조건 key에 해당하는 값을 return하거나, 없으면
None값을 key로 return하는 dictionary의 get이란 함수를
사용한다. get이란 함수의 좋은점은 2가지가 있다. key가 없으면 에러를
내지않고 임의의값으로 key를 등록한다.  key가 있는지 없는지 확인할
필요가 없다. 없으면 default 값으로 key를 등록하기 때문이다. 그리고
if문을 사용해서 none으로 등록된 key를 제대로 된 alphabet으로 하고
occurs를 등록한다. 이렇게만 해도 충분해 보인다. 하지만, 강사는
defaultdict가 이것을 훨씬 편하게 해준다고 한다.


### defaultdic의 사용 {#defaultdic의-사용}

```python
from collections import defaultdict

text = """Lorem ipsum dolor sit amet, consectetuer adipiscing elit.
Donec hendrerit tempor tellus.  Donec pretium posuere tellus.
Proin quam nisl, tincidunt et, mattis eget, convallis nec, purus.
Cum sociis natoque penatibus et magnis dis parturient montes,
nascetur ridiculus mus.  Nulla posuere.  Donec vitae dolor.  Nullam
tristique diam non turpis.  Cras placerat accumsan nulla.  Nullam
rutrum.  Nam vestibulum accumsan nisl."""

characters = defaultdict(int)
# characters = defaultdict(lambda: 0)
for char in text:
    characters[char] += 1

print(characters)
```

defaultdict을 사용하면, 매우 간단해지는 것을 볼수 있다. 즉
text로부터 꺼낸 알파벳에 대한 key값이 모두 dictionary에 들어있다고
생각하게끔 만든다. 즉 모든 알파벳에 대한 key와 value가 이미
dictionary에 있기 때문에 해줘야 할 것은 text에서 뽑은 key를 갖는
요소에 +1만 해주면 된다. 위에서 살펴봤던 get을 사용하는 경우나,
내가 생각했던 방식보다 훨씬 간단한것을 알 수 있다.

여기서 defaultdict를 생성할때, int를 주면 int()를 해서 모든 값이
0으로 채워진다고 한다. 그런데 특정값을 생성할 수 있는 lambda를
사용해도 된다. lambda로 0을 만들수도 있고, 특정 계산이 들어갈 수도
있다. 그리고 for-loop에서 꺼낸 알파벳을 key값으로 해서 value를
저장하는데, key가 없다면 key를 생성하는 부분은 내부적으로 구현되서
감춰져 있다. 강사는 dictionary를 사용할 일이 있을때, defaultdic을
사용하는것도 좋지만 counter를 사용하면 더 깔끔하게 코딩할 수 있고
pythonic하다고 한다.


## Counter {#counter}


### 개요 {#개요}

Counter는 defaultdic과는 달리 세는데 최적화된 class라고
한다. defaultdict를 다시 한번 살펴보자.

```python
from collections import defaultdict

text = """Lorem ipsum dolor sit amet, consectetuer adipiscing elit.
Donec hendrerit tempor tellus.  Donec pretium posuere tellus.
Proin quam nisl, tincidunt et, mattis eget, convallis nec, purus.
Cum sociis natoque penatibus et magnis dis parturient montes,
nascetur ridiculus mus.  Nulla posuere.  Donec vitae dolor.  Nullam
tristique diam non turpis.  Cras placerat accumsan nulla.  Nullam
rutrum.  Nam vestibulum accumsan nisl."""

characters = defaultdict(int)
# characters = defaultdict(lambda: 0)
for char in text:
    characters[char] += 1

print(characters)
```

이것을 counter를 사용하면 다음과 같이 된다고 한다.

```python
from collections import Counter

text = """Lorem ipsum dolor sit amet, consectetuer adipiscing elit.
Donec hendrerit tempor tellus.  Donec pretium posuere tellus.
Proin quam nisl, tincidunt et, mattis eget, convallis nec, purus.
Cum sociis natoque penatibus et magnis dis parturient montes,
nascetur ridiculus mus.  Nulla posuere.  Donec vitae dolor.  Nullam
tristique diam non turpis.  Cras placerat accumsan nulla.  Nullam
rutrum.  Nam vestibulum accumsan nisl."""

characters = Counter(char for char in text)
print(characters)
```

Counter안의 표현법은 list comprehension과 비슷하다. 간단하게
counter의 기본 동작을 확인하는 code를 짜보자.

```python
from collections import Counter

print(Counter([1,2,1,2,3]))
```

Counter에 [1,2,1,2,3]이라는 list를 넣어주면, list의 item을
key값으로 하고, 해당 key의 occurs를 value로 하는 dictionary가
내부적으로 생성된것을 볼 수 있다. 즉 우리가 원래 하려고 했던 작업인
text로 부터 알파벳들이 몇번씩 occurs되는지를 Counter를 사용하면
매우 간단하게 할수 있겠다는 생각이 든다. 즉 list를 넣어주면
counting값을 갖는 dictionary를 자동으로 만들어주니까, 우리가 해야할
것은 text를 Counter에 넣어만 줘도 되는거 아닌가? 물론 text는
string이고 list가 아니라는 차이는 있다. 한번 해보자.

```python
from collections import Counter

text = """Lorem ipsum dolor sit amet, consectetuer adipiscing elit.
Donec hendrerit tempor tellus.  Donec pretium posuere tellus.
Proin quam nisl, tincidunt et, mattis eget, convallis nec, purus.
Cum sociis natoque penatibus et magnis dis parturient montes,
nascetur ridiculus mus.  Nulla posuere.  Donec vitae dolor.  Nullam
tristique diam non turpis.  Cras placerat accumsan nulla.  Nullam
rutrum.  Nam vestibulum accumsan nisl."""

print(Counter(text))
```

문제없이 된다. 그런데, 왜 강사는 string을 list comprehension을
사용해서 list로 만들었는지는 이해가 안간다. 다만, list
comprehension을 넣을수 있다. 이것을 알려주려 했을지도 모르겠다. 또다른 예를 보여준다.

```python
from collections import Counter

print(Counter(["test","test", "text"]))
```

여기서 궁금한점, string을 사용해서 단어를 세는 program을 Counter로
작성하는것이 가능할까? 하는것이다.


### counter에 대한 분석 {#counter에-대한-분석}


#### counter는 dictionary {#counter는-dictionary}

```python
from collections import Counter

c = Counter({"korean":2, "English":3})
print(c.keys())
print(c.values())
print(c["korean"])

print(list(c.elements()))

# d = {'a':3,'b':2}
# print(list(d.elements()))
```

Counter는 내부적으로 dictionary를 이용한다. 따라서 dictionary로
봐도 된다. 그리고 list만 인자로 넣는것이 아닌 dictionary를 인자로
넣어도 아무 문제 없다. list의 경우 내부적으로는 list를
counting해서 dictionary를 다시 만든다. dictionary는 그대로 가져다
쓴다. 여기서 특이한 method가 있다. elements라는
method이다. 일반적인 dictionary에는 존재하지 않는다. counting은
list를 dictionary형태로 바꿀때 counting value를 사용했다. 이를
elements()로 list로 변환할 때는 counting을 했던것을 다시
바꿔준다.


#### counter는 집합 연산 지원 {#counter는-집합-연산-지원}

```python
from collections import Counter

a = Counter([1,1,2,2,2,3])
b = Counter([2,3,3,4])

print("a =", a)
print("b =", b)
print('a+b =', a+b)
print('a&b =', a&b)
print('a|b =', a|b)
print('a-b =', a-b)

# a = {'a':3,'b':5}
# b = {'c':5, 'b':2}
# print(a+b)
```

-   a+b

    a와 b가 counter객체일때 두 객체의 합은 무엇일까?
    dictionary에선 +연산자를 지원하지 않는다. counter는 내부적으로
    key에대한 counter를 가지고 있기 때문에, key가 같다면,
    counter수를 증가시켜준다.

-   a&amp;b

    a&amp;b도 예측하기 어렵다. 우선 두 counter객체가 가진, key가 양
    객체에 모두 존재해야 한다. value에 해당하는 occurs는 작은값을
    가지게된다. 그게 공통적으로 갖게 되는 값이기 때문이다. 예를
    들어, a객체에 2:1, b객체에 2:4가 있다면, a&amp;b로 얻는 것은 2:1이
    된다.

-   a|b

    이것도 key와 value를 모두 따져야한다. key의 경우, a객체와
    b객체에서 한번이라도 나온것은 다 포함된다. value의 경우, 계산은
    하지 않는다. 둘중 큰값을 선택한다. 예를들어서, a객체에 2:1이
    있고, b객체에 2:3이 있다면 a|b로 얻는것은 2:3이다.

-   a - b

    이것은 a객체가 가진 item에서 b객체의 item을 빼준다. 여기서
    고려해야 하는것은 a객체에도 있고, b객체에도 있는
    item이다. b객체에만 있는것은 고려대상이 아니다. a객체에만
    있다면, -해야할 께 없기때문에 고려대상이 아니다. 즉 공통으로
    있는 item에서 계산이 일어난다. 예를 들어 a객체에 2:3이 있고,
    b객체에 2:1이 있다면, a-b에는 2:2가 들어가게 된다.


## Named Tuple {#named-tuple}


### 개요: named tuple이 나온 배경 {#개요-named-tuple이-나온-배경}

```python
class Coords3D:
    def __init__(self, x, y, z):
        self._x = x
        self._y = y
        self._z = z

    @property
    def x(self):
        return self._x

    @property
    def y(self):
        return self._y

    @property
    def z(self):
        return self._z
```

named tuple이란건 data만을 담기 위한 class라고 한다. 위의 예를
보면, class를 만들었다. 이 class에는 x,y,z값을 저장하고 별다른
method가 없다. 즉 하나의 instance는 하나의 3d 좌표값만을 갖는
class다. 한번 생성된 3d값은 수정은 안되고, @property를 통해서
각각의 값을 꺼내서 보거나, 사용할 수 는 있지만, 새 값을 넣는건
안된다. 아래 property를 사용하는 예다.

```text
coord = Coords3D(1,2,3)
print(coord.x)
print(coord.y)
print(coord.z)
```

이런 class를 만들 수도 있지, 난 대수롭지 않다고 생각한다. 그런데,
이런 간단한 구조인데 굳이 class를 만들 필요가 있냐?라는 사람들이
있다고 한다. 그사람들이 말하는 것은 data만 저장하는 값인데, 값을
꺼내기 위해서 @property를 사용한 getter함수를 모두 작성해야 하고,
같은형태의 많은 data값을 저장하는 것도 아니기 때문에 굳이 이렇게
만들어서 써야하느냐는 사람들이 있다. 그런 사람들은 3d좌표값을
나타낸다면, tuple을 사용하면 되지.라고 말한다.

```python
coords3d = (10,20,30)

print(coords3d[0])
print(coords3d[1])
print(coords3d[2])
```

위와 같이 tuple을 사용하면, class를 사용한 것과 별차이
없다. class를 사용했을때는 x,y,z와 같이 좌표값을 인식할 수 있는
변수를 사용했기때문에 coords.x, coords.y, coords.z 처럼 가독성은 더
좋지만, 기능은 별다른 점이 없기 때문이다.


### named tuple의 사용 {#named-tuple의-사용}

위의 tuple을 사용하면, index로 접근하기 때문에 가독성이
안좋았다. 이 단점을 없애기 위해서 named tuple이란 자료구조를
사용한다.

```python
from collections import namedtuple

Coords3D = namedtuple("Coords3D", ['x','y','z'])

point = Coords3D(10,20,z=30)
print(point.x)
print(point[1])
print(*point)

# point[1] += 1     error 발생
```

namedtuple은 이름이 암시하듯 tuple의 item에 이름 붙이기가
가능하다. 이것의 생성방식이 좀 특이한데, 다음을 보자.

```text
Coords3D = namedtuple("Coords3D", ['x','y','z'])
```

첫번째 인자로 type(class) 이름이 들어간다. 그리고 두번째 인자로
item의 이름이다. type이름이 들어간다는것은 우리가 class로
coords3d라는 class를 만들었듯이, namedtuple도 내부적으로 class를
만든다는 것을 의미한다. 이렇게 만들어진 type의 instance를 만들어사
사용한다. 이것의 장점은 여러종류의 tuple을 만들고, class 이름도
마음대로 정할수 있다는 것이다. 사용법을 살펴보자.

만들어진 Coord3D instance인 point는 name으로도 접근 가능하고
indexing으로도 가능하다. 한가지 특이한것은 point객체는 tuple이기
때문에 point라는 tuple이 가진 내용을 unpacking해서 보여줄 수 있다는
것이다.

```text
print(*point)
```

tuple은 immutable하기 때문에 값을 변경시키는 += 연산자는 에러를
발생한다.


### Dataclass의 사용 {#dataclass의-사용}


#### 개요 {#개요}

위에서 data만을 저장하는 경우가 있었다. 예를들면, 3d좌표값 같은
경우가 있었다. 3개의 좌표값을 갖는 data structure를 위해서,
처음에는 class를 만들었다. class를 사용하기엔 너무 거창해서, 그냥
tuple을 사용하려 했으나 가독성이 안좋아서 namedtuple을 배웠고 이를
사용할 수도 있었다. 근데 처음에 정의한 class처럼 비슷한 용도로
사용할 수 있는 dataclass라는게 있다고 한다.


#### 사용법 {#사용법}

```python
from dataclasses import dataclass

@dataclass
class Coords3D:
    x: float
    y: float
    z: float = 0

    def norm(self) -> float:
        return (self.x ** 2 + self.y ** 2 + self.z **2) ** .5

point = Coords3D(10,20,z=30)
print(point)
print(point.norm())
```

Data만을 저장하기 위해서 우리가 만들었던 class를 다시 한번 보자.

```python
class Coords3D:
    def __init__(self, x, y, z):
        self._x = x
        self._y = y
        self._z = z

    @property
    def x(self):
        return self._x

    @property
    def y(self):
        return self._y

    @property
    def z(self):
        return self._z
```

@dataclass라는게 class에 붙게되면, 형식이 좀 다르다. 일반적인
class를 작성할때는 __init__()도 정의해야 했고, 값을 꺼낼수 있도록
@property라는 decorator를 구현해야 했다. 그런데, @dataclass는 이
과정을 다 없앴다. 즉 class의 내부변수 x,y,z만 정의하면
된다. 나머지 instance.x, instance.y, instance.z로 해서 값을
접근하게 해주는 @property로 함수를 정의하는것은 해주지 않아도
된다. dataclass로 만들어진 instance는 instance를 출력할 수 있는
__str__()가 재정의되어 있는듯하다. 그래서 print()로 출력할때 나름
이쁘게 보여진다고 한다. 그런데 그냥 객체의 요소를 보여줄 뿐
예쁘다는 생각은 들지 않았다.

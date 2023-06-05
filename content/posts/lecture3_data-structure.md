+++
title = "lecture3 data structures"
author = ["holy"]
description = "python data structure에 관한 강의 요약"
date = 2023-06-05T00:00:00+09:00
draft = false
+++

## Data Structure {#data-structure}


### List {#list}


#### list의 특징 {#list의-특징}

-   대괄호로 만들어진다.
-   아무 type의 객체를 가리킬수 있다.
-   list가 con cell로 이루어져있고 car, cdr이 모두 pointer라서 어떤
    type의 객체를 가리키는건 너무 자연스럽다.
-   길이가 정해져 있지 않다.
    ```python
    seq = [12345,101, "Text", None, True]
    print(seq)
    ```


#### list index &amp; slicing {#list-index-and-slicing}

<!--list-separator-->

-  indexing

    -   index로 개별 원소를 접근한다. 이 부분이 좀 특이하다. lisp에서
        개별 원소에 접근할 때는, linked list이기 때문에 car과 cdr을
        사용해서 access했기 때문에, 마치 배열처럼 index로 접근한다는건
        좀 특이하다. 배열이 index로 접근할 수 있는건 각각의 원소가
        위치한 메모리 공간이 붙어있기 때문에, index로 해당 원소의 메모리
        공간을 지정할 수 있기 때문이다. 그런데, list는 그렇지가
        않다. index를 지정해도, index만큼 포인터를 이동해야만 하기
        때문이다. 예를 들어, list의 2번째 원소에 접근하는것은 car(car
        a)을 의미한다. 즉 a[2] =&gt; car(car a)를 변환될 듯하다.
    -   음수도 indexing이 가능하다.

<!--list-separator-->

-  slicing

    -   사용법: seq[start: end: step:]
    -   default값은 생략 가능하다. start: end: 가 0이거나, step:이 1인
        경우 생략 가능하다.
    -   example
        ```python
        seq=[1,2,3,4,5,6,7,8,9,10]
        print(seq[:3])
        print(seq[3:])
        print(seq[3:-1])
        print(seq[-3:-1])
        print(seq[::2])
        print(seq[9:2:-1])
        print(seq[9:2:1])
        ```
    -   seq[:3]은 index가 0,1,2를 의미한다. 3은 포함하지 않는다.
    -   seq[3:]은 index가 3,4,5...9까지를 의미한다.
    -   seq[3:-1]은 index가 3,4,5...8까지를 의미한다.
    -   seq[::2]는 step만 지정하는 것도 가능하다.
    -   seq[9:2:-1]는 9부터 시작해서 2로 간다. 9보다 작은것으로 갈려면
        step을 -값으로 해주어야 한다.
    -   seq[9:2:1]은 9부터 시작해서 2로 가는데, 1씩 더해서 간다. 이런
        경우, []를 얻는다.
    -   lisp의 list와는 다른 list원소 접근법이다. index로 접근하는것은
        직관적이긴 하다. function과 같이 쓰일때 강력한 성능을 보일지는
        모르겠다.

<!--list-separator-->

-  List operators

    -   append(+)
        ```python
        a = [1,2,3,4]
        b = [5,6,7,8]
        print(a + b)
        a = a + b
        print(a)
        ```

        -   list는 mutable객체라서 a = a + b를 해도 새로운 객체가 만들어지진 않을 듯하다.
    -   원소 값 바꾸기
        ```python
        a[0] = 'something'
        ```
    -   multiply(\*)

        -   list에 곱하기도 연산이 가능하다.

        <!--listend-->

        ```python
        a = [1,2,3,5]
        print(a * 2)
        ```
    -   in 연산자.
        ```python
        a = [1,2,3,4]
        print(3 in a)
        ```
    -   len(): 길이 구하는 operator
        ```python
        seq = [1,2,None, True]
        print(len(seq))
        ```
    -   append(): 원소를 추가한다. 뒤에 추가된다.
    -   extend(): list를 추가한다. 뒤에 추가된다.
    -   insert(index,value): index에 value를 추가한다.
    -   del: list의 element를 삭제한다. method나 operator형태가 아니다.
        ```python
        a = [1,2,3]
        del a[1]
        print(a)
        ```
    -   remove(value): list의 method. list의 특정 값을 삭제한다. 하나만
        삭제한다. 동일한 값이 또 있어도 삭제하지 않는다.
        ```python
        a = [1,"sth",23, "sth"]
        a.remove("sth")
        print(a)
        ```


#### python은 모든것이 object이고, 모든 function은 method다. {#python은-모든것이-object이고-모든-function은-method다-dot}

-   강사는 내장함수와 메소드를 나누어 설명한다. 또한 예약어를 말하기도 한다.
-   나는 내장함수도 method라고 생각한다. 그런데, fluent python이란
    책에서는 len은 method가 아니라고 한다. 예약어는 ()를 사용하지 않는다.
-   내장함수(built-in function)
    -   len()
    -   sum()
    -   range()
-   method
    -   .append()
    -   .insert()
-   예약어
    -   del
    -   assert
-   강사는 예약어, 내장함수, method, 내부 library, third-party의
    순서로 원하는 기능을 구현한 함수를 찾으라고 한다.


#### list의 time complexity {#list의-time-complexity}

<!--list-separator-->

-  big-Out 표기법

    -   big-O는 함수는 아니고, 표기법이 함수 형태일 뿐이다.
    -   나는 big-O의 O가 out(결과)를 나타낸다고 생각한다. 입력
        argument의 개수를 I로 표시하기로 했다.
    -   I(N) = O(1) : n개의 입력이 있다면, 1번의 computation이 일어날때
        이렇게 표기한다. 이 말은 무한의 데이터가 있어도, 1번만 혹은
        10번만 computation하면 된다는 말이다. 즉 input의 개수와 상관이
        없다. O에 N이 포함이 안되었다는건 관련이 없다는것이다. 무한대의
        입력이 있으나, 없으나 상관이 없다.
    -   I(N) = O(logN) : n개의 입력이 있다면, logN번의 computation이
        일어날때 이렇게 표기한다. ex) 16개의 입력이 있다면, 4번만 계산하면 된다.
    -   I(N) = O(N): n개의 입력이 있다면, n번의 computation이 일어난다.
    -   I(N) = O(NlogN): n개의 입력이 있다면, NlogN의 computation이 일어난다.
    -   I(N) = O(N^2): 보통 double loop
    -   I(N) = O(N^n):

<!--list-separator-->

-  list의 operator와 big-O 표현법

    -   index: l[i] =&gt; O(1)
        -   index는 list의 원소를 꺼낼때, O(1)이 걸린다. 즉 한번에
            데이터를 꺼낼수 있다는 말이다. linked list나 lisp을 사용하는
            입장에선 조금 이해가 안 갈 수가 있다. 100개의 item으로 구성된
            list에서 하나의 원소를 꺼낼때, list의 첫번째 원소가 원하는
            값이면 1번의 계산, 최악의 경우 마지막 원소와 일치한다면
            100번의 이동이 필요하다. 따라서 O(N)을 예상한다. 그런데
            python에선 O(1), 마치 array와 같은 속도를 보인다고 하니까
            놀랠 수 밖에 없다. array가 O(1)의 속도를 갖는 것은 address와
            index를 더해서 특정 메모리공간을 지정할 수 있기 때문이다. 즉
            한번의 덧셈만 하면 된다. 그런데 linked list에서는 그렇지
            않다. 매번 list item을 거쳐가야 한다. 어떻게 O(1)이
            나오는지는 모르겠다. python에서 list는 동적배열(dynamic
            array)라서 가능하다고 하는데, 아직 설명이 없다.
        -   참고로 list operator의 입력으로는 list가 들어간다고 생각하면 된다.
    -   store: l[i] =&gt; O(1)
        -   store도 array처럼 현재 address + index로 특정 메모리 공간을
            한번에 지정이 가능하기 때문에 O(1)이다.
    -   len: len(i) =&gt; O(1)
        -   왜 length가 O(1)인지 모르겠음.
    -   append: l.append(5) =&gt; O(1)
        -   append는 list의 마지막에 추가하는것이기 때문에 list객체가
            1000개의 item이 있던, 10000개가 있던간에 O(1)이 될 것이다.
    -   pop: l.pop(n) =&gt; O(1)
        -   pop 함수는 n번째 요소를 제거한다. 그리고 꺼낸 요소를
            반환한다. array라면, index와 address를 사용해서 item의 위치를
            지정할 수 있기 때문에 한번의 연산으로 해결될 수 있을껄로
            보인다.
    -   clear: l.clear() =&gt; O(1)
        -   list의 clear()는 모든 요소가 제거된다. 그런데 왜 O(1)이
            걸릴까? list 객체가 가진 value에 list가 pointer로 연결되어
            있다면 그 Value값을 0로 만들면 되는 것이기 때문이지 않을까?
    -   insert: l.insert(n,v) =&gt; O(N)
        -   list의 특정 index에 특정값을 입력하는것은 최선의 경우는
            마지막원소 끝에 insert하면 하나의 list cell을 추가 하기
            때문에 1번의 계산이면 된다. 최악의 경우, 첫번째 item에
            삽입하면, 그 뒤의 요소들을 하나씩 뒤로 이동 시켜야 하기
            때문에 O(N)이 된다.
    -   delete: l.delete(n) =&gt; O(N)
        -   delete도 list의 특정 item을 삭제하고, list의 item별로 위치
            재조정을 하기 때문에 O(N)이 걸린다.
    -   remove: l.remove(value) =&gt; O(N)
        -   remove함수는 value를 list에서 찾아서 삭제한다. 최악의 경우
            list 마지막 item에 원하는것이 있을 수 있다. 이 경우
            마지막까지 원소를 비교해야 하기 때문에 O(N)이 걸릴 수 있다.


#### 동적 배열에 대해서 {#동적-배열에-대해서}

-   list를 array로 만든다. linked list가 아닌, array다. array가 가진
    특징인 fixed된 array와 다르게 dynamic array는 특정길이의 array가
    할당되지만 할당된 크기를 넘어가면 자동으로 array가 늘어나는
    방식이다. 이것은 lisp의 vector와 비슷할 것이라고 생각된다.


### Tuple {#tuple}


#### tuple의 특징 {#tuple의-특징}

-   tuple의 모양: ()를 사용한다. ,로 사용해도 된다.
    ```python
    t = (1,2,3,4)
    t = 1,2,3,4
    print(t)
    ```
-   tuple은 immutable하다.
    -   assign이 불가능하다.
        ```python
        t = (1,2,3,4)
        # t[3] = 8 ;; 실행되지 않는다. immutable하기 때문이다. immutable은 update가 안된다.
        ```

    -   assign이 가능할 수도 있다.
        ```python
        t = (1,2,[5,6,7])
        t[2].append(8)
        print(t)
        ```

-   함수 return값으로 사용된다. 아래와 같이 여러 값을 return할 수 있다.
    ```python
    return 1,2,3
    ```
-   하나의 요소를 가진 tuple
    ```python
    t = (1)  # tuple이 아니다. int다.
    print( type(t))
    t =  (1,)   # tuple이다.
    print(type(t))
    ```
-   string은 immutable하다는 면에서 tuple로 봐도 된다.


#### packing과 unpacking {#packing과-unpacking}

-   packing: 여러 데이터를 묶기, unpacking: 여러 데이터를 풀기
    ```python
    t = 1,2,3,4,5   ;; packing
    a,b,c,d,e =t    ;; unpacking
    print(d)
    ```

-   unpacking의 관습: \_를 사용해서 필요없는값은 사용하지 않는다.
    ```python
    t = "holy",1,2,3
    name,_,_,_ = t
    print(name)
    ```

-   unpacking과 packing은 list에서도 가능하다.
    ```python
    t = ["holy",1,2,3]
    name,_,_,_ = t
    print(name)
    ```

-   특이한 unpacking: \*를 사용해서 나머지 해당 요소들을 list로 묶는다.
    ```python
    t = [1,2,3,4,5]
    a, *b, c =t
    print(a,b,c)
    ```


### dictionary {#dictionary}


#### dictionary의 특징 {#dictionary의-특징}

-   {}을 사용한다.
-   dictionary는 사전형태다. 즉 key를 사용해서 빠르게 찾는게
    가능하다.
-   dictionary는 mutable하다.
-   요소는 key: value로 되어있다.
-   key는 immutable하다.
    ```text
    {key1: value1, key2:value2, key3:value3}
    ```
-   example
    ```python
    dictionary = {
        1: 'something',
        (1,2.5): 1.5,
        'text': 2,
        }
    print(dictionary[1,2.5])
    ```

    -   위의 예에서 (1,2.5)라는 key가 있고, 이 key값에 접근할 때,
        dictionary[1,2.5]라는 표기를 눈여겨 볼 필요가 있다. 왜냐하면,
        key가 tuple이기 때문에 ()없이 사용할 수 있다.

    -   만일 a[1,2,3], dict[a,[1,2],3:5] 이런식의 표현법을 보면 key가
        tuple이라고 생각하면 된다.

-   comma(,)에 대해서
    -   dictionary를 만들때나 list, tuple의 마지막 원소 다음에 ,를
        입력해도 아무 문제 없다.


#### dictionary 기본 동작 {#dictionary-기본-동작}

-   dictionary의 생성
    ```python
    dictionary = {}
    ```
-   dictionary의 삽입
    ```python
    dictionary = {}
    dictionary['text'] = 1
    dictionary['list'] = [5,6,7]
    print(dictionary)
    ```
-   동일한 key값을 갖는 item은 생성 불가능, overwrite된다.
    ```python
    dictionary = {}
    dictionary['key'] = 'value'
    dictionary['key'] = 'updated value'
    print(dictionary)
    ```
-   dictionary item제거: del을 사용한다.
    ```python
    dictionary = {}
    dictionary['key1'] = 'value1'
    dictionary['key2'] = 'value2'
    del dictionary['key2']
    print(dictionary)
    ```
-   len으로 크기 확인
    ```python
    len(dictionary)
    ```
-   dictionary의 변환

    -   dictionary을 list로 변환할 수 있다. 이 때 items()라는 method를
        사용한다.
    -   key와 value는 tuple형태로 list의 item으로 들어가게 된다.

    <!--listend-->

    ```python
    dictionary = { "한국어": 0 , "영어":1, "중국어":2}
    print(dictionary.items())
    ```

    -   key만 list로 만들 수 있다. 이 때 keys()라는 method를 사용한다.
        ```python
        dictionary = { "한국어": 0 , "영어":1, "중국어":2}
        print(dictionary.keys())
        ```

    -   value로만 list를 만들 수 있다.
        ```python
        dictionary = { "한국어": 0 , "영어":1, "중국어":2}
        print(dictionary.values())
        ```

    -   in을 사용하는 경우
        -   어떤 collection의 특정 요소가 있는지 없는지 확인할때나,
            loop를 돌릴때 in keyword를 사용한다. dictionary와 in과는
            어떤 관계가 있을까? in의 뒤에는 보통 list가 있어야
            한다. in뒤에 dictionary를 직접 사용하지는 않는다. 따라서
            dictionary를 list형태로 바꿔야 한다. 그래서 keys(),
            values(), items()라는 메소드가 존재하는 것이다. dictionary를
            list로 변환후 in을 사용해서 특정값의 존재 여부를 확인할 수
            있다. 여기서 2가지를 더 말하고 싶다. 첫번째로
            dictionary라는게 어차피 key를 통해서 값을 꺼내면 되는건데,
            굳이 in을 써서 값을 확인하기 위해 list로 변환해야 하는가?
            하는 의문이 들수 있다. key를 알고 있다면, 별문제 없지만,
            key를 잘못썼거나, key를 모를때는 dictionary에서 key list를
            뽑아서 in을 사용해서 check하는것은 그리 나빠보이지
            않는다. 두번째로 in이라는건 이렇게 있는지 없는지 여부의 기본
            기능보다 for-loop에서 많이 쓰인다. dictionary를 for-loop에서
            사용한다고 했을때, in을 사용한다. 따라서 dictionary를
            list형태로 바꿀 필요가 있다. 즉 dictionary와 in을 같이
            사용한다는 것은 list로 변환해서 사용한다는 것을 의미한다.

<!--listend-->

```python
dictionary = { "한국어": 0 , "영어":1, "중국어":2}
print("한국어" in dictionary.keys())
```


#### dictionary의 time complexity {#dictionary의-time-complexity}

-   dictionary는 key마다 index값이 있다. index가 있다는 말은
    address로 접근 한다는 뜻이다. 따라서 value에 접근하는 time
    complexity는 O(1)이다. 이것을 hash구조라고 한다.
-   index: d[k] =&gt; O(1)
    -   key로 값을 가져오는것은 dictionary의 크기가 엄청 커도 1번의
        computation으로 가능하다.
-   store: d[k] = v =&gt; O(1)
-   length: len[d] =&gt; O(1)
-   delete: del d[k] =&gt; O(1)
-   clear: d.clear =&gt; O(1)
    -   d = {} or d= dict()와 같다.


### Set {#set}


#### set 개념 {#set-개념}

-   dictionary의 key만 모여 있는 형태.
-   set을 만들때, list를 사용한다.
    ```python
    s = set([1,2,3,'text'])
    print(s)
    ```
-   set에 원소 추가
    ```python
    s = set([1,2,3])
    s.add(4)
    print(s)
    ```
-   set 원소 삭제(remove)

    -   set 원소에 해당하는 값이 있다면 삭제 없다면 error가 생긴다.

    <!--listend-->

    ```python
    s = set([1,2,3])
    s.remove(2)
    print(s)
    ```
-   set 원소 삭제(discard)

    -   remove는 값이 없다면 error가 생긴다. discard는 에러가 생기지 않는다.

    <!--listend-->

    ```python
    s = set([1,2,3])
    s.discard(44)
    print(s)
    ```
-   update 메소드
    ```python
    s = set([1,2,3])
    s.update([5,None, True, False, 33])
    print(s)
    ```


#### set operator {#set-operator}

-   수학적 집합 연산자 존재.
-   교집합(&amp;)
    ```python
    s1 = set([1,2,3,4])
    s2 = set([3,4,5,6])
    print(s1 & s2)
    ```

-   합집합(|)
    ```python
    s1 = set([1,2,3,4])
    s2 = set([3,4,5,6])
    print(s1 | s2)
    ```

-   차집합(-)
    ```python
    s1 = set([1,2,3,4])
    s2 = set([3,4,5,6])
    print(s1 - s2)
    ```

-   배타적 합집합(^)
    ```python
    s1 = set([1,2,3,4])
    s2 = set([3,4,5,6])
    print(s1 ^ s2)
    ```

-   frozen set( immutable)
    -   set은 mutable하다. 반면 frozen set은 immutable하기 때문에
        dictionary key값으로 사용할 수 있다.
        ```python
        a = frozenset([1,2,3])
        d = {a:3}
        print(d)
        ```

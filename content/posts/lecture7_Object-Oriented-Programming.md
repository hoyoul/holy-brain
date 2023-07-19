+++
title = "lecture7_Object-Oriented-Programming"
author = ["holy"]
description = "python의 oop에 대해서."
date = 2023-06-05T00:00:00+09:00
draft = false
+++

## OOP programming {#oop-programming}


### class 기본 {#class-기본}


#### class 선언 예시 {#class-선언-예시}

-   example
    ```python
    class Courier(object):    # (object)는 생략가능
        NATIONALITY = 'KOR'   # 클래스 속성

        def __init__(self, name: str, address: str):  # 생성자
           self.name = name       # attribute 초기화
           self.address = address
           elf.parcels = []

           def assign(self, parcel: str) -> None:
              self.parcels.append(parcel)

           def deliver(self) -> None:
              for parcel in self.parcels:
                   print(parcel, "배달중")

    ```

    -   class 특징들
        -   class이름은 대문자.
        -   상속은()를 사용한다.
        -   class attribute는 전역적으로 선언
        -   class의 member attribtue는 init에서 self로 초기화.


#### class 생성 {#class-생성}

-   example
    ```python
    class Courier(object):    # (object)는 생략가능
        NATIONALITY = 'KOR'   # 클래스 속성

        def __init__(self, name: str, address: str):  # 생성자
           self.name = name       # attribute 초기화
           self.address = address
           self.parcels = []

        def assign(self, parcel: str) -> None:
            self.parcels.append(parcel)

        def deliver(self) -> None:
            for parcel in self.parcels:
                print(parcel, "배달중")

    courier1 = Courier("김기사","경기도 성남시 정자동")
    print(courier1.name, "-", courier1.address, "근무중")
    courier1.assign("편지")
    courier1.deliver()
    ```


#### class declaration {#class-declaration}

```text
class Courier(Object):
```

-   class 이름은 CamelCase가 관습적으로 사용된다.
-   부모 class가 지정되지 않으면, object가 자동 상속된다. 그런데 object는 class가 아니라 객체라는것도 유의해야 한다.
-   모든 class는 object객체를 상속한다. Object class가 아니다.
-   object객체에 있는 method를 built-in function이라고 부른다.


#### class Attribute {#class-attribute}

```text
class Courier(Object):
   Nationality = 'KOR'
```

속성은 2가지가 종류가 있다. class attribute와 member
attribute. 둘다 객체가 갖는 속성이다. 하지만 여러 모로
다르다.

1.  우선 의미가 다르다. 붕어빵틀로 붕어빵을 찍어낼때, 붕어빵의
    내용물은 붕어빵 객체마다 다를수 있다. 하지만, 붕어빵의 크기에
    대한 속성은 모든 붕어빵 객체가 동일한 값을 갖는다.
2.  생성하는 순서와 방식이 다르다. class를 python interpreter가
    읽으면서 class객체를 만든다. 그때, class 객체의 attribute는
    객체의 한 요소로 값이 만들어진다. 반면에 member attribute는
    객체가 생성될때 init이라는 생성자에서 local하게
    생성된다. python interpreter가 class로 쓰여진 부분을 읽어서
    만들어지는 class객체에는 class변수에 해당하는 pointer와
    function들에 대한 pointer들이 있을 뿐이다. python
    interpreter가 객체선언을 읽으면 그때 객체를 만들게 되는데,
    그때는 init이라는 생성자를 호출 시켜서 member attribute를
    생성하게 된다.
    1.  접근하는 방식이 다르다. class attribute는 class 자체 객체에
        포함된 속성이라서 아래와 같이 사용한다. 반면에 member
        attribute는 객체를 만든 후에야 생성자에 의해
        만들어진다. 그리고 그 이후에 객체.attribute로 사용될 수 있다.
        ```text
        print Courier.Nationality
        ```


#### class의 function들. {#class의-function들-dot}

class 내부에 있는 함수들이 있다. 이 함수들은 method라고 부른다. 이
method는 내부에 self라는 argument들을 가지고 있다. 이 self라는것은
객체를 의미한다. 예를들어서, python interpreter가 아래에서 보듯이
class Holy를 읽게 되면, Holy라는 이름의 class객체를 생성하고
method를 등록한다. Holy class 자체에서 method를 호출하려면, 첫번째
인자가 self라는 객체를 요구받는다. class자체객체를 전달할 순
없다. 즉 method를 사용하려면, 아래처럼 Holy class로부터
tempholy같은 객체를 만든다. 만들어진 객체에는 method들이 등록되어
있지는 않다. 객체에서 method를 호출하는것은 class객체에 등록된
method를 호출하는것이고, 그래서 첫번째 인자는 self로 되어 있는
것이다. self에는 tempholy가 인자로 들어가서 수행하는
것이다. tempholy객체에는 자신의 class에 대한 포인터가 등록되어
있기 때문에 class에 정의된 method들을 호출 할 수 있다. 다시
말하면, class는 class멤버변수와 method의 껍데기만 가진채로 생성이
되고, 객체가 만들어지면, 그 객체에는 class pointer가 있기 때문에,
class의 class attribute와 method를 수행할 수 있는 것이다. class의
method를 수행하는 방식은 2가지가 있다. 하나는 class자체 객체에서
호출하는 것이다.

```python
class Holy(object):
    class_var = "temp"
    def __init__(self, name: str):
        self.name = name
        print("constructor")

    def assign(self, newname:str) -> None:
        self.name = newname
        print(self.name,"assign method")

print(Holy.class_var)
tempholy = Holy("holy")
print(tempholy.assign("park"))
print(Holy.assign(tempholy,"lee"))
```


#### 생성자(객체 속성) {#생성자--객체-속성}

객체를 생성할때 __init__()가 호출된다. __init__()는 class에
정의되어 있다. python에서 객체를 생성할 때는 무조건 =(asignment)를
사용한다. 이때 생성자의 모양에 따라 argument를 넣어 주어
생성한다.

```text
courier1 = Courier("김기사", "경기도 성남시")
```

= 은 rvalue와 lvalue를 입력으로 받는다. rvalue의 type인 Courier가
courier1 객체에 들어가고, Courier의 method인 __init__()가
호출된다. 인자로는 "김기사","성남시"가 stack에 저장되고, Courier의
__init__()의 argument들은 function의 local변수이기 때문에 stack의
값으로 초기화된다. __init__함수에 보면, self는 courier1이 전달
되기 때문에, __init__()에 보면, self.name과 같은 식으로 객체를
만드는게 보인다. 이것은 courier1이라는 객체내에서 value값으로
만들어 지는 것이다. 따라서 courier1에서는 접근할수 있다. 그런데,
특이한게 있다. value는 생성자에 있는 member 변수가
아니다. java에서는 member변수가 아니라면, 객체에서 아래처럼
마음대로 member객체를 만들수가 없다. 그런데 python은 객체에서
member변수? member객체를 생성해서 사용할 수 있다.

```text
courier1.value = 10
```

<!--list-separator-->

-  magic method: 생성자 initializer

    dunder method를 magic method라고 부르기도 한다. 즉 __로 시작하고
    __로 끝나는 method를 뜻한다. init method도 dunder
    method다. 위에서도 이 init method에 대한 설명을 했는데, init
    method는 객체가 생성될때 호출된다. 예를 들면,

    ```text
    courier1 = Courier("김기사", "경기도 성남시")
    ```

    여기서 Courier class객체는 이미 만들어져 있다. class로 정의하면
    생성이 되기 때문이다. 즉 이미 만들어진 type객체인 Courier의
    init()를 호출하는 것으로 보면 된다. courier1은 인자로 전달되어
    self로 assign되게 된다.

<!--list-separator-->

-  magic method: 소멸자

    ```text
    class Courier(object):
       def __del__(self):
         self.parcels.clear()
    ```

    객체가 소멸할 때 호출된다고 한다. python에선 GC(Garbage
    Collection)을 가지고 있는데, 주기적으로 참조 되지 않는 객체를
    삭제한다고 한다.


### 객체지향의 3요소와 특성들 {#객체지향의-3요소와-특성들}


#### 상속 inheritance {#상속-inheritance}

```text
class Courier(object):
```

object는 부모 class, Courier는 자식 class가 된다.


#### 다형성 polymorphism {#다형성-polymorphism}

같은 이름의 method를 다르게 작성. 다중 상속이 가능하다고
한다. 그리고 super를 통해서 상위 class에 대한 접근이
가능하다. 이것이 polymorphism과 큰 관련이 있는지는
모르겠다. super를 사용하는 예제를 보여준다.

```python
class Courier:
    def __init__(self, name:str):
        print(self)
        self.name = name
        print("courier 생성자")
        self.address = "부산"
        self.parcels = []

    def assign(self, parcel: str) -> None:
        self.parcels.append(parcel)

    def deliver(self) -> None:
        for parcel in self.parcels:
            print(parcel, "super 배달중 -", self.address)

class JejuCourier(Courier):
    def __init__(self, name: str, ticket: int):
        print("생성자juju")
        # super().__init__(name)
        super(name)
        self.ticket = ticket

    def deliver(self) -> None:
        print(self.ticket, "티켓으로 제주도 이동")
        super().deliver()

# courier = JejuCourier("김기사", 15)
JejuCourier("김기사", 15)
# courier.assign("편지")
# courier.deliver()
# super(JejuCourier, courier).deliver()
```

python은 모든 게 객체이기 때문에, class도 객체다. 그리고,
class로부터 만들어지는 instance도 객체다. 각각의 객체엔 type(<span class="underline"><span class="underline">class</span></span>)이란
항목이 있다. type(<span class="underline"><span class="underline">class</span></span>)이란 항목엔 instance를 만든 class 객체를 가리키고
있다. 예를 들어서, A라는 class가 있고, a라는 instance가 있다면, A
class도 객체가 있고, a도 객체 인 것이다. 객체인 A class와 a에는
객체이기 때문에 type(<span class="underline"><span class="underline">class</span></span>)이란 항목이 존재한다. a객체의 type(<span class="underline"><span class="underline">class</span></span>)에는 A
class객체를 가리킨다. 그러면 A class객체의 type(<span class="underline"><span class="underline">class</span></span>)이란 항목은 무엇을
가리키고 있을까? A class 그자체도 객체이기 때문에,
class의 부모 class를 type(<span class="underline"><span class="underline">class</span></span>)으로 가리키고 있을 것이다.

위에서 type에 대해 설명한 것은 super()를 설명하기 위함이다. 우선
super는 내부적으로는 class로 정의되어 있다. __init__()만 가지고
있는 class다. super()는 type의 class의 __init__()를 호출하여
객체를 만든다. 소스를 보면서 설명해보자.

python interpreter는 Courier, JejuCourier라는 class 정의를 보고,
class 객체를 만든다. class 객체엔 name이란 항목, type이란 항목,
value라는 항목이 설정된다. name에는 class의 이름이 들어가고,
type에는 Courier의 경우는 object, JejuCourier에는 Courier가
들어간다. value에는 body부분이 들어가게 된다. class객체를 만들때,
body부분은 실행하지 않는다. 즉 body에선 수많은 객체 생성을 할텐데,
class객체는 body 전체만 가리키는 포인터만 가질뿐이다. class객체로
부터 instance객체를 만들고 instance 객체에서 body부분을 실행할 때
처리되는 것이다.

python interpreter는 아래를 읽고 실행한다.

```text
courier = JejuCourier("김기사", 15)
```

= 은 객체를 만드는 명령어다. 객체를 만들고, name은 courier로
지정하고. type은 JejuCourier로 한느 객체를 만든다. 그리고
JejuCourier라는 class객체의 __init__함수를 호출한다. 인자는 지금
만든 courier객체, "김기사", 15값을 stack 넣어
전달한다. courier라는 객체는 단순하다. 왜냐면, courier객체는
JejuCourier를 type으로 갖기 때문에 JejuCourier의 method를 그대로
상속해서 사용한다. type이라는 것은 부모 class로 보면 되기
때문이다.

[JejuCourier의 __init__함수]

```text
def __init__(self, name: str, ticket: int):
   print("생성자juju")
   super()
   super().__init__(name)
   self.ticket = ticket
```

print문을 출력하고, super()라는 부분이 나온다. self는
courier라는 객체를 나타낸다면, super()는 현재 수행되는
class객체인 JejuCourier객체의 type, 즉 부모 class를 생성하는
것이다. 부모 class의 __init__을 호출해서 부모의 class의
instance객체를 만든다. 물론 그전에 부모 class객체는 만들어져
있는 상황이다. 예를 들어, JejuCourier()를 호출한다면,
JejuCourier class객체는 이미 만들어져 있고, JejuCourier
class객체의 __init__()를 호출해서 instance객체를 name없이
만드는것과 같다. 즉 저기서 super()는 부모인 Courier의
__init__메소드를 호출해서 instance객체를 만드는 것이다. 그런데
super()를 실행하면, Courier의 __init__()이 일치하는게
없다. Courier의 __init__(self, name:str)의 형태이기 때문에,
부모인 object의 __init__()가 호출될 것이다. Courier의
__init__(self, name :str)을 호출하기 위해서는 명시적으로
호출해야 한다. 즉, super().\__init__(name)으로 호출해야
한다. 그런데 여기서 질문, Courier의 init메소드의 인자 self는
무엇으로 초기화 되는가? 그리고 만일 super(name)으로 Courier의
__init__을 호출 할 수 있는가? 어떻게 self가 초기화 되는가?
자식객체가 type의 method를 호출할때는 자기자신이 인자로
전달된다. 그러면 super(name)도, super().\__init__(name)이
수행되듯이 수행되어야 할 것이다. 그런데 수행되지 않는다. 이것은
정말 이상한데, super라는게 부모 class를 가리키고, super()를 하면
instance를 만들고 인자 없는 __init__()을 호출하는
과정이다. super(name)하면, 부모 class에대한 instance를 만들고,
__init__(self, name:str)을 호출해야 맞는데 호출 되지
않는다. super()는 Courier()를 실행하고, 그다음 __init__()를
호출하는건, JejuCourier()를 실행했을 때, JejuCourier instance를
만든후 __init__메소드를 수행하는것과 동일한데, 이상하게 안된다.

그리고, 맨 마지막의 실행문을 보자.

```text
super(JejuCourier, courier).deliver()
```

이것은 어떻게 해석 할 것인가? 이전의 super()는 특정 객체의
method에 있었다. 즉 특정 객체의 method가 호출되어 실행되기
때문에 그 context에서는 super가 가르키는게 특정 class객체임을
알 수 있었다. 하지만, 여기서 super는 어떤 class객체를
가리키는가? 이게 module하고 관련있는것 같다. 즉 class내가 아닌
밖에서 사용되는 function도 module하고 어떤 관계가 있어
보인다.여기서는 별 다른 설명이 없다.


#### overloading과 overriding {#overloading과-overriding}

overloading과 overriding은 모두 부모와 같은 이름의 함수를
뜻한다. overloading은 argument가 다른 함수다. 즉 다른 함수라고
봐도 된다. 하지만, overriding은 동일한 함수를 재정의
하는것이다. 단어만 보면 overwrite하고 비슷하다. 위 코드에서 보면,
deliver는 overriding한것이고 __init__은 overloading한 함수다.


#### static &amp; class method {#static-and-class-method}

우선 예제를 보자.

```python
class Number:
    Constant = 10

    @staticmethod
    def static_factory():
        obj = Number()
        obj.value = Number.Constant
        return obj

    @classmethod
    def class_factory(cls):
        obj = cls()
        obj.value = cls.Constant
        return obj

number_static = Number.static_factory()
number_class = Number.class_factory()
print(number_static.value, number_class.value)

```

staticmethod와 classmethod는 이름만 봐선, 우선 class method는
class객체에 포함되는 method고, static method는 일종의 전역함수로
봐도 되지 않을까? 일반 method는 self라는 argument가
있었다. 하지만, class method와 static method에는 self가 있을
필요가 없다.

사용방법을 보면, 둘다 다음과 같이 호출한다.

```text
number_static = Number.static_factory()
number_class = Number.class_factory()
```

static method는 선언만 class안에 선언되었을 뿐이지, 밖에
선언되어도 상관없을 method다. 하지만, python에선 모든것은 객체고
method이기 때문에 안에서 선언되고 접근만 가능할 뿐이여서 class에
포함된 method라고 보기 힘들다. 여튼 코드 해석을 해보자.

python interpreter는 Number라는 class를 읽고 Number class객체를
만든다. 그리고 다음 code를 실행한다.

```text
number_static = Number.static_factory()
```

= 은 객체를 만든다. number_static이란 name을 갖고,
Number.static_factory()함수를 호출 결과의 type과 value를 가질
것이다. static_factory()는 외부 함수로 봐도 된다. 여튼 여기서는
Number의 instance를 만들어서, return한다. 따라서 Number라는
type이 지정되는 객체가 만들어진다.

두번 째로, 다음 코드를 보자.

```text
number_class = Number.class_factory()
```

여기서는 Number의 instance를 만들지는 않는다. 제일 처음에 python
interpreter가 Number라는 class객체를 만들었기 때문에, Number
class객체의 class method인 class_factory()를 접근한다.

```text
@classmethod
def class_factory(cls):
   obj = cls()
   obj.value = cls.Constant
   return obj
```

여기서 눈여겨 봐야 할것은 cls이다. 우리가 객체를 생성해서
객체에서 method를 호출할 때는 객체.method() 형태로 method를
호출한다. 이 때, method는 class객체에 있기 때문에, 객체가 인자로
넘어가서 실행된다. 근데 여기서는 class method는 class에 정의되어
있다. 그리고 class객체 자기자신이 인자로 넘어간다는게 좀
다르다. cls는 Number class객체의 이름이 넘어간다. 그리고 그
이름으로 Number instance를 만들어서 return하는 구조다.

위의 두 함수 모두, class의 instance를 만들고, instance의
method를 호출하는 방식과는 다르다. instance는 내부적으로
만들어져 return 하는 형태다. factory design pattern을 사용하기
때문이다.

또 한가지 static method와 class method 모두 decoration을
사용하고 class객체에서 호출 가능하다는 공통점이 있지만, 둘
사이의 커다란 차이점은, class method는 상속이 되지만, static
method는 상속이 되지 않는다는 것이다.


#### Abstraction (visiblity) {#abstraction--visiblity}

Abstraction으로 알고 있던 용어를 여기서는 visiblity라고
부른다. 다른 class에서 객체 내부 요소를 감추는 캡슐화 작업이라고
한다. java에서 private이나 protected로 설정했던거라고 보면
된다. 즉 내가 김기사라는 instance를 만들었을때, instance라고 해서
자신의 member attribute를 다 접근할 수 없게 만들었다. class에서
정의된 방식으로만 접근할 수 있게 할 수 있는데, 예를들면, set과
get이라는 method에서만 직접적 처리가 가능하게 했다. instance는 이
method를 호출해서 해당 변수에 접근이 가능하다. 이것을
capsule화라고 한다. java에서는 private과 protected라는 keyword로
제공했지만, python에서는 private이나 protected라는 keyword는
없다고 한다. 다만, __로 시작하면 private이라고 하고, \_라고 하면
protected라고 일종의 규약처럼 사용되는데, 문법적 요소는 없다고 한다.

예를 들어 보자.

```python
class TestClass(object):
    def __init__(self):
        self.attr = 1
        self._attr = 2
        self.__attr =3

instance = TestClass()
print(dir(instance))
print(instance.attr)
print(instance._attr)
# print(instance.__attr)
```

dir은 instance가 가진 모든 attribute를 보여준다고 한다. 여기보면,
\_attr과 attr은 보이지만, __attr은 보이지 않는다. 강사는 mangling이
적용되었다고 말한다. mangling은 __가 앞에 붙어 있으면 이름이
\_TestClass\__attr로 변경된다. mangling이 되면, 객체에서 직접적으로
접근할 수 없게 된다. 즉, private한 효과가 있다. 위에서 직접 접근을
시도했지만, 에러가 발생되는 것을 볼 수 있다. 굳이 접근할려고 하면,
instance._TestClass__attr로 접근할 수 있다. mangling된 이름으로
접근하면 된다. protected는 별다른 처리를 하진 않는다. 여기서 __로
시작하는것을 dunder method나 magic method로 보면 안된다. dunder
method는 __로 시작하고 __로 끝날때만을 의미한다. __는
attribute와 function에 적용되고 mangling하는 특징을 갖는다.


#### abstraction (visibility2) {#abstraction--visibility2}

java같은 oop언어에서는 private을 사용하고, setter, getter 메소드를
정의해서 사용하는 경우가 많다. python에서는 명시적인 private과
protected keyword를 제공하지 않는다고 했다. 어떻게 보면,
python에서는 기존의 oop언어가 member variable을 private으로
감추고, setter와 getter를 사용하는것이 쓸모 없다고 생각했을 수도
있다. 그래서 그냥 member variable에 값을 넣고 꺼내면 되지 않냐?
이런식의 주장을 하는 것 같기도 한다. 그렇지만, 직접적으로 그렇게
사용하진 않는다. python도 java처럼 setter와 getter를
사용한다. 하지만, 마치 직접 변수를 접근하는 것처럼 눈속임을
한다. 이때 사용되는게 @property와 @name.setter를 사용한다. 이것을
사용하면, python이 원래 의도했던, 마치 instance에서 setter
getter라는 method도움없이 직접 입력하는 것과 같은 착시효과를 준다.

예를 들어보자.

```python
class Circle(object):
    PI = 3.141592
    def __init__(self, radius=3.):
        self.radius = radius

    def get_area(self):
        return Circle.PI * self.radius ** 2

    def set_area(self, value):
        self.radius = (value / Circle.PI) ** .5

circle = Circle(5.)
print(circle.get_area())
circle.set_area(10)

print(circle.radius)
```

위에는 일반적으로 coding할 때의 예다. radius라는 attribute가 있고,
get_area, set_area함수에서 해당 radius에 접근해서 area계산값을
return한다. 그리고 instance에서 radius값을 직접 출력해 보기도
한다. 만일 radius가 private하다면, 아래의

```text
print(circle.radius)
```

는 수행 될 수 없다. get함수를 써야, OOP의 개념을 살린
coding이라고 말할 수 있을것이다. 그런데 python에는 애초부터
private한 keyword가 없기 때문에 굳이 get함수를 사용할 필요는
없다. 다만 oop형태로 set과 get method를 만들지만, 직접 사용하는
것처럼 만들 수 있다. 아래의 예를 보자.

```python
class Circle(object):
    PI = 3.141592
    def __init__(self, radius = 3.):
        self.radius = radius
    @property
    def area(self):
        return Circle.PI * self.radius **2

    @area.setter
    def area(self,value):
        self.radius = (value /Circle.PI) ** .5

circle = Circle(5.)
print(circle.area)
circle.area = 10.
print(circle.radius)
```

여기에서 보면, @property와 @name.setter라는 decorator가
추가되었다. 이것은 setter, getter method를 마치 변수처럼
만들어준다. @property를 해주면, method가 변수처럼 되어
버린다. 위의 예에서는 마치 getter럼 정의된 area란 method에
@property가 있다. 따라서 아래와 같이 출력이 가능하다.

```text
print(circle.area)
```

area가 변수처럼 보이지만, area는 함수다. @property처럼
보여라하는 decorator가 붙어서 property처럼 처리한다.

다음은 setter method처럼 정의된 함수에 decorator를 붙였다.

```text
@area.setter
def area(self,value):
   self.radius = (value /Circle.PI) ** .5
```

그리고 다음과 같이 사용한다.

```text
circle.area = 10.
```

보기에는 area변수에 10.0을 assign한것 처럼 보이지만, 실은
area라는 함수다.


#### magic method (dunder method) {#magic-method--dunder-method}

파이썬에는 magic method를 많이 제공한다. 위에서 봤듯이 magic
method는 __를 prefix와 postfix에 사용한다. 그리고 대부분이 object
객체에 있는 함수들이다. 이것은 built-in function들로 불린다.

<!--list-separator-->

-  indexing method

    ```python
    class DoubleMapper:
        def __init__(self):
            self.mapping = {}

        def __getitem__(self, index):
            return self.mapping.get(index, index * 2)

        def __setitem__(self, index, item):
            self.mapping[index] = item

    mapper = DoubleMapper()
    print(mapper[10], mapper[1,2])
    mapper[10] = 15
    print(mapper[10], mapper[1,2])
    ```

    [ ] 를 재정의 한 코드라고 강사는 말한다. __getitem__과
    __setitem__을 class에 정의하게 된다면,

    ```text
    mapper[10] = 5
    ```

    이런 statement의 경우 __setitem__이 호출되고,

    ```text
    a = mapper[20]
    ```

    이런 statement의 경우 __getitem__이 호출 된다고 한다. 이제
    코드를 분석해 보자.

    ```text
    print(mapper[10], mapper[1,2])
    ```

    여기서, mapper[10]과 mapper[1,2]는 __getitem__을
    호출한다. 처음은 10이라는 값을 넘기고, 두번째는 (1,2)라는
    tuple값을 넘기는 것이다. 두 번째의 경우가 좀 이해하기 힘들긴
    하다. 여튼 저런 값은 tuple값으로 생각하면 된다.

    ```text
    def __getitem__(self, index):
        return self.mapping.get(index, index * 2)
    ```

    첫번째는 10이란 index를 __getitem__에 넘겼다. 여기서 get이란
    함수가 좀 특이한데, 만일 index값이 없다면, 2를 곱해서
    return한다는 뜻이다. 10이란 index에 값이 없기때문에, 20일
    return된다. 마찬가지로 (1,2)라는 index가 존재하지 않기 때문에
    2를 곱해서 (1,2,1,2)를 return한다고 한다. 즉 이제는 index가
    10이거나 (1,2)에 대해선 값이 존재한다.

    이제 __setitem__을 수행하는 코드를 보자.

    ```text
    mapper[10] = 15
    ```

    이 코드는 class의 __setitem__을 호출한다.

    ```text
    def __setitem__(self, index, item):
       self.mapping[index] = item
    ```

    mapper객체의 index가 10인 값은 15로 저장되게 된다. 이렇게
    해서 mapper객체의 값들은 {10:15, (1,2):(1,2,1,2)} 이렇게
    유지된다.

    이렇게 <span class="underline"><span class="underline">setitem\__과 __getitem__을 사용한다면, index관련한
    처리를 재정의가 가능하다. dictionary와 tuple array, list같은
    index를 사용한 연산에서 index의 기능을 재정의하는게
    가능하다. 위에서도 index를 사용해서 값을 return받거나,
    index에 값을 삽입하는 것을 __getitem</span></span>, __setitem__을
    재정의하면 해당 method가 호출되는 것을 볼 수 있다.

    이런 형태가 pandas나 tensorflow에서 많이 보이는데, 안에
    구조를 보면 setitem과 getitem을 재정의해서 사용하는 경우가
    많다고 한다. tensor class가 이런 형태라고 한다.

<!--list-separator-->

-  length method

    예제를 먼저 보자.

    ```python
    class Dataset:
        def __init__(self, data, times =3):
            self.data = data
            self.times = times

        def __len__(self):
            return len(self.data) * self.times

        def __getitem__(self, index):
            if index > len(self):
                raise IndexError()
            return self.data[index % len(self.data)]

    dataset = Dataset([10,2,5,2], times=5)
    print(len(dataset))
    ```

    코드를 분석하자.

    ```text
    dataset = Dataset([10,2,5,2], times=5)
    ```

    이 부분은 dataset이라는 객체를 만든 것이다.

    ```text
    print(len(dataset))
    ```

    여기서, len(dataset) 이 부분이 해석하기가 좀 어려운데,
    dataset.\__len__()이 아니라 len(dataset)의 형태이기
    때문이다. 두개가 형태만 다를뿐 동일한 것같다. 여튼, dunder
    method의 경우, len(dataset)형태로 많이 사용되어진다는 게
    특이하다. 그리고 len(dataset)은 Dataset class의 __len__()를
    호출한다고 보면 된다. 그리고 object 객체에 미리 정의되어
    있다.

    __getitem__()는 dataset[2], dataset[10] 처럼 index를 사용해서
    값을 가져오는 명령에서는 __getitem__이 정의되어 있다면
    호출된다. 연산자 재정의와 유사하다고 했다. code를 보면 다음과
    같이 되어 있다.

    ```text
    def __getitem__(self, index):
        if index > len(self):
           raise IndexError()
        return self.data[index % len(self.data)]
    ```

    pass받은 index값이 원래 dataset이 가진 객체의 len()보다 작다면
    에러가 나는데, len()는 객체가 가진 data의 길이다. 즉 index가
    가진 data보다 큰 값으로 접근하면 에러가 발생된다는 얘기다.

<!--list-separator-->

-  typing magic method

    ```python
    class Courier:
        def __init__(self, name: str, address: str):
            self.name = name
            self.address = address

        def __str__(self):
            return self.address + '담당' + self.name

    courier = Courier("김기사", "경기도 성남")
    text = str(courier)
    print(courier)
    ```

    여기서도, str(courier)과 같은 형태가 나온다. courier.str()의
    형태가 아니다. 이것은 object에 정의된 dunder method라고 바로
    추측한다. 물론 위에선 재정의한 것이다. object에서 dunder method로
    정의하는덴 그만한 이유가 있다. str이다. str은 int float와 같은
    type이다. str(courier)라는 형태는 좀 이상해 보이지 않는가? 보통은
    형변환시 사용되는 방법이다. str클래스가 있고, 생성자에 객체를
    전달해서 str객체로 형변환한다고 생각한다. 또다른 예로, int객체
    3이 str생성자에 전달되어 str(3)은 str 객체로 변환된다고 생각한다.
    하지만, 이것은 int 클래스에 정의된 str dunder method의
    호출이다. python에선 그렇다. int라는 class에 <span class="underline"><span class="underline">str\__메소드가
    정의되어 있는것이다. 우리가 형변환이라고 부르는 int(courier)이나,
    float(courier), bool(courier) 모두 class의 dunder method로
    정의되어 있다는 것이다. __str</span></span> dunder method를 정의해서 편리하게
    쓰는 경우는 객체를 print할 때다. __str__메소드가 리턴하는 값이
    출력된다.

<!--list-separator-->

-  comparison operator magic method

    ```python
    class Courier:
        def __init__(self, name: str, cid: int):
            self.name = name
            self.cid = cid

        def __lt__(self, other):
            return self.cid < other.cid

    couriers = [
        Courier("김기사", 56),
        Courier("박기사", 72),
        Courier("정기사", 62)
    ]

    print(dir(Courier))
    print(*[courier.name for courier in sorted(couriers)])
    ```

    여기서 눈여겨 볼 것은 list comprehension에서 sorted(couriers)
    문장이다.

    ```text
    print(*[courier.name for courier in sorted(couriers)])
    ```

    이전에도 보았듯이 couriers.sorted()의 객체 method가 아닌,
    sorted(couriers)형태가 나온다. 이것은 sorted가 dunder method임을
    말하고, class에 정의되어 있다. couriers객체의 type은
    list이다. 즉 list에 <span class="underline"><span class="underline">sorted\__()가 정의 되어 있을
    것이다. __sorted__()의 내부 동작은 정확히 모르지만, 객체들의
    __lt__()를 사용해서 크기 비교를 하는것 같다. 예를 들면, a &lt; b,
    a&gt; c, 혹은 if a == b 와 같이 많은 비교를 할 것이다. sorted가
    아니더라도, 객체를 비교하는 연산을 사용하는 경우는 많다. 이때,
    class에서 __lt__()를 정의하고 있다면, a &lt; b라는 일견 평범한
    연산은, a.\__lt__(b)로 해석될 수 있는 것이다. 즉 python에서는
    모든 것은 객체고, 모든 operator는 method이기
    때문이다. 마찬가지로 __le</span></span>, <span class="underline"><span class="underline">gq</span></span>, <span class="underline"><span class="underline">ge</span></span>, __ne__등 많은 것이
    존재한다.

<!--list-separator-->

-  연산자 재정의에 대해서.

    -   1&gt;2, 1&lt;3, 1 ==3 같은 logic operator
    -   ||, &amp;&amp;, ! 같은 관계연산자.
    -   +, **, / ,\***, % 같은 arithematic operator
    -   = assign operator
    -   len함수 같은것들.

    이런 연산자들은 3&gt;4, 1+4, a \*\* b 이런식으로 사용하는게 너무나
    자연스럽게 생각하지만, 객체지향 언어에선 당연하다거나
    자연스럽다고 생각하면 안된다. 왜냐하면, 객체 지향언어에서는
    객체.method의 형태로 함수나 operator를 사용하지, 수학이나
    c언어에서 사용하듯이 사용하는 저 방식은 매우 낯선것이기
    때문이다. python에선 모든것은 객체고 모든 function은
    method이다. 따라서 저 operators들은 class에 정의된
    method이다. 우리가 class를 만들때마다 저런 operator를 모두
    method로 만들어줘야 한다. 근데, Object에 이미 만들어져 있기
    때문에, 자동으로 상속된다. 우리가 만든 dunder method는 모두
    재정의한 것이다. overloading을 했던가 혹은 overriding을
    한것이다.

    근데 한가지 궁금한 게 생겼다. 위에서 설명한 dunder method들,
    len, comparison 연산자들은 모두 객체에서 정의된 그대로 호출 할수
    있었다.

    ```text
    a.__len__()
    ```

    그런데 실제 사용할 때는

    ```text
    len(a)
    ```

    와 같이 사용한다. 어떻게 해서 이렇게 사용할 수 있는것인가?
    그리고, 위의 경우는 이름이 비슷하기라도 하다. 전혀 다른것들이
    있다. 아래를 보면 &lt; 심볼은 실제 __lt__()를 호출 한다. 이것은
    어떻게 가능한 것인가? 여기에도 mangling이 되는 것인가? 그렇지는
    않다. 왜냐면 dunder method는 직접 호출이 가능하기 때문이다.

    ```text
    a < b
    ```

    ```text
    def __lt__(self,...):
       self.a < other.a
    ```

    또 재밌는건, __lt__() method로 선언한 내부에는 &lt;,&gt;와같은 기호를
    그대로 쓴다는 것이다. 그럴바에는 __lt__()를 만들 필요가 있었는지
    모르겠다. 사용할때도 &lt;,&gt;같은 기호를 쓰고, 내부적으로도
    사용한다면, 굳이 __lt__라는 이름뿐인 함수를 왜 정의하는지
    모르겠다.

<!--list-separator-->

-  arithmetic operator : magic method

    ```python
    class MyComplex:
        def __init__(self, real, imaginary):
            self.real = real
            self.imaginary = imaginary

        def __str__(self):
            return str(self.real) + '+' + str(self.imaginary) + 'j'

        def __add__(self, other):
            return MyComplex(
                self.real + other.real,
                self.imaginary + other.imaginary
                )

    a = MyComplex(3, -5)
    b = MyComplex(-6,7)
    print(a + b)

    ```

    어떤 class를 만들었을때, class로 만든 instance가 + 연산을 할 수
    있게 하려면, class에 __add__()가 있어야 한다. 물론 object에도
    정의되어 있다. overloading이나 overriding으로 재정의할려면
    위와같이 __add__()를 재정의한다. __str__()도 재정의해서
    print문에 사용할 수 있다. __sub__(), __mul__()도 존재한다.

    __iadd__()도 존재한다. 이것은 = 을 사용해서 객체를 만드는 대신
    +=을 사용해서 객체를 새롭게 생성하지 않는다고 한다. 왜냐면, +=는
    연산자이기 때문이다.

<!--list-separator-->

-  Callable : magic method

    ```python
    class AdditionNumber(object):
        def __init__(self, number: int):
            self.number = number

        def __call__(self, number: int):
            return number + self.number

    addition_5 = AdditionNumber(5)
    print(addition_5(10))
    ```

    이건 또 뭐야? 할정도로 이상한 모양이다.

    ```text
    print(addition_5(10))
    ```

    addtion_5는 instance다. AdditionNumber(5)로 부터 만들어진
    instance다. 그런데 instance에 (10)을 붙였다. 이것은 syntax
    error가 날 만도 하다. 근데 정상 동작이 된다. 어떤 이유에서일까?
    addition5자체는 instance객체의 이름이다. ()는 <span class="underline"><span class="underline">call</span></span> method를
    의미한다고 한다. object객체에 정의된 built-in function이기도
    하다. 따라서, addition5.\__call__(10)을 addition5(10)으로
    사용한다는 건데 그러면, ()와 __call__간의 mapping은 어디에 정의
    되어 있는가?

<!--list-separator-->

-  for : magic method iterable

    ```python
    seq = [1,2,3,4,5]

    for elem in seq:
        print(elem)
    ```

    위와 같은 for문은 다음과 같은 형태라고 한다.

    ```python
    seq = list([1,2,3,4,5])

    iterable = iter(seq)
    while True:
        try:
            elem = next(iterable)
        except StopIteration:
            break
        print(elem)

    ```

    python에서 for문은 다른언어와 다르게 iterable객체에서 값을
    가져와서 처리하게 되어있다. 즉 유한한 값을 반복한다. 그래서
    구조도 좀 다르다. for in이 같이 쓰인다. in 다음에는 collection이
    들어가는데, 이 collection은 __iter__()를 사용해서 iterable객체가
    된다. iterable객체에는 start,end, cur이라는 내부변수가
    있다. next()가 있어서 cur이 가리키는 값을 return한다. return한
    값은 변수와 binding되고, 다음 명령어가 수행된다.

<!--list-separator-->

-  context manager: magic method

    ```python
    class Courier:
        def __init__(self,name: str):
            self.name = name

        def __enter__(self):
            self.parcels = []
            return self

        def __exit__(self,exec_type,exec_value, trace):
            for parcel in self.parcels:
                print(parcel, "배달 실패")
                # parcel.clear()

    courier = Courier("김기사")
    with courier:
        courier.parcels.append("소포")

    with courier as c:
        c.parcels.append("소포")

    ```

    with로 시작되는 구문이 있다. 생소하다. as도 생소하다. 우선 with
    다음에는 객체가 온다. 그리고 block이 정해진다. 해당 객체가
    block에서 사용될때, class의 enter()가 실행되고, block을
    빠져나올때, exit가 수행된다. as는 객체의 이름을 block에서 c라고
    사용하겠다는 뜻이다. exit는 error나 exception이 발생되도 실행이
    되게 되어 있다. 그래서 error의 정보를 나타내기 위해서 exec_type,
    exc_value같은 인수를 제공한다.

    with as가 가장 많이 사용되는 경우는,

    ```text
    with fopen("test.txt") as fd
    ```

    과 같이 file을 열때, context를 유지해야할 때 많이 사용한다고
    한다.

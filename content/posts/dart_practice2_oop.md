+++
title = "[dart] practice2 - oop"
author = ["holy"]
description = "dart oop summary"
date = 2023-10-18T00:00:00+09:00
draft = true
+++

## [1-class] class만들고 instance의 member 변수,함수 출력하기 {#1-class-class만들고-instance의-member-변수-함수-출력하기}

```dart
 void main(){

   Idol black = Idol();
   print(black.name);
   print(black.members);
   black.sayHello();
   black.introduce();

 }

 class Idol {
   String name = "blackpink";
   List<String> members = [       'harry','john','paul'];

   void sayHello(){
     print("hi blackpink");
     }
   void introduce(){
     print("저희는 3명입니다");
     }
}
```


## [2-class] constructor 만들기 (가장 기본형) {#2-class-constructor-만들기--가장-기본형}

-   class에서 member변수를 설정하면, 매번 instance를 만들때 마다 동일한
    instance가 만들어진다.
-   함수가 parameter를 통해서 다양한 값에 대해 동일한 body로 처리하는
    것과 같이, 생성자로 다양한 instance를 만들 수 있다.
-   가장 기본형은 인자를 받지 않는것이다.

<!--listend-->

```dart
void main(){
  Idol idol = new Idol();
  idol.sayHello();
}

class Idol{
  String name = 'black';
  List<String> members = ['holy','frege'];
  Idol();
  void sayHello(){
    print('hi');
    }

  void introduce(){
    print("hi we are band");
  }
}
```


## [3-class] constructor (positional parameter) {#3-class-constructor--positional-parameter}

-   constructor를 만드는게 특이하다. 다른 언어와 많이 다르다.
-   member 변수는 선언만 하는게 가능해진다.
-   생성자에서 선언만 된 member변수를 assign해준다.

<!--listend-->

```dart
  void main(){
    Idol idol = Idol('holy2', ['c','d']);
    print(idol.name);
    print(idol.members);
    idol.sayHello();

  }

  class Idol{
    String name;
    List<String> members;

    Idol(String name, List<String> members):
    this.name = name,
    this.members = members;

    void sayHello(){
      print("hello");
      }

    void introduce(){
      print("introduce");
      }
}

```


## [4-class] 여러개의 instance 만들기 {#4-class-여러개의-instance-만들기}

-   생성자를 만들면 여러개의 instance를 만들수 있다.

<!--listend-->

```dart
void main(){
  Idol bts = Idol("bts", ['a','b','c']);
  print(bts.name);
  print(bts.members);
  bts.sayHello();
  bts.introduce();

  Idol black = Idol("black", ['ab','bb','cb']);
  print(black.name);
  print(black.members);
  black.sayHello();
  black.introduce();

}
class Idol{
  String name;
  List<String> members;

  Idol(String name, List<String> members):
  this.name = name, this.members = members;

  void sayHello(){
    print("hello");
  }
  void introduce(){
    print("hi");
  }

}
```


## [5-class] member함수를 this 사용해서 처리 {#5-class-member함수를-this-사용해서-처리}

```dart
void main(){
  Idol bts = Idol("bts", ['a','b','c']);
  print(bts.name);
  print(bts.members);
  bts.sayHello();
  bts.introduce();

  Idol black = Idol("black", ['ab','bb','cb']);
  print(black.name);
  print(black.members);
  black.sayHello();
  black.introduce();

}
class Idol{
  String name;
  List<String> members;

  Idol(String name, List<String> members):
  this.name = name, this.members = members;

  void sayHello(){
    print("hello ${this.name}");
  }
  void introduce(){
    print("hi ${this.members}");
  }

}
```


## [6-class] 간략한 생성자 사용하기. this 사용. {#6-class-간략한-생성자-사용하기-dot-this-사용-dot}

```dart
void main(){
  Idol bts = Idol('bts', ['a','b','c']);
  print("=============");
  print(bts.members);
}

class Idol{
  String name;
  List<String> members;

  Idol(this.name, this.members);

  void sayHello(){
    print("hello $name");
  }
  void introduce(){
    print("hi $members");
    }
}
```


## [7-class] named constructor {#7-class-named-constructor}

-   contructor의 이름은 class이름과 같게 쓴다. 하지만, 생성자가
    class이름과 다른 이름을 갖는 특정함수가 될 수 있다. 이것이 named constructor다.
-   함수를 사용하지만, 생성자를 초기화하듯이 body를 {}대신에 :을
    사용해서 정의하는게 다르다.
-   매우 생경한 방식이다.

<!--listend-->

```dart
void main(){
  Idol bts = Idol.fromMembers(
    [
      ['a','b'],'bts'
      ]);
   print(bts.name);
}
class Idol {

  String name;
  List<String> members;

  Idol.fromMembers(List values)
  : this.members = values[0],
  this.name = values[1];

}



```


## [8-class(encapsulation)] encapsulation member변수 {#8-class--encapsulation--encapsulation-member변수}

-   객체 지향언어의 한 속성이다.
-   class의 member 변수가 외부에서 접근하면 안된다. 그래서 java에서는
    private으로 설정한다.
-   dart에서는 member변수를 final로 선언한다.

<!--listend-->

```dart
void main(){
  Idol bts = Idol.fromList(
    [
      'bts', ['a','b']
    ]);
  bts.sayHello();
}

class Idol{
  final String name;
  final List<String> members;

  Idol.fromList(List values)
  : this.name = values[0], this.members = values[1];

  void sayHello(){
    print("hello $name");
  }

  void introduce(){
    print('hi $members');
  }
}
```


## [9-class(encapsulation)] const contructor {#9-class--encapsulation--const-contructor}

-   const와 final은 한번 만들어지면, 다시 assign할 수 없다. symbol과
    값을 붙이기 때문이다.
-   const는 한번 만들어지면 constant pool에 들어간다.
    그리고 재사용된다. 새롭게 만들어지지 않고 재사용된다.
-   const constructor를 사용하는 이유는 재사용으로 인한 메모리 효율을
    높이기 위함이다.
-   const를 사용하는 방식이 좀 특이하다. class 선언시 const를 붙여주고,
    객체 생성시에도 const를 사용한다. 객체 생성시 const를 붙여주면,
    constant pool에 있다면 가져와서 재사용하겠다는 뜻이다.
-   아래 주석은 Idol이라는 class가 const constructor를 사용하지만,
    Idol로 생성시켜서 heap에 bts란 객체가 있는 것이고, bts2는 constant
    pool에 만든다. 따라서 주석에 있는 bts와 bts2는 같지 않다.
-   반면에 주석이 없는 bts는 constant pool에 Idol instance가 없기 때문에
    객체를 생성한다. 그 다음 bts2는 constant pool에서 instance를
    재사용하기 때문에 두개는 동일한 객체다. 따라서 true가 나온다.

<!--listend-->

```dart
void main(){
  // Idol bts = Idol('bts', ['a','b']);
  // Idol bts2 = const Idol('bts', ['a','b']);
  Idol bts = const Idol('bts', ['a','b']);
  Idol bts2 = const Idol('bts', ['a','b']);
  print(bts == bts2);

}
class Idol{
  final String name;
  final List<String> members;

  const Idol(this.name, this.members);

}
```


## [10-class(encapsulation)] getter 작성법 {#10-class--encapsulation--getter-작성법}

-   getter는 문법으로 정해져 있다.
-   get name {} 형태다. 인자를 받지 않는다.
-   getter는 함수라기 보단, 마치 member 변수 처럼 사용된다.

<!--listend-->

```dart
void main(){
  Idol bts = Idol('bts',['a','b']);
  print(bts.firstMember);
}

class Idol{
  final String name;
  final List<String> members;

  Idol(this.name, this.members);

  String get firstMember{
    return members[0];
    }
}
```


## [11-class(encapsulation)] setter 작성법 {#11-class--encapsulation--setter-작성법}

-   setter의 이름은 getter와 동일하게 한다.
-   setter는 class의 값을 설정한다. 따라서 함수형태의 구조를 갖는다.
-   setter는 인자를 단 한개 받는다. setter를 사용하는게 a.firstmember =
    'a' 이런식이기 때문에 한개의 인자만 갖는 것이다.
-   setter는 class의 member변수를 설정하기 때문에 member변수는 final이 되어선 안된다.
-   setter는 class의 member변수의 값을 변경하기 때문에 const 생성자를 사용할 수 없다.
-   setter는 member변수의 값을 바꾼다. 그래서 encapsulation때문에
    final키워드를 사용했던 member는 final 키워드를 붙일 수 없다.
-   강의에서는 setter는 현대 programming 언어에서는 잘 안 쓰인다고 하는
    private으로 member변수를 선언하고, 외부에서 member variable에
    접근하지 못하게 하고 setter와 getter를 사용하는것은 흔한 일이다.

<!--listend-->

```dart
void main(){
  Idol bts = Idol('bts', ['a','b']);
  bts.firstMember = 'black';
  print(bts.firstMember);
}

class Idol {
  String name;
  List<String> members;

  Idol(this.name, this.members);

  String get firstMember{
    return this.members[0];
  }
  void set firstMember(String name){
    this.members[0] = name;
  }
}

```


## [12-class(encapsulation)] setter와 getter private. {#12-class--encapsulation--setter와-getter-private-dot}

-   위에서도 얘기했는데, dart에선 private은 \_로 설정한다.
-   member variable을 접근할때 setter와 getter를 사용하는데, 이는
    private으로 설정되었을때 접근하기 위한것이다.


## [13-class(Inheritance)] extends 와 super 사용 {#13-class--inheritance--extends-와-super-사용}

-   Idol이라는 class를 작성하고, BoyGroup이라는 class가 상속받게 하자.
-   여기서 named parameter를 사용하는 생성자의 형태에 유념하자. this를
    사용한다. 생성자의 인수를 this로 받으면 : 설정을 하지 않아도 된다고
    했다. positional parameter를 사용할때 간략하게 하기 위해서,즉 :으로
    assign을 안할려고 this를 사용했듯이 named parameter도 동일하다. 만일
    this를 사용하지 않는다면 생성자의 인수에 변수를 선언하고 body 대신
    :으로 assign해줘야 한다.

<!--listend-->

```dart
void main(){
  BoyGroup bg = BoyGroup('bg',5);
  bg.sayName();
}
class Idol{
  String name;
  int membersCount;

  Idol({
      required this.name,
      required this.membersCount,
      });
  void sayName(){
    print(' im $name ');
  }
  void sayMembersCount(){
    print('our members number is $membersCount');
  }
}

class BoyGroup extends Idol{
  BoyGroup(String name, int numbers):
  super(name: name, membersCount: numbers);
}

```


## [14-class(Inheritance)] 상속받는 BoyGroup class에 BoyGroup만의 함수 추가하기 {#14-class--inheritance--상속받는-boygroup-class에-boygroup만의-함수-추가하기}

-   상속받는 BoyGroup에 sayMale()를 추가한다.
-   이것은 당연히 Idol instance에서는 접근할 수 없다.
-   Idol의 named parameter 생성자의 선언과 사용법을 잊지말자. 자주
    나오는 패턴이다.

<!--listend-->

```dart
void main(){
  BoyGroup bg = BoyGroup('bg',7);
  bg.sayName();
  bg.sayMale();

  Idol black = Idol(name:'black', memberCount:5);
  black.sayName();
  // black.sayMale();
}
class Idol{
  String name;
  int memberCount;

  Idol({
      required this.name,
      required this.memberCount,
      });
  void sayName(){
    print("hello $name is");
  }
  void sayMemberCount(){
    print("our member is $memberCount");
  }
}

class BoyGroup extends Idol{
  BoyGroup(String name, int countNumbers):
  super(name:name, memberCount: countNumbers);

  void sayMale(){
    print("we ar male");
    }
}
```


## [15-class(Inheritance)] Idol을 상속받는 Girl Group을 만든다. {#15-class--inheritance--idol을-상속받는-girl-group을-만든다-dot}

```dart
void main(){
  GirlGroup gg  = GirlGroup('gg',4);
  gg.sayName();
}
class Idol{
  String name;
  int memberCount;

  Idol({
      required this.name,
      required this.memberCount,
      });
   void sayName(){
     print('this is $name.');
   }

   void sayMemberCount(){
     print('this is member count of $memberCount');
   }
}

class GirlGroup extends Idol{

  GirlGroup(String name, int countNumbers):
  super(name: name, memberCount:countNumbers);

}
```


## [16-class(Inheritance)] GirlGroup만의 함수 만들기 {#16-class--inheritance--girlgroup만의-함수-만들기}

-   sayFemale()를 만든다.
-   girlGroup에만 있는 함수라서 Idol instance나, BoyGroup instance에서
    접근할 수 없다.

<!--listend-->

```dart
void main(){
  GirlGroup gg = GirlGroup('gg',5);
  gg.sayFemale();
}
class Idol{
  String name;
  int memberCount;

  Idol({
      required this.name,
      required this.memberCount,
      });
  void sayName(){
    print("hello my name is $name.");
  }

  void sayMemberCount(){
    print('hi our member is $memberCount.');
  }
}

class GirlGroup extends Idol{
  GirlGroup(String name, int memberCount):
  super(name:name, memberCount:memberCount);

  void sayFemale(){
    print('our group is female group');
    }
  }
```


## [17-class(Inheritance)] type 비교 {#17-class--inheritance--type-비교}

-   자식 instance들이 부모 class에 포함되는지 여부와 부모 instance들이
    자식 class에 포함되는지 여부.
-   is 사용
    ```dart
    void main(){
      Idol apink = Idol(name:'apink',number: 5);
      BoyGroup bg = BoyGroup('bg',3);
      GirlGroup gg = GirlGroup('gg',7);

      print(bg is Idol);
      print(gg is Idol);
      print(apink is BoyGroup);
      print(apink is GirlGroup);

    }
    class Idol{
      String name;
      int number;

      Idol({
          required this.name,
          required this.number,
          });
      void sayName(){
        print('hi $name.');
        }
      void sayNumber(){
        print('our member is $number');
      }
    }

    class GirlGroup extends Idol{

      GirlGroup(String name, int numbers):
      super(name: name, number: numbers);

      void sayFemale(){
        print("our member is female");
      }
    }

    class BoyGroup extends Idol{
      BoyGroup(String name, int numbers):
      super(name:name, number:numbers);

      void sayMale(){
        print("this is male");
        }
      }
    ```


## [18-class(polymorphism)] method overriding1 {#18-class--polymorphism--method-overriding1}

-   method재작성
-   timestwo라는 class를 만든다. 숫자를 입력받아 2를 곱하는 함수
    calculate가 있다.

<!--listend-->

```dart
void main(){
  TimesTwo tt = TimesTwo(2);
  print(tt.calculate());
}

class TimesTwo{
  final int number;

  TimesTwo(this.number);

  int calculate(){
    return this.number *2;
  }
}


```


## [19-class(polymorphism)] method overriding2 {#19-class--polymorphism--method-overriding2}

-   method overriding은 상속받은 부모클래스의 method를 변경한다.
-   timesfour라는 class를 만들고 calculate를 overriding하자.
-   @override 사용할줄 알아야 한다.
-   TimesFour는 자체적으로 member변수가 없다는것을 인지해야 한다. 부모의
    멤버변수를 사용할 뿐이다.
-   TimesFour에서 생성자에서 생성한 인자인 number는 마치 NumberFour의
    member 변수처럼 행동한다. 따라서 this.number도 사용가능하고
    number로도 사용 가능하다.

<!--listend-->

```dart
void main(){
  TimesFour tf = TimesFour(2);
  print(tf.calculate());
}
class TimesTwo{
  final int number;
  TimesTwo(this.number);

  int calculate(){
    return this.number *2;
  }
}

class TimesFour extends TimesTwo{
  TimesFour(int number):
  super(number);

  @override
  int calculate(){
    return super.number * 4;
    // return this.number * 4;
    // return number * 4;
  }
}

```


## [20-class(polymorphism)] method overriding3 {#20-class--polymorphism--method-overriding3}

-   부모의 function을 그대로 이용하는 방법

<!--listend-->

```dart
void main(){
  TimesFour tf = TimesFour(2);
  print(tf.calculate());
}

class TimesTwo{
  final int number;
  TimesTwo(this.number);

  int calculate(){
    return this.number * 2;
  }
}

class TimesFour extends TimesTwo{

  TimesFour(int num):
  super(num);

  @override
  int calculate(){
   return super.calculate() * 2;
  }
}
```


## [21-class(polymorphism)] static keword {#21-class--polymorphism--static-keword}

-   emplyee라는 class를 만든다.
-   building이라는 static member변수를 만드는데, class변수를 의미한다.
-   static이 없으면 객체의 identity를 나타내는 instance변수라면,
    static은 class의 특성을 나타내는 변수다.
-   static 변수에 해당하는 값이 모든 instance에 있지 않다. 그래서 nullable하게 한다.
-   static변수와 함수는 class에서 생성및 실행한다.

<!--listend-->

```dart
void main(){
  Employee sg = Employee('sg');
  Employee.building = 'big';
  sg.printNameAndBuilding();
  Employee.printBuilding();
}

class Employee{
  static String? building;
  final String name;

  Employee(this.name);

  void printNameAndBuilding()
  {
    print('$name works at $building');
  }

  static void printBuilding()
  {
    print('I works at $building');
  }
}
```


## [22-class(polymorphism)] interface {#22-class--polymorphism--interface}

-   interface는 dart 3.0에서 새롭게 추가되었다. 그래서 여기선 생략한다.


## [23-class(polymorphism)] generic type {#23-class--polymorphism--generic-type}

-   type을 외부에서 받을때 사용한다.
-   type을 외부에서 받기때문에 class를 선언할때, type을 받을 수 있게 &lt;&gt;를 사용한다.
-   &lt;&gt;를 사용해서 type을 받기도 하고 전달하기도 한다.
-   Lecture라는 class를 만든다. class에는 id와 name을 멤버변수로 갖게 한다.
-   객체를 생성할때, id와 name값 뿐만 아니라 type도 갖게 만들어라.

<!--listend-->

```dart
void main(){
  Lecture<String> lecture1 = Lecture("id1", "english");
}
class Lecture<T> {
  final T id;
  final String name;

  Lecture(this.id, this.name);

}
```


## [24-class(polymorphism)] generic type 출력 {#24-class--polymorphism--generic-type-출력}

```dart
void main(){
  Lecture<String> lec1 = Lecture('id1','music');
  lec1.printIDType();
  Lecture<int> lec2 = Lecture( 3,'physics');
  lec2.printIDType();
}
class Lecture<T>{
  final T id;
  final String name;

  Lecture(this.id, this.name);

  void printIDType(){
    print(id.runtimeType);
    }
}
```


## [25-class(polymorphism)] 여러개 type을 받는 generic {#25-class--polymorphism--여러개-type을-받는-generic}

```dart
void main(){
  Lecture<String,int> lect1 = Lecture("lect1", 333);
  lect1.printAll();
}

class Lecture<S,T> {
  final S id;
  final T name;

  Lecture(this.id, this.name);

  void printAll(){
    print(id.runtimeType);
    print(name.runtimeType);
    }
}
```


## [26-Object] Object class {#26-object-object-class}

-   모든 class는 extends Object가 생략되어 있다.

<!--listend-->

```dart
void main(){
  Test t = Test();
  print(t);
}

class Test extends Object{
  }
```

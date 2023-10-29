+++
title = "[dart] practice1- basic"
author = ["holy"]
description = "dart 매일 해야하는것들"
date = 2023-10-16T00:00:00+09:00
draft = true
+++

## [1] hello world {#1-hello-world}

```dart
void main(){
   print('hello world');
}
```


## [2-var] var (var로 값 만들고 출력) {#2-var-var--var로-값-만들고-출력}

-   값에 따라 type이 결정, build time(compile time)에 결정.

<!--listend-->

```dart
void main(){
  var name1 = 'holy';

  print(name1);

  name1 = 'frege';

  print(name1);

}
```


## [3-var] var로 값 변경하고 출력 {#3-var-var로-값-변경하고-출력}

```dart
void main(){
  var name1 = 'holy';
  name1 = 'frege';
  print(name1);
  }
```


## [4-int] int 선언 출력 {#4-int-int-선언-출력}

```dart
void main(){
  int number1 = 10;
  print(number1);
  int number2 = 15;
  print(number2);
  int number3 = -10;
  print(number3);
}
```


## [5-int] int 계산 4가지 {#5-int-int-계산-4가지}

```dart
void main(){
  int number1 = 10;
  int number2 = 15;
  print(number1 + number2);
  print(number1 - number2);
  print(number1 * number2);
  print(number1 / number2);
}
```


## [6-double] double 선언 및 출력 {#6-double-double-선언-및-출력}

```dart
void main(){
  double number1 = 0.5;
  double number2 = 1.0;
  print(number1);
  print(number2);
}
```


## [7-double] double의 계산 4가지 {#7-double-double의-계산-4가지}

```dart
void main(){
  double number1 = 1.0;
  double number2 = 0.5;

  print(number1 + number2);
  print(number1 * number2);
  print(number1 - number2);
  print(number1 / number2);
}
```


## [8-bool] bool 의 선언및 출력 {#8-bool-bool-의-선언및-출력}

```dart
  void main(){
  bool isTrue = true;
  bool isFalse = false;

  print(isTrue);
  print(isFalse);
}
```


## [9-String] String 선언과 출력 {#9-string-string-선언과-출력}

-   string을 사용할때 String의 S는 대문자다.

<!--listend-->

```dart
void main(){
String name1 = 'redvelvet';
String name2 = 'holy';

print(name1);
print(name2);
}
```


## [10-string] var와 string의 차이(runtimeType) {#10-string-var와-string의-차이--runtimetype}

-   var도 문자열을 값으로 가질수 있고, String도 문자열을 가질 수 있다.
-   var는 int도 가질수 있고 bool도 가질 수 있는데, assign되는 value에
    의해 type이 결정된다. build time때 결정되지만, runtimeType으로
    확인할 수 있다. runtimeType은 함수가 아니다.
-   var,dynamic은 type이 아니다.
    ```dart
        void main(){
        var name3 = 'holy';
        var number = 20;

        print(name3.runtimeType);
        print(number.runtimeType);
    }
    ```


## [11-String] string 덧셈 {#11-string-string-덧셈}

```dart
void main(){
  String name1 = 'holy';
  String name2 = 'frege';

  print(name1 + name2);
}
```


## [12-String] embedded string {#12-string-embedded-string}

-   두가지 형태가 있다. {}을 안치면 변수만 가능, {}를 치면 함수도 가능.

<!--listend-->

```dart
void main(){
  String name1 = 'holy';
  print('this is ${name1}');
  print('this is $name1');
  print('this is ${name1.runtimeType}');
}
```


## [13-dynamic] dynamic 선언과 출력 {#13-dynamic-dynamic-선언과-출력}

-   dynamic은 모든 type의 value를 받을 수 있다.
-   dynamic은 build time때 Object type을 갖는데, runtime때 value에 따라
    type이 결정된다.

<!--listend-->

```dart
void main(){
  dynamic name = 'holy';
  print(name);

  dynamic number = 1;
  print(number);
}
```


## [14-dynamic] var과 dynamic의 차이 {#14-dynamic-var과-dynamic의-차이}

-   var는 build time때 value를 보고 type이 만들어진다.
-   dynamic은 runtime때 value를 보고 type이 만들어진다.
-   var로 선언된 변수의 값을 다른 type의 값으로 변경은
    불가능하다. dynamic은 가능하다.

<!--listend-->

```dart
  void main(){
    var name = 'holy';
    dynamic name2 = 'frege';

    name2 = 3;
    print(name);
    print(name2);
}
```


## [15-nullable] ? {#15-nullable}

-   Null class가 있다.
-   String, int, double,bool같은 type은 일반적으로 null값을 가질 수 없다.
-   type에 ?을 추가하면 Null을 상속받아서 null값을 가질 수 있다.

<!--listend-->

```dart
void main(){
  String name = 'holy';
  String? name2 = null;

  print(name);
  print(name2);
}
```


## [16-nullable] ! {#16-nullable}

-   !는 symbol 뒤에 표시한다. null값을 가질 수 없다는 의미다.
-   보통 함수 호출시 parameter를 받을때 사용한다.

<!--listend-->

```dart
void main(){
  String? name = null;

  print(name!);
}
```


## [17-final] final keyword 선언과 출력 {#17-final-final-keyword-선언과-출력}

-   한번 선언하면 그 값을 바꿀수 없다.

<!--listend-->

```dart
void main(){
  final String name = 'holy';
  // name = 'frege';
  print(name);

}
```


## [18-const] const의 선언과 출력 {#18-const-const의-선언과-출력}

-   const로 한번 선언하면 그 값을 바꿀 수 없다.

<!--listend-->

```dart
void main(){
  const String name = 'holy';
  // name = 'frege';
  print(name);
}
```


## [19-final vs const] final vs const 공통점1 {#19-final-vs-const-final-vs-const-공통점1}

-   final과 const는 한번 선언되면 그 값을 바꿀수 없다.

<!--listend-->

```dart
void main(){
  final String name = 'holy';
  print(name);
  const String name2 = 'frege';
  print(name2);

}
```


## [20-final vs const] final vs const 공통점2 - using it without type {#20-final-vs-const-final-vs-const-공통점2-using-it-without-type}

-   final과 const는 var가 포함되어 있다.
-   final과 const는 값에 따라 type이 결정된다.

<!--listend-->

```dart
void main(){
  final name = 'holy';
  print(name);
  const name2 = 'frege';
  print(name2);
}
```


## [21-final vs const] final vs const 차이점 -DateTime {#21-final-vs-const-final-vs-const-차이점-datetime}

-   final과 const의 차이는 값이 runtime때 결정되냐? compile때 결정되냐의
    차이다.
-   const는 compile때 값이 결정된다. final은 runtime때 결정된다.
-   DateTime.now()는 runtime에 값이 결정되는 함수다. final은 가능하지만, const는 불가능하다.

<!--listend-->

```dart
void main(){
  DateTime now = DateTime.now();
  print(now);

  final DateTime now1 = DateTime.now();
  print(now1);

  // const DateTime now2 = DateTime.now();
  // print(now2);
}
```


## [22-operator] 4칙 연산 operator {#22-operator-4칙-연산-operator}

```dart
void main(){
  final number1 = 3;
  final number2 = 5;
  print('$number1 + $number2 = ${number1 + number2}');
  print('$number1 * $number2 = ${number1 * number2}');
  print('$number1 / $number2 = ${number1 / number2}');
  print('$number1 - $number2 = ${number1 - number2}');
}
```


## [23-operator] % operator {#23-operator-operator}

-   나머지 연산자

<!--listend-->

```dart
void main(){
  final number1 = 10;
  final number2 = 5;

  print('$number1 % $number2 = ${number1 % number2}');
}
```


## [24-operator] ++,-- operator {#24-operator-plus-plus-operator}

-   ++,--는 전위 후위가 가능하다.
-   값을 변경하기 때문에, final은 사용할 수 없다.

<!--listend-->

```dart
void main(){
  // final int number1 = 3;
  int number1 = 3;
  print('$number1++ = ${number1++}');

  int number2 = 6;
  print('$number1++ = ${++number1}');

  }
```


## [25-operator] +=, -= {#25-operator-plus}

```dart
void main(){
  int number = 4;

  number += 5;
  print(number);

  int number2 = 9;
  number2 -= 3;
  print(number2);

}
```


## [26-operator] ??= {#26-operator}

-   nullable operator
-   ??= 변수가 null이면 assign한다. null이 아니면 그대로.

<!--listend-->

```dart
void main(){
  int? number1 = null;

  number1 ??= 3;
  print(number1);
}
```


## [27-operator] &lt;, &gt;, &gt;=,&lt;=, `=, !` 비교 연산자 출력 {#27-operator-비교-연산자-출력}

```dart
void main(){
  int number1 = 10;
  int number2 = 5;

  print(number1 > number2);
  print(number1 < number2);
  print(number1 >= number2);
  print(number1 <= number2);
  print(number1 == number2);
  print(number1 != number2);
}
```


## [28-operator] is 와 is! {#28-operator-is-와-is}

```dart
void main(){
  int number1 = 10;

  print(number1 is int);
  print(number1 is! int);
}
```


## [29-operator] logic operator &amp;&amp; || {#29-operator-logic-operator-and-and}

```dart
void main(){
  bool results = 12 >10 && 1>0;
  print(results);

  bool results2 = 1<5 || 12 > 0;
  print(results2);
}
```


## [30-list] List 생성과 출력 {#30-list-list-생성과-출력}

-   대문자로 시작
-   List는 data를 넣는 container, 어떤 data를 넣을 지 generic으로 선언해야 한다.

<!--listend-->

```dart
void main(){
  print('==================');
  List<String> member = ['a' 'b', 'c', 'd'];
  print(member);
  print('==================');
  List<int> numbers = [1,2,3,4,5];
  print(numbers);
}
```


## [31-List] List에서 값꺼내기 {#31-list-list에서-값꺼내기}

```dart
void main(){
  List<String> members =['harry','George','john'];
  print(members[0]);
  print(members[1]);
  print(members[2]);
}
```


## [32-List] 전체 List의 길이를 알기 {#32-list-전체-list의-길이를-알기}

-   length를 사용

<!--listend-->

```dart
void main(){
  List<String> members = ['harry','George', 'Jed'];
  print(members.length);
}
```


## [33-List] List의 add, remove, indexOf 함수 사용 {#33-list-list의-add-remove-indexof-함수-사용}

```dart
void main(){
  print('---------------------');
  List<String> members = ['harry','George','Jed'];
  members.add('ted');
  print(members);
  members.remove('harry');
  print(members);
  int num = members.indexOf('Jed');
  print(num);
}
```


## [34-Map] Map의 생성과 출력 {#34-map-map의-생성과-출력}

-   Map은 key value를 가진 하나의 객체다.

<!--listend-->

```dart
void main(){
  Map<String,String> dict = {
    'age': '43',
    'name': 'holy',
    'address': 'jeju',
    };
    print(dict);
}
```


## [35-Map] Map에 값을 추가하기 - addAll() {#35-map-map에-값을-추가하기-addall}

-   addAll()에 인자로 Map을 추가하면 된다.

<!--listend-->

```dart
void main(){
  Map<String,bool> casting = {
    "George": true,
  };
  casting.addAll(
    {"Jed": false,});
  print(casting);
}
```


## [36-Map] Map에 값을 추가하기 - index사용 {#36-map-map에-값을-추가하기-index사용}

```dart
void main(){
  Map<String,bool> casting = {
    "lingo": true,
    "George": true,
    "Queen": false,
    };
  casting['blur']=false;
  print(casting);
}
```


## [37-Map] Map의 값을 변경 {#37-map-map의-값을-변경}

```dart
  void main(){
    Map<String, bool> casting = {
      'jed': true,
      'George':false,
  };
  casting['jed'] = false;
  print(casting);
}
```


## [38-Map] Map의 값을 삭제 remove()사용. {#38-map-map의-값을-삭제-remove사용-dot}

-   remove는 함수다. 이 함수를 사용해서 삭제할 수 있다.

<!--listend-->

```dart
void main(){
  Map<String,bool> casting = {
    'George': true,
    'Fat': false,
};
casting.remove('George');
print(casting);
}
```


## [39-Map] keys와 values 가져오기 {#39-map-keys와-values-가져오기}

-   keys와 values는 변수다.
-   kesy와 values는 iterable을 return한다.

<!--listend-->

```dart
void main(){
  Map<String,int> people = {
    "Harry":33,
    "potter": 22,
    "John": 88,
    "Shelly": 86,
    };
 print(people.keys);
 print(people.values);

}
```


## [40-Set] Set의 생성과 출력 {#40-set-set의-생성과-출력}

-   중복을 허용하지 않는다.
    ```dart
    void main(){
      Set<String> strset = {
        'George',
        'Harry',
        'Potter',
        };
        print(strset);
    }
    ```


## [41-set] set에 add, remove {#41-set-set에-add-remove}

```dart
void main(){
  Set<String> strset = {
    'john',
    'Mccarthy',
    'edward',
    };
    strset.add('mac');
    print(strset);
    strset.remove('john');
    print(strset);
}
```


## [42-set] contain(),포함여부 확인 {#42-set-contain-포함여부-확인}

```dart
void main(){
  Set<String> strset = {
    'john',
    'mccarthy',
    'holy',

    };

    print(strset.contains('holy'));
}
```


## [43-if] if,else if, else 기본 사용법 {#43-if-if-else-if-else-기본-사용법}

-   if,else if,else 사용법
    ```dart
      void main(){
        int number = 3;
        if (number % 3 ==0)
        {
          print('remainder 0');
        } else if (number % 3 == 1)
        {
            print('remainder 1');
        }else
        {
              print('remainder 2');
        }
    }
    ```


## [44-switch] switch문 기본 사용법 {#44-switch-switch문-기본-사용법}

-   각 case에는 break를 넣어야 한다.
-   default case를 잊지 말아야 한다.
    ```dart
    void main()
    {
      int number = 3;

      switch(number % 3){
        case 0:
        print("remainder 0");
        break;
        case 1:
        print("remainder 1");
        break;
        case 2:
        print("remainder 2");
        break;
        }
    }
    ```


## [45-for] for-loop {#45-for-for-loop}

```dart
void main(){
  for(int i=0;i< 10;i++){
    print(i);
    }
}
```


## [46-for] list for-loop {#46-for-list-for-loop}

-   for ~ in 사용법
-   in 을 사용할 때 함수처럼 ()에 기술한다. 이것이 좀 특이하다.

<!--listend-->

```dart
void main(){
  int total = 0;
  List<int> numbers = [1,2,3,4,5];
  for(int i in numbers){
    total += i;
    }
  print(total);
}
```


## [47-while] while 기본 사용법 {#47-while-while-기본-사용법}

```dart
  void main(){
    int total = 0;

    while(total <10){
      total +=1;
      }
    print(total);
}
```


## [48-while] do while 사용법 {#48-while-do-while-사용법}

-   while과 do while의 차이는 무엇인가? do는 먼저 한번 실행하고 그 다음
    반복할 뿐이다.
    ```dart
      void main(){
        int total = 0;
        do {
          total += 1;
          } while (total <10);
        print(total);
    }
    ```


## [49-break] loop에서 if break 사용법 {#49-break-loop에서-if-break-사용법}

-   break는 loop를 빠져나간다.

<!--listend-->

```dart
void main(){
int total = 0;
while(total<10){
   total +=1;
   if(total ==5) break;
  }
print(total);
}

```


## [50-continue] loop에서 if continue {#50-continue-loop에서-if-continue}

```dart
void main(){

  for (int i =0; i< 10; i++){
    if(i ==5){
      continue;
      }
    print(i);
    }

  }
```


## [51-enum] enum의 생성과 사용 {#51-enum-enum의-생성과-사용}

-   enum은 main밖에서 선언한다.
-   enum은 class keyword처럼 사용한다.
-   enum의 값은 symbol로 표시하며 보통 상태값을 표현한다.
-   enum의 값에 대한 접근은 마치 static value값을 접근하듯이 한다.
-   enum을 쓰는 이유: 몇가지 상태만 있는경우 그 상태를 명확하게
    해준다.string을 쓰지 않고 enum을 쓰면 코드를 명확하게 해준다.
    ```dart
    enum Status{
      approved,
      pending,
      rejected,
      }
    void main(){
      Status status = Status.pending;

      if(status == Status.approved){
        print("approved!");
        }else if(status == Status.pending){
          print("pending!");
          }else{
            print("rejected");
            }
          }
    ```


## [52- function] function과 주석 그리고 호출. {#52-function-function과-주석-그리고-호출-dot}

-   함수를 사용하기전 주석으로 어떤 역할을 하는 함수인지 기술한다.
    ```dart
    void main(){
      addNumbers();
    }

    // 3개의 숫자(x,y,z)를 더한다. 더한 값이 짝수인지 홀수 인지 알려주는 함수.
    addNumbers(){
      print("addNumbers 실행");
    }
    ```


## [53-function] function의 구현 {#53-function-function의-구현}

```dart
void main(){
  addNumbers();
}

// 3개의 숫자(x,y,z)를 더한다. 더한 값이 짝수인지 홀수 인지 알려주는 함수.
addNumbers(){
  int x = 10;
  int y = 20;
  int z = 30;

  int sum = x+y+z;
  if( sum % 2 ==0){
    print("this is even");
    }else{
    print("this is odd");
  }
}
```


## [54-function] argument (positional parameter)를 만들자. {#54-function-argument--positional-parameter--를-만들자-dot}

-   함수를 argument없이 사용하면 매번 호출시 매번 동일한 동작을 한다.
-   argument가 주어질때, 함수는 다양한 동작이 가능해진다.
    ```dart
    void main(){
      addNumbers(10,20,30);
    }

    // 3개의 숫자(x,y,z)를 더한다. 더한 값이 짝수인지 홀수 인지 알려주는 함수.
    addNumbers(int x, int y, int z){
      int sum = x+y+z;
      if( sum % 2 ==0){
        print("this is even");
        }else{
        print("this is odd");
      }
    }
    ```


## [55-function] optional parameter {#55-function-optional-parameter}

-   함수에 parameter가 없다면, 매번 똑같은 일만 수행한다. parameter로
    함수의 body를 재사용한다.
-   optional parameter는 호출시 입력을 하지 않아도 된다. [ ]로 optional
    parameter를 정해준다. 여기서 문제점이 발생한다.
    ```dart
    void main(){
      addNumbers(10,20,30);
    }

    // 3개의 숫자(x,y,z)를 더한다. 더한 값이 짝수인지 홀수 인지 알려주는 함수.
    addNumbers(int x, [int y, int z]){
      int sum = x+y+z;
      if( sum % 2 ==0){
        print("this is even");
        }else{
        print("this is odd");
      }
    }
    ```
-   int y , int z를 []로 묶어 주었다.


## [56-function] optional parameter 문제점 1 {#56-function-optional-parameter-문제점-1}

-   함수 선언시 []로 optional로 정해주면, argument가 null값을 갖는데,
    int는  nullable type이 아니라서 에러가 난다.
-   int가 null을 가질 수 있게 type에 ?를 추가한다.

<!--listend-->

```dart
void main(){
  addNumbers(1)
}
addNumbers(int x,[int? y, int? z]){
  int sum = x + y + z;
  if (sum % 2 == 0){
    print('this is even');
    }else {
      print('this is odd');
    }
  }
```


## [57-function] optional의 또다른 문제점 2 해결-default값 {#57-function-optional의-또다른-문제점-2-해결-default값}

-   argument type에 ?을 추가해서 nullable하게 만들었지만, 실행되지
    않는다.
-   왜냐하면 int sum에서 y와 z가 null값이 될수 있기 때문이다. 그러면
    sum도 null이 가능하게 해야한다. 그런데 null과 숫자의 덧셈자체가
    안된다. 그래서 에러는 계속 나게 된다.
-   optional만 사용하면 null값을 갖기 때문에 꼬리에 꼬리를 무는 문제가
    계속 발생된다. 그래서 default값으로 해결한다.

<!--listend-->

```dart
void main(){
  addNumbers(3);
}

addNumbers(int x, [int y=1, int z=1]){
  int sum = x + y + z;
  if (sum % 2 == 0){
    print('this is even');
  }else{
    print('this is odd');
  }

}

```

-   optional을 적용하기 위해서 []로 묶기만 해서는 안된다. null값 문제가
    발생하기 때문이다. 그래서 default값을 같이 적용해야만 한다.


## [58-function] named parameter {#58-function-named-parameter}

-   parameter를 기술할때 optional은 []를 사용했다면, named parameter는 {}을 사용한다.
-   required라는 keyword를 사용해서 선언한다.
-   named parameter는 호출시 값만 넣어서 호출하는 일반함수와 다르게
    이름을 기술해야 한다. 그래서 named parameter다.
-   named parameter의 특징은 순서가 중요하지 않다는 것이다.

<!--listend-->

```dart
void main(){
  addNumbers(x:10,y:20,z:30);
}

addNumbers({
required int x,
required int y,
required int z,
}){
  int sum = x+y+z;
  if (sum %2 == 0){
    print("this is even");
  }
  else{
    print("this is odd");
    }
}

```


## [59-function] named parameter의 순서 {#59-function-named-parameter의-순서}

-   parameter의 순서가 상관없다.

<!--listend-->

```dart
 void main(){
   addNumbers(z:20,y:30,x:40);
 }
 addNumbers({
     required int x,
     required int y,
     required int z,
 }){
   int sum = x+y+z;
   if (sum %2 == 0){
     print("it is even");
   }else{
       print("it is odd");
   }
}
```


## [60-function] named parameter와 optional parameter의 관계 {#60-function-named-parameter와-optional-parameter의-관계}

-   named parameter는 required로 기술한다. required를 제거하면 optional
    parameter가 된다.
-   optional은 null문제가 있어서 항상 default를 처리해줘야 한다.

<!--listend-->

```dart
void main(){
  addNumbers(x:10,y:20,z:30);
}

addNumbers({
    required int x,
    required int y,
    int z=50,      }){
  int sum = x + y + z;
  if( sum %2 == 0){
    print("this is 짝수");
  } else{
    print("this is odd");
    }
    }



```


## [61-function] positional parameter와 named parameter같이 사용 {#61-function-positional-parameter와-named-parameter같이-사용}

```dart
void main(){
  addNumbers(10,y:20,z:30);
}

addNumbers(int x,{
    required int y,
    required int z,}){
  int sum = x + y + z;
  if (sum % 2 == 0){
    print('this is even');
  }else{
    print('this is odd');
    }
    }


```


## [62-function] addNumbers에 return값 처리 {#62-function-addnumbers에-return값-처리}

-   return하는 함수를 작성하자.

<!--listend-->

```dart
void main(){
  int results = addNumbers(x:30,y:30,z:10);
  print(results);
}

int addNumbers({
    required int x,
    required int y,
    required int z,
    }){

      int sum = x + y + z;
      return sum;

      }
```


## [62-function] arrow function {#62-function-arrow-function}

-   addNumbers 를 arrow function으로 만들자.
-   arrow function의 body는 중괄호도 사용하지 않는다.
-   arrow function은 body 계산값이 반드시 return된다.

<!--listend-->

```dart
void main(){
  addNumbers(x:10,y:20,z:30);
}
addNumbers({
    required int x,
    required int y,
    required int z,
    }) => x+ y + z;

```


## [63-typedef] typedef 생성 {#63-typedef-typedef-생성}

-   함수와 비슷하지만 body가 없다.
-   함수의 인자와 return값을 표현하는 게 function signiture다.
-   typedef typdefinition으로 function definition을 만드는것이다. 문법에
    유의하자.

<!--listend-->

```dart
void main(){

}
typedef Operation = int Function(int x, int y, int z);
```


## [64-typedef] typedef 사용법 (add, substract) {#64-typedef-typedef-사용법--add-substract}

-   function signiture를 만들면 fuction signiture와 일치하는 함수를
    symbolic mapping할 수 있다.
-   add와 subtract를 function signiture에 맞춰 만들고, symbolic
    mapping해서 사용하는 예다.

<!--listend-->

```dart
void main(){

  Operation op = add;
  int result = op(3,2,1);
  print(result);
  Operation op2 = substract;
  int result2 = op(11,2,3);
  print(result2);
}

typedef Operation = int Function(int x, int y, int z);
int add(int x, int y, int z) => x + y + z;
int substract(int x, int y , int z) => x - y -z;

```


## [65-typedef] typedef 실제 사용예 {#65-typedef-typedef-실제-사용예}

-   typedef는 function의 signiture를 만든다.
-   function signiture는 함수의 인자로 들어가서 사용될 수 있다.

<!--listend-->

```dart
typedef Operation = int Function(int x, int y, int z);
int add(int x,int y, int z) => x+y+z;
int substract(int x,int y, int z) => x-y-z;

int calculate(int x, int y, int z, Operation op){
  return op(x,y,z);
  }

void main(){
  calculate(3,3,3,add);

}
```

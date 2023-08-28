+++
title = "[dart] practice3 functional language"
author = ["holy"]
description = "functional language"
date = 2023-08-26T00:00:00+09:00
draft = true
+++

## [1-type casting] List -&gt; Map {#1-type-casting-list-map}

-   List를 Map으로 변환(asMap 사용)
-   key는 0,1,2가 붙는다.
-   Map은 {}로 표현된다.

<!--listend-->

```dart
void main(){
  List<String> black = ['a','b','c'];
  print(black.asMap());
}
```


## [2-type casting] List -&gt; Set {#2-type-casting-list-set}

-   set으로 변환(toSet()사용)
-   set도 {} 객체 형태다.

<!--listend-->

```dart
void main(){
  List<String> bb = ['a','b','d','d'];

  print(bb.toSet());

}
```


## [3-type casting] Map -&gt; keys,values iterator -&gt; list {#3-type-casting-map-keys-values-iterator-list}

-   iterable을 toList()를 사용해서 list로 바꾼다.

<!--listend-->

```dart
void main(){
  Map<int,String> black = {0:'a',1:'b',2:'c'};
  print('----------------------');
  print(black.keys.toList());
  print(black.values.toList());

}
```


## [4-type casting] List -&gt; Set {#4-type-casting-list-set}

-   list를 set으로 만들기 위해서, toSet()를 사용했다.
-   Set의 static function인 from()을 사용해서 set으로 만들수도 있다.

<!--listend-->

```dart
void main(){
  List<String> l1 = ['1','2','3'];
  Set s1 = Set.from(l1);
  print(s1);
}
```


## [5- map function] map function 사용 {#5-map-function-map-function-사용}

-   collection들에는 map function이 있다. map function에 lambda를
    기술해서 사용한다.
-   map에서 lambda를 표현하는 방식은 두가지가 있다.
-   (){} 방식은 return문이 있어야 하고, ()=&gt; ,화살표 방식에선 return문이
    자동으로 일어난다.
-   return되는 값은 iterable이다.

<!--listend-->

```dart
  void main(){
    List<String> li = ['a','b','c'];
    print(li.map((x){ return x + ' black'; }));
}

```


## [6- map function] map() - arrow function {#6-map-function-map-arrow-function}

-   arrow function을 사용해서 lambda를 만들수 있다.
-   lambda의 결과는 iterable 객체가 return된다.
-   return된 iterable을 toList() 사용해서 List로 바꿀수 있다.

<!--listend-->

```dart
void main(){
  List<String> li1 = ['a','b','c'];
  Iterable result = li1.map((x) => 'black' + x);
  print('===================');
  print(result.toList());
}
```


## [7- map function] string map 사용예 {#7-map-function-string-map-사용예}

-   string에는 map()이 없다. split()로 list를 만든다.
-   string을 concat은 + 말고 embeded string을 사용할 수 있다.

<!--listend-->

```dart
void main(){
  String number = '13579';
  // final parsed = number.split('').map((x)=> x+'.jpg');
  final parsed = number.split('').map((x)=> '$x.jpg');
  print(parsed);
}

```


## [8- map function] Map에서 map() 사용하기 {#8-map-function-map에서-map-사용하기}

-   list에만 map()가 있는게 아니다.
-   Map에도 map함수가 있다. map함수를 적용하면 return값은 Map이 나온다.
-   key와 value를 모두 처리해야한다. lambda의 인자로 key, value가
    들어간다.
-   body에서 MapEntry함수를 사용해서 Map으로 만든다. MapEntry함수는
    key값과 value값을 따로 처리한다.

<!--listend-->

```dart
void main(){
  Map<String,String> map1 = {
    "1":"one","2":"two","3":"three",};
  final result = map1.map((x,y) => MapEntry('key1 $x', 'value1 $y'));
  print(result);

}
```


## [9- map function] Map을 list로 처리 {#9-map-function-map을-list로-처리}

-   Map을 map()를 사용해서 Map으로 바꾸는 경우는 많지 않다.
-   Map의 key나 value를 iterable로 뽑아낸후 list로 변환해서 사용한다.
-   iterable은 map()가 있다. map()로 iterable요소들에 대한 조작이 가능하다.

<!--listend-->

```dart

void main(){
  Map<String,String> map1 = {
    '1':'one',
    '2':'two',
    '3':'three',
    };
  print('----------------');
  print(map1.keys.map((x) => 'number $x').toList());

}

```


## [10- map function] Set에서 map 을 사용해서 변경하기. {#10-map-function-set에서-map-을-사용해서-변경하기-dot}

-   Set에도 map을 적용할 수 있다.
-   Set에 map을 적용하면 iterable이 return된다. 여기서 toSet()로 다시
    Set으로 변환한다.

<!--listend-->

```dart
void main(){
  Set dict1 = {
    '1',
    '2',
    '3',
  };

  final result = dict1.map((x) => 'number $x').toSet();
  print(result);

}
```


## [11- where function] where function 사용법 {#11-where-function-where-function-사용법}

-   보통 json처리할 때 많이 사용된다. filtering한다.
-   List안에 map이 들어간 형태의 json을 만들자.
-   where에서 사용되는 lambda가 조건문처럼 쓰인다. return값은
    iterable이다. 따라서 toList()로 list로 바꿔준다.

<!--listend-->

```dart
void main(){
  List<Map<String,String>> people = [
    {
      'name':'holy',
      'group': 'logic',
    },
    {
      'name': 'frege',
      'group': 'math',
    },
    ];
    print('----------------');
    print(people);
    final result = people.where((x) => x['group'] == 'math');
    print(result);
}
```


## [12- reduce function] List에서 reduce 출력 {#12-reduce-function-list에서-reduce-출력}

-   reduce는 lisp에도 있다.
-   map처럼 lambda함수를 사용한다. 그런데 lambda함수의 인자가 정해져
    있다.
-   동작원리는 prev에는 이전단계의 결과가 입력으로 들어간다.

<!--listend-->

```dart
void main(){
  List<int> li1 = [1,2,3];
  final result = li1.reduce((prev,next) {
      print('==================');
      print('prev = $prev');
      print('next = $next');
      return prev + next;
  });

}
```


## [13- reduce function] reduce로 단어를 문장으로 합치기 {#13-reduce-function-reduce로-단어를-문장으로-합치기}

-   reduce는 iterable을 return하지 않는다. 값을 return한다.
-   map은 iterable을 return한다.

<!--listend-->

```dart
void main(){
  List<String> li1 = ['안녕','하세요','holy','입니다.'];
  final result = li1.reduce((prev,next) => prev + next);
  print(result);
}
```


## [14- reduce function] reduce가 return하는 값의 type. {#14-reduce-function-reduce가-return하는-값의-type-dot}

-   reduce가 iterable이 아닌 값을 return한다.
-   return하는 값의 제약이 있다. List가 String원소라면 reduce결과값도
    String이여야 한다. int면 int여야 한다.
-   아래는 에러가 나는 예이다. String에서 int값을 return하는 reduce다.

<!--listend-->

```dart
void main(){

  List<String> li1 = [
    "one",
    "two",
    "three",
    ];
  final result = li1.reduce((prev,next) => prev.length + next.length);
  print(result);

}
```


## [15- fold function] fold 사용법- reduce의 대안 {#15-fold-function-fold-사용법-reduce의-대안}

-   reduce의 문제는 list의 원소 type과 다른 reduce type이 나오면 안된다.
-   fold는 다른 type을 return해도 상관없다.
-   reduce와 다른건 시작값이 있다는 것과, return 하는 type을 generic으로
    명시한다는 것이다.
-   위에서 reduce로 안된걸 fold로 해보자.
-   여기서 주의할께, lambda의 인자가 모두 int라고 생각해야 한다.
-   초기값 0과 next.length의 합은 int고 이것은 다시 prev입력으로 들어간다.

<!--listend-->

```dart
void main(){
  List<String> li1 = [ 'abc', 'd','ef'];

  final result = li1.fold<int>(0,(prev,next) => prev + next.length);
  print(result);
}
```


## [16- fold function] 일반적인 fold함수 {#16-fold-function-일반적인-fold함수}

-   sum을 구하는 fold함수를 만들어보자.

<!--listend-->

```dart
void main(){
  List<int> numbers = [1,2,3,4,5];
  final sum = numbers.fold<int>(0,(prev, next) => prev + next);
  print(sum);
  }
```


## [17- cascading operator] 여러개의 list를 하나로 합칠때 사용한다. {#17-cascading-operator-여러개의-list를-하나로-합칠때-사용한다-dot}

-   even과 odd list를 만들고 합치자.
-   even list와 odd list를 합칠때, 일반적인 방법의 문제점.
-   list안에 list가 있다.
-   list앞에 ...을 붙인다. unpacking과 비슷하다.

<!--listend-->

```dart
void main(){
  List<int> even = [2,4,6,8,10];
  List<int> odd = [1,3,5,7,9];

  print('---------------');
  print([even,odd]);
  print([...even,...odd]);

}
```


## [18- functional programming] functional programming의 일반적인 사용예(json -&gt; class) {#18-functional-programming-functional-programming의-일반적인-사용예--json-class}

-   people이라는 json을 만든다.
-   person이라는  class를 만든다.

<!--listend-->

```dart
  void main(){
    final List<Map<String,String>> people = [
      {
        'name':'holy',
        'group': 'cs',
      },
      {
        'name':'frege',
        'group': 'math',
      },
      {
        'name':'john',
        'group': 'math',
      },
    ];

    print('--------------------');
    print(people);

    final parsedPeople = people.map((x) => Person(name:x['name']!,group:x['group']!)).toList();
      print(parsedPeople);
}
  class Person{
    final String name;
    final String group;
    Person({
        required this.name,
        required this.group,});
    @override
    String toString(){
      return 'name :$name, group:  $group';
    }
}

```


## [19- functional programming] functional programming의 일반적인 사용예 (looping 하기) {#19-functional-programming-functional-programming의-일반적인-사용예--looping-하기}

-   json을 class로 만든후 for looping을 사용할 수 있다.
-   for-loop 사용할때 괄호로 묶는걸 잊지말자.

<!--listend-->

```dart
class Person{
  final name;
  final group;

  Person({
      required this.name,
      required this.group,
      });
  @override
  String toString(){
    return 'name:$name, group:$group';
  }
}
void main(){

  List<Map<String,String>> people = [
    {
      "name": "holy",
      "group": "cs",
    },
    {
      "name": "frege",
      "group": "math",
    },
    {
      "name": "john",
      "group": "math",
    },
  ];

  final results = people.map((x) => Person(name:x['name'], group: x['group'])).toList();

  for (Person person in results){
    print(person);
  }
}

```


## [20- functional programming] functional programming의 일반적인 사용예 (where 사용법) {#20-functional-programming-functional-programming의-일반적인-사용예--where-사용법}

-   객체 list를 가져온 후 group이 math인것만 출력해보자.

<!--listend-->

```dart
class Person{
  final name;
  final group;

  Person({
      required this.name,
      required this.group,
  });

  @override
  String toString(){
    return 'name: $name, group:$group';
  }
}

void main(){
  List<Map<String,String>> people = [
    {
      'name': 'holy',
      'group': 'cs'
    },
    {
      'name': 'frege',
      'group': 'cs'
    },
    {
      'name': 'john',
      'group': 'math'
    },
  ];

  List parsedPeople = people.map((x) => Person(name:x['name'],group:x['group'])).toList();
  for (Person p in parsedPeople){
    print(p);
  }
  final result = parsedPeople.where((x) => x.group =='math');
  print(result);
}
```


## [20- functional programming] functional programming의 일반적인 사용예 (chain rule 사용) {#20-functional-programming-functional-programming의-일반적인-사용예--chain-rule-사용}

-   people이라는 json을 map을 사용해서 객체 list로 만들었다. 만들어진
    객체 list로 부터 where을 사용해서 filtering을 했는데, 이것을
    연결해서 사용할 수 있다.

<!--listend-->

```dart
class Person{
  final name;
  final group;

  Person({
      required this.name,
      required this.group,
  });
  @override
  String toString(){
    return 'name: $name, group:$group';
  }
}
void main(){

  List<Map<String, String>> people = [
    {
      'name':'holy',
      'group': 'cs',
    },
    {
      'name':'frege',
      'group': 'cs',
    },
    {
      'name':'john',
      'group': 'math',
    },
    ];

    final result = people
    .map(
      (x) => Person(
        name:x['name'],
        group:x['group']
      ),
    ).where((x) => x.group == 'math');
    print(result);
}
```

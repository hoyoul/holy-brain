+++
title = "lecture11-IO"
author = ["holy"]
description = "python의 I/O 처리"
date = 2023-06-05T00:00:00+09:00
draft = false
+++

## standard Input/output {#standard-input-output}


### 개요 {#개요}


#### input과 output의 의미 {#input과-output의-의미}

program이 하는 일은 대부분 변수나 객체 생성, for-loop, if로
이루어져 있다. 변수나 객체를 생성하는 것은, cpu와 memory간의
작업이다. 변수나 객체를 생성하는 명령어를 cpu가 실행해서, data
memory에 data를 쓰는 작업이다. for loop도 code memory에 놓여 있는
code의 address를 cpu가 address를 계산하는 cpu와 memory의 계산
작업이다. if는 code or data가 놓여진 memory의 값을 가져와서 cpu의
alu가 비교하는 cpu와 memory의 계산작업이다. 결국 모든 program은
cpu와 memory사이의 통신과 계산으로 이루어져 있다. program에서
input과 output의 의미란 무엇인가? cpu와 memory가 아닌 다른
device와 통신하면 input과 output이 된다. memory에도 user program이
아닌 다른 program과 통신하면 input과 output이 된다.


#### program과 program간의 i/o 관계 {#program과-program간의-i-o-관계}

program의 input output은 program과 다른 program과의
communication이라고 볼 수도 있고, device와 device간의 통신으로 볼
수있다고 했다. 좀 더 자세히 살펴보자. device와 program은 같은
level이 아니다. device는 h/w level이고, program은 s/w
level이다. 두개를 혼합해서 사용하면 햇갈린다. 우리가 만든
program은 cpu와 memory라는 장치를 이용하는 sw이다. 이 cpu에서
monitor로 data를 보낸다고 하자. 그러면 h/w level단에서는 cpu와
monitor device간의 통신이라고 볼 수 있지만 s/w level에서는 내가
만든 program과 monitor device driver라는 program과의 통신이라고
봐야 한다. 그리고 h/w level단에서의 통신은 모두 program간의
통신이라고 말할수도 있는게, 모든 h/w에는 그 h/w를 제어하는 s/w가
돌아가고 있기 때문이다.


#### kernel(os) {#kernel--os}

program과 다른 program간의 통신 or device와 다른 device간의 통신은
kernel이라는 program의 도움 없이는 안된다. I/O를 주관하는
kernel이라는 os라는 program이 이를 주관한다. user program이
monitor device driver라는 program과 통신하기 위해선, kernel
program에 요청하는 것이다. file을 가져오기 위해서 hdd device와
통신하기 위해서도 file system이라는 s/w와 통신해야 하는데, 이것도
os에게 요청을 해야 한다.


#### system call과 shell {#system-call과-shell}

program과 program의 통신을 kernel의 주관한다고 했다. kernel이 user
program이나 사용자에게 sytem call이라는 library를 제공한다. 이것은
다른 device에 data를 전달하거나 받거나 혹은 파일을 만든다거나
memory에 process를 만든다거나 하는 hw/resource관련한 작업을 user가
요청하게 만든것이다. c언어나 assembly로 프로그램을 짠다면, 이런
system call을 직접 호출 할 수 있다. 반면 python이나, ruby,
javascript같은 script형 언어들은 shell을 사용한다. shell은 system
call이라는 function들을 command형태로 바꾼 program이다. 즉 file을
open하거나 file에 directory를 만드는 작업은 c에서는 함수 호출을
하지만, shell위에 떠있는 python,ruby,js는 shell의 mkdir같은
명령어를 사용해서 directory를 만든다. 각각의 python
instance아래에는 shell이 떠있다고 보면 된다.


#### standard i/o와 console i/o {#standard-i-o와-console-i-o}

c언어는 system call이라는 function을 직접 호출할 수 있다고
했다. c에서는 system call을 호출하는 방식이 2가지가
있다. stdio라는 standard i/o 방식과 conio라는 console
i/o방식이다. stdio는 system call을 호출하기 전에 buffer를
사용한다거나, 사용을 위한 특별한 객체나 변수등을 제공하고, system
call을 wrapping해서 제공한다. 반면에 conio는 직접 system call을
호출한다.

python에서는 shell을 통해서 system call을 호출한다. 즉 python은
kernel을 사용할 일이 있다면, shell에게 넘겨준다. shell에서는
python에서 전달받은 i/o관련 처리를 standard i/o library를 사용해서
처리한다.


### standard output {#standard-output}

```python
print("this", "sentence")
print("this", "sentence", sep=", ")
```

모든 program들은 shell에서 실행된다. cli로 된 shell이던,
gui형태로된 shell이던 명령어 해석기를 거쳐서 program이 실행되기
때문에 중간에 shell이 개입된다. python program은 print함수를
사용해서 해당 data를 출력하고자 한다. shell은 중간에 있다가 출력할
data를 file에 써버린다. 이것은 python이 shell에 의존적인것과는
무관하다. c나 java 모든 program들의 실행은 shell에 의존적이기
때문이다. 즉 shell의 특성이지, python과는 무관하다.

```text
python a.py > results.txt
```

이렇게 하면 code의 print문은 shell에게 data를 전달해주고, shell은
results.txt에 저장하게 된다.


### standard input {#standard-input}

```python
>>> var = input()
입력을 받습니다.
>>> var
'입력을 받습니다.'
>>> var = input()
12345
>>> var
'12345'
```

python의 input의 경우도 output과 마찬가지로 shell이란 중간단계를
거치게 된다. 즉 data를 입력받는게 kernel에 요청해서 kernel이 data를
python program에게 주는게 아니다. shell에게 요청하고 shell이
준다. shell이라는 중간 경유지를 거치기 때문에 경우에 따라서
shell에서 redirection을 사용할 수 있다. python에서 input()를
사용하면 data를 받기 위해서 기다린다. shell은 redirection으로
파일을 열고 data를 전달한다.

```python
test.py < results.txt
```

test.py에 input()는 results.txt로 부터 입력을 받게 된다.


### redirection 과 pipe {#redirection-과-pipe}

위에서 redirection을 봤는데, redirection은 data의 i/o를 file로부터
처리한다면, program과 program를 pipe로 연결해서 처리할 수도
있다. 예를 들어보자.

-   test1.py
    ```python
    m = input()
    print(m)
    ```

-   test2.py
    ```python
    m = input()
    print(m)
    ```

test1.py와 test2.py가 있다고 하자. 두개를 pipe로 연결할 수
있다. 다음을 보자.

```text
>>> python test1.py | test2.py
```

test1.py를 실행하면 사용자로부터 입력을 받고 입력받은 data를
test.py의 입력으로 전달해서 출력할 수 있다.

이렇게 pipe와 redirection은 shell에서는 자주 사용된다. 예를들어,

```text
conda list | grep numpy
```

위의 경우도 2개의 program을 연결하는 pipe를 보여준다. conda list의
결과가 grep numpy의 입력으로 들어가서 출력하게 된다.


## File Input/Output {#file-input-output}

file에 대한 처리는 os(kernel)에서 한다. file에 대한 처리는 system
call을 통해서 한다. system call은 kernel의 함수를 외부에서 사용할 수
있게 export한 것이다. 이 system call들은 대부분 shell에서
wrapping했고, 이 wrapping된 함수를 user의 program들이
사용한다. shell은 user mode와 kernel mode 경계에 있다고
보면된다. user mode에서 실행하는 program들은(python interpreter도
포함해서) kernel mode에 접근할 수가 없다. shell을 통해서만 가능하다.


### 개요 {#개요}

File i/o를 다루기전에 program과 file간의 관계를
살펴보자. file이란건 영구적 보존을 위해 data가 file system에 저장된
형태다. program도 file의 형태로 저장이 되어 있다. file을 생성하고
data나 code를 저장하는것은 program에서 한다. 따라서 program만이
file을 만들고 저장할 수 있기 때문에 관련 함수를 아는건
중요하다. 그런데 어떤 data를 넣을 것인가?는 다른
문제다. program에서 file을 만들고, data를 넣을수도 있고, file을
삭제할 수도 있다. 근데 왜 file을 만들어 오래 보존하는것일까? 도대체
어떤 내용이길래? 내용에 상관없이 모든것을 program을 사용해서 file로
저장할 수 있다. 좀더 정확하겐 file i/o 함수들이다.


### File open {#file-open}

```text
fd = open("<파일이름>","<접근모드>", encoding="utf8")
fd.close()
```

&lt;접근모드&gt;

| 접근모드 | 설명                                      |
|------|-----------------------------------------|
| r    | read mode - file을 text형태로 읽을 때 사용 |
| rb   | binary read mode- file을 binary형태로 읽을 때 사용 |
| w    | write mode - file을 text형태로 쓸 때 사용 |
| wb   | write binary mode- file을 binary형태로 쓸 때 사용 |
| a    | append mode - 파일의 마지막에 새로운 text를 추가할 때 사용 |

접근모드에서 신경써야 할것은 w다. 이미 내용이 있는 file을 open하고
write하기 위해서 w를 사용하면 안된다. 기존 내용이 다 삭제 되기
때문이다. file을 open하고 file 작업을 한 이후에는 close를 항상
해줘야 한다.


### read file {#read-file}


#### read() - 파일 한번에 읽기 {#read-파일-한번에-읽기}

```python
fd = open("test.txt", "r")
contents = fd.read()
fd.close()
print(contents)
```

file을 읽는건 read()를 사용하면 된다. file을 다 읽은 후에 file을
close하는 것을 잊으면 안된다. resource를 낭비하기 때문이다. 그런데
file을 close하는것을 깜박할때도 많고, file을 읽다가 error가 나면,
close를 하지않고 program이 종료를 할수 있다. 그래서 context
manager형태를 사용하면, 자동으로 fd를 닫아준다고 한다. 아래의
구문을 사용한다고 한다.

```text
with <contextManager> as <return value>
```

```python
with open("text.txt","r") as fd
   contents = fd.read()
```

read()는 파일을 열고 한번에 읽는다.


#### 줄단위로 읽기 {#줄단위로-읽기}

<!--list-separator-->

-  file descriptor사용

    ```python
    import os

    contents = []
    print(os.path.realpath(__file__))

    with open("./data/test.txt", "r") as f:
        for sentence in f:
            contents.append(sentence)

    print(contents)
    ```

    for-loop를 사용해서 file을 읽는데, read()를 사용하지 않는다. file
    descriptor가 range()같은 generator 역할을 한다. 한줄 한줄
    return하게 된다.

    또한 white space도 포함해서 return하게 되어, \n과 같은
    escape문자가 포함된 하나의 string으로 return하게 된다. 즉 3줄이
    있다면, 3개의 string이 return하게 된다.

    위의 예에선 return한 string을 list에 담아 두었다.

<!--list-separator-->

-  readlines 사용

    ```python
    # contents = []
    with open("./data/test.txt", "r") as f:
        contents = f.readlines()

    print(contents)
    ```

    위에 나온 file descriptor와 동일한 결과를 나타낸다. for-loop을
    사용하지 않는다. list도 선언하지 않는다.  readlines는 파일 전체를
    읽은 후, list에 line별로 넣기 때문에, code가 더 간단해 진다.


### write file {#write-file}


#### write() {#write}

```python
with open("./data/text.txt", "w") as fd:
    for i in range(10):
        fd.write(f"{i+1}번째 문장\n")
```

open으로 file을 열고, write()를 사용해서 string을 쓴다. string을
여기서는 fstring으로 만들어 주었다. 변수값이나, 객체값을
string으로 출력할 목적으로 fstring을 사용하는 것이다.


#### writeline() 사용 {#writeline-사용}

```python
with open("./data/text2.txt", "w") as fd:
    fd.writelines(f"{i+1}번째 줄입니다.\n" for i in range(10))
```

writelines()안에 for-loop이 있다. 계속해서 write를 할 수
있다. writelines()는 string을 write하는데,\n은 자동으로 포함하지
않는다. 따라서 필요할 경우, \n을 string 안에 넣어야 한다.


#### a(append) option 사용하기 {#a--append--option-사용하기}

```python
i = 10
with open("./data/text.txt", "a") as fd:
    fd.write("내용을 추가합니다.\n")
    fd.writelines(f"{i+1}번째 줄입니다.\n"
```

append mode는 file의 contents를 지우지 않고, 이어서 작성을 해주는
option이다.


### directory {#directory}

```python
import os

os.mkdir("test")       #folder가 이미 있으면 error

if not os.path.isdir("test"):
    os.mkdir("test")

os.makedirs("test/a/b/c", exist_ok=True)
```

os란 module은 directory를 생성하는 함수가 있다. mkdir이란 shell에서
사용하는 directory 생성명령어랑 동일하다. makedirs()는
subdirectory를 한번에 만드는 함수다. exist_ok=True는 이미 해당
폴더가 존재한다면 만들지 않고 pass한다. False는 새롭게
만든다. directory path에 사용되는 /문자는 window,linux 에 맞게
python이 변환해준다.


### listing directory {#listing-directory}

```python
import os

print(*[entry for entry in os.listdir('img')])
```

여기서 \*는 list unpacking 연산자다. 즉 list에 있는 item들을
unpacking 해서 출력하게 된다. \*가 없다면, list가 출력하게
된다. listdir함수는 directory를 인자로 받아서 포함된 file들을
listing한다.


### glob {#glob}

```python
import glob

print(*[entry for entry in glob.glob('img/*.txt')])
```

os.listdir()는 directory에 포함된 파일을 for-loop으로 가져오지만,
원하는 파일만 선별해서 가져오는건 아니다. 이럴때, shell에서
사용하는 다음과 같은 명령어가 그리울 수 있다.

```text
ls *.png
ls *.pdf
```

이것을 가능하게 해주는게 glob()다. 현재 폴더에서 원하는 것만
가져오는 프로그램을 짠다면, for-loop로 현재폴더의 file list를
꺼내서 if로 비교연산을 해야 하는것을 meta문자를 사용해서 shell에서
편리하게 하듯, python에선 glob()를 사용해서 이것을 shell에서 하듯이
할 수 있다. 보통의 string에서 "test/\*.img"는 그냥 문자열에
불과하다. glob()는 문자열에서 /와 \*을 meta문자로 처리한다. 즉 일반
문자가 아니라 다른 동작을 하게 meaning이 별도로 지정된것을
말한다. 즉 /는 디렉토리 path separator로 meaning이 정해져 있고, \*는
all character를 나타내는 것과 같다.


## pickle {#pickle}


### 객체의 직렬화. {#객체의-직렬화-dot}

program만이 file을 만들고 저장할 수 있다고 했다. 무슨 내용을
저장할까? 보통은 string으로 된 text file이나 program code를
compile한 binary file을 만든다. 에디터라는 program을 만든다면 file
io를 사용해서 이런 file들을 만들 것이다. 그런데 program만을 위한
file을 만들 필요는 없을까? 내가 작업하고 있는 객체를 file로
저장하고 필요할때 program에서 load해서 사용하는 형태로 말이다. 또한
file은 network전송이 가능하기 때문에 program에서 사용하고 있는
객체를 원격에 있는 program에서 사용할 수 있게 말이다. 이것은 어떻게
보면, program file을 만들고 원격에서 사용하는 것과 무엇이
다른가?라고 말할 수도 있다. 그런데 다르다. program을 파일로 보내서
compile해서 객체를 만들었다고 해서, data도 같은것은 아니다. 객체를
저장해서 보낸다는 것은 객체라는 구조와 객체가 가진 data를 같이
보내는 것이다. 그래서 객체를 저장하고 load하는 방식에 대한 연구가
이루어졌고 그 결과가 객체 직렬화이다. 객체가 가진 구조와 data를
저장하고 load하는 api를 만들었고 이것이 python에서
pickle이다. pikckle에서는 객체를 보내기위해서 class도 같이
보낸다.왜냐면 복원을 해야 하기 때문이다. 이것을 객체 직렬화라고
한다. 하지만, 객체 직렬화는 대중적이지 않다. 옛날 방식인 data만
보내고 객체의 구조에 맞게 data를 읽어서 parsing해서 넣어주는 방식이
선호된다. 대표적인게 json이다. json은 객체형태에 맞는 data만
보낸다. structure는 보내지 않는다.


### 객체 직렬화 pickle의 사용예 {#객체-직렬화-pickle의-사용예}

```python
import pickle

seq = [[ i * j for j in range(5)] for i in range(5)]

print(seq1)
with open("test.pkl", "wb") as fd:
    pickle.dump(seq,fd)

del seq

with open("test.pkl", "rb") as fd:
    seq = pickle.load(fd)

# print(seq[12][9])
```

위 코드에서 우선 살펴봐야 할것은 list comprehension이다. list
comprehension은 list안에서 for-loop을 사용할 수 있다는 것이다. list
comprehension의 for-loop는 item을 만들어낸다. item으로 list를
만들어낼려면, 위와 같이 list comprehension의 item에 해당하는
for-loop 앞에 위치한 곳에 list를 만들면, list안에 list item을 갖게
된다. 사용할 때는 seq[1][1] 이런식으로 사용한다.


### primitive 객체의 Seriaization. {#primitive-객체의-seriaization-dot}

pickle은 객체를 file에 읽고 쓸 수 있게 해준다. pickle의 dump()는
말그대로 dump한다. 덤프트럭에 담긴 객체를 file에 붓는다. 그리고
file에 있는 객체를 load()로 실어 return한다. pickle은
serialization이라고 보면 된다. 즉, serialization은 객체의 구조를
정의된 방식으로 file에 쓰고 객체 구조로 복원하게 된다. file에서
읽고 쓸때는 binary형태로 읽고 쓴다. 객체를 serialization해서
file에 저장했을때는 python이 저장한 방식으로 저장된 binary
file이다. 다른 언어에서 사용할 수 없다. python의 객체는 python에서
정의된 객체의 structure를 가지고 있기 때문이다. java는 java만의
객체구조가 있고, javascript는 javascript만의 객체구조가 있기
때문에 다른 언어에서 이것을 복원한다고 해도 사용할 수가 없다.

그리고 또하나 살펴봐야 하는것은 pickle에 의해 저장과 복원된 객체가
list라는 것이다. list는 primitive한 객체다 내부적으로
seriaization과 restoration이 정의되어 있기 때문에, pickle로 file에
썼다가 다시 복원하는게 가능하다.

primitive한 객체가 아닌, 내가 만든 class의 객체도 직렬화와 복원이
가능할까? 내가 만든 class의 attribute들이 모두 primitive한
객체라면 가능하다.


### my class의 직렬화 {#my-class의-직렬화}

```python
import pickle

class MyComplex:
    def __init__(self, real, imaginary):
        self.real = real
        self.imaginary = imaginary

    def __add__(self,other):
        return MyComplex(
            self.real + other.real,
            self.imaginary + other.imaginary
            )

my_complex = MyComplex(3,5)

with open("test.pkl", "wb") as fd:
    pickle.dump(my_complex,fd)

del my_complex

#del MyComplex
with open("test.pkl", "rb") as fd:
    my_complex2 = pickle.load(fd)

print(my_complex2.real)
print(my_complex2.imaginary)
```

우선 MyComplex라는 class의 attribute들은 모두 int type이라는
전제를 한다. 그래야 serialization이 가능하기
때문이다. my_complex라는 객체를 만들고, pickle을 사용해서 객체를
dump하고, load로 다시 복원 시켰다. my_complex라는 직렬화한 객체는
삭제하고, load()로 파일에서 복원한 것은 my_complex2라는 이름의
객체로 있게 된다. 이전 예제에서 list를 직렬화 복원과 큰 차이는
없다. 다만 여기서 차이가 있는것은 MyComplex라는 class가
삭제된다면, file에 있는 MyComplex class의 instance는 복원이
안된다는 것이다. del이라는 객체 지우는 명령어로 class를 삭제하고
복원하면 에러가 나는것을 볼 수 있다.


## csv(comma seperated values) {#csv--comma-seperated-values}


### csv 개요 {#csv-개요}

program에서 사용하는 data를 위한 file로는 예전부터 csv라는게
있었다. database도 program이 처리하기 위한 data를
저장한것이다. 그래서 일반 text파일과는 좀 다르다. program이
사용하기위한 data를 객체에 넣고 객체를 저장하고 원격에서 객체를
사용하기 위한방법으로 객체 직렬화라는게 나오긴 했지만, 이 방법은
대중화되지 않았다. program이 data를 처리하기위해서 필요한 data는
file이나 db에 넣고, 가져와서 program이 사용하는 방식의 옛날 방법이
더 선호된다. csv도 그런방식이다. data를 comma를 사용해서 저장하는
file. simple하다. excel파일도 comma separated value file이라고 볼
수도 있다. 아래와 같이 엑셀파일이 있다고 하자. 이런 data를 csv로
바꿀 수 있다.

```text
| id | Name | Loc     |
|  1 | cho  | seoul   |
|  2 | kim  | busan   |
|  3 | lee  | daegu   |
|  4 | park | Gwangju |
|  5 | choi | daejeon |
```

```text
id,Name,Loc
1,cho,seoul
2,kim,busan
3,lee,daegu
4,park,gwangju
5,choi,daejeon
```

text data를 저장할때, 아무런 규칙없이 txt로 저장하는 것보다,
csv파일로 data를 저장하고 처리하는게 더 효율적이다. comma가 아닌,
tab이나, 공백으로도 처리가 가능하기 때문에 확장자가 .tsv(tab),
.ssv(공백)인 파일들도 있다.


### csv 읽고 쓰기 {#csv-읽고-쓰기}


#### csv 읽기 - csv reader {#csv-읽기-csv-reader}

<!--list-separator-->

-  delimiter

    ```python
    import csv

    with open('test/test.csv','r') as fd:
        reader = csv.reader(fd,
                            delimiter=',',
                            quotechar='"',
                            quoting = csv.QUOTE_MINIMAL)
        for entry in reader:
            print(entry)
    ```

    csv의 reader()는 file에서 csv파일의 각줄을 읽고 구분자를 사용해서
    item을 뽑아내서 string으로 만든다. 그후 각각의 item을 원소로 하는
    list 객체를 만들어 return한다. delimiter는 구분자를
    말한다. 구분자를 사용해서 item을 가져온다.

<!--list-separator-->

-  quotchar

    그런데 만일 string안에 구분자가 있는 경우는 어떻게 될까?  예를
    들어보자. 다음과 같은 csv파일이 있다. delimiter가 ,로 csv reader를
    만들자.

    ```text
    id,name,loc
    1,"park,hoyoul","incheon"
    2,"lee", "seoul"
    ```

    이경우, 다음곽 같은 결과가 나온다.

    ```text
    : ['id', 'Name', 'Loc']
    : ['1', '"park', 'hoyoul"', '"seoul"']
    : ['2', 'kim', 'busan']
    ```

    ,를 기준으로 자른다. "는 그냥 문자일뿐이다. 그래서 "seoul"이라는
    item도 '"string"'으로 만들어지고, csv에서 string안에 ','가 있던,

    ```text
    "park,hoyoul"
    ```

    은 아래와 같이 가져온다.

    ```text
    '"park','hoyoul"'
    ```

    우리는 "park, hoyoul"이 하나의 item으로 뽑아낼 줄 알았다. 그런데
    ','에 의해서 string이 하나의 item이 아닌 2개가 되었다. 이것을
    제어할 필요가 있다. 그래서 quotchar를 설정하고 csv reader를
    만들어야 한다. 즉 quotchar가 " 라는 것은 " "로 둘러싼 string의 경우
    안에 delimiter가 있어도 무시하라는 뜻이다.

<!--list-separator-->

-  parsing option

    -   QUOTE_MINIMAL: 최소길이로 parsing한다. 이부분으 그냥
        default값을 쓰고 나중에 공부할 때 채워 놓기로 한다.


#### csv 쓰기 - csv writer {#csv-쓰기-csv-writer}

```python
import csv

with open('test/test1.csv','w') as fd:
    writer = csv.writer(fd,
                        delimiter=',',
                        quotechar='"',
                        quoting = csv.QUOTE_MINIMAL
                        )
    writer.writerow(['id', 'label'])
    writer.writerows([I, f'label_{I}'] for I in range(10))

```

csv파일을 with open으로 열고, fd를 csv reader에 넣어서 csv reader
객체를 만들듯이, csv writer도 쓸 파일을 with open으로 열고 fd를
가지고 csv writer객체를 만든다. csv를 어떻게 처리할 지에 대한
option도 넣어두고, 이렇게 하면 내가 만든 string을 원소로 한 list가
csv파일에 저장될 것이다. csv reader를 만들면, csv파일을 한줄 한줄
읽어서 string item으로 된 list객체를 return했었다. 쓰는것은
반대다. list를 만들어줘야 한다. string item을 가진 list를 만들고
writer의 writerow()를 사용해서 파일에 쓴다. 여러줄을 쓰기 위해서
writerows()를 사용하기도 하고, 한줄만 쓰기위해서 writerow()를
사용하기도 한다.


## json(javascript Object Notation) {#json--javascript-object-notation}


### json 개요 {#json-개요}

program을 위한 file이 있다고 했다. 즉, program에서 제공하는
structure와 data가 결합된 형태인 객체를 직접 file에 저장하고 꺼내서
사용하는 pickle을 말했었다. pickle과 같은 객체 직렬화 방식은
대중적이지 않아서 csv처럼 program이 필요한 data만 file에 저장하고
load하고, program의 structure는 program이 그대로 가지고 있는 옛날
방식을 사용한다고 했다. program은 적절한 구조를 만들고, csv파일에서
읽어서 객체를 초기화하는 방식이다. 그런데 csv형태에선 모든게
string이다. program에서 사용하는 structure는 여러 data type을
사용하는데, csv를 사용하면, parsing작업이 많아 진다. json은 객체의
구조에 적절한 data를 pre processing없이 사용할 수 있게 만든
방식이다. csv처럼 program에서 사용할 data만 저장한다는 면에서는
동일하다. 즉 객체를 저장하는 방법(structure+data)에서 data만 별도로
저장하는 방식인데, csv보다 upgrade된 방식이라고 볼 수
있다. key:value구조로 된 파일. csv파일의 모든 item들은 csv reader나
csv writer를 사용할 때, 모두 string으로 처리한다. 즉 csv reader로
읽을 때 모든 item들은 string이다. 저장할 때도 string으로 된 list를
csv파일에 저장한다. 이렇게 하는 이유는 csv파일 자체가 plain
text파일이기 때문이다. json은 programming에 친화적인 data저장용
파일이다. csv의 모든 data가 string인 반면에, json은 int형,
string형, list형 자료형태도 가질 수 있다. json파일 한개는 {}로
둘러싸인 object형이다.


### json 읽기 {#json-읽기}

```python
import json

with open('test/test.json', 'r') as fd:
    data = json.load(fd)

print(data['hobbies'])
print(data['hobbies'][2]['sports'][0])
```


### json 쓰기 {#json-쓰기}

```python
import json

obj = {
    "ID": None,
    "bool": False,
    "bobbies": {
        "sports": [
            "snowboard"
            "volley-ball"
            ]
        }
    }
with open("test/test2.json", 'w') as fd:
    json.dump(obj, fd)
```

csv파일을 쓸때는 csv파일에 들어갈 형태로 program에서 만든다. 들어갈
형태는 string을 item으로 갖는 list였다. 그리고 write했다.

```text
['a','b','c']
```

json도 똑같다. json에 들어갈 형태로 program내에서 만들어야
한다. json파일에 들어갈 형태라는 것은 dictionary object의
형태다. 따라서 위의 obj dictionary처럼 key:value형태로 data를
만들어서 json파일로 저장한다.

일반적으로 program에선 객체를 가지고 작업을 한다. python에서 주로
객체를 사용한다. program에서 주로사용하는 객체를 인간이 이해할 수
있는 string이나, file에서 사용하기위해서 많은 program적 요소들이
존재한다. string을 보자. 우리는 string을 literal하게 string을
작성하지 않았다. string을 만드는 것은 file에 저장하거나, 화면에
보여준다. 이때, 순수하게 순전히 string을 작성해서 보여주거나
저장하지 않는다. 왜냐하면, program에서 주로 다뤄지는건 객체이기
때문에 객체정보를 string이나 file에 쉽게 포함되게 하는 방법이
필요했다. 왜냐? 우리가 file에 저장하거나 화면에 보여줄것은 string
literal이 아닌 객체 값이기 때문이다. 그래서 string안에 객체의 값을
넣기 위해서 format이라던가, %표현, fstring을 사용했다. 마찬가지로
file도 string literal이 저장될 꺼라고 생각할테지만, 그렇지
않다. 객체의 값을 꺼내서 file에 저장하기 때문이다. python에서
사용하는 dictionary 객체, list객체등에 있는 값을 꺼내서
저장하기에는 json구조가 잘 맞는다.

아니 그렇다면, programming에서 사용되는 객체를 파일에 저장하기에
적합한 pickle을 사용하면되지 json을 사용할 필요가 있을까? pickle은
모든 객체를 저장한다는 보장이 없다. 일부객체에만 사용할 수 있기에,
객체의 내용을 적절하게 json object형태로 만들고, json파일로
저장하는 방식이 모든 객체에 적용할 수 있기 때문에 더 인기있는
방식이 되었다. json object형태로 만들고 json파일에 저장하는것은
어떻게 보면 객체 직렬화와 동일하다. 1,"abc"같은 값들이
program내에선 객체다. 그리고 그것을 file에 쓸때는 객체 직렬화를
거치기 때문에, json파일로 저장하는건 객체 직렬화가 수행된다고 볼 수
있다. 그래서 program내에서 만든다는 json object의 구성품들은 모두
직렬화가 가능한 primitive data type이라는 것을 알수 있다.


## XML(Extended Markup Lanugage) {#xml--extended-markup-lanugage}


### xml 개요 {#xml-개요}

csv에서 string만 사용한다는 단점을 json은 잘 극복했다. program에서
주로 사용하는 int, list와 같은 다양한 종류의 data도 사용할 수 있게
했다. 원래 객체를 저장하려는 방식(직렬화)에서 객체의 구조를
떼어내고 data만 저장하고 load하겠다는 의도였기 때문에 json은 구조도
객체형태의 data이기 때문에 매우 적합하다. xml은 json과 비슷하게
사용된다. 하지만 xml은 시작이 다르다. json은 program이 사용하는
객체를 혹은 program의 일정 단위를 파일의 형태로 저장및 복원하는
객체 직렬화의 대안으로 나온 구조이기 때문에 객체가 가진 구조적
특징, 이름, 여러종류의 data type을 key:value형태로 해서 비슷하게
구현했기 했다. 즉 json객체를 load만 잘하면, 그대로 program의 객체를
저장하고 load하는 직렬화랑 거의 비슷하게 된다. xml은 program을
위한게 아니라, 사람들이 보는 문서를 tag를 사용해서 좀더 구조적으로
만든것이다. tag에는 name에 해당하는 tag도 있고 attribute들을 설정할
수 있기 때문에, json과 거의 비슷하게 사용될 수도 있다. json이
객체가 가진 data를 객체의 구조에 맞게 만들었듯이 xml도 객체가 가진
구조에 맞게 만든다면 json처럼 사용될 수 있을 것이다. 하지만
역사에도 보았듯이 xml은 인간이 보는 text파일을 구조적으로 작성한
방식이라서 tag라는것도 객체를 위한것이라기 보단 문서를 어떤식으로
보이게 할 것인가? 그런데 촛점을 둔 문서다. html을 보면 알 수 있을
것이다. 따라서 json처럼 객체를 위한 data저장 파일로 보면
안된다. xml은 이미 html형태로 대중화가 되어있다. python에서는 xml을
파싱해서 적절한 처리를 할 library를 제공할 뿐이다. python에선 xml을
parsing할 수 있다는건 수많은 인터넷 문서, 즉 html로되어 있는 문서를
가지고 와서 program이 사용할 수 있다는 큰 장점이 있다. json과는
의도 자체가 다르다. xml문서는 순전히 data의 역할을 할뿐이다. 일반
책이나 문서파일이라고 봐도 된다. tag라는 부가적 정보가 있을뿐이지
그냥 data다. json처럼 code의 structure를 고려할 필요가 전혀
없다. 그냥 data다. 어떻게 보면, csv도 마찬가지다. 순전한 data다.


### xml parsing {#xml-parsing}


#### beautifulsoup {#beautifulsoup}

xml 파일을 처리하기 위한 default library를 제공하긴 하나,
불편하다. parsing을 위한 외부 library가 존재한다. beautifulsoup을
사용하면 xml문서에 대한 처리가 가능하다.


#### beautifulsoup 설치 {#beautifulsoup-설치}

```text
conda install beautifulsoup4
```


#### xml 파일 읽기 by beautifulsoup {#xml-파일-읽기-by-beautifulsoup}

<!--list-separator-->

-  예제

    ```python
    from bs4 import BeautifulSoup

    with open("test/test.xml", "r") as fd:
        soup = BeautifulSoup(
            fd.read(),
            'html.parser'
            )

    to_tag = soup.find(name='to')
    print(to_tag.string)

    for cite_tag in soup.findAll(name = 'cite'):
        print(cite_tag.string)

    cites_tag = soup.find(name='cites')
    print(cites_tag.attrs)
    print(cites_tag['attr'])

    cites_tag = soup.find(attrs={'attr': 'name'})
    for cite_tag in cites_tag.find_all(name='cite'):
        print(cite_tag.string)
    ```

    Beautifulsoup은 xml파일을 읽고 parsing을 한다. file을 읽고
    처리해야 하기 때문에, with open절을 사용한다. fd.read()는
    xml파일을 읽고, 지정된 parser로 parsing한다. 이렇게 하면
    Beautifulsoup 객체는 xml의 모든 내용을 접근할 수 있다.

<!--list-separator-->

-  find()

    soup에서 가장 많이 사용하는건 find()다. tag를 찾아서, tag의
    값이나, tag의 속성을 가져올 수 있다.

    ```text
    mytag = soup.find(name=tag)
    print(mytag.attrs)
    print(mytag.string)
    print(mytag['attr'])
    ```

    find()로 tag를 찾은후 tag의 속성은 attrs로 접근하고, tag의 값은
    string으로 접근한다. tag의 속성은 dictionary형태이기 때문에
    위처럼 mytag['attrs']로 접근이 가능하다.

    속성으로 tag를 찾을 수도 있다. 속성은 dictionary형태이다. 따라서
    아래처럼 찾는다.

    ```text
    cites_tag = soup.find(attrs={'attr': 'name'})
    ```

<!--list-separator-->

-  findAll()

    find()는 find(name='tag')로 해서 하나의 tag를 찾는다면,
    findAll(name='tag')는 같은 이름의 tag를 찾아서 sequence로
    만든다. sequence로 만들면, for-loop에 사용할 수 있다.

<!--list-separator-->

-  find_all()

    findAll()는 xml내에서 정의된 tag를 모두 찾는다면, find_all()는
    찾은 객체 내에서 검색이 가능하다.

    ```text
    cites_tag = soup.find(attrs={'attr': 'name'})
    for cite_tag in cites_tag.find_all(name='cite'):
        print(cite_tag.string)
    ```

    위에서 보면, cites_tag는 속성을 갖는 tag를 가져오는데, tag는
    하나의 객체로 봐도 된다. 가져온 tag안에 sub tag들이 엄청 많을 수
    있다. 그 tag안에 검색을 한다. find_all(name='cite'), 즉 cite라는
    tag가 있다는 뜻이다.


## YAML(YAML Ain't Markup Language) {#yaml--yaml-ain-t-markup-language}


### 개요 {#개요}

객체 직렬화는 program에서 객체를 파일로 저장하고 복원하겠다는
idea다. program을 위한 file을 만들고 사용하겠다는 based idea가
있었다고 했다. 그래서 pickle도 있었지만, 대중화되지 않고, 옛날방식,
data는 file에 저장하지만 복원시 parsing을 통해 적절하게 객체를
초기화하겠다는 생각이 지금도 널리 사용된다고 했다. 그래서 json이란
형태로 객체의 data를 저장하고 복원하는 방식이 인기가
있었다. json에도 많은 문제가 있다.


### json의 문제점 {#json의-문제점}

-   주석을 지원하지 않는다.
-   큰따옴표만 지원한다.
-   escape문자의 처리가 힘들다.


### YAML {#yaml}

-   json처럼 객체, dictionary, list를 나타낼수 있고, 위에 말한
    단점들도 다 보완했다.
-   yaml은 json의 superset으로 보면 된다.

-   dictionary 표현법
    ```text
    doe: "this is a value"
    pi: 3.141592
    xmas: true
    ```

-   list 표현법
    ```text
    calling-birds:
    ​  - huey
    ​  - dewey
    ​  - louie
    ​  - fred
    ```

-   dictionary 안의 dictionary
    ```text
    xmas:
        tree-birds: four
        french-hens: 3
    ```
    tab을 사용해서 inner dictionary를 표현한다.


### 설치 {#설치}

```text
conda install pyyaml -c anaconda
```


### yaml 읽기 {#yaml-읽기}

```python
import yaml
import pprint

with open('test/test.yaml') as fd:
    data = yaml.load(fd, Loader = yaml.FullLoader)

pprint.pprint(data)
```

위에서 with open에 'r'은 생략할 수 있다. pprint는 standard
library라서 import해서 사용하면 된다.

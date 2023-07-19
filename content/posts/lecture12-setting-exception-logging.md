+++
title = "lecture12-setting-exception-logging"
author = ["holy"]
description = "python의 exception longgin처리에 대해서."
date = 2023-06-05T00:00:00+09:00
draft = false
+++

## Command Line Argument {#command-line-argument}


### 개요 {#개요}

python을 실행할때, gpu개수, epoch같은 변수들을 program이 동작할때
cmd line interface에서 argument에서 전달받겠다, 입력받겠다고 처리할
수 있다. program안에서 상수값으로 처리하는게 아니라, program을
실행할 때, 해당 값을 설정해서 실행하는 것이다.

```text
(1) python main.py
(2) python main.py arguments
(3) python main.py --options 12345
```

위와같이 program을 실행할 때, 아래와 같이 하면 command line
argument를 건네 받을 수 있다.

```python
import system
print(sys.argv)
```

각각의 결과는 아래와 같다.

```text
(1) python main.py => ['main.py']
(2) python main.py arguments  => ['main.py', 'arguments']
(3) python main.py --options 12345  => ['main.py', '--options', '12345']
```

argument들은 공백을 기준으로 item이 도출된다. parsing이
복잡하다. item이 string형태라서 int,float로 형변환도 해야 하기
때문에 쉽게 사용할 수 있는 argparser를 사용한다.


### argparser 사용법 {#argparser-사용법}

```python
import argparse

parser = argparse.ArgumentParser()
parser.add_argument('-l', '--left', type= int)
parser.add_argument('-r', '--right', type= int)

parser.add_argument('--operation',
                    dest='op',
                    help='Set Operation',
                    default='sum')
args = parser.parse_args()
print(args)

if args.op == 'sum':
    out = args.left + args.right
elif args.op == 'sub':
    out = args.left - args.right
print out

```

argv로 cmd명령어와 option을 하나의 문자열로 입력받아 parsing해서
처리하지 않고, 위와 같이 argparse 모듈을 사용하면, option에 대한
처리를 미리 정의할 수도 있다. 짧은 option과 긴 option을 사용해서
받아올 값의 type도 설정이 가능하다. 어떻게 사용하는지 정리해 보자.

-   ArgumentParser라는 객체를 만든다.
-   이 객체에서 argument에 대한 설정을 할수 있다.
    ```text
    parser.add_argument('-l', '--left', type= int)
    parser.add_argument('-r', '--right', type= int)

    parser.add_argument('--operation',
                   dest='op',
                   help='Set Operation',
                   default='sum')
    ```

-   command argument가 program에 전달되면, parsing이 가능하다.
    ```text
    args = parser.parse_args()
    ```

-   add_argument로 정한 argument값에 대한 접근을 할 수 있다.
    ```text
    args.left, args.right, args.op로 접근 가능
    ```
    args.operation은 dest옵션으로 args.op로 접근 가능하다.


## Exception Handling {#exception-handling}


### 개요. {#개요-dot}

-   0으로 나누거나,
-   파일을 열었는데, 해당 파일이 없다거나,
-   server와 연결이 끊겼을 때..

이런 예외가 발생했을때, 다른 대응 코드를 사용해서 처리해야
한다.


### try except 코드 {#try-except-코드}

예외 발생이 예상되는 코드가 있다. 그 code에 다음과 같이 처리하면,
예외가 발생했을 때 그냥 program이 종료하는게 아닌, 적절한 대응을
해서 계속 진행이 가능하다.

```text
try:
   <예외 발생 가능 코드>
except <예외클래스>:
   <대응 코드>
```


### exception handling example {#exception-handling-example}

```python
for i in range(-5,5):
    try:
        print(10/i)
    except ZeroDivisionError:
        print("Zero Division, skip the number.")
```

i가 0이 되면 zero division error가 발생한다. try exception처리가
없다면, program은 종료한다. exception처리를 했기 때문에 for-loop를
계속 진행한다.


### Built-in Exception {#built-in-exception}

| Exception class     | 설명                | 발생 가능 예시            |
|---------------------|-------------------|---------------------|
| Index Error         | List의 index범위를 넘어감. | list[001]                 |
| Name Error          | 존재하지 않는 변수를 호출 | not_exist+1               |
| Zero Division Error | 0으로 숫자를 나눔   | 10/0                      |
| Value Error         | 반환할 수 없는 문자열/숫자를 변환 | float("abc")              |
| FileNotFoundError   | 존재하지 않는 파일 호출 | open("not exist.txt","r") |

이것 외에도 많은 built-in exception들이 있다.


### Exception class {#exception-class}

Exception들은 BaseException에서 상속받은 class들이다.

{{< figure src="img/class-uml.png" >}}

exception이 inheritance를 갖기 때문에 try except에서 처리할 때 부모
class를 잡아서 처리하는게 효율적이다. 참고로 위 tree에서
exception처리할 수 있는 class는 Exception아래 클래스만 해당한다.

```text
try:
except Lookuperror:

```

이렇게 하면, index error와 key error에 대한 처리가 가능하다. 사용자
정의 Exception도 만들 수 있는데, 만들기 위해선 Exception class를
상속해서 만들면 된다.


### Raising &amp; Referencing Exception {#raising-and-referencing-exception}

raise구문으로 예외를 발생시킬 수 있다. 그리고 as 구문으로 잡힌
에러를 참조 할 수 있다.

```python
try:
    while True:
        value = input("A,B,C중 하나를 입력하세요:")
        if len(value) ==1 and value not in "ABC":
            raise ValueError("잘못된 입력입니다. 종료합니다.")

        print("선택된 옵션:", value)
except ValueError as e:
    print(e)
```

위 코드에서 raise로 Exception객체를 만든다. 이렇게 만들어진
exception객체는 except구문에서 잡을 수 있다. ValueError 클래스
객체라면 e로 잡고, e를 출력하면 Exception객체가 가진 값을 출력한다.
만일 except문에서 처리하지 못한다면, program은 종료하게 된다.


### Assertion {#assertion}

assert문이 있다. 조건을 확인해서 참이 아닐때 AssertError를
발생한다. raise가 무조건적인 error를 발생시킨다면, assert는 조건을
확인하고 발생시킨다.

```text
assert <조건>
assert <조건>, <에러 메시지>
```

```python
def add_int(param):
    assert isinstance(param,int), "int만 된다."
    return param+1

try:
    print(add_int(10))
    print(add_int('str'))

except AssertionError as e:
    print(e)
```

try except는 try~catch구문과 동일하다. add_int가 try문에 걸려
있는데, 여기서 assert문이 있다. param이 int가 아니기 때문에
AssertionError가 발생한다. 그리고 except에서 해당 error를 catch해서
처리한다.


### post-error processing {#post-error-processing}

try-except문에는 except로 error를 잡아서 처리하는 것 외에 다른
처리를 할 수 있게 else와 finally같은 keyword가 존재한다. 3개의
각각의 경우를 비교해 보자. functions()에서 SomeError가 발생하거나 다른 Error가 발생하지 않을때, 대비하는 코드인 except, else, finally가 어떻게 수행되는 지 보자.


#### except만 있는 경우 {#except만-있는-경우}

```python
try:
    functions()
except SomeError as e:
    print(e, "예외 발생")

print("예외 이후")
```

1.  예외발생이 없는 경우
    "예외 이후"를 출력.
2.  SomeError가 발생한 경우
    "예외 발생"을 출력
    "예외 이후"를 출력.
3.  다른 예외가 발생한 경우.
    프로그램 비정상 종료


#### else가 있는 경우 {#else가-있는-경우}

```python
try:
    functions()
except SomeError as e:
    print(e, "예외 발생")
else:
    print("예외 이후")
```

else의 의미가 좀 애매하다. 왜냐면, try-except에서 처리가 되는
경우에 대한 else이기 때문이다. 즉 except에서 처리가 되지 않는
경우는 else를 수행하기 때문이다.

1.  예외발생이 없는 경우
    "예외 이후"를 출력.
2.  SomeError가 발생한 경우
    "예외 발생"을 출력
3.  다른 예외가 발생한 경우.
    프로그램 비정상 종료


#### finally구문이 있는 경우 {#finally구문이-있는-경우}

```python
try:
    functions()
except SomeError as e:
    print(e, "예외 발생")
finally:
    print("예외 이후")
```

finally구분은 모든 경우에 출력되는 것을 볼 수 있다.

1.  예외발생이 없는 경우
    "예외 이후"를 출력.
2.  SomeError가 발생한 경우
    "예외 발생"을 출력
    "예외 이후"를 출력.
3.  다른 예외가 발생한 경우.
    "예외 이후"를 출력.
    프로그램 비정상 종료


### Exception Handling Example {#exception-handling-example}

```python
for i in range(5,-5,-1):
    try:
        value /= i

    except NameError:
        print("No value on Value: set 0")
        value = 10

    except ZeroDivisionError:
        print("Zero Division: Skip")

    except Exception as e:
        print(type(e),e)
        raise e

    else:
        print(value)

    finally:
        print("step")
```

첫번째로 발생하는 error는 NameError다. NameError가 발생하는 이유는,
value /= i에서 발생한다. 이것은 value = value/i인데 좌변은 문제
없지만 우변이 문제가 있다. 우변의 value는 값을 가지고 있지
않다. 따라서 NameError가 발생한다. 그리고 finally가
수행된다. finally는 try except에서 처리하던 안하던, 수행이 되는
구문이기 때문이다. else는 try-except에서 error를 처리하지 못하면
수행된다. 따라서 zerodivisionerror가 발생한 이후는 계속해서 else와
finally만 수행되게 된다.


## Logging 처리 {#logging-처리}


### 개요 {#개요}

program안에서 일어난 일을 logging할 수 있다고 한다. debug를 위해서
logging을 할 수도, 사용자 패턴파악을 위해서 logging을 할 수 있다고
한다.


### Logging module 사용 {#logging-module-사용}

```python
import logging

logging.debug("디버깅")
logging.info("정보 확인")
logging.warning("경고")
logging.error("에러")
logging.critical("치명적오류")
```

상황에 따라 다른 level의 log출력이 가능하다고 한다. 아래 처럼
level을 갖는 log를 보여준다.

-   debug &lt; info &lt; warning &lt; error &lt; critical

디버그를 할때 print debug라는게 있다. 즉 tracer를 사용해서
debugging을 할 수도 있지만, 값을 찍어서 확인할 수도 있는데, 그때 이
log 모듈을 사용할 수 있다. log가 level이 있다면, 저장될때도,
level에 따라 file에 저장되거나, 혹은 화면에 출력되는것도
결정하는걸로 알고 있는데, 그것에 대한 설명은 없다. 다만 아래 표를
읽어줬는데, 이표만 가지고는 별 도움이 안되는거 같다.

| level    | 설명                           | 예시                                |
|----------|------------------------------|-----------------------------------|
| DEBUG    | 상세한 정보, 문제를 진단할 때 사용 | 변수 A에 값대입, 함수 F호출         |
| INFO     | program이 정상동작중 발생하는 event보고 | 서버시작, user의 서버접속           |
| WARNING  | 예상치 못한 일이 발생하거나, 발생할 문제에 대한 보고 | 문자열 대신 숫자 입력, 인자로 들어온 list가 길이가 안맞음 |
| ERROR    | 오류가 발생했으나 program은 동작가능 | 파일이 없거나 외부 서버 연결이 불가능 |
| CRITICAL | 심각한 오류 발생, 프로그램이 실행되지 않을 때 | 중요 파일이 없거나 사용자 강제 종료시 |


### root logging {#root-logging}

왜 root logging이라고 부르는지는 모르겠다. 하지만 여기서 logging을
할때 저장되는 문자열에 root가 있다고 한다. 예를 들면,

```text
WARNING:ROOT: this is warning message
ERROR:ROOT: this is error message
```

```python
import logging

logging.basicConfig(
    filename='test.log',
    level=logging.INFO
    )
logging.debug("기록 안됨")
logging.info("기록 됨")
logging.ERROR("기록 됨")
```

basicConfig에서 설정하는 내용을 보면 log가 저장될 파일과 level이
정해진다. debug가 기록되지 않는 이유는 info보다 level이 낮기
때문이다. 우리가 program을 개발할때, develop단계에서는 debug를
위해서 print문을 많이 쓴다. 그리고 그 코드가 product단계로 가서,
그대로 출시될 수도 있다. logging을 사용하면 그런 문제를 막아줄 수
있다. logging에서 print의 level을 정할 수 있기 때문에, basic
config만 설정하면된다. print문이 많다면, 모든 print문을 찾아서
지우거나 혹은 필요한것만 남겨야 하는데, logging을 사용하면 간단히
처리할 수 있다.


### logger management {#logger-management}

root logger가 아닌, 새로운 이름의 logger를 만들기 위해선,
getlogger를 사용한다고 한다.

```python
import logging

logging.basicConfig(
    filename='test.log',
    )
# logger = logging.getLogger("main") # 새로운 logger생성
logger = logging.getLogger(__name__) # module이름으로 logger생성
logger.setLevel(logging.INFO)

logging.info("Root에 info 기록")
logging.warning("Root에 warning 기록")

logging.info("메인에서 info기록")
logging.warning("메인에서 warning기록")
```

basicConfig라는게 root logger의 설정이라고 한다. 하지만 getLogger로
새로운 user logger를 만들면 root logger의 설정을 그대로 사용하게
된다고 한다. 강의가 좀 부실하다. 나중에 더 조사해야 할듯하다.

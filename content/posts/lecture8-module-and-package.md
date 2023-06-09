+++
title = "lecture8-module-and-package"
author = ["holy"]
description = "python의 module과 package에 관해서"
date = 2023-06-05T00:00:00+09:00
draft = false
+++

## module {#module}


### import 사용법 {#import-사용법}

module은 .py로 끝나는 파일 한개를 의미한다. python으로 작성된 모든
file들은 python module이라고 부를 수 있다. import구문으로 module을
불러올 수 있다. 예를 들어보자. 내가 작업하고 있는 file에서
functions.py라는 파일에 있는 qr()를 사용하고 싶다면, 우선 import로
가져와야 한다. 가져온다기 보단, 실행한다고 말을 해도 된다. 오히려
그게 직관적이다. 여튼 가져오던 실행하던 문맥에 맞게 이해하면 된다.

```text
import functions

print(functions.qr())
```

import로 가져온 file의 함수를 사용하기 위해선, 모듈명.함수명()으로
사용한다. import로 가져온 함수다라는 꼬리표를 달아두는
것이다. import뒤에는 module이 올수도 함수나 변수가 올 수도
있다. import뒤에 모듈이 올 경우에는 모듈 이름으로 class를 만들고
module이 담고 있는 내용이 복사가 된다고 생각하면 된다.


### import 사용시 주의점 {#import-사용시-주의점}

내가 작업하는 파일에서 import로 모듈을 가져올 때, 가져올 파일은
내가 지금 작업하는 파일과 같은 폴더이거나 하위폴더에 있어야
한다. 그래야 가져올 수 있다. 상위폴더는 안된다.python interpreter는
import로 모듈을 가져오면서 처음부터 끝까지 읽고 객체들을
만든다. 만일 모듈에 print문이 있다면, 그냥 출력시킨다.


### module의 이름 {#module의-이름}

이전에 말했듯이 .py로 끝나는 파일을 module이라고 했고, 파일의
이름이 module의 이름이다. 그런데, 특이한게 있다. main이라는
module 이름이다. 이것은 python에 의해서 정해진 이름이다. 다음을
보자. 나는 test.py라는 파일을 만들고, 모듈이름을 출력하는 코드를
만들었다.

```text
print(__name__)
```

```text
python test.py
```

이렇게 실행하면, test라는 이름이 출력되야 한다. 우리는 test
module을 실행시켰기 때문에 test가 출력되야 하는데, main이라는
이름이 출력된다. python에 의해 실행되는 file의 모듈이름은 main인
것이다. 모듈이 실행되는 경우는 2가지다. python interpreter에
의해서 직접적으로 실행되거나, import문에 의해서 실행될 수
있다. 직접 실행되는 module의 이름은 main이 되고, 나머지는
파일이름을 module이름으로 갖는다.

main이란 module이름을 가장 많이 사용하는 예에는 다음과 같은 경우가
있다.

```text
if __name__ == '__main__':
```

즉, python에 의해서 실행된 파일인 경우, 파일이름과 상관없이
수행하게 된다는 뜻이다. python으로 직접 실행하면, main이라는
이름을 갖기 때문이다.


### import하는 예시들. {#import하는-예시들-dot}

우선 가정을 하자.

<a id="figure--구조"></a>

{{< figure src="./img/import-example1.png" caption="<span class=\"figure-number\">Figure 1: </span>구조." >}}

위와 같이 functions.py라는 파일이 directory라는 폴더 아래에 있다고
하자. main.py에는 아래와 같이 import할 수 있다.

```text
import directory.functions
print(directory.functions.add(1,2))
```

import뒤에는 module이 올수도 있고 함수나 변수가 올수도
있다. import뒤에 module이 오는 경우, class를 만든 후 붙여
넣기한다. import할 module이 같은 폴더내에 없다면, 경로를 위와같이
명시해야 한다. 그래야 정확하게 현재 파일의 윗 부분에 붙여
넣는다. 붙여 넣을때, directory라는 class가 만들어지고, 그 안에
functions라는 class가 만들어진다고 보면 된다. 따라서 그 안의
add라는 함수를 사용할 때는 위와 같이 꼬리표를 달아야 한다.

```text
import directory.functions as func
print(func.add(1,2))
```

as는 alias의 준말이라고 한다. 2개의 class를 만들어서 import하는게
아니라, as를 사용해서 func라는 class를 만들고, 그 안에 붙여
넣는다.

```text
from directory import functions
print(functions.add(1,2))
```

from이라는게 나왔다. from은 경로만 얘기한다. functions를
import하겠다. functions의 위치는 directory아래에 있다. functions은
module이다. 따라서 functions라는 class를 만들고, functions의
내용을 다 붙여 넣기 한다. functions class의 내용을 사용할때는
class의 함수를 사용하기 때문에 class이름을 사용하여 접근한다.

```text
from directory.functions import add
print(add(1,2))
```

위에 표기법과 비슷하다고 생각할 수 있다. 근데 import뒤에 있는건
module이 아니라 function이다. module이 아니기 때문에 class를
만들고 copy &amp; paste를 하지 않고, 바로 copy &amp; paste할 것이다.
하지만, 여기서 알아야 하는건 import뒤에 module이 아닌
function이라는게 올 때는 조건이 필요하다는 것이다. from으로
module을 지정해야 한다. 그렇지 않고, import로 직접 function이나
variable을 가져오면 에러가 난다. 예를 들면 다음과 같은 경우가
있다.

```text
import directory.functions.add
```

import만 쓰이는 경우는 module을 써야 하는데, add는 function이라서
에러가 난다.

```text
import add
```

```text
from directory.functions import *
print(add(1,2))
```

이것도 import하는게 module이 아니다. 그래서 그대로 functions
module의 모든 내용을 copy &amp; paste한다. 이것은 문제가 될 수
있다. 내가 작성한 함수와 import로 가져온 함수가 동일할 때,
overwrite가 된다.

주의 해야할게 있는데, import는 module,변수,함수만 할 수
있다. 경로라고 생각하면 안된다.

<a id="figure--example"></a>

{{< figure src="./img/import_example3.png" caption="<span class=\"figure-number\">Figure 2: </span>example" >}}

예를 들어 위에서 directory를 import하고, 하위 모든것이
import된다고 생각해선 안되는 것이다.


### import 예시2 {#import-예시2}

import할 때, 파일의 경로문제가 있다. main module과 import하는
module의 경로에 따라서 다음과 같은 에러가 발생할 수 있다.

```text
ImportError: attempted relative import with no known parent package
ValueError: attempted relative import beyond top-level package
```

경로에 따른 import문제가 발생하는 이유는, 경로는 main모듈 기준으로
상위폴더에 접근이 되지 않는다. 또한 하위폴더들은 절대경로로
주어지며, package를 사용했을 때만이 상대경로를 사용하여 상위폴더나
하위폴더에 접근할 수 있기 때문이다.


#### import의 경로(상위폴더와 경로의 기준) {#import의-경로--상위폴더와-경로의-기준}

<a id="figure--import example2"></a>

{{< figure src="./img/import2.png" caption="<span class=\"figure-number\">Figure 3: </span>import example2" >}}

경로의 개념이 os기준도 아니고, python interpreter기준도 아니고,
main모듈 기준이라고 했다. function2 module을 import해서 경로가
어떤 것을 의미하는지 확인해 보자.

1.  function2에 대한 경로 import
    ```python
    import Users.holy.temp.pythontest.test_nlp.parent_dir.mydir.child_dir1.functions2
    Users.holy.temp.pythontest.test_nlp.parent_dir.mydir.child_dir1.functions2.sub(3,2)
    ```

    ```text
    python main.py
    ```
    import의 경로는 os의 root를 기준으로 설정했다. 에러가 나지
    않는다면 import의 경로는 os기준이다.라고 말할 수 있을
    것이다.

    <a id="figure--import error"></a>

    {{< figure src="./img/import_error1.png" caption="<span class=\"figure-number\">Figure 4: </span>import error" >}}

    경로라는게 os입장에서의 절대경로가 아닌것을 알 수 있다. 그렇다면
    혹시 python의 실행위치가 경로의 기준인 top-level directory일까?
    ```python
    import parent_dir.mydir.child_dir.functions2
    parent_dir.mydir.child_dir.functions2.sub(3,2)
    ```

    ```text
    python parent_dir/mydir/main.py
    ```
    python의 실행위치는 project의 최상단에서 시작한다. python
    실행위치 기준에서는 parent_dir이 하위디렉토리이기 때문에, 위와
    같이 import하면 경로를 인식할 수 있을것이다.

    <a id="figure--error2"></a>

    {{< figure src="./img/import_error2.png" caption="<span class=\"figure-number\">Figure 5: </span>error2" >}}

    그런데 python은 하위폴더인 parent_dir도 인식하지
    못한다. top-level directory가 파이썬의 실행위치가 아님을 알 수
    있다. 그러면 main module 기준인가? 확인해 보자. main module을
    기준으로 하위폴더의 function2를 import해서 test해보자.

    -   function2의 import
        ```python
        import child_dir1.functions2
        child_dir1.functions2.sub(3,2)
        ```

        ```text
        python parent_dir/mydir/main.py
        ```
        <a id="figure--import success"></a>

        {{< figure src="./img/import_success1.png" caption="<span class=\"figure-number\">Figure 6: </span>import success" >}}

        성공적으로 import하는 것을 알 수 있다.


#### package와 import 상대 경로 {#package와-import-상대-경로}

python으로 program을 만들때, file하나만 만들어 사용하지
않는다. 여러개의 file을 import해서 사용하고, 배포를 통해서
다른사람에게도 전달한다. 그래서 package라는게 나왔다. 정해진
규격에 따라 여러 파일들을 모아서 배포도 가능하고 그 자체가 하나의
독립적인 program이 되는 것이다. main.py같은 main 모듈은 package를
사용할 뿐이지, package에 포함되는 건 아니다. package에서
import문은 여러 특징이 있다. python에서 package를 만들어 test해보자.

package를 만드는 것은 간단하다. folder안에 <span class="underline"><span class="underline">init</span></span>.py를 만들어
넣으면 package가 된다. <span class="underline"><span class="underline">init</span></span>.py가 하는 역할은 단순히 이 폴더가
package라고 말하기도 하지만, import를 처리하기도 한다. 기존
import구문을 확장해서 처리한다. import구문에서는 module,
함수,변수만이 올 수 있었다. 그런데, <span class="underline"><span class="underline">init</span></span>.py를 사용해서
import뒤에 폴더가 오게 할 수도 있다. 또한 상대경로도 사용할 수
있다.

<!--list-separator-->

-  import뒤에 폴더가 오는 경우

    우선 다음과 같이 game이란 package와 package를 이용할 main.py를 만들었다.

    <a id="figure--package example"></a>

    {{< figure src="./img/package_example1.png" caption="<span class=\"figure-number\">Figure 7: </span>package example" >}}

    game package안에는 <span class="underline"><span class="underline">init</span></span>.py가 있어서 package를
    나타낸다. sound도 또다른 package다. sound에는 echo모듈 아래
    echo_test()가 있다. main에서 이 함수를 import해서 사용해 보자.

    ```python
    import game.sound.echo
    game.sound.echo.echo_test()
    ```

    <a id="figure--package test"></a>

    {{< figure src="./img/package_test1.png" caption="<span class=\"figure-number\">Figure 8: </span>package test" >}}

    별다른 문제없이 실행되는 것을 볼 수 있다. 다음을 test해보자.

    ```python
    import game
    game.sound.echo.echo_test()
    ```

    <a id="figure--package test2"></a>

    {{< figure src="./img/package_test2.png" caption="<span class=\"figure-number\">Figure 9: </span>package test2" >}}

    당연히 에러가 나온다. 왜냐면 import뒤에는 module이 나오거나,
    from이 있다면, function, 변수가 나와야 하는데, game이란 그냥
    폴더가 나왔기 때문이다. 그래서 에러가 나온다. 그런데 package에선
    이것이 가능할 수 있다.

    game의 <span class="underline"><span class="underline">init</span></span>.py에 다음을 추가하자.

    ```python
    import game.sound.echo
    ```

    그리고 아까와 동일하게 main.py에서 game만 import하고
    echo_test()에 접근하자. 동작이 되는 것을 확인 할 수 있다.

    ```python
    import game
    game.sound.echo.echo_test()
    ```

    <a id="figure--package test"></a>

    {{< figure src="./img/package_test3.png" caption="<span class=\"figure-number\">Figure 10: </span>package test" >}}

    즉 이것은 import game을 읽으면, game폴더안의 <span class="underline"><span class="underline">init</span></span>.py의 설정된
    내용으로 대체가 된다.

    즉 game이 game.sound.echo로 replace된다.

    ```python
    import game.sound.echo
    game.sound.echo.echo_test()
    ```

<!--list-separator-->

-  import뒤에 \*가 오는 경우

    다음을 test 해보자.

    ```python
    from game.sound import *
    echo.echo_test()
    ```

    이것은 문제가 있다. import \*를 사용하기 위해선, from에서 module을
    포함해야 하는데, from에 있는 sound는 module이 아니다. 따라서
    error가 날 수 밖에 없다. 또한 echo.echo_test()도 echo를
    import했을 때만 이렇게 사용될 수 있기 때문에 이것도 문제가
    있다. 그런데, 이것도 package에선 가능할 수 있다.

    sound폴더의 <span class="underline"><span class="underline">init</span></span>.py를 다음과 같이 설정하자.

    ```python
    __all__ = ['echo']
    ```

    import에서 \*를 사용할 경우, 참조할 module을 지정하는 것이다. 결국
    sound폴더의 <span class="underline"><span class="underline">init</span></span>.py를 읽고, \*가 echo로 replace된다는 뜻이다.

    ```python
    from game.sound import *
    echo.echo_test()
    ```

    위의 내용이 아래와 같이 바뀐다.

    ```python
    from game.sound import echo
    echo.echo_test()
    ```

<!--list-separator-->

-  상대 경로 사용하기.

    다시 한번 우리의 package를 살펴보자.

    <a id="figure--package example"></a>

    {{< figure src="./img/package_example1.png" caption="<span class=\"figure-number\">Figure 11: </span>package example" >}}

    여기서 graphics폴더에 graph module을 추가해보자. 그리고
    gameplayer라는 module도 상위 폴더에 만들자.

    <a id="figure--package example"></a>

    {{< figure src="./img/package_test4.png" caption="<span class=\"figure-number\">Figure 12: </span>package example" width="400px" >}}

    graph 모듈에서 상위폴더의 gameplayer.py라는 module을 import해
    보자. 우리는 import구문은 하위 folder의 모듈만 access할 뿐
    상위폴더의 module은 access할 수 없다고 했다. package에선
    가능하다.

    내가 시도하려는 것은 graph라는 module에서 상위 폴더의
    gameplayer라는 module의 pplayer()를 상대경로로 import해서
    사용할려고 한다.

    graph.py에 다음을 추가하자.

    ```python
    from ..gameplayer import pplayer
    def render():
        pplayer()
    ```

    ..은 상위 폴더를 의미한다. 상위 폴더의 module의 pplayer()를
    import해서 사용하는 것이다.

    이제 main에서 graph module을 import해서 test해보자.

    ```python
    from game.graphics import graph
    graph.render()
    ```

    아래와 같이 동작되는 것을 알 수 있다.

    <a id="figure--package results"></a>

    {{< figure src="./img/package_result4.png" caption="<span class=\"figure-number\">Figure 13: </span>package results" width="400px" >}}

<!--list-separator-->

-  __init__.py와 전역변수

    <span class="underline"><span class="underline">init</span></span>.py에서 import만 처리하는게 아니라, package에서
    전역적으로 사용하는 변수도 넣어도 된다. 예를 들어, game 폴더 아래
    <span class="underline"><span class="underline">init</span></span>.py에 number_of_players = 10을 넣고 main에서 사용 할 수
    있다.

    ```python
    import game.sound.echo

    NUMBER_OF_PLAYERS = 10
    ```

    main에서 다음과 같이 사용할 수 있다.

    ```python
    import game

    print(game.NUMBER_OF_PLAYERS)
    ```

<!--list-separator-->

-  summary

    <span class="underline"><span class="underline">init</span></span>.py가 없어도 최신 버전에서는 폴더를 package로 인식한다고
    한다. 하지만, <span class="underline"><span class="underline">init</span></span>.py가 있으면 많은 import기능을 확장할 수
    있고, 전역적으로 사용되는 것을 모아둘 수도 있다. 일종의
    convention 비슷하다. 또한, package에서 구현을 하고, main.py는
    package를 test하는 용도로 사용한다는 것이다. main에서 모든것을
    하려고 하면 안된다. 즉 main은 package에 있는 module을 import해서
    test하는 역할이면 된다.


## python standard library {#python-standard-library}

우리가 모든 package를 만들어서 사용하지 않아도 python에서 설치하지
않아도 제공하는 library(package)들이 있다. 이것을 standard
library라고 부른다. 가장 많이 사용하는 standard library를 정리한다.


### random package {#random-package}

```python
import random

print(random.randint(0,100))
print(random.uniform(0,1))
```

0-100까지의 정수를 반환하거나, 0-1사이의 uniform distribution에서
한개를 sampling할 때 위 package를 사용한다.


### time {#time}

```python
import time

start = time.time()
time.sleep(1)
print(time.time() - start)
```

time은 시간관련 standard library다. time()는 현재 시간을
return한다. sleep()는 1초 기다린다.


### threading {#threading}

```python
import threading
import time

def print_function():
    print(" python은 GIL때문에 single thread이다.")
    time.sleep(1)

thread = threading.Thread(target=print_function) #쓰레드 만들기
thread.start()   #Thread 시작
thread.join()    #Thread 수거?
```

GIL은 Global Interpreter Lock이라고 한다. interpreter기반이라서
그렇다고 한다.


## python 외장 library 와 package manager {#python-외장-library-와-package-manager}


### 외장 library {#외장-library}

python은 많은 외장 library를 제공한다.

-   수치 그래프 -&gt; matplotlib
-   웹서버 -&gt; flask, django
-   gpu연산 -&gt; cupy
-   deep learning library -&gt; tensorflow, pytorch


### package manager와 virtual env {#package-manager와-virtual-env}


#### 개요 {#개요}

 package manager는 외부 package를 system에 설치하는
프로그램이다. virtual env는 python이 설치된 가상환경을 의미한다.


#### 문제점 {#문제점}

python project마다, 다른 version의 python interpreter를
사용한다거나, 외장 library를 가져와서 사용할 수 있다. 예를 들어서,
web개발을 위해 django를 설치하고 deep learning을 위해서 pytorch를
설치했다고 하자. 해당 framework마다 내부적으로 다른 version의
package들을 가져와서 사용하는데, 이게 충돌의 위험이 있다고
한다. 또한 python의 version에 따라 동작이 안되는 package가 있을 수
있다. 예를 들어서 django는 3.5에서 성능이슈가 있고, pytorch는
3.8에서 문제가 있다면, 둘다 문제가 없는 3.6이나 3.7을 사용하면
된다. 과연 문제가 없을까? 3.6에서 두 framework의 내부 package들끼리
충돌이 일어날 수 있다. 그래서 django를 위해선 python 3.9를 사용하고
pytorch를 위해선 3.8을 사용하면 된다. 그런데 여기서 문제, python은
system에 하나만 설치할 수 있지 않나? 그 문제를 해결한게 virtual
environment이다.


#### pip(+ virtual env)와 anaconda {#pip--plus-virtual-env--와-anaconda}

pip와 anaconda는 package manager다. package를 system에 설치하고,
의존성 검사도 하고, 삭제도 하는 관리 프로그램이다. pip에는 virtual
env, 즉 python을 버전별로 여러개 한 system에 설치하는 기능은
없다. virtualenv와 virtualwrapper등의 도움을 받아야
한다. anaconda는 conda에서 virtual env기능도 지원한다.

anaconda는 200개의 외부 library가 설치된다. 무겁다. miniconda는
최소만 설치된다.


#### colab {#colab}

colab은 notebook마다 kernel이 개별적으로 있다. kernel은 python
interpreter + library인 environment를 의미한다.


### anaconda 사용법 {#anaconda-사용법}

강사는 anaconda를 위주로 사용법을 설명해준다.


#### virtual environment 만들기 {#virtual-environment-만들기}

-   conda create -n nlp : nlp라는 가상환경을 만든다. -n은 name이라고
    한다.
-   conda activate nlp : nlp 가상환경을 활성화한다.
-   conda deactivate : 현재 nlp 가상환경을 비 활성화 한다.


#### package management {#package-management}

-   conda install &lt;package name&gt; -c &lt;설치 채널&gt; : 채널은 package가
    설치된 목록을 가지고 있는 repo로 봐도 된다.  유명한 channel로는
    conda-forge가 있다. conda의 기본채널도 있다. 어떤 package를
    설치하려고 하는데 default package에서 찾을 수 없다면,
    conda-forge채널에서 찾을 수 있을것이다. conda-forge에서 찾을수
    없다면 거의 안 쓰이는 package라고 보면 되고, pip의 채널을
    사용해야 한다. package를 설치할때는 [anaconda hub](https://anaconda.org/conda-forge/hub)를 통해 검색하면
    좋다. conda-forge사이트이다. pytorch같은 경우는 pytorch에서 직접
    설치할 수도 있다. pytorch의 channel이 있기 때문이다.
    ```text
    conda install pytorch -c pytorch
    ```
    default channel은 안써도 상관없고 써도 상관없다.
    ```text
    conda install python=3.9 -c default
    ```
-   conda list : 설치된 library를 볼 수 있다.
    ```text
    conda list | grep numpy
    ```


#### anaconda를 설치하고 깔아야 하는 library {#anaconda를-설치하고-깔아야-하는-library}

-   matplotlib : conda install로 설치하자.
-   tqdm(progress bar): 진행사항을 progress bar로 보여준다.


## module과 built-in function에 대하여 {#module과-built-in-function에-대하여}

.py파일은 module이다. module은 class로 봐도 된다. python에서 main
module, 즉, program의 시작을 나타내는 module은 main이라는 class로
보면 된다. java에서는 public static void main()아래에서 coding을
한다. 변수도 선언하고 for-loop도 돌린다. public static void가 포함된
.java파일에는 class가 있다. java에선 하나의 파일이 하나의 class이기
때문에, class 문장으로 시작한다. 그런데 python에서는
implicit하다. 하나의 파일이 하나의 class인것도 java와
동일하다. 다만, class라고 명시적으로 쓰지 않는다. 그런데 module을
import하면 import한 모듈의 class가 만들어지고, class.변수,함수
이렇게 접근을 한다. java나 python이나 모두 file은 하나의
class이지만, java는 명시적으로 class가있지만, python은 없다고
했다. 그래서 .py를 열어보면, 바로 for-loop이 나온다거나, len()같이
함수들이 불쑥 불쑥 튀어나온다. 그런데, 그런 built-in
function이란것들은 function같이 보이지만, main class혹은 module
class의 method이다. len은 물론 object를 상속 받았기 때문에, object의
method이지만, python에서 function이라고 부르는 대부분은 method이다.

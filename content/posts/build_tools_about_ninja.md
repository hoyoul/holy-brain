+++
title = "[build_tools] about ninja"
author = ["holy"]
description = "옛날 자료 취합"
date = 2023-08-06T00:00:00+09:00
draft = true
+++

## build tool이란 {#build-tool이란}

소스파일과 같은 어떤 파일에 관해서 처리를 할려고한다. 예를 들면
소스파일 하나에 compile해서 실행파일을 만든다고 하자.  이런 경우는
간단하다. compiler를 사용하면 된다. compiler는 소스파일을 컴파일하고,
만일 import나 include가 있는 경우, 그 파일을 현재 code에
붙여넣는다. 그리고 해당하는 함수정의가 포함된 library는 이미
compile되어 있기 때문에 linking과정에서 합치는 과정을 거친다. 이렇게
해서 실행파일이 만들어진다. 소스 파일이 몇개 안될때는 컴파일러를
사람이 cli에서 실행시켜서 이런 과정이 진행된다고 보면 된다. 그런데,
소스파일이 100개 1000개 된다고 할때, 사람이 100번의 compiler를
실행시켜서 실행파일을 만든다는것은 손이 많이 간다. 또한 각각의
소스코드를 컴파일한 후 linking과정을 거쳐야 하는데, linking과정에서
중복되는 library가 많을 수도 있다. 이런것을 managing할 수 있는게 build
tool이다. make가 대표적인 build tool이다.


## build tool을 사용하는 이유(incremental builds) {#build-tool을-사용하는-이유--incremental-builds}

build tool을 사용하는 이유중에 하나가 incremental builds다. 파일에
어떤 조작을 하는 경우, 우리는 보통 프로그램을 사용한다. 그것이 다량의
파일이거나, compile이나 linking 같은 복잡한 작업이라도 programming
language에서 build 처리를 할 수 있기 때문이다. 그럼에도 불구하고 build
tool을 사용하는 이유는 incremental builds때문이다. 예를 들어, 매번
build할때 마다 build해야할 파일들이 10개씩 늘어난다고 하자. program은
매번 늘어난 만큼 모두 build한다. 그런데 build tool은 이미 build가 되어
있는경우 build를 하지 않는다. 변경된 파일이나 신규파일에 한해
build처리를 하기 때문이다. 이것을 incremental builds라고 부르고 build
tool을 사용하는 이유가 된다.


## ninja build tools {#ninja-build-tools}

make는 설정이 많고 복잡하다. 의존성도 따져야 하고, linking, compile에
따른 option도 알아야하고, 복잡한게 많다. 따라서 cmake라는 보조 tool이
있다. 간단한 설정으로 Makefile을 만들어준다. 그런데 이런 복잡한 설정을
하지 않고 단순히 여러개의 file에 어떤 rule만 적용하는 경우 ninja라는
tool을 사용해도 된다. 예를 들어서, 모든 파일에 공통적인 string을
replace 한다던지, string을 추가하는 작업을 하는 경우, ninja같은
tool로도 충분하다. ninja는 incremental builds기능이 있다.


## ninja 사용법 {#ninja-사용법}

ninja는 매우 간단하다. ninja는 rule을 정의하고 사용하면 된다. 예를
들어보자.

```ninja
# 규칙 정의
rule compile_cpp
  command = g++ -c $in -o $out

# 파일에 대한 규칙 적용
build obj/file1.o: compile_cpp src/file1.cpp
```

한개의 rule과 그것의 적용으로 나타낼 수 있다. 여러개의 파일은 다음과
같이 한다.

```ninja
# 규칙 정의
rule compile_cpp
  command = g++ -c $in -o $out

# 여러 파일에 대한 규칙 적용
build obj/file1.o: compile_cpp src/file1.cpp
build obj/file2.o: compile_cpp src/file2.cpp
build obj/file3.o: compile_cpp src/file3.cpp

```

이게 전부다. rule을 만들고 적용한다. 그러면 이런 질문을 할 수
있다. build tool을 사용하는 이유 중 하나가, 대량 파일의 처리다. 예를
들면 특정폴더의 모든 파일에 대해서 처리한다거나, 특정 확장자를 가진
파일만 처리하는 기능을 사용하고 싶다. 그런데, ninja는 wildcard와 같은
pattern을 제공하지 않는다. 즉 할수가 없다. 참조:[여기](https://lwn.net/Articles/706404/)


## ninja의 단점과 해결책 {#ninja의-단점과-해결책}

ninja는 너무나 쉬운 구조로 되어 있기 때문에 make처럼 다양한 설정을 할
수 없다. 위에서 말한 특정폴더의 모든 파일에 적용한다거나 특정확장자를
가진 파일을 처리한다거나 하는것들은 programming language를 사용해서
처리한다. 그 처리방법은 원시적이다. 위에서 특정 폴더의 모든 파일에
대해서 규칙을 적용하는것은 build명령어를 특정폴더의 모든 파일만큼
기술하면 된다. 이것을 for-loop로 처리하는 것이 해결책이다. 이것에 관한
것은 다음을 참조한다. [다음](https://jvns.ca/blog/2020/10/26/ninja--a-simple-way-to-do-builds/)

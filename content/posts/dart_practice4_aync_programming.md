+++
title = "[dart] practice4- aync programming"
author = ["holy"]
description = "async programming 알아야할 최소한의 것들."
date = 2023-08-27T00:00:00+09:00
draft = true
+++

## 동기와 비동기 {#동기와-비동기}

순차적으로 코드가 실행되면, 동기화 program. 좀 더 정확히는 하나의 코드
instruction이 실행이 끝난 후 다음 instruction이 실행되면 동기화
program이다. 반면, 이전 instruction이 끝나기도 전에 다음 instruction이
시작된다면, 비동기 program이다. 대부분의 programming 언어들은
default가 동기화다. 비동기를 할려면 특별한 keyword를 사용한다.


## 비동기가 필요한 이유 {#비동기가-필요한-이유}

cpu를 사용하지 않는 작업들, I/O stream을 연결해서 사용하는 작업들,
socket, file과 같은 작업들은 cpu를 사용하지 않고 언제 끝날지 알수
없다. program이 이런 코드들을 실행하면 block된다. lock이 걸린다.는
표현을 한다. 허송세월 기다리는 이런 코드들을 비동기로 처리해야
한다. flutter의 경우 app프로그램을 짠다. app에서 반응속도는 매우
중요하다. 즉 비동기 프로그램은 flutter에서 없어서는 안되는 기본이다.


## [1- future] 비동기가 필요한 상황 simulation {#1-future-비동기가-필요한-상황-simulation}

-   비동기 program을 할수 밖에 없는 상황을 우선 만들어야 한다.
    block되는 상황을 만들고, 여기서 비동기 programming을 가능케하는
    keyword를 붙여서, 와! 하게 피부로 느끼게 해야한다.
-   우선, future라는 keyword가 비동기 진행을 가능하게 하는 keyword다.
-   block되는 상황을 만드는 code는 delayed()가 있다.

<!--listend-->

```dart
void main(){

}
```
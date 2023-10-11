+++
title = "[docker] getting started with docker"
author = ["holy"]
description = "docker 시작"
date = 2023-09-27T00:00:00+09:00
draft = true
+++

## Docker의 idea와 필요성 {#docker의-idea와-필요성}

docker는 배포와 설치문제의 어려움을 해결해준다. 우리가 어떤 java
프로그램을 만들었다고 하자. java program은 여러개의 package를 load하고
java vm 8.0에서 실행된다고 하자. 내 local system에서는 실행이 문제
없이 된다. 그래서 해당 파일을 친구한테 보내거나 혹은 여러사람한테
배포하기로 한다. 근데 사람들이 말한다. 보낸 파일 실행 안되는데요. 이런
문의가 계속 온다. 이런일이 발생하는 이유는 내가 만든 java프로그램이
참조하는 package와 java vm 그리고 program이 수행되는 environment가
달라서 그렇다. 그래서 아예 java program이 다른 system에서도 문제없이
실행될 수 있도록, 해당 program과 관련된 vm이니, package니 다른 환경적
요소들을 모두 포함해서 배포를 한다면, 실행이 안되네요. 에러가
나네요. 이런 문제를 해결할수 있을것이다. 이런 아이디어로 docker를
만들었다. idea는 좋다. 그런데, c program을 만들어서 배포한다고
생각하자. docker로 배포한다고 할때, c를 compile하고 실행하는 gcc의
경우, system dependent하다. gcc와 내가 만든 program을 묶어서
배포해봤자. 에러가 나거나 실행이 안되는 문제가 생기게 된다. 왜냐하면
gcc는 os에 dependent하기 때문이다. 내 시스템은 osx를 사용한다. 그러면
거기에 built-in된 gcc를 사용하기 때문에, window나 linux에서는 내가
만든 program과 gcc를 docker로 묶어서 보냈다 하더라도, gcc가 os와 같지
않고 같더라도 버전 문제로 에러가 난다. 이 문제를 해결하지 않고서는
docker의 idea는 실현가능성이 없게 된다. 그래서 docker에서는 linux까지
포함한 환경을 묶기로 결정한다. 이렇게 linux까지 묶고서 process로
실행하게 만들었다. 이렇게 하면 어떤 system에서도, windows, linux에서도
그냥 process를 실행할 뿐이다. 하지만, 내부적으로는 linux에 올려진 c
program을 실행하는 것이다.


##  {#d41d8c}
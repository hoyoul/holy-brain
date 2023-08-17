+++
title = "[project] about wayland"
author = ["holy"]
description = "wayland 개발에 대한 설명"
date = 2023-08-17T00:00:00+09:00
draft = true
+++

## idea {#idea}

LG에서 손목시계(watch)를 개발하기로 했었다.

<a id="figure--lg watch"></a>

{{< figure src="/img/portfolio/lgwatch.png" caption="<span class=\"figure-number\">Figure 1: </span>lg watch" width="400px" >}}

여기서 어떻게 하면 최소의 resource를 가지고 최대의 효율을 갖는
손목시계를 만들 수 있는가에 대한 회의가 있었다. 내가 낸 idea는
2개다. `첫째`, 원형 손목시계의 메모리를 최소화하는 방안에 대한 연구를
하자. 사용되지 않는 테두리의 pixel들을 free linked-list로 묶어서 다른
app에서 사용할 수 있게 하자. `둘째` wayland를 porting해서 기존
방식보다 더 빠르게 동작하게 하자. 라는 아이디어의 두번째를 구현한
것입니다.


## wayland란? {#wayland란}

wayland는 os에 사용되는 graphics user system을 말한다. 그리고 가장
edge에 있는 system이다.


## GUI {#gui}

GUI를 잠깐 설명해야 할 듯 하다. 현대 모든 OS는 GUI system을 가지고
있다. GUI system은 두가지로 구성된다. 첫째, interface. 둘째,
interaction. interface는 단어 그대로 상호간에 보여지는거, 즉, 보여지는
화면 UI를 의미한다. interaction은 상호간에 action, 예를 들어, 마우스
클릭, 키보드 입력과 같은 action을 어떻게 처리할까를 정한것이다. 이
두가지를 구현한 GUI system이 wayland다.


## wayland는 왜 빠를까? {#wayland는-왜-빠를까}

wayland는 server/client구조로 되어 있다. 이것은 기존의 x86도
동일하다. 다른 점은, weston이란 compositor를 kernel 밖으로 빼내서
server의 부하를 줄여주었다.


## 동영상에 대한 설명 {#동영상에-대한-설명}

raspberry pi에 포팅하는것은 kernel compile을 필요로 한다. 만들어진
kernel을 raspberry pi에 올린것은 회사 세미나에서 시연했고, 화면에
보이는 것은 virtual machine에서 테스트한 화면이다.

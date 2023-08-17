+++
title = "[project 4] about K-smart water"
author = ["holy"]
description = "k smart water에 대해서"
date = 2023-08-17T00:00:00+09:00
draft = true
+++

## 참조 {#참조}

-   project1: [tech blog]({{< relref "project_about_tech_blog" >}})
-   project2: [wayland]({{< relref "project_about_wayland" >}})
-   project3: [solar monitoring system]({{< relref "project_3_about_solar_monitoring_system" >}})
-   project4: K-smart water
-   project5:


## Idea {#idea}

smart water라는 것은 디지털 계량기 사업이다. 디지털 계량기는 5개의
센서가 라즈베리파이에서 rs485방식으로 연결되어 있다. 연결된 센서로부터
수량,ph,수온,유속,다른 한가지는 기억나지 않지만, 5가지 data를 읽어
들여서 maria db로 전송한다. rest api서버는 db로 부터 데이터를 가져와서
json으로 뿌린다.


## 구현 노트 {#구현-노트}

이것도 구현노트가 회사의 server와 gitlab에 보관되어 있다. 참조된
영상에는 smart water system의 hw부분만 담겨 있다. monitoring system은
외부로 공개된게 아니라서 예전에는 login해서 들어갔는데, 지금은
없어져서 화면을 찾을 수 없었다.

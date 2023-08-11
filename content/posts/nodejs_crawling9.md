+++
title = "[nodejs] crawling9"
author = ["holy"]
description = "nodejs crawling에 대해서"
date = 2023-08-09T00:00:00+09:00
draft = true
+++

## selenium vs open api vs 내부 api {#selenium-vs-open-api-vs-내부-api}

request로 page를 다운로드 하고 cheerio로 분석하는 방식은 selenium에서
사용하는 방식과 유사하다. 이 방식의 문제는 cepchar문제와 느리다는데
있다. 그런데 가장 큰 문제는 웹페이지가 변경되었을때 코드도 변경되어야
한다는 것이다. 크롤링의 두번째 방법으로 open-api를 사용하는 방식이
있다. 이것은 공공기관이 제공하는 data를 받아서 처리하는
방식이다. 따라서 이것은 crawling의 범위를 벗어난다. 그리고
crawling하는 또다른 방법으로 내부 api를 사용하는 경우가 있다. 이경우
내부적으로 쓰는 api이기 때문에 웹페이지가 변경되더라도 내부 api는
그대로 인경우가 많기 때문에 소스코드 수정이 적을 수 있다는 장점이
있다. 그리고 이경우 websocket을 사용해서 crawling하는 경우가 많다.


## 내부 api사용 {#내부-api사용}

내부 api라는 단어는 조금 이상하다. 왜냐면 내부 api란 단어를 들으면,
뭐지 하고 오랜 경력의 개발자도 갸우뚱거릴 단어이기 때문이다. 이것은 js
api function을 말한다. 우리가 naver지도나, daum site를 들어가면, js를
다운 받는다. 그리고 우리가 입력창에 무언가를 검색하면, 새로고침이
일어나지 않고 json객체만 전달 받는다. 이때 내부 api가 이용된
것이다. 지도 서비스는 깜빡거림때문에라도 새로운 지도를 다운받지
않는다. 즉, 서버에서 json객체만 보낸다. 이런 json객체를 보내달라고
요구하는 api를 내부 api라고 부른다. 예를 들어서, 지도 검색창에서
'편의점'을 검색하면 주변의 편의점 정보를 계산해서 server에서 지도에
표시해서, 그리고 검색된 편의점들을 server에서 page로 만들어서 보내는게
아니다. 검색창에 입력된 문자열을 내부 api들이 server에 요청하고
json객체를 받아서 표시하는것이다. 즉 ajax 생각하면 된다. ajax query가
내부 api처럼 말한다.


## <span class="org-todo todo TODO">TODO</span> 나머지 강의 (10분부터) {#나머지-강의--10분부터}

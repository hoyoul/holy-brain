+++
title = "[sql] programmers sql high score2"
author = ["holy"]
description = "programmers 문제 풀이"
date = 2023-08-03T00:00:00+09:00
draft = true
+++

## problem1: 강원도에 위치한 생상공장 목록 출력하기(level1) {#problem1-강원도에-위치한-생상공장-목록-출력하기--level1}

{{< figure src="/img/sql/p1-1.png" width="600px" >}}

{{< figure src="/img/sql/p1-2.png" width="600px" >}}


## 풀이 {#풀이}

푸는 순서는 다음과 같다. from부터 푼다. 이문제에서 어려울것은 없다.


### from FOOD_FACTORY {#from-food-factory}


### select FACTORY_ID, FACTORY_NAME,ADDRESS from FOOD_Factory {#select-factory-id-factory-name-address-from-food-factory}


### select FACTORY_ID, FACTORY_NAME,ADDRESS from FOOD_Factory order by FACTORY_ID asc {#select-factory-id-factory-name-address-from-food-factory-order-by-factory-id-asc}


## problem2: 흉부외과 또는 일반 외과 의사 목록 출력하기(level1) {#problem2-흉부외과-또는-일반-외과-의사-목록-출력하기--level1}

{{< figure src="/img/sql/p2-1.png" width="600px" >}}

{{< figure src="/img/sql/p2-2.png" width="600px" >}}

{{< figure src="/img/sql/p2-3.png" width="600px" >}}


## 풀이 {#풀이}

하나의 table에서 조회하는 것이다. 풀이 순서는 동일하다. from부터
시작한다.


### from DOCTOR {#from-doctor}

=&gt; table을 db에서 가져온다. 이건 어렵지않다.


### where MCDP_CD like "CS" or  MCDP_CD like "GS" {#where-mcdp-cd-like-cs-or-mcdp-cd-like-gs}

=&gt; cs 나 gs인 경우, 이것도 어렵지 않다. 수치의 경우 MCDP_CD =3 이런
식으로 나타낸다면 문자열의 경우 like를 사용한다. 정도? like는
문자열에서 사용되는데 좋은점이 있다. date like "2002-03%" 라는 식의
wildcard를 사용할 수 있다는 것이다.

<div class="important">

where절에서 and or not in을 사용할 수 있다. 위에서 or대신에 `in` 을
사용할 수 있다.  where MCDP_CD in ('cs', 'gs')

</div>


### select DR_NAME, DR_ID,MCDP_CD, DATE_FORMAT(HIRE_YMD,"%Y-%m-%d") as DATE_FORMAT {#select-dr-name-dr-id-mcdp-cd-date-format--hire-ymd-y-m-d--as-date-format}

=&gt; select에선 column값을 선택만 하는게 아니라 출력형태를 바꿔서 출력할
수 있다. 이 때, 함수를 사용하는데, 대표적인게 mmacs라는 집계함수와
date format()이다.


### [최종] {#최종}

```mysql
select DR_NAME, DR_ID,MCDP_CD, DATE_FORMAT(HIRE_YMD,"%Y-%m-%d") as DATE_FORMAT
```


## problem3: 서울에 위치한 식당 목록 출력하기(level4) {#problem3-서울에-위치한-식당-목록-출력하기--level4}

{{< figure src="/img/sql/p3-1.png" width="600px" >}}

{{< figure src="/img/sql/p3-2.png" width="600px" >}}

{{< figure src="/img/sql/p3-3.png" width="600px" >}}

{{< figure src="/img/sql/p3-4.png" width="600px" >}}


## 풀이 {#풀이}


## problem4: 조건에 맞는 도서 리스트 출력하기(level1) {#problem4-조건에-맞는-도서-리스트-출력하기--level1}

{{< figure src="/img/sql/p4-1.png" width="600px" >}}

{{< figure src="/img/sql/p4-2.png" width="600px" >}}


## 풀이 {#풀이}


## problem5: 과일로 만든 아이스크림 고르기(level1) {#problem5-과일로-만든-아이스크림-고르기--level1}

{{< figure src="/img/sql/p5-1.png" width="600px" >}}

{{< figure src="/img/sql/p5-2.png" width="600px" >}}

{{< figure src="/img/sql/p5-3.png" width="600px" >}}


## 풀이 {#풀이}


## problem6: 평균 일일 대여 요금 구하기(level1) {#problem6-평균-일일-대여-요금-구하기--level1}

{{< figure src="/img/sql/p6-1.png" width="600px" >}}

{{< figure src="/img/sql/p6-2.png" width="600px" >}}


## 풀이 {#풀이}


## problem7: 조건에 부합하는 중고거래 댓글 조회하기(level1) {#problem7-조건에-부합하는-중고거래-댓글-조회하기--level1}

{{< figure src="/img/sql/p7-1.png" width="600px" >}}

{{< figure src="/img/sql/p7-2.png" width="600px" >}}

{{< figure src="/img/sql/p7-3.png" width="600px" >}}


## 풀이 {#풀이}


## problem8: 인기 있는 아이스크림(level1) {#problem8-인기-있는-아이스크림--level1}

{{< figure src="/img/sql/p8-1.png" width="600px" >}}

{{< figure src="/img/sql/p8-2.png" width="600px" >}}

{{< figure src="/img/sql/p8-3.png" width="600px" >}}


## 풀이 {#풀이}


## problem9: 3월에 태어난 여성 회원 목록 출력하기(level2) {#problem9-3월에-태어난-여성-회원-목록-출력하기--level2}

{{< figure src="/img/sql/p9-1.png" width="600px" >}}

{{< figure src="/img/sql/p9-2.png" width="600px" >}}


## 풀이 {#풀이}


## problem10: 12세 이하인 여자환자 목록 출력하기(level1) {#problem10-12세-이하인-여자환자-목록-출력하기--level1}

{{< figure src="/img/sql/p10-1.png" width="600px" >}}

{{< figure src="/img/sql/p10-2.png" width="600px" >}}


## 풀이 {#풀이}


## problem11: 모든 레코드 조회하기(level1) {#problem11-모든-레코드-조회하기--level1}


## 풀이 {#풀이}


## problem12: 재구매가 일어난 상품과 회원 리스트 구하기(level2) {#problem12-재구매가-일어난-상품과-회원-리스트-구하기--level2}


## 풀이 {#풀이}


## problem13: 역순 정렬하기(level1) {#problem13-역순-정렬하기--level1}


## 풀이 {#풀이}


## problem14: 오프라인/온라인 판매 데이터 통합하기(level4) {#problem14-오프라인-온라인-판매-데이터-통합하기--level4}


## 풀이 {#풀이}


## problem15: 아픈 동물 찾기(level1) {#problem15-아픈-동물-찾기--level1}


## 풀이 {#풀이}


## problem16: 어린 동물 찾기(level1) {#problem16-어린-동물-찾기--level1}


## 풀이 {#풀이}


## problem17: 동물의 아이디와 이름(level1) {#problem17-동물의-아이디와-이름--level1}


## 풀이 {#풀이}


## problem18: 여러기준으로 정렬하기(level1) {#problem18-여러기준으로-정렬하기--level1}


## 풀이 {#풀이}


## problem19: 상위 n개 레코드(level1) {#problem19-상위-n개-레코드--level1}


## 풀이 {#풀이}


## problem20: 조건에 맞는 회원수 구하기(level1) {#problem20-조건에-맞는-회원수-구하기--level1}


## 풀이 {#풀이}

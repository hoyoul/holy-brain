+++
title = "[web] hosting(netlify and github pages) and heroku, firebase"
author = ["holy"]
description = "github hosting"
date = 2023-09-11T00:00:00+09:00
draft = true
+++

## web 개발 {#web-개발}

webpage를 만드는 방식은 2가지다.  html과 js로 page를 만든다. 필요한
data는 rest api로 가져와서 보여준다.

만들어서 모든 사람에게 보여줄려면 webserver에 올려야
한다. 이것을 deploy라고 부른다. deploy할 web server를 예전에는
만들었다.


## 전통적인 방식 {#전통적인-방식}

web server를 위한 computer를 구입하고,


## iass 전통적인 방식 {#iass-전통적인-방식}

web page를 모든 사람한테 보여주기 위해선 webserver가 있어야 한다. 이
webserver는 internet browser에서 접속가능한 web server여야
한다. rails나 django,express로 webserver를 만들고 webpage를 올려놔도
된다. 그런데 이렇게 직접 webserver를 만들기 위해선 ip주소도 할당받아야
하고, webserver를 돌릴 컴퓨터도 있어야 한다. 하루종일 컴퓨터를 켜놔야
한다.
+++
title = "[nodejs] crawling1 - naver지도 검색"
author = ["holy"]
description = "nodejs로 크롤링하기"
date = 2023-08-05T00:00:00+09:00
draft = true
+++

## 참조 사이트 {#참조-사이트}

아주 오래된 내용이지만, 그래도 python이 아닌 nodejs로 된
강좌다. [여기](https://www.youtube.com/watch?v=HVANBB2zRAc&list=PLqh5vK4CKWeZyaNrMmfGPJiPuGM0XX1kM)를 참조한다. 그런데 너무 오래되서 동작하는게 아무것도
없다. 다른 영상을 참고해야 할듯 하다. python으로 하는 web scrpaing책은
[다음]({{< relref "python_web_scraping_with_python_1" >}})을 참조한다.


## 웹에서 data를 가져오는 방법 {#웹에서-data를-가져오는-방법}

1.  scraping: 웹페이지 요청후 down받은 webpage에서 데이터를 꺼낸다.
2.  내부 api사용: google chrom에서 개발자도구 이용
3.  open api사용: 지자체나 정부기관에서 restful한 api를 제공해준다.

나는 이렇게 인터넷에서 data를 수집하는 전 과정을 web scraping이라고
생각한다. 위에 적히 3개 모두 web scraping이라고 생각한다. web
scraper를 `bot` 이라고 말하기도 한다.


## scraping {#scraping}

scraping은 일반적으로 down받은 web page에서 정보를 찾는것이다. chrome
development에서 console에서 jquery를 사용해서 data를 꺼내는 예를
보여주는데, 오래된 내용이라 맞지 않다. 보통 ul tag아래 li를 꺼낼때는
children()를 사용하는데, 여기서는 그렇게 하지 않았다. jquery에서
인자는 string이라는걸 까먹으면 안된다. 또한 class가 space로
구분된경우는 jquery에서 이어서 써야 한다. 예를 들어서, &lt;ul class =
"abc def ghi"&gt; 태그 아래 li가 많다면,

```emacs-lisp
$(".abc.def.ghi").children()[1]
```

위와 같이 접근이 가능하고, index가 있기 때문에 for-loop도 가능하다.
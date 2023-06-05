+++
title = "lecture13-web"
author = ["holy"]
description = "python web 사용"
date = 2023-06-05T00:00:00+09:00
draft = false
+++

## web crawling {#web-crawling}


### web crawling 개요 {#web-crawling-개요}

우리가 browser로 보는 화면은 html문서를 formatting한 것이다. web
문서인 html문서를 browser가 우리 컴퓨터에 down받고 down받은
html문서를 formatting해서 보여주는 것이다. browser가 html문서를
down받아서 보여주는 것처럼, python에서 html문서를 down받아서 분석할
필요가 있다. 이것을 web crawling이라고 한다. python에서 html문서를
가져오기 위해서는 requests라는 사용자 library를 사용해야 한다.


### Requests {#requests}


#### 설치 {#설치}

```text
conda install requests
```


#### requests 사용법 예시 {#requests-사용법-예시}

```python
import requests

URL = 'https://www.naver.com'
response = requests.get(URL)

print(response.status_code)
print(response.text)
```

request.get으로 html문서와 여러 응답결과를 객체로 만들어
return한다. return한 객체에 html문서가 있다. 문서는 text라는
변수가 가리킨다.


#### Crawling 예시 {#crawling-예시}

```python
import requests
from bs4 import BeautifulSoup

URL = "https://sports.news.naver.com/index"
response = requests.get(URL)
soup = BeautifulSoup(
    response.text,
    'html.parser'
    )

headline = soup.find(name='ul', attrs={'class' : "today_list"})
for title in headline.find_all(name='strong', attrs={'class':"title"}):
    print(title.string)

```

간단한 web scrawl의 경우 beautifulsoup으로 해도 되지만, 복잡한
구조의 html문서의 web crawling은 scrapy패키지를 사용한다.


## 강의 끝 {#강의-끝}

강의에서 미흡된 부분은 아래와 같다.

-   Multi thread
-   Networking

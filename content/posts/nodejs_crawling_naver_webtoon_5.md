+++
title = "[nodejs] crawling-naver webtoon-5"
author = ["holy"]
description = "naver webtoon crawing 만들기"
date = 2023-08-08T00:00:00+09:00
draft = true
+++

## cheerio 모듈 {#cheerio-모듈}

이전에 개발자도구에서 jquery를 사용해서 원하는 tag를 가져올 수
있었다. 이것을 jquery가 아닌 cheerio를 사용해서 가져올 수
있다. cheerio의 사용법은 다음과 같다.

<a id="figure--cheerio"></a>

{{< figure src="/img/crawling/cheerio1.png" caption="<span class=\"figure-number\">Figure 1: </span>cheerio" width="600px" >}}

위에서는 안나왔지만, $로 html을 load해서 받는 이유가 있다. 검색을
jquery식으로 하기 때문이다. $로 받기 때문에 다음과 같은 코드가
가능해진다.

```text
$('.wt_viewer img')[0]
```


## cheerio module사용하기 {#cheerio-module사용하기}


### module 설치 {#module-설치}

npm으로 설치한다.

```text
npm install --save cheerio
```


### require로 load한다. {#require로-load한다-dot}

```js
let request = require('request')
let cheerio = require('cheerio')


```


### jquery형태로 검색을 해보자. {#jquery형태로-검색을-해보자-dot}

request callback function의 body가 html문서를 가져오기 때문에
callback함수안에서 jquery형태로 검색하고 출력해보자.

```js
request('https://comic.naver.com/webtoon/detail?titleId=813335&no=1', function(error, response,body){
    // console.log('error:',error);
    // console.log('statuscode:', response && response.statusCode);
    // console.log('response:', body);
    const $ = cheerio.load(body);
    // console.log($.html());
    console.log($('.wt_viewer img')[0].attribs.src);
});

```

위에서 .attribs.src 이것을 해준것은 img 태그에서 src에 image에 대한
url이 있기 때문이다. 이것은 html문서의 구조를 보고 img태그에
attribs라는 class아래에 src에 url이 있다는 것을 확인하고 사용한
것이다. 확인하는 방법은 다음과 같다.

```js
console.log($('.wt_viewer img'));
```

여기서 출력해 보면 image의 url을 대략 어디쯤에서 찾을 수 있는지 감이 온다.

<a id="figure--source"></a>

{{< figure src="/img/crawling/cheerio2.png" caption="<span class=\"figure-number\">Figure 2: </span>source" width="600px" >}}

위에 보면, attribs src에 url이 있음을 볼 수 있다. 그래서 위에서 처럼
image의 url을 찾을수 있는것이다.

```js
console.log($('.wt_viewer img')[0].attribs.src);
```


### 모든 image를 다 가지고 오자. {#모든-image를-다-가지고-오자-dot}

0번째 image의 url을 가져왔는데, html문서에 기술된 모든 image를
가져와보자.

```js
for(let i=0; i<$('.wt_viewer img').length; i++)
    console.log($('.wt_viewer img')[i].attribs.src);
```

이렇게 하면 대략 192개의 이미지를 가져온다.

<a id="figure--result"></a>

{{< figure src="/img/crawling/cheerio3.png" caption="<span class=\"figure-number\">Figure 3: </span>result" width="600px" >}}

+++
title = "[nodejs] crawling-naver webtoon-6"
author = ["holy"]
description = "naver webtoon crawler 만들기"
date = 2023-08-08T00:00:00+09:00
draft = true
+++

## webtoon 이미지 down받기 {#webtoon-이미지-down받기}

webtoon image의 url을 html을 cheerio로 parsing해서 다 꺼낼수
있었다. url만 안다면 동영상이던, 음악이던 만화던 다 다운받을수 있다고
했다. html문서를 다운받을때 사용했던 request를 사용하면 된다. 그러면
간단하게 0번째 만화 이미지를 다운받아서 download라는 폴더에 저장하는
것을 해보자. download라는 폴더를 만들고, image_download()를
만들자. 코드는 다음과 같다.

```js
const image_download = (path,url) => {
    request(url, function(error, response,body){
        console.log("statuscode:", response.statusCode);
    });
}
request('https://comic.naver.com/webtoon/detail?titleId=813335&no=1', function(error, response,body){
    const $ = cheerio.load(body);
    for(let i=0; i<1; i++)
        image_download("./download",$('.wt_viewer img')[i].attribs.src);

});

```

한개의 image url을 꺼내서 image_download라는 함수에 전달하면
image_download는 request로 다운받는다. 현재는 download라는 폴더에
넣으라는 처리는 안했다. 이렇게 하는 이유는 403에러가 나기
때문이다. image를 다운받을 때, naver에서는 referer을 check한다고
한다. 이것에 대해서 좀 얘기해야 한다.


## 403 referer 에러 {#403-referer-에러}

이미지의 url을 알았다고해서 request를 사용해서 image를 다운받으려 하니
403에러가 났다. 이것은 server에서 허용하지 않는다는 것이다. naver
webtoon에서 referer를 check하기 때문이라고 한다. referer은 페이지를
요청한 이전 page의 url을 뜻한다. 마치 backlink와 비슷하다. 이것은
server입장에서는 우리사이트가 어떤 경로로 유입되었는가를 알수 있게
해주는 정보다. naver웹툰 page에서 요청한 그림 url이라면 정상적이지만,
크롤링으로 요청하면 이상 경로라고 판단해서 403에러가 나는
것이다. 이것을 탈피해야 한다. 어떻게 할까? request를 요청할때
referer값을 setting하고 요청하면 된다.


## referer setting {#referer-setting}

referer을 setting해서 request를 다시 보내면 된다고 했다. 이것을
request module에서는 option이라고 한다. option을 추가해서
request하는건데, option의 url은 referer을 나타내는 url이다. 즉
이전경로에 해당하는 url을 option에 넣어서 보내야 한다. 아래 그림을
보자.

<a id="figure--referer"></a>

{{< figure src="/img/crawling/referer1.png" caption="<span class=\"figure-number\">Figure 1: </span>referer" width="600px" >}}

어쨌듯 option의 값을 채워서 request하면 된다는 건데, 그러면 referer에
해당하는 url을 어떻게 구할수 있는가?


## referer url 구하기 {#referer-url-구하기}

referer url을 구하려면 web browser에서 해당 webtoon 만화의 page로
간다. 예를 들어서 120화를 본다고 한다면, 이전에 119화에서 넘어오던,
webtoon제목을 클릭해서 넘어왔던간에 referer은 naver webtoon이 된다. 이
주소는 chrome개발자 도구에서 확인할 수 있다.

<a id="figure--referer"></a>

{{< figure src="/img/crawling/referer2.png" caption="<span class=\"figure-number\">Figure 2: </span>referer" width="600px" >}}

위의 그림처럼, 날짜로 적혀진 request의 header에서 referer url을 얻을
수 있다. 그런데 재밌게도 찾은 referer url은 webtoon page의 url과 같다.

<a id="figure--referer"></a>

{{< figure src="/img/crawling/referer3.png" caption="<span class=\"figure-number\">Figure 3: </span>referer" width="600px" >}}

이것은 무엇을 의미하는가? 우리는 webtoon의 특정 page의 url을 request로
요청해서 html문서를 다운받고 거기서 cheerio를 통해서 만화 이미지의
url을 얻고 그 이미지를 다운받기 위해서 다시 request를 사용했다. 그런데
403에러 때문에 referer url이 필요해졌다. 그런데 이 url이 맨처음
webtoon의 특정 page의 url을 request로 요청했을때의 그 url이란
뜻이다. 즉 referer url은 요청한 page url을 그대로 사용해도 된다는
얘기다. 굳이 새로고침해서 날짜로된 request를 찾아서 referer를 찾을
필요가 없다는 얘기다. 이 얘기를 하기 위해서 위 과정을 실행한
것이다. server입장에서는 referer url이 현재 요청한 image url의
유입경로로 보게된다.


## image download 구현 {#image-download-구현}

위에서 option을 만들어서 구현해도 되지만, image url을 request로
요청할때 referer의 값을 추가하는 식으로 해도 된다.

```js
const image_download = (path,url) => {
    request(
        {
            url:url,
            headers: {'referer': 'https://comic.naver.com/webtoon/detail?titleId=813335&no=1'}

        }, function(error, response,body){
            console.log("statuscode:", response.statusCode);
            console.log("body:", body);
    });
}
```

위와 같이 변경했다. headers라는 객체에 referer url을 넣는
방식이다. 이렇게 하면 statuscode는 200ok가 떨어진다.


## file에 저장 {#file에-저장}

이제 특정 폴더에 저장하는 기능만 하면 된다. 이것은 fs라는 module을
사용한다. nodejs의 기본 모듈이기 때문이다. file system의 약자인데,
여기서 writefile이라는 함수를 사용해서 저장할 것이다. 저장할때,
어떤이름으로 저장할 것인가?라는 문제가 있는데, image url을 split해서
사용한다. 이 기법은 매우 자주 사용되지만, 손에 익지 않으면 바로 바로
사용할 수 없다.

```js
if (url.toString().includes('_IMAG')){
    let fs_str = path + '/' + (url.toString().split('_IMAG')[1])
    fs.writeFile(fs_str , body, (err) => {
        if(err) throw err;;
        console.log("The file has been saved!")
    });
}
```

if (url.toString().includes('_IMAG')) 문을 사용한 이유는, 다운받는
image중에 만화가 아닌 다른 이미지가 있는거 같아서 filtering 하기
위해서 넣었다.  split(arg_str)를 사용하면 arg_str을 찾고, 발견된
arg_str기준으로 조각을 낸 배열을 return한다. fs.writefile은 2개의
인자를 받는다. 하나는 저장될 위치와 다른 하나는 다운받은
파일이다. file이 저장되는것을 확인할 수 있다. 코드가 간단하기 때문에
여기에 기술하면 다음과 같다.

```js
let request = require('request')
let cheerio = require('cheerio')
let fs = require('fs')

const image_download = (path,url) => {
    request(
        {
            url:url,
            headers: {'referer': 'https://comic.naver.com/webtoon/detail?titleId=813335&no=1'}

        }, function(error, response,body){
            console.log("statuscode:", response.statusCode);
            console.log("body:", url);
            if (url.toString().includes('_IMAG')){
                let fs_str = path + '/' + (url.toString().split('_IMAG')[1])
                fs.writeFile(fs_str , body, (err) => {
                    if(err) throw err;;
                    console.log("The file has been saved!")
                });
            }
    });
}
request('https://comic.naver.com/webtoon/detail?titleId=813335&no=1', function(error, response,body){

    const $ = cheerio.load(body);
    // for(let i=0; i<$('.wt_viewer img').length; i++)
    for(let i=0; i<3; i++)
        image_download("download",$('.wt_viewer img')[i].attribs.src);

});
```

그런데 문제가 있다. jpg로 된 파일이 열리지 않는다. 이것은 binary
image를 utf-8로 인코딩하기 때문이다. image파일을 download받을때 그리고
file에 쓸때, 모두 utf-8로 encoding한다. 이 부분을 모두 null로 해서
binary code임을 알려야 한다.


## encoding null {#encoding-null}

image는 binary file이라서 encoding을 null로 설정해야 한다. 이렇게 하기
위해서 image url을 request할때 head에 encoding을 null로 해야 한다.


### request encoding null {#request-encoding-null}

아래 코드를 넣었다.

```js
request(
    {
        url:url,
        headers: {'referer': 'https://comic.naver.com/webtoon/detail?titleId=813335&no=1'},
        encoding: null

    }, function(error, response,body){

```


### writeFiles encoding null {#writefiles-encoding-null}

writeFiles도 encoding을 null로 해준다.

```js
fs.writeFile(fs_str , body, null, (err) => {
    if(err) throw err;;
    console.log("The file has been saved!")
});
```
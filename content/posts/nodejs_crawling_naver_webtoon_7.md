+++
title = "[nodejs] crawling-naver webtoon-7"
author = ["holy"]
description = "crawling naver webtoon"
date = 2023-08-09T00:00:00+09:00
draft = true
+++

## webtoon viewer crawling의 일반화 {#webtoon-viewer-crawling의-일반화}


### title명과 회수 {#title명과-회수}

지금까지 한건, 특정 제목을 가진 webtoon의 특정 page를 url로 전달해서
만화 image를 다운 받았다. webtoon의 제목을 입력받고, webtoon의 몇번째
화 인지도 입력 받는다면, program을 일반화 할 수 있다. 그래서 처음
시작할때 request로 webtoon page url입력 받아 처리하는 부분을 title,
no를 받는 함수로 바꿀 것이다. 코드로 보면 다음과 같다.

```js
request('https://comic.naver.com/webtoon/detail?titleId=813335&no=1', function(error, response,body){

    const $ = cheerio.load(body);
    for(let i=0; i<$('.wt_viewer img').length; i++)
        image_download("download",$('.wt_viewer img')[i].attribs.src);

});
```

이것을 getImageUrls함수로 바꾼다. 바꿀때 변수를 string에 어떻게
포함시킬것인가? concat을 사용할 것인가? tip이긴 한데, 홑따옴표로
string을 묶고 거기에 ${}로 embeded한다. js에서 무척 많이 쓰이는
방법이다.

<div class="important">

변수를 string에 embeded하는 방법: \` \`로 string을 묶고 ${var}로 embeded한다.

</div>

```js
  const getimageurls = (titleId,no) => {
      request(`https://comic.naver.com/webtoon/detail?titleId=${titleId}&no=${no}`, function(error, response,body){
    const $ = cheerio.load(body);
    for(let i=0; i<$('.wt_viewer img').length; i++)
        image_download("download",$('.wt_viewer img')[i].attribs.src);

});
  getImageurls(813335,10);
```

이렇게 일반화한게 잘 되는지 확인하자. 아래와 같이 10화의 image들이 추출되는지 확인해 보자.

```text
getImageurls(813335,10);
```

안된다. 이 만화는 연재한지 얼마 안된다. 그래서 3화를 해보자.

```text
getImageurls(813335,3);
```

이상없이 동작하는 것을 확인할 수 있다.


### 파일명 {#파일명}

title과 회차를 입력하면 회차의 모든 image를 download폴더에
저장되었다. 그런데, 우리가 원하는 회차는 특정 회차일 수도 있지만, 전체
회차일 수도 있다. 이때 저장되는 파일명이 모두 동일하면 겹쳐
써진다. 그래서 통일된 파일명이 필요하다.

```text
titleid_no_이미지number.jpg
```

형태로 파일명을 정했다. 파일을 저장할때 원래 image가 가진 file명에서
이미지number만 split해서 가져왔다. 이것을 위와 같은 형식으로 저장하기
위해선, fileWrite()를 수행하는 함수에 title명과 회차(no)를 넘겨주어
처리해야 한다. 이것을 처리한 소스코드는 다음과 같다.

```js
let request = require('request')
let cheerio = require('cheerio')
let fs = require('fs')

const image_download = (path,url,titleid,no) => {
    request(
        {
            url:url,
            headers: {'referer': `https://comic.naver.com/webtoon/detail?titleId=${titleid}&no=${no}`},
            encoding: null

        }, function(error, response,body){
            console.log("statuscode:", response.statusCode);
            console.log("body:", url);
            if (url.toString().includes('_IMAG')){
                let fs_str = path + '/' + `${titleid}_${no}` + url.toString().split('_IMAG01')[1]
                fs.writeFile(fs_str , body, null, (err) => {
                    if(err) throw err;;
                    console.log("The file has been saved!")
                });
            }
    });
};
const getImgUrls = (titleid,no) => {
    request(`https://comic.naver.com/webtoon/detail?titleId=${titleid}&no=${no}`, function(error, response,body){
        const $ = cheerio.load(body);
        for(let i=0; i<$('.wt_viewer img').length; i++)
            image_download("download",$('.wt_viewer img')[i].attribs.src, titleid,no);

    });
}
getImgUrls(813335,3);

```

문제없이 동작하는 것을 확인할 수 있다.
여기서 1-5회까지 다운받는 코드를 실행해 보자.

```js
for(let i=1; i< 5;i++){
        getImgUrls(813335,i);
        }
```

3회차까지만 다운로드 받는다. 내가 받는 얼짱시대라는 webtoon은 현재 3회까지 밖에 없기 때문이다.


## timeout error {#timeout-error}

내 경우에는 3회차까지 밖에 다운로드 받는게 없어서 timeout error가
없었다. 그런데 만일 100회차 까지 다운로드 받는다면 timeout error가 날
수 있다.  page하나당 socket을 열어서 가져오는데, page가 많으면 열려진
socket이 많을 것이고, 그렇게 된다면 timeout error가 나올 가능성은
상당히 높을 수 밖에 없다.


### 해결책 {#해결책}

이것에 대한 해결책은 매번 page요청시에 delay를 주는 방식이다. 두번째는
exception처리다. 만일 timeout errorr가 발생했다면 재요청을 하는
것이다.


#### delay 주는 법 {#delay-주는-법}

setTimeout함수를 사용해서 delay를 줄 수 있다. 유튜버는 좀 이상하게
delay를 준다. 내가 생각한건, 그냥 2초마다 실행하게 만들면 되지 않을까?
했는데, 10화부터 100화까지 한다면 끝으로 갈수록 delay를 길게 취하는
방식을 사용한다. 이것에 대한 명쾌한 설명은 하지 않는다. code는
간단하다. j라는 counter를 만들어서 j초만큼 delay를 준다.

```js
for(let i=1 j=0; i< 5;i++,j++){
    setTimeout(
        () => {
        getImgUrls(813335,i);
        } ,j*1000)
}
```


#### retry {#retry}

request시에 error가 나면 다시 시도하는 방식이다. 이것을 어디에 위치할
것인가? request는 2개가 있다. 하나는 html page를 요청하는 부분, html
page에서 image url을 추출한후 image url을 request로 요청하는 두 부분이
있다. 두 부분 모두 처리해도 되지만, image를 못가져오는 부분만
retry처리를 해보자. image_download()가 image를 가져오는 함수인데,
error가 발생되면 image_download()를 재 호출하는 식이다.

```js
const image_download = (path,url,titleid,no,retryCount) => {
    request(
        {
            url:url,
            headers: {'referer': `https://comic.naver.com/webtoon/detail?titleId=${titleid}&no=${no}`},
            encoding: null

        }, function(error, response,body){

            if(error && --retryCount>=0){
                console.log(`retry ${titleid} ${no} ${retryCount}`);
                image_download(path,url,titleid,no,retryCount);
                return;
            }

            console.log("statuscode:", response.statusCode);
            console.log("body:", url);
            if (url.toString().includes('_IMAG')){
                let fs_str = path + '/' + `${titleid}_${no}` + url.toString().split('_IMAG01')[1]
                fs.writeFile(fs_str , body, null, (err) => {
                    if(err) throw err;;
                    console.log("The file has been saved!")
                });
            }
    });
};
```

위의 if문에서 error를 만나면 retryCount만큼 image_download()를 재
호출한다.


#### 확인 {#확인}

우선 내가 가진 webtoon은 횟수가 3회차라서 연재가 오래된 webtoon으로
바꾸자. 김부장이란 webtoon이고 titleid는 url에서 783053인것을
확인했다. retry를 테스트하자. setTimeout을 주지않고 1~5화까지 다운로드
받아보자. 그렇게 하기 위해서 코드를 바꿔야 한다. i만 사용할 거라서 j는
그대로 두자.

```js
for(let i=1, j=0; i< 5;i++,j++){
    // setTimeout( () => {
        getImgUrls(783053,i);
    // },j*1000);
}

```

여기서 재요청을 한 경우는 없었다. 만일 인터넷 환경이 안좋다면, retry를
볼 수도 있었을꺼 같다. retry를 하지 않기위한 보완코드로 settimeout도
했기 때문에 어지간한 환경에선 이미지를 다운로드 받을 수 있을 것이다.


## 정리 {#정리}

크롤링을 하는 경우라거나 open api를 사용한다고 해도 socket을 사용하는
경우는 네트웍이 과부하된다거나 느린 환경에선 retry와 timeout과 같은
보완코드가 필요하다.

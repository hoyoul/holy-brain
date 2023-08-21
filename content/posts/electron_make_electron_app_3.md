+++
title = "[electron] make electron app-3"
author = ["holy"]
description = "crawling app 만들기"
date = 2023-08-13T00:00:00+09:00
draft = true
+++

## renderer에서 crawling 기능 추가 {#renderer에서-crawling-기능-추가}

renderer에서 crawling하기 위해서, crawling하는 코드를 가져온다.


### crawl.js {#crawl-dot-js}

naver webtoon을 다운받는 crawling source를 crawl.js란 이름으로 추가한다.

```js
let request = require('request')
let cheerio = require('cheerio')
let fs = require('fs')

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

const getImgUrls = (titleid,no,path,nidAut,nidSes) => {

    let j = request.jar();
    let cookie1 = request.cookie(`NID_AUT=${nidAut}`);
    let cookie2 = request.cookie(`NID_SES=${nidSes}`);

    let url = "https://comic.naver.com"
    //jar로 묶는다.
    j.setCookie(cookie1,url);
    j.setCookie(cookie2,url);

    request({url: `https://comic.naver.com/webtoon/detail?titleId=${titleid}&no=${no}`,jar: j}, function(error, response,body){
    // request(`https://comic.naver.com/webtoon/detail?titleId=${titleid}&no=${no}`, function(error, response,body){
        console.log("error:"+error);
        // console.log("body:"+body);
        const $ = cheerio.load(body);
        const retryCount =5;
        for(let i=0; i<$('.wt_viewer img').length; i++)
            image_download("download",$('.wt_viewer img')[i].attribs.src, titleid,no,retryCount);

    });
}
// for(let i=1; i< 5;i++){
//     getImgUrls(813335,i);
// }
// for(let i=1, j=0; i< 5;i++,j++){
//     setTimeout( () => {
//         getImgUrls(783053,i);
//     },j*1000);
// }
let path = '';
for(let i=1, j=0; i<= 2;i++,j++){
    const nidAut='wIOaKL4KwP1xOvWc9vaMpf8WDsUCtljrnqfWmyP3E2w7O+DLRVXqGilo/OHm9eWc';
    const nidSes='AAABtuE014or2aojLwS9ksaE1jhs577YG9vXZl9wChP8GicWJZXmohis8cOWyqgy4Fi9eclPnD9v4hiYsTJAA46+xgpsGyRz+il1PUcXi94fxvGMxX09NLkBEPIVwHUIfTP5x7JoWICcENNeQbnpZzPSwKhqYxpyCmXLzl48GYzeiUKLDZnyn8HZGhTTVcXRTQUh5uSFPh4u+vPZ+RFpNmXLHkI6NQFYXPfZVJpYorgHa+GVLlJ/HHA4bPC0Iq+RI6lkiZtpmazQWb8F0vVrlpz5rx/uloYFcppIWMGF9E5N5xxH0tzW1JlYwy0xgTXQmm1jVIRv0qe4yae2ed/ElYvxAKlq9LYO7DwbkwSFdjSxLk9zmx5dAFEcn2gRwyKVV1vFlhStKwYGQwJagdrD9VgfuclRGxIcTX2tRHBBnW2NYmjC8AKoTYZYFqdcdx9cdITLLCcnBrUuse6KtChBIHB7MfY624y8slWG9Vts/gev7scJiQFJ5+5FbcYA1xV6Dw8hh3D5nXH3b/iyBemXEj+GeuQuzVl+kqoBKj4AyW2oORFqbWsJRYBY+M2MXfZnhb1UvKqCpu5Kkq4sGksQclLN93c=';
    setTimeout( () => {
        getImgUrls(675393,i,path,nidAut,nidSes);
    },j*1000);
}

```

별다른 건 없다. 여튼 여기서 require로 2개의 package 'request', 'cheerio'
를 load하는데 현재 없기때문에 npm으로 설치해준다.


### index.html {#index-dot-html}

그리고 index.html에서 require로 crawl.js를 load한다. 두개의 package를 script태그에
추가한다.

```html
<script>
require('./crawl.js')
require('./renderer.js')
</script>
```

이전에도 말했듯이, nodejs는 commmon js를 사용하고 chome browser의 js는
ES6문법을 따른다. 지금 require 코드는 renderer process가 처리하는
ES6에선 이해할 수 없는 문법이다. 보통 여기에서 에러가 난다. 그래서
[여기]({{< relref "electron_make_electron_app_2" >}})서 설명했듯이 main process에서 처리해 줘야 한다. 처리를 했으면
에러가 나지는 않는다.


## crawling app UI 만들기 {#crawling-app-ui-만들기}

ui에선 사용자로부터 입력을 받는다. title명, 회차, 저장받을 위치,
성인이라면 성인 인증 쿠키값(2개)다. 여기서 회차는 범위로 받을 수
있다. 어쨋든, 이것 들은 원래 crawling 프로그램에서는 program에서
상수로 주어졌던 값들이다. 하지만, UI에서 입력을 받기 때문에 이것을
변수 처리 해줘야 한다. 이제 UI를 만들어보자. 6개의 값들을 UI에서 받기
위해서 renderer process가 보여주는 index.html에서 6개의 input창을
만든다.


### 입력 UI만들기 {#입력-ui만들기}

6개의 입력을 받는 UI를 만들자. index.html에서 6개의 input을 추가하면
다음과 같은 모양이 된다.

<a id="figure--app screen"></a>

{{< figure src="/img/electron/app_screen1.png" caption="<span class=\"figure-number\">Figure 1: </span>app screen" width="600px" >}}

아래와 같이 코드를 넣으면 된다.

```html
<form method="post">
  <input type="text" name="title-id" placeholder="title-id" required="required" />
  <input type="text" name="start-no" placeholder="start-no" required="required" />
  <input type="text" name="end-no" placeholder="end-no" required="required" />
  <input type="text" name="path" placeholder="path" required="required" />
  <input type="text" name="nid-aut" placeholder="nid-aut" required="required" />
  <input type="text" name="nid-ses" placeholder="nid-ses" required="required" />
  <button type="submit" class="btn btn-primary btn-block btn-large">Let me in.</button>
</form>
```


### 화면 사이즈도 키우자. {#화면-사이즈도-키우자-dot}

main process에서 화면의 크기를 정한다. 1200x 800으로 하자.

```js
const win = new BrowserWindow({
    width: 1200,
    height: 800,
    webPreferences: {
        nodeIntegration: true,
        contextIsolation: false,
        preload: path.join(__dirname, 'preload.js')
    }
})
```

크기나 UI를 수정하는 것은 개발자 도구를 사용해서 조절한다. 편집은 다음을 참조하자.
[편집화면](~/hoyoul_projects/holy-brain/static/img/electron/ui_editing.mp4) (새창이나 새탭에서 open)

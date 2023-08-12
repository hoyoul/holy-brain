+++
title = "[nodejs] crawling-naver webtoon-8"
author = ["holy"]
description = "naver webtoon crawling하기"
date = 2023-08-09T00:00:00+09:00
draft = true
+++

## 성인 인증 crawling {#성인-인증-crawling}

네이버 성인만화의 경우 naver login을 해야 한다. 성인물의 경우
그렇다. 지금까지 만든 crawler에 성인물 만화의 titleid와 한 회차만
test로 가져오는지 확인해 보자. 우선 만화 제목은 "한번더해요"구,
titleid는 675393이다. 한 회차만 다운로드 해보자. 아래와 같이 10회차만
다운로드하게 했다.

```js
for(let i=10, j=0; i<= 10;i++,j++){
    setTimeout( () => {
        getImgUrls(675393,i);
    },j*1000);
}
```

아무런 에러도 나지 않는다. 다운받을때 message도 출력 안된다. error를
출력하니 null이였다. error가 아니라면 page를 가져온다는 건데, 한번
page를 출력해보기로 한다. 만화 page를 요청하는 부분에서
console.log(body)를 추가해보자. 성인물이라서 login을 요청하는 page가
다운된다는 것을 알 수 있다.

<a id="figure--adult"></a>

{{< figure src="/img/crawling/adult.png" caption="<span class=\"figure-number\">Figure 1: </span>adult" width="600px" >}}

즉, 인증과정을 거쳐야 된다는 것을 의미한다.


## session cookie 사용 {#session-cookie-사용}

request로 page요청을 할때에, session cookie를 넣어서 요청하면,
인증과정이 처리된다. naver의 session 쿠키는 NID_SES와
NID_AUT였다. request에서 cookie를 넣어서 요청하는 경우, jar()와
setCookies()가 사용된다.

<a id="figure--jar"></a>

{{< figure src="/img/crawling/request-jar.png" caption="<span class=\"figure-number\">Figure 2: </span>jar" width="600px" >}}

위와 같이 호출해서 사용한다. 위 코드를 적용하기 위해서, 코드를 수정해
보자. 개발자 도구에서 nid_ses와 nid_aut를 가져와서 아래코드에
넣어주어야 한다.

```js
let j = request.jar();
let cookie1 = request.cookie('NID_SE=value');
let cookie2 = request.cookie('NID_AUT=value');
let url = "https://comic.naver.com"
//jar로 묶는다.
j.setCookie(cookie1,url);
j.setCookie(cookie2,url);

```

위와 같이 jar를 설정하고 request호출시 넣어준다. 원래 request는 url과
callback function으로 되어 있다. 여기서 json객체를 첫번째 인자로
넣어줄 수 있다.

```js
request(`https://comic.naver.com/webtoon/detail?titleId=${titleid}&no=${no}`, function(error, response,body){
```

위의 코드를 아래와 같이 변형한다.

```js
request({url: `https://comic.naver.com/webtoon/detail?titleId=${titleid}&no=${no}`,jar: j}, function(error, response,body){
```

이렇게 하고 test를 해보자. 제대로 가져오는 것을 확인할 수 있다.


## 인증과정 일반화 {#인증과정-일반화}

프로그램을 어떻게 짤것인가?에 따라 다르겠지만, 인증을 login창을 그대로
보여주고 사용자가 입력하게 할 수도 있다. 아니면, NID_SES와 NID_AUT를
입력하게 만들수 있다. 내가 생각하는 방식은 url을 drag drop식으로 내
프로그램에 던져주면, login창을 보여주고 그때부터 검색하게 만드는
것이다. 그런데 우선 NID_SES와 NID_AUT를 입력 받는식으로 해보자. 그렇게
하기 위해서 코드를 좀 refactoring하자. 우리 코드를 보면, for-loop에서
title과 회차를 설정해서 request를 하는 함수로 전달한다. 마찬가지로
for-loop에서 nid_ses와 nid_aut를 설정해서 그 값을 던져주는 식으로
바꾸자.
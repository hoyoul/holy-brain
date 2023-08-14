+++
title = "[electron] make electron app-5"
author = ["holy"]
description = "webtoon downlaoder 만들기"
date = 2023-08-13T00:00:00+09:00
draft = true
+++

## ui 입력값 가져오기 {#ui-입력값-가져오기}

form창의 input에 입력된 값은, start download버튼을 누르면 가져오게
해야 한다. renderer의 js에 startDownload라는 함수를 만든다. 이 함수는
start download 버튼이 눌려지면, 호출된다.

```js
const startDownload = () => {
    let titleId = document.querySelector("#titleId");
    let startNo = document.querySelector("#startNo");
    let endNo = document.querySelector("#endNo");
    let path = document.querySelector("#path");
    let nidAut = document.querySelector("#nidAut");
    let nidSes = document.querySelector("#nidSes");
}
```

아래 그림을 보자.

<a id="figure--start download"></a>

{{< figure src="/img/electron/file2.png" caption="<span class=\"figure-number\">Figure 1: </span>start download" width="600px" >}}

여기서 start download 버튼이 눌려지면, js에 있는 startDownload()가
호출되게 한다. 그리고 form tag에서 onSubmit=startDownload()를 호출하게
한다.

```html
<form method="post" onSubmit="startDownload();">
  <input type="text" name="title-id" id="titleId" placeholder="title-id" required="required" />
  <input type="text" name="start-no" id="startNo" placeholder="start-no" required="required" />
  <input type="text" name="end-no" id="endNo" placeholder="end-no" required="required" />
  <input type="file" name="path" id ="path" placeholder="path" required="required" webkitdirectory/>
  <input type="text" name="nid-aut" id="nidaut" placeholder="nid-aut" required="required" />
  <input type="text" name="nid-ses" id="nidses" placeholder="nid-ses" required="required" />
  <button type="submit" class="btn btn-primary btn-block btn-large">Start Download</button>
</form>
```

그런데 제대로 동작이 되지 않는다. startDownload()에 console.log()를
찍어도 log가 보이지 않는다. 이것은 버튼을 누르는 순간 새로고침이 되서
모든 값들이 초기화되고 renderer process가 새로 시작되기 때문이다. 이
문제를 해결하기 위해선 startDownload()도 return을 false로 하고, html의
form tag에도 false를 return하게 처리해야 한다고 한다.

우선 form tag 처리를 해보자.

```html
<form method="post" onsubmit="return startDownload();">
  <input type="text" name="title-id" id="titleId" placeholder="title-id" required="required" />
  <input type="text" name="start-no" id="startNo" placeholder="start-no" required="required" />
  <input type="text" name="end-no" id="endNo" placeholder="end-no" required="required" />
  <input type="file" name="path" id ="path" placeholder="path" required="required" webkitdirectory/>
  <input type="text" name="nid-aut" id="nidaut" placeholder="nid-aut" required="required" />
  <input type="text" name="nid-ses" id="nidses" placeholder="nid-ses" required="required" />
  <button type="submit" class="btn btn-primary btn-block btn-large">Start Download</button>
</form>
```

그리고 js에서도 처리해준다.

```js
const startDownload = () => {
    console.log("************")
    let titleId = document.querySelector("#titleId");
    let startNo = document.querySelector("#startNo");
    let endNo = document.querySelector("#endNo");
    let path = document.querySelector("#path");
    let nidAut = document.querySelector("#nidAut");
    let nidSes = document.querySelector("#nidSes");
    console.log("start Download" + titleId)
    return false;
}
```

그런데 이렇게 해도 제대로 동작하지 않는다. 에러 메시지도 금방 지나가서
볼 수 없다. 그런데 강사는 말한다. crawl.js를 load하는게 export하고
require하기 때문이라고, 그래서 그 부분을 script로 바꿔줘야 한다고
말한다. 이해가 되지 않았지만, 시키는대로 해보기로 한다. require부분을
다 지워주고 script로 crawl.js만 추가 시켰다.

```html
<script src="./crawl.js"></script>
```

이렇게 하니 log가 찍히고 새로고침도 안하는듯 하다. log는 html object가
찍히는데, value를 찍히게 하기 위해서 다음과 같이 바꾸면 된다.

```html
console.log("start Download" + titleId.value)
```

근데 실제 startDownload함수에서 각 변수에 값이 들어가게 해야 하기
때문에 모두 value를 추가한다.

```js
const startDownload = () => {
    console.log("************")
    let titleId = document.querySelector("#titleId").value;
    let startNo = document.querySelector("#startNo").value;
    let endNo = document.querySelector("#endNo").value;
    let path = document.querySelector("#path").files[0].path;
    let nidAut = document.querySelector("#nidAut").value;
    let nidSes = document.querySelector("#nidSes").value;
    console.log("start Download" + titleId.value)
    return false;
}
```

다만 path는 조금 처리가 다르다. fake path때문에 그렇다.


## 최종 코드 작성 {#최종-코드-작성}

이제 ui에서 사용자가 입력한 값을 코드에서 가져오는것에 성공했다. 원래
crawling하는 소스에 입력해서 제대로 이미지를 load하는지 알아봐야겠다.

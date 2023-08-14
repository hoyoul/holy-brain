+++
title = "[electron] make electron app-4"
author = ["holy"]
description = "naver webtoon downloader 만들기4"
date = 2023-08-13T00:00:00+09:00
draft = true
+++

## file 선택창 {#file-선택창}

webtoon의 이미지를 저장하는 파일 선택창은 input tag에서
변경한다. input tag의 type을 file로 하면 된다.

<a id="figure--file exploere"></a>

{{< figure src="/img/electron/file.png" caption="<span class=\"figure-number\">Figure 1: </span>file exploer" width="600px" >}}

코드도 보면 다음과 같다.

```html
<div class="login">
  <h1>Naver Webtoon Downloader</h1>
  <form method="post">
    <input type="text" name="title-id" placeholder="title-id" required="required" />
    <input type="text" name="start-no" placeholder="start-no" required="required" />
    <input type="text" name="end-no" placeholder="end-no" required="required" />
    <input type="file" name="path" placeholder="path" required="required" />
    <input type="text" name="nid-aut" placeholder="nid-aut" required="required" />
    <input type="text" name="nid-ses" placeholder="nid-ses" required="required" />
    <button type="submit" class="btn btn-primary btn-block btn-large">Start Download</button>
  </form>
</div>

```


### file창 ui 변경 {#file창-ui-변경}

file창의 ui가 이쁘지 않다고 생각된다면 codepen에 들어가서 file
select로 검색해서 괜찮은 ui로 바꾸자. 나는 그대로 쓰기로 했다.


### fake path {#fake-path}

input으로 입력되어진 값들중에 path의 경우는, path가 포함되지
않는다. 경로가 다 표시 되지 않는 fakepath를 갖는다. browser에서 local
path를 얻는건 보안상 위험하기 때문이다. 그래서 다른 방식으로 path를
가져오는데, 그것은 javascript를 사용한다. fakepath는 검색요!

```text
document.querySelector('#path').file[0].path;
```

위와 같은 방식으로 가져온다.


### 폴더의 처리 {#폴더의-처리}

우리가 원한건 저장 폴더였다. 이미지가 저장될 폴더였기 때문에 file
explorer가 실행되서 폴더만 선택되게 할 수 있다. 이것은
webkitdirectory라는 option을 input tag에 붙이는 방식이다.

```html
<input type="file" name="path" id ="path" placeholder="path" required="required" webkitdirectory/>
```

위와 같이 하면 폴더를 선택할 수 있다.

+++
title = "[nodejs] crawling2-session and cookies"
author = ["holy"]
description = "nodejs 크롤링"
date = 2023-08-06T00:00:00+09:00
draft = true
+++

## session과 쿠키 {#session과-쿠키}

동영상에서도 설명을 하는데, 맞는지는 모르겠다. 내가 아는 수준에서
얘기해 보겠다. session과 cookies는 http라는 통신이 갖는 weakness를
보완해 주기 위해 만들어진 개념이다. http는 연결하고 끊는다. 웹문서
요청하고 받고 끝이다. 아무나 요청하고 문서를 받는다. 처음부터 이런
목적으로 설계된 protocol이기 때문에 어떤 사람이 요청했는지 알 필요도
없다. 그런데, 만일 특정 사용자에게 문서를 줄려면 login기능을 만들어야
하고, 한번 login하면 계속 다른 문서도 요청할 수 있게 하기 위해서,
session이라는 것을 만들었다. login하면 session을 만들고, session_id를
서버에 저장한다. 그리고 client에게 session_id를 전달하는데, 이것이
cookie라는 형태로 저장된다. 이것을 session cookie라고 부른다. session
cookie던 그냥 cookie던 이것은 browser에 저장될 수도 있고, hdd에 저장될
수도 있다.


## EditThisCookie plugin {#editthiscookie-plugin}

크롤링하는데, session 쿠키정보를 확인할 필요가 있다. 확인하는 방법은
plugin이다. 확인할 수 있는 chrome plugin이 있는데, EditThisCookie라는
plugin이다.

<a id="figure--editthiscookie"></a>

{{< figure src="/img/crawling/etc1.png" caption="<span class=\"figure-number\">Figure 1: </span>editthiscookie" width="600px" >}}


## session 쿠키 확인 {#session-쿠키-확인}

session 쿠키를 확인하는것은 login을 한 후에 session쿠키로 의심가는
쿠키를 삭제하고, 새로 고침을 한다. session 쿠키로 의심가는 쿠키를
확인하기 위해선 우선 쿠키를 다 볼 수 있어야 한다. 이 때 plugin을 사용한다.
naver에 login하고 plugin을 보면 다음과 같다.

<a id="figure--cookies"></a>

{{< figure src="/img/crawling/cookie1.png" caption="<span class=\"figure-number\">Figure 2: </span>cookies" width="600px" >}}

이 때 제일 위에 있는 쿠키를 지우고, naver를 새로 고침하자. 이때
login상태가 해지된다면 그것이 session과 관련된 쿠키라고 의심할 수
있다. 모든 쿠키를 다 테스트한다. 그러면 NID_AUT,NID_SES가 새로고침했을
때 login상태를 해지시키는 것을 알 수 있다. 그럼 이제 2개가
session쿠키라고 확정지어 말할 수 있는가? double check해보자.


## double check {#double-check}

만일 두개의 cookie가 session 쿠키라면, login하지 않은 naver페이지에서
2개의 cookie를 설정하고 새로고침하면 login상태로 진입해야 한다. 그런데 이렇게
할 수 있냐?라는 질문할 수 있다. cookie를 설정할 수 있는가? 그렇다 할수 있다.


### [step1] chromiumn browser에서 naver에 접속한다. {#step1-chromiumn-browser에서-naver에-접속한다-dot}

login되지 않은 상태여야 한다.

<a id="figure--naver"></a>

{{< figure src="/img/crawling/naver.png" caption="<span class=\"figure-number\">Figure 3: </span>naver" width="600px" >}}


### [step2] login성공했던 session 쿠키를 현 page에 설정한다. {#step2-login성공했던-session-쿠키를-현-page에-설정한다-dot}

개발자도구 -&gt; application에 가면 cookie를 삽입할 수 있다. 다음을
보자.

<a id="figure--cookie2"></a>

{{< figure src="/img/crawling/cookie2.png" caption="<span class=\"figure-number\">Figure 4: </span>cookie2" width="600px" >}}

위에서 session쿠키로 생각했던 NID_AUT와 NID_SES를 그대로
설정한다. 설정항목은 3개의 값이다. name,value,domain name 3개의 값을
설정하고 새로고침 해보자.

<a id="figure--naver"></a>

{{< figure src="/img/crawling/naver2.png" caption="<span class=\"figure-number\">Figure 5: </span>naver" width="600px" >}}

login상태로 변하는것을 볼 수 있다. 즉 session 쿠키가 맞았던 것이다.
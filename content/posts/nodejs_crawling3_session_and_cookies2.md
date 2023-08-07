+++
title = "[nodejs] crawling3-session and cookies2"
author = ["holy"]
description = "동영상 강의 듣고 요약."
date = 2023-08-06T00:00:00+09:00
draft = false
+++

## daum에서 session cookie 찾기 {#daum에서-session-cookie-찾기}

session cookie를 찾기 위해서 EditThisCookie라는 plugin을 사용하는 것은
동일하다. login하기전의 cookie와 login후의 cookie를 비교해서
session쿠키가 될만한 것을 찾을 수 있다. 아래 2개의 이미지가
있다. login전후의 cookie를 비교한 것이다. 여기서, login후에 생성된것이
session 쿠키인지 확인하면 된다.

<a id="figure--before-cookies"></a>

{{< figure src="/img/crawling/before_cookies.png" caption="<span class=\"figure-number\">Figure 1: </span>before_cookies" width="600px" >}}

<a id="figure--after-cookies"></a>

{{< figure src="/img/crawling/after.png" caption="<span class=\"figure-number\">Figure 2: </span>after_cookies" width="600px" >}}

확인하는 방법은 login후에 만들어진 cookie를 삭제하고 새로고침 했을때
login상태가 해지 된다면 session쿠키로 볼 수 있다. HM_CU, HTS, PROF,
TS, LSID와 같이 많은 쿠키들이 session 쿠키인거 같다.


## double check {#double-check}

위에서 찾아낸 session 쿠키가 진짜 맞는지 확인할려면, login되어 있지
않은 상태에서 해당 cookie를 설정하고 새로고침 했을때 login되는지를
확인해보자. naver의 경우에는 chrome개발자 도구의 application에서
cookies를 설정해서 했다면, 이번에는 plugin에 cookie를 복사해서
동작되는지를 확인해보자. Editthiscookie라는 plugin에는 import/export도
있고, cookie를 추가할 수 있기 때문에, login되었을때 cookies를
export한다음에 login전의 page에서 export한 후 새로고침 했을 때,
login이 된다면, session cookie임을 확인할 수 있다. 그래서 login후의
cookie를 export해본다.

<a id="figure--export"></a>

{{< figure src="/img/crawling/export.png" caption="<span class=\"figure-number\">Figure 3: </span>export" width="600px" >}}

export 버튼을 누르면 clipboard에 복사된다. login전의 page로
간다. 여기서 export한 cookie들을 import해보자.

<a id="figure--export"></a>

{{< figure src="/img/crawling/import.png" caption="<span class=\"figure-number\">Figure 4: </span>export" width="600px" >}}

그런데 적용이 되지 않는다. json을 쿠키가 아니라고 한다. import만
안되는게 아니라, +를 눌러서 새로운 cookie를 만드는것도
안된다. plugin이 제대로 동작하지 않는것이다. 이럴때는
chrome개발자도구에서 application에서 cookie를 설정하면 된다.


## 요약 {#요약}

data crawling할때 login된 상태에서 data를 가져와야 할 경우 session
쿠키를 알아야 접근할 수 있다.

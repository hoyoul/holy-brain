+++
title = "[electron] make electron app-2"
author = ["holy"]
description = "app만들기"
date = 2023-08-05T00:00:00+09:00
draft = true
+++

## 예제 {#예제}

youtube에서 옛날꺼긴 하지만, 좋은 강의같은게 있어서 [참고](https://www.youtube.com/watch?v=KN2rg0PCjvA&list=PLqh5vK4CKWeZDGPhn5IMk3uZv2rQ5hNSK&index=4) 해보기로
한다. 내가 예젠에 electron을 사용할때와 version이 달라서 많은것이
바꼈다. 이 강의도 옛날꺼라서 지금과는 다르다.


## login 페이지 만들기 {#login-페이지-만들기}

codepen에 괜찮은 login [page](https://codepen.io/frytyler/pen/nJYVEO)가 있어서 이것을 적용하기로 한다. 이전에
작업하던 project에 styles.css를 만든다. 그리고 codepen에서 긁은 css를
붙인다. 그리고 index.html에 link를 걸자.

```html
<link rel="stylesheet" href="./style.css">
```

html의 div태그도 붙여준다. codepen에서 그냥 긁어서 붙여주면된다.

```html
<div class="login">
        <h1>Login</h1>
    <form method="post">
        <input type="text" name="u" placeholder="Username" required="required" />
        <input type="password" name="p" placeholder="Password" required="required" />
        <button type="submit" class="btn btn-primary btn-block btn-large">Let me in.</button>
    </form>
</div>
```

그리고 실행을 하면 다음과 같이 login화면이 나온다.

<a id="figure--login"></a>

{{< figure src="/img/node/first_electron1.png" caption="<span class=\"figure-number\">Figure 1: </span>login" width="600px" >}}

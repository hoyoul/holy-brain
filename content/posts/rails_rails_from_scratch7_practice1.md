+++
title = "[rails] rails from scratch7-practice1"
author = ["holy"]
description = "옛날 자료 취합"
date = 2023-08-02T00:00:00+09:00
draft = true
+++

## 제일 먼저 할것은 hello world page {#제일-먼저-할것은-hello-world-page}

<div class="note">

rails를 설치하고, CI/CD를 위한 환경이 조성되었다면, hello world를
출력하는 것이다. 이것은 간단하게 routes와 controller만 사용해서
출력하기로 한다. route에서는 root 경로만 설정해준다.

</div>

> rails new hellodemo --database=mysql 로 project를 만든다. (database.yml처리를 mysql 맞게 해준다.


### route 설정 {#route-설정}

<div class="note">

route를 설정하기 위해서 route file을 연다.  root를 사용해서 아래와 같이 application controller의 hello라는 action으로 mapping한다.

</div>

<a id="figure--"></a>

{{< figure src="/img/rails/rt1.png" caption="<span class=\"figure-number\">Figure 1: </span>rt1" width="600px" >}}


### controller의 설정 {#controller의-설정}

<div class="note">

application controller에서는 action에 해당하는 hello method를 작성하지만, 실제 view와 연결짓지는 않는다.
render함수의 정확한 용법은 모르겠다. 하지만, 이렇게 관습적으로 사용한다.

</div>

<a id="figure--"></a>

{{< figure src="/img/rails/render.png" caption="<span class=\"figure-number\">Figure 2: </span>render1" width="600px" >}}


### 실행 {#실행}

<div class="note">

local에선 별도의 rails db:migration이나 rails assets:precompile을 하지
않아도 된다. 왜냐면, db와 css,js를 사용하지 않기 때문이다. 그냥 rails
s만 하면 된다.  server는 cap production deploy로 release를 발행한다.

</div>


## css,js,image사용법 (bootstrap의 적용, jquery의 적용: ajax) {#css-js-image사용법--bootstrap의-적용-jquery의-적용-ajax}

<div class="note">

어떤 page작업을 하더라도 css와 js가 사용된다. 둘의 사용이 능수
능란해야 한다. webpacker에 대한 설명은 맨아래에 따로 두었다. 여기서는
css와 js 사용법만을 얘기한다. css와 js를 사용하는 이론적인 것을
설명한후, 실제 test과정을 기술하겠다.

</div>


### [ 이론 ] css,js 사용법과 나의 기준 {#이론-css-js-사용법과-나의-기준}

<div class="important">

css와 js를 만들 때의 기준은 첫번째 사용범위, 두번째 어떤 것을 사용할 것인가의 문제다. 어떤것을 사용하느냐에 따라 pack파일 기술이 달라진다. 이 두가지를 간략히 설명하겠다.

</div>


#### 사용 범위에 따른 기준 (packfile의 naming) {#사용-범위에-따른-기준--packfile의-naming}

-   전체 vs 부분

    <div class="note">

    전체 page에 공통적으로 적용되는가? 아니면 controller가 다루는
    page들에만 한정해서 적용 되는가? 특정 page에만 적용 되는가?
    default로 전체 page에 공통적으로 적용되는 것은 이미 적용되어
    있다. application.html.erb파일에 보면 application.js라는 pack과
    application.scss라는 pack은 공통적으로 모든 page에 적용된다. 그래서
    전체 page에 적용되는 것은 application.js와 application.scss에
    포함시켜야 한다.

    </div>

<!--listend-->

-   controller과 관리하는 pages 혹은 특정 page에만 적용 되는 경우

    <div class="note">

    controller가 다루는 page들에만 적용된다면, Controller명.scss나
    Controller.js로 파일을 pack안에 만든다. 특정 page에만 적용되는 js나
    scss의 경우 Controller명Action명.scss, Controller명Action명.js를
    /pack안에 만든다.

    </div>


#### 만들어진것 vs 만들어서 (packfile의 구조) {#만들어진것-vs-만들어서--packfile의-구조}

<div class="note">

만들어진것을 사용(package)하느냐, 만들어서 사용하는냐에 따라
pack파일의 기술 방법이 다르다.

</div>

-   만들어진것(package)를 사용

    <div class="important">

    yarn으로 package를 설치하고 사용해야 한다. 설치하는 방식은 "yarn
    add package명" 을 webapp의 home에서 실행 해준다. 그러면 yarn은
    webapphome/ node_modules라는 곳에 package를 설치한다. yarn이란것은
    아래 [부록]에서 별도로 설명하겠다. 이렇게 설치된 package를 pack에
    기술하기 위해선, import라는 지시어를 사용한다. import
    package명/js의 위치로 기술해서 사용한다. 실제 예제에 보면, js를
    import한 후 start() 를 사용하는 경우를 볼 수 있는데, 그것은 초기화
    과정이다. 보통은 필요없다.

    </div>
-   만들어서 사용

    <div class="important">

    만일 우리가 만든 css나 js가 다른 page에서 사용되는 일종의
    library같다면, js라는 폴더, stylesheet라는 폴더에 넣은 후
    pack파일에 import해서 사용하면 된다. 마치 위에서 만들어진
    package를 사용하는 것과 동일하다. 그런데 내가 만든 css나 js가
    재사용이 안되고 그 page에만 적용된다면, pack파일에 직접 기술한다.

    </div>


#### case 시나리오 {#case-시나리오}

-   (1) 전체 page에 적용되고 이미 만들어진 package를 사용하는 경우 (bootstrap scss와 jquery js처리)
-   (2) 특정 page에 적용되고 이미 만들어진 package를 사용하는 경우 (bootstrap scss와 jquery js처리)
-   (3) 전체 page에 적용되고 내가만든 file을 사용하는 경우
-   (4) 특정 page에 적용되고 내가 만든 file을 사용하는 경우


### [ 실전 case1: bootstrap.scss, jquery 전체 page사용하기 ] {#실전-case1-bootstrap-dot-scss-jquery-전체-page사용하기}

<div class="important">

-   (1) 전체 page에 적용되고 이미 만들어진 package를 사용하는 경우 (bootstrap cs와 jquery js처리)
    이미 만들어진 package를 사용한다. 그러면 우선 package를 설치한다. bootstrap을  yarn으로 설치해본다. jquery도 yarn으로 설치한다.  bootstrap5부터는 javascript는 바닐라 js이기 때문에 package를 가져다 사용하는 것에 큰 의미가 없어 보여서 jquery.js를 사용한다.

</div>

<a id="figure--"></a>

{{< figure src="/img/rails/case1_1.png" caption="<span class=\"figure-number\">Figure 3: </span>case1_1" width="600px" >}}

<a id="figure--"></a>

{{< figure src="/img/rails/case1_js.png" caption="<span class=\"figure-number\">Figure 4: </span>jquery" width="600px" >}}

<div class="important">

전체 page에 적용된다. 따라서 application.js, application.scss라는 pack파일에 jquery의 js와 bootstrap.scss파일을 import하면 된다. node_modules folder에서 jquery, bootstrap이 있는지 확인하고, 있다면 지원하는 bootstrap.scss와 jquery.js의 위치를 파악한다. 위치를 파악하는 이유는 import에 경로를 기술하기 위함이다.

</div>

<a id="figure--"></a>

{{< figure src="/img/rails/case1_js2.png" caption="<span class=\"figure-number\">Figure 5: </span>case" width="600px" >}}

<a id="figure--"></a>

{{< figure src="/img/rails/case1_2.png" caption="<span class=\"figure-number\">Figure 6: </span>case1_2" width="600px" >}}

<a id="figure--"></a>

{{< figure src="/img/rails/case1_3.png" caption="<span class=\"figure-number\">Figure 7: </span>case1_3" width="600px" >}}

-   import 위치

> 요약하면
> js위치: jquery/src/ajax.js bootstrap/js/src/alert.js, bootstrap/js/src/button.js ...
> scss의 위치: bootstrap/scss/bootstrap.scss

-   pack파일에 적용

<div class="note">

이것을 pack파일에 적용 시켜보자. 전체 page에 적용되기 때문에, application.scss와 application.js에 import하면 된다. javascript_pack_tag나 stylesheet_pack_tag를 layouts/application.html.erb에 적용해야 한다. rails 6에서는 default이긴 하지만, 좀 다르다. scss는 asset을 이용하고 javascript만 webpack을 이용하기 때문이다. 난 webpack에서 모든것을 관리하기 때문에 변경을 해줬다.

</div>

<a id="figure--"></a>

{{< figure src="/img/rails/case1_js3.png" caption="<span class=\"figure-number\">Figure 8: </span>case1_2js2" width="600px" >}}

<a id="figure--"></a>

{{< figure src="/img/rails/case1_4.png" caption="<span class=\"figure-number\">Figure 9: </span>case1_4" width="600px" >}}

<a id="figure--"></a>

{{< figure src="/img/rails/case1_6.png" caption="<span class=\"figure-number\">Figure 10: </span>case1_6" width="600px" >}}

-   Test1 [scss test]

    <div class="note">

    1.  button을 만들어보자(scss테스트)
    2.  동작확인 (아래 2번째와 같이 제대로 된 동작을 하지 않는다.)
    3.  뭐가 문제인가? debug 어떻게 debuging할 것인가?

    </div>

<a id="figure--"></a>

{{< figure src="/img/rails/case1_7.png" caption="<span class=\"figure-number\">Figure 11: </span>case1_7" width="600px" >}}

<a id="figure--"></a>

{{< figure src="/img/rails/case1_8.png" caption="<span class=\"figure-number\">Figure 12: </span>case1_8" width="600px" >}}

<div class="attention">

[문제 해결] scss에서 import는 @import를 사용해야 한다.

</div>

<a id="figure--"></a>

{{< figure src="/img/rails/case1_9.png" caption="<span class=\"figure-number\">Figure 13: </span>case1_9" width="600px" >}}

<a id="figure--"></a>

{{< figure src="/img/rails/case1_10.png" caption="<span class=\"figure-number\">Figure 14: </span>case1_10" width="600px" >}}

-   Test2 [js test]

    <div class="note">

    jquery를 테스트 해보자. jquery에서 ajax를 load했기 때문에  ajax를 테스트 해볼려고 한다. ajax는 테스트가 힘들어 위에서 import를 jquery.js로 바꿔서 모든 jquery를 사용할 수 있게 바꾸고 테스트한다.  예제코드는 다음을 참조했다.
    <https://www.w3schools.com/jquery/jquery_animate.asp>

    </div>

<a id="figure--"></a>

{{< figure src="/img/rails/case2_2_jquery.png" caption="<span class=\"figure-number\">Figure 15: </span>case2_jquery" width="600px" >}}

<a id="figure--"></a>

{{< figure src="/img/rails/case1_js4.png" caption="<span class=\"figure-number\">Figure 16: </span>case1_js4" width="600px" >}}

<div class="attention">

[정상동작] 아무 문제 없이 동작하는 것을 확인했다.

</div>


### [ 실전 case2:  d3.js and d3.scss를 특정 page에 사용하기 ] {#실전-case2-d3-dot-js-and-d3-dot-scss를-특정-page에-사용하기}

<div class="note">

-   d3를 yarn으로 설치하자. (yarn add d3)
-   d3의 설치 경로를 살펴보자. dist와 src에 js가 있다. 난 dist/d3.js를 import하기로 했다.
-   static_pages_home.js란 pack을 만들자.(app/javascript/pack/ 에 만든다)
-   만든 pack에 d3를 import한다. (import 'd3/dist/d3.js')
-   pack을 page에 include한다. (javascript_pack_tag 'static_pages_home')

</div>

-   pack을 만든다.

<a id="figure--"></a>

{{< figure src="/img/rails/case2_d3_1.png" caption="<span class=\"figure-number\">Figure 17: </span>pack을 만든다." width="600px" >}}

-   view에 pack을 추가시킨다.

<a id="figure--"></a>

{{< figure src="/img/rails/case2_d3_3.png" width="600px" >}}

-   test 결과 [ js가 적용된것을 볼 수 있다.]

<a id="figure--"></a>

{{< figure src="/img/rails/case2_d3_2.png" width="600px" >}}


### [ 실전 case3: 전체 page에 적용되고 내가만든 file을 사용하는 경우 ] {#실전-case3-전체-page에-적용되고-내가만든-file을-사용하는-경우}

<div class="note">

내가 만든 css와 js가  전체 page에 적용한다는 것은, 라이브러리 모듈이라고 생각하면 된다. 그래서 js나 stylesheet폴더에 파일이 있고 그것을 application.scss와 application.js에서 import해서 사용하는 것을 의미한다.

</div>

<div class="important">

-

</div>


### [ 실전  case4:  font awesome(아이콘) 전체 page 적용 {#실전-case4-font-awesome--아이콘--전체-page-적용}


#### 적용1 {#적용1}

<div class="note">

-   (1) yarn add font-awesome 으로 설치한다.
-   (2) import location을 찾는다.

</div>

<a id="figure--"></a>

{{< figure src="/img/rails/case4_font1.png" caption="<span class=\"figure-number\">Figure 20: </span>case4" width="600px" >}}

<div class="important">

scss란 폴더가 따로 있어서, import위치를 예측할 수 있다. /font-awesome/scss/font-awesome.scss가 import할 대상이다. 이것은 application.scss pack에 import한다.

</div>

<a id="figure--"></a>

{{< figure src="/img/rails/case4_font2.png" caption="<span class=\"figure-number\">Figure 21: </span>case4" width="600px" >}}


#### 문제점 {#문제점}

<div class="note">

이렇게 하면 제대로 동작하지 않는다.  에러가 난다. 인터넷에서 찾은
방식을 사용해 보자.

</div>


#### 다른 방식 {#다른-방식}

<div class="note">

-   yarn add @fortawesome/fontawesome-free
-   import "@fortawesome/fontawesome-free/css/all" 을 application.js에 설치한다.
    =&gt; 이상없이 된다.

</div>


### [ 실전 case5: bootstrap-icons 전체 page적용 {#실전-case5-bootstrap-icons-전체-page적용}

<div class="note">

-   yarn add bootstrap-icons
-   import 'bootstrap-icons/font/bootstrap-icons.css' in application.js pack

</div>


### 최종 정리 {#최종-정리}

<div class="important">

내가 생각한 방식은 "간단하게 하자"라는 모토에서 벗어나지 않는다. 간단하게 하기 위해서 생각한건 다음과 같다.

-   모든 page에 적용되는가?
    =&gt; application.scss,와 application.js팩들에 기술하고, layouts/application.html.erb에 가져다 쓴다.

-   일부 page에만 적용되는가? 여러 page에 적용되는가?
    =&gt; 모두 controllerAction.scss, controllerAction.js라는 pack에 기술한다. 즉 page별로 적용한다. 물론 내가 만든 scss나 js가 library module처럼 여러 페이지에 사용된다거나, d3같은 차트관련해서 몇몇 page에서만 사용된다고 할 지라도 따로 pack을 만들고, 해당 page에 include해서 사용한다.  이런 유혹을 느낄수 있다. 여러 페이지에서 사용된다면 page마다 동일한 코드를 중복 사용하는 문제가 생기는것이기 때문에 js폴더나 styles폴더에 해당 라이브러리를 만들고, pack에서 import해서 쓰는게 맞다고...물론 맞는 얘기다. 그런데 지금처럼 신경쓸 게 많을때는 단순하게 가야 한다. 단순하게 가기로 했다.

-   [단순하게] **모든 page에 적용되는게 아니라면, pack에다 직접 기술한다.**
    -   아래 module들은 전체 page에서 사용될 확률이 높은 것들이다.
        -   bootstrap
        -   font-awesome(아이콘 사용을 위해)
        -   lodash, underscore (js내의 array같은 collection사용을 위해)
        -   jquery

-   일부 page에서 사용
    -   d3

</div>


### 최종 정리2 {#최종-정리2}

-   import의 사용법

    <div class="important">

    -   yarn을 사용한 경우
        node_modules에서 설치된 package의 js와 scss의 위치를 파악한다.
        js: import 'module/js/index.js' 처럼 기술 한다.
        scss: @import로 동일하게 기술한다.
    -   자체 만든 library 경우
        pack폴더를 기준으로 한다. import '../js/mylibrary.js'와 같이 한다.

    </div>


### 최종정리3 {#최종정리3}

<div class="important">

최종적으로 bootstrap과 jquery는 application.js와 application.scss에
있어서 bootstrap과 jquery, awesome font, bootstrap-icons를 사용할 수
있게 해야 한다.

</div>


## application layout 만들기 {#application-layout-만들기}

-   application layout에 대해서

<div class="note">

모든 page의 layout(와꾸, 기본틀)를 잡아주는
page다. app/views/layouts/application.html.erb파일이다. 여기서 해야
할 것은 모든 page의 공통적인 것을 기술한다. 공통적인것은 header와
footer를 의미한다.  header에는 navigation menu bar가 들어가고
footer에도 menubar가 들어간다.  특정 page에는 side menu bar가
들어갈수도 있다. 어떻게 design하느냐에 따라 달라진다.

</div>

<div class="important">

application.js에서 bootstrap과 jquery를 사용하게 setting했기 때문에
bootstrap의 header와 footer를 사용하기로 한다.

</div>


### 실제 구현 {#실제-구현}

<div class="note">

-   bootstrap5 homepage에서 examples를 본다. 마땅한것이 있다면 source를
    보고 copy해서 application.html.erb에 yield사이로 붙인다. 이게
    전부다.

</div>


#### partial page의 사용 {#partial-page의-사용}

<div class="important">

page는 보통 html tag로 되어 있는데, 보기에 복잡하다. 이것은 관리가 힘들다는 것이다.  그리고 보통 다른곳에서  source를 가져와 사용하기 때문에 따로 분리할 필요가 있다. 그래서 온전히 하나의 page를 작성하는 경우는 드물고, partial page로 나눠서 작성하고 관리한다. application layout도 다르지 않다.

</div>

-   partial page만드는 법

<div class="note">

header와 footer를 partial page로 만들 것이다. layouts폴더에 \_header.html.erb와 \_footer.html.erb라는 2개의 파일을 만든다. 만든 파일에 긁어온 html을 붙여넣거나 직접 작성한다.

</div>

-   partial page 적용

    <div class="note">

    만든 partial page를 application.html.erb에 적용한다. 적용 방법은 다음과 같다.
       &lt;%= render 'layouts/header' %&gt;
       &lt;%= render 'layouts/footer' %&gt;

    </div>


#### 결론 {#결론}

<div class="note">

navigation bar를 만드는 방법은 좀 복잡하다. 단순히 bootstrap을 copy &amp;
paste하더라도, class의 의미를 이해해야 한다. 지금 작성하는 시점에서는
대충 알지만, 나중에는 까먹을것이 분명하기 때문이다.

</div>


## static pages  만들기 - navigation menu {#static-pages-만들기-navigation-menu}


### static pages 개요 {#static-pages-개요}

-   static page란?

<div class="note">

web page를 만들 환경이 다 되었다면 기본적으로 해야할 것이, static pages들을 만들어야 한다.
static page란 건, db를 사용하지 않고 동적으로 만들어지지 않는 page를 말한다. static page에는 대략적으로 다음과 같은 것이 있다.

</div>

-   static page종류

    <div class="important">

    -   (1) home
    -   (2) help
    -   (3) about
    -   (4) contact us
    -   (5) news
    -   (6) support

    </div>


### [1] static pages 만들기 {#1-static-pages-만들기}

<div class="note">

**1. rails g controller StaticPages home help about contact로 만든다.**
   [ 참고로 Controller, Model 모두 camel case로 표기한다. 다만 Controller는 복수를, Model은 단수를 사용한다.]

</div>


#### home page 작성 {#home-page-작성}

-   view 작업

<div class="note">

home  page를 작성한다. 만일 작성할 page가 많다면 partial page를 사용한다.

</div>

-   routing작업

    <div class="note">

    root to: 'static_pages#home' 추가

    </div>
-   연결작업

    <div class="note">

    layouts/application.html.erb에서 navigation을 만든 경우, home을 연결해야 한다.

    </div>


#### about page 작성 {#about-page-작성}


## [devise gem]으로 로그인 만들기 {#devise-gem-으로-로그인-만들기}


### devise란? {#devise란}

<div class="note">

회원가입, login, password관련 처리를 gem으로 할 수 있다.  session관련
처리뿐만 아니라, url도 만들어주고, db도 만들어 주며, view도 만들어
준다. session이 뭔지를 알아야 한다. session은 공식적으론 cookie의
일종이다. client가 server에 연결할 때 server가 key value값을
만든다. 이것을 session이라고 부른다. server는 만든 session을 client에
전달하고 client는 해당 browser 쿠키 보관소에 그 값을 가지고 있다가,
다시 동일 서버에 접근할때 저장된 cookie값을 동봉해서 보낸다. 그러면
server는 cookie로 사용자를 판단할 수 있게 된다. 이 과정을 구체적으로
사용자 인증과 결부하여 살펴보면 다음과 같다.  client가 회원가입 시,
server에 session이 만들어지고 저장된다. 그리고 client가 login시
,server는 session을 가져와서 client에게 보낸다. client가 탈퇴를 하게
되면 저장된 session은 삭제된다. devise는 이런 session처리를 알아서
자동화 한다. session은 user_signed_in?, current_user,user_session이란
심볼로 대신한다. devise 설치는 이 모든 것을 다 만들어준다. 만들어준 이
모든 것을 논리적 의미에 따라 session 심볼들을 적절히 사용하는 것이
devise gem을 사용하는 방식이다.

</div>


### devise 설치 과정 {#devise-설치-과정}

<div class="note">

devise를 설치하면,  routing, model,view, controller 관련된 모든것을 설치해야 한다.  나누어서 설명하겠다.

</div>

-   **[1] Gemfiles에 devise gem 추가**

<a id="figure--gem1"></a>

{{< figure src="/img/rails/gem1.png" width="600px" >}}

<div class="note">

Gemfiles에서 gem 'devise'만 할 경우, rails 4나 5에 맞춰서 설치된다는 얘기가 있다. rails 6에 맞춰야 하기 때문에 다음과 같이 입력해도 된다.

gem 'devise' git: 'https://github.com/heartcombo/devise.git'

</div>

-   **[2] bundle install을 실행한다.**
-   **[3] rails g devise:install를 실행한다.**

<a id="figure--gem2"></a>

{{< figure src="/img/rails/gem2.png" caption="<span class=\"figure-number\">Figure 22: </span>gem2" width="600px" >}}

-   4) config.action_mailer.default_url_options를 environments/development.rb에 설정한다. mail template에 대한 URL을 만들어준다고 한다. 보통 해도되고 안해도 된다.
-   5) root, to: 'home#index'가 반드시 있어야 할 필요는 없다.
-   6) **layout/application.html.erb에는 notice와 alert tag를 삽입하면, session이 만들어질때나 유지될때 메시지가 출력된다. 하자**

    <div class="tip">

    &lt;p class="notice"&gt;&lt;%= notice %&gt;&lt;/p&gt;
    &lt;p class="alert"&gt;&lt;%= alert %&gt;&lt;/p&gt;

    </div>
-   7) **railg g devise:views**  : view/devise라는 폴더가 만들어지면서 여러 page들이 만들어진다.
-   8) **rails g devise User** : user model을 만든다.
-   9) migrate file에서 t.string :username으로 사용자 이름 field를 추가한다.

<a id="figure--"></a>

{{< figure src="/img/rails/devise1_1.png" width="600px" >}}

-   10) **rake db:migrate** 로 db에 table을 만든다.
-   11) routes 파일을 보면 devise_for users라고 만들어진다. 어떤 URL이 있는 지 확인하자.

<a id="figure--"></a>

{{< figure src="/img/rails/devise1_2.png" caption="<span class=\"figure-number\">Figure 23: </span>devise1-2" width="600px" >}}

-   12) rake routes | grep users
-   13) 위에서 확인해야할 것은 다음과 같다.

<div class="note">

-   users/sign_up :회원가입 url

f- users/sign_in : 로그인 page

</div>

1.  url/users/sign_up으로 들어가서 회원가입을 작성 한다. -&gt; 작성이 끝나면 login되면서 home으로 url이 이동된다.
2.  다시 url/users/sign_up을 하면 login이 이미 된 상태라서 회원가입창이 나오지 않고 다시 home으로 이동된다.
3.  navigation에 있는 sign in, sign up의 경로를 맞춰줘야 한다.  application layout에 있는 navi menu에 sign-in과 sign_up이 있는지 확인한다. 없다면 만든다.  아래는 login 아이콘과 signed up 아이콘이 있는 button이다. 자주 사용되서 가져왔다. font awesome icon을 사용했다.

    <div class="tip">

    &lt;ul class="nav navbar-nav ml-auto"&gt;
    	 &lt;li class="nav-item"&gt;
        &lt;a class="nav-link" href="#"&gt;&lt;span class="fas fa-user"&gt;&lt;/span&gt; Sign Up&lt;/a&gt;
        &lt;/li&gt;
    	  &lt;li class="nav-item"&gt;
        &lt;a class="nav-link" href="#"&gt;&lt;span class="fas fa-sign-in-alt"&gt;&lt;/span&gt; Login&lt;/a&gt;
          &lt;/li&gt;
    &lt;/ul&gt;

    </div>
4.  14) [ **navigationbar에서 signup과 login의 link를 알맞게 연결한다.** ]
5.  15) [ **login 상태에 따른 처리도 해야한다.** ]

    <div class="note">

    login 상태에 대한 처리라는 것은 다음과 같다.
    만일 login이 되었다면, log out버튼만이 보여야 한다.
    login이 안 되었다면 log in과 sign up 버튼이 보여야 한다. 이것은  다음과 같이 구현한다.

    </div>

    <div class="tip">

    &lt;% if user_signed_in? %&gt;
      &lt;li class="nav-item"&gt;
        &lt;%= link_to destroy_user_session_path, class: "nav-link" do %&gt;
        &lt;!-- &lt;span&gt; --&gt;
          &lt;i class="fas fa-sign-out-alt"&gt;&lt;/i&gt;
          Log Out
          &lt;!-- &lt;/span&gt; --&gt;
          &lt;% end %&gt;
      &lt;/li&gt;
    &lt;% else %&gt;
      &lt;li class="nav-item"&gt;
        &lt;a class="nav-link" href="/users/sign_in"&gt;&lt;span class="fas fa-sign-in-alt"&gt;&lt;/span&gt; Login&lt;/a&gt;
      &lt;/li&gt;
      &lt;li class="nav-item"&gt;
        &lt;a class="nav-link" href="/users/sign_up"&gt;&lt;span class="fas fa-user"&gt;&lt;/span&gt; Sign Up&lt;/a&gt;
      &lt;/li&gt;
    &lt;% end %&gt;

    PS: 위에서 link to는 a태그와 같이 link를 걸지만, 그안에 class속성과 icon을 넣을 수 있다.  그 방식은 tip이라고 할 수 있다.

    </div>
6.  16) [ **에러 발생** ] logout시 session을 지울때 method를 delete로 해서 server로 전송하는게 안된다. 어떤 방식을 써도 다음과 같은 에러가 발생한다.

<a id="figure--"></a>

{{< figure src="/img/rails/devise_error.png" caption="<span class=\"figure-number\">Figure 24: </span>devise_error" width="600px" >}}

-   17) [ **logout 문제 해결 방법** ]

    <div class="note">

    -   (1) &lt;%= link_to "logout" , destroy_user_session_path %&gt; 로 한다.
    -   (2) (1)을 수정해서   &lt;%= link_to destroy_user_session_path, data:{method: "delete"}, class: "nav-link" do %&gt;로 한다. 그런데 method: "delete"가 먹지 않는것같다. 즉 계속 :get으로 연결한다.
        그래서 난, (3)에서 signed out을 :get으로 변경했다.
    -   (3) config/initializers/devise.rb에서 config.sign_out_via = :delete로 되어 있다면 :get으로 변경한다.

    </div>
-   18) **username항목 추가**

    <div class="note">

    db:migrate하기 전에 migrate파일에서 username을 추가했었다. 이 부분이 회원가입과 login시에 포함되어 있지 않다.

    </div>

    -   회원 가입 화면  처리

        <div class="note">

        우선 회원가입 page에서 username을 추가 시키자. 회원 가입 page는 devise/registration/new.html.erb에서 다음과 같이 추가한다.

        </div>

<a id="figure--"></a>

{{< figure src="/img/rails/devise_registration.png" caption="<span class=\"figure-number\">Figure 25: </span>devise-registration" width="600px" >}}

<a id="figure--"></a>

{{< figure src="/img/rails/signup.png" caption="<span class=\"figure-number\">Figure 26: </span>sign up" width="600px" >}}

<div class="note">

이렇게 page를 만든후에 test해본다. signup을 눌러서 회원가입 form에 username이 입력 가능한지 알아보고, 가입을 해본다.  가입이 되었다는 말은 form의 정보가 server에 전송되어서 db에 저장된것으로 생각한다. 그러나 값은 저장되지 않았다. 확인하기 위해선, rails c를 사용해서  console로 진입한다. rails c를 사용하는 이유는 한가지! Active Record(db table을 객체화하는 framework)를 사용해서 db의 내용을 확인할 수 있기 때문이다.
rails c로 console로 들어간후 User.last로 회원가입시 내가 입력한 username이 db에 저장되었는지 확인해 보자. 저장이 되지 않았음을 알 수 있다.

</div>

<a id="figure--"></a>

{{< figure src="/img/rails/devise_username.png" caption="<span class=\"figure-number\">Figure 27: </span>devise_username" width="600px" >}}

-   username [controller처리]

<div class="note">

page에서 username항목은 있지만, 실제 입력된 data가 db에는 저장되지 않는다. 이것은 우리가 처리해 줘야 한다. db table을 만들 때, username이라는 항목을 만들었고, page에서도 항목을 만들었지만, controller에서는 새로만든것을 처리하지 않고 있다. 이것을 devise에서는 strong parameter라는 항목으로 소개를 했다. devise의 코드를 가져와서 application controller에 붙인다.

</div>

<div class="tip">

before_action :configure_permitted_parameters, if: :devise_controller?

protected

def configure_permitted_parameters
  devise_parameter_sanitizer.permit(:sign_up, keys: [:username])
end

</div>

<a id="figure--"></a>

{{< figure src="/img/rails/devise_controller1.png" caption="<span class=\"figure-number\">Figure 28: </span>devise controller" width="600px" >}}

<a id="figure--"></a>

{{< figure src="/img/rails/devise_controller2.png" caption="<span class=\"figure-number\">Figure 29: </span>devise_controller" width="600px" >}}

-   update에관한 처리(view)

<div class="note">

회원가입시 username항목에 대한  controller의 처리를 했다. 그런데 update시에 추가한 username도 처리해야 한다. view에서 update하는 곳에 username항목을 넣워야 한다.
/devise/registration/edit.html.erb에 추가한다. 이렇게 하면 나중에 사용자 정보 수정시 username도 수정 가능하다.

</div>

<a id="figure--"></a>

{{< figure src="/img/rails/devise_registration2.png" caption="<span class=\"figure-number\">Figure 30: </span>devise_registration" width="600px" >}}

-   수정 화면

<a id="figure--"></a>

{{< figure src="/img/rails/devise_useredit.png" caption="<span class=\"figure-number\">Figure 31: </span>devise_user edit" width="600px" >}}

-   수정 결과 (DB 저장 여부)

<a id="figure--"></a>

{{< figure src="/img/rails/devise_db.png" width="600px" >}}

-   navigation에 사용자 이름 출력

    <div class="note">

    username이라는 항목을 devise에 추가하면서, 회원가입시, 회원정보 수정시 view,controller에 알맞는 처리를 해주었다. 마지막으로 사용자가 login시에, navigation bar에 사용자 이름과 logout 아이콘이 나오게 해야 한다. 지금은 logout 아이콘만 나온다. 이것을 추가하기 위해서는 navigation code가 있는 \_header.html.erb를 수정한다.

    </div>

-   19) **page 접근권한**

    <div class="note">

    devise에서 제공하는 것 중 유용한게 있다. 특정 page에 접근하려고 할때 login이 되어 있지 않다면 접근할 수 없게 할 수 있다.
    이걸 하려면, controller에 before_action을 거는 것이다. before action으로, authentication_user!를 사용하면 해당 controller가 관할하는 pages들에 대해서 login하지 않았다면 접근 할 수 없다. only와 except라는 option으로 세부 조정도 가능하다.

    </div>

    <div class="important">

    before_action :authenticate_user! : 모든 page에 접근할 수 없다.
    before_action :authenticate_user!, except: :index # index빼고 실행
    before_action :authenticate_user!, only: :show # show만 실행

    before_action :authenticate_user!, only: [:index, :show]
    before_action :authenticate_user!, only: ["index", "show"]

    \#퍼센트 기법을 사용하면 아래와 같이도 가능
    before_action :authenticate_user!, only: %i[index show]
    before_action :authenticate_user!, only: %w[index show]

    </div>
-   20) **devise page 꾸미기** (bootstrap) --delay: 나중에 bootstrap css를 다시 공부하고 난 후에 한다.

    <div class="note">

    devise에서 제공하는 page는 별로 이쁘지 않다. 수정이 필요하다. 완벽한 수정전에 우선 중앙 정렬부터 하자. 중앙 정렬은 &lt;div class=container&gt;로 묶어주면 된다.

    수정할 page를 어떤게 있고, 어떻게 찾을수 있는가?
    찾는법: rails routes에서 page와 url mapping을 볼 수 있다.

    -   registration page(회원가입 page): /users/sign_up -&gt; view/devise/registration/new.html.erb
    -   login page (로그인 page): users/sign_in -&gt; views/devise/session/new.html.erb
    -   회원 정보 수정 -&gt;views/devise/registration/edit.html.erb

    </div>

    (1) **로그인 page수정**

    <div class="note">

    &lt;h2&gt;Panels with Contextual Classes&lt;/h2&gt;
      &lt;div class="panel panel-primary"&gt;
        &lt;div class="panel-heading"&gt;Panel with panel-primary class&lt;/div&gt;
        &lt;div class="panel-body"&gt;Panel Content&lt;/div&gt;
      &lt;/div&gt;

    </div>


## rails_admin  관리자 페이지 만들기 {#rails-admin-관리자-페이지-만들기}

-   (1) **gem 'rails_admin', '~&gt; 2.0''** in gemfiles
-   (2) **bundle install**
-   (3) **rails g rails_admin:install**

<a id="figure--"></a>

{{< figure src="/img/rails/admin.png" width="600px" >}}

-   (4) **server restart** 후 동작확인 (동작은 완료)
    url/admin으로 들어가면 접속된다.
-   (5) **[문제점]너무 느린 문제** /admin접속 시에 너무 느리다. 해결책은
    dashboard의 statistics를 false로 해서 처음 접속시 시간이 많이 걸리는
    통계를 건너뛴다.

<a id="figure--"></a>

{{< figure src="/img/rails/rails_admin1.png" caption="<span class=\"figure-number\">Figure 32: </span>statistics false" width="600px" >}}

-   (6) 계정에 admin column추가

    <div class="note">

    devise gem에선 User라는 model을 만들고 table도 만들었다. 이 users table에는 사용자의 기본 정보들을 column으로 갖는다. rails-admin페이지는 현재 아무나 접근할 수 있기 때문에, devise gem에서 만든 user table에 admin이라는 column을 추가해서, 이 값이 true인  admin 사용자만 접근할 수 있게 처리해야 한다.

    </div>

    -   **admin column을 갖는 migration을 만든다.**

        <div class="note">

        rails generate migration add_admin_to_users admin:boolean을 실행하면 admin:boolean이라는 column을 추가하라는 migration이 만들어진다. 이 migration을 좀 수정할 필요가 있다. add_admin_to_users라는 migration에서 default:false로 처리한다.

        </div>
    -   **rails db:migrate** 를 실행한다.

-   (7) 특정 계정에 admin설정하기

    <div class="note">

    rails c 로 들어가서 특정 user를 찾거나, user를 만든다. 나는 user를 만들고 만든 user에게 admin권한을 주겠다.
    User.create(username: "admin", email: "admin@pnc.co.kr", password:"1234567", password_confirmation:"1234567") 로 실행한다. 만들때 admin을 true를 해줘야 하는데 못해준 경우, 다음과 같이 User.find_by로 찾는다.
    t=User.find_by(email:admin@pnc.co.kr)
    t.update_attribute :admin,true

    참고: find는 id로 찾는다. find_by와 where은 attribute로 찾는다. find_by는 레코드 1개를 가져온다. where은 여러줄을 가져온다.

    </div>

<a id="figure--"></a>

{{< figure src="/img/rails/rails_admin2.png" caption="<span class=\"figure-number\">Figure 33: </span>admin2" width="600px" >}}

<a id="figure--"></a>

{{< figure src="/img/rails/admin3.png" caption="<span class=\"figure-number\">Figure 34: </span>admin3" width="600px" >}}

-   (8) routing table 수정

    <div class="note">

    아래와 같이 routing table을 수정한다. 이렇게 하면 /admin에 접근할 수 있다.

    </div>

<a id="figure--"></a>

{{< figure src="/img/rails/admin4.png" caption="<span class=\"figure-number\">Figure 35: </span>admin4" width="600px" >}}

<div class="note">

/admin에는 url로 접근할 수 있지만, navigation에는 링크가 없기 때문에 접근할 수 없다. link를 추가한다.
user_signed_in중에서 admin인 경우만, 접속할 수 있는 link를 하나 만든다.

</div>

<a id="figure--"></a>

{{< figure src="/img/rails/admin5.png" caption="<span class=\"figure-number\">Figure 36: </span>admin5" width="600px" >}}

<a id="figure--"></a>

{{< figure src="/img/rails/admin6.png" caption="<span class=\"figure-number\">Figure 37: </span>admin6" width="600px" >}}

-   (9) **css깨지는 문제점**

    <div class="note">

    production에서 css가 적용되지 않는 문제가 있다. assets:precompile을 production mode로 하고 아래를 추가하라고 한다. 나는 /confing/environments/production.rb에서 아래와 같이 수정만 했다. 그랬더니, 적용이 된다.

    </div>

<a id="figure--"></a>

{{< figure src="/img/rails/admin7.png" caption="<span class=\"figure-number\">Figure 38: </span>admin7" width="600px" >}}

<a id="figure--"></a>

{{< figure src="/img/rails/admin8.png" caption="<span class=\"figure-number\">Figure 39: </span>admin8" width="600px" >}}


## table 만들기와 pagenation 구현하기 {#table-만들기와-pagenation-구현하기}

<div class="note">

-   pagination을 만들기 위해서는 pagy라는 gem을 사용한다. <https://kbs4674.tistory.com/72> 참조.
-   우선 db에 table이 있다고 가정한다.
-   view에서 table을 출력하고 있다고 가정한다.

</div>


### pagy 설정 {#pagy-설정}

<div class="note">

-   gem pagy를 추가한다.
-   bundle을 한다.
-   application_controller에 pagy::backend를 추가한다. (application controller에 작성한다는 것은 모든 controller에 적용된다는 뜻)

</div>

<a id="figure--"></a>

{{< figure src="/img/rails/pagy1.png" caption="<span class=\"figure-number\">Figure 40: </span>pagy1" width="600px" >}}

<div class="note">

-   app/helpers/application_helpers.rb에 pagy::frontend를 추가한다.

</div>

<a id="figure--"></a>

{{< figure src="/img/rails/pagy2.png" caption="<span class=\"figure-number\">Figure 41: </span>pagy2" width="600px" >}}


### pagy 적용 {#pagy-적용}

<div class="note">

적용하고자하는 controller/action 에 다음과 같이 설정한다. applicationController에서 pagy::backend를 설정했기 때문에 pagy()를 실행할 수 있다.

</div>

<a id="figure--"></a>

{{< figure src="/img/rails/pagy3.png" caption="<span class=\"figure-number\">Figure 42: </span>pagy3" width="600px" >}}

<div class="note">

view에 pagy_nav()를 적용시켜 본다. 이걸 적용할 때 주의할 사항이 있다. pagination은 table 아래에 위치해야 하고,
&lt;%== pagy_nav(@pagy) %&gt; 과 같이 입력하던가, &lt;%= pagy_nav(@pagy).html_safe %&gt;를 입력해야 한다. 그런데, 이렇게 입력하면
이쁘지가 않다. bootstrap을 적용해야 하는데, 우선 initializer/pagy.rb라는 파일을 만들고, 그 안에 bootstrap을 가져오는 코드를 넣는다.

</div>

> \#/config/initializer/pagy.rb
>  require 'pagy/extras/bootstrap'

<div class="note">

그리고 view에서 &lt;%= pagy_nav(@pagy).html_safe %&gt;대신 bootstrap이 적용된 page navigation을 사용한다.

</div>

<a id="figure--"></a>

{{< figure src="/img/rails/pagy4.png" caption="<span class=\"figure-number\">Figure 43: </span>pagy4" width="600px" >}}


### pagy의 table rows 정하기 {#pagy의-table-rows-정하기}

<div class="note">

pagy에서 보여줄 table의 rows를 정할 수 있다. initializer에서 pagy.rb라는 파일이 있는데, 여기서 설정정보를 입력한다.
Pagy::VARS[:items] = 10 =&gt; 10개의 row만 보여진다.

</div>

<a id="figure--"></a>

{{< figure src="/img/rails/pegy5.png" caption="<span class=\"figure-number\">Figure 44: </span>pagy5" width="600px" >}}


### table의 모양 꾸미기 {#table의-모양-꾸미기}

<div class="note">

pagy는 bootstrap을 추가한 버전은 이쁘지만, table자체는 이쁘지 않을 수
있다. 보통은 table을 bootstrap의 card에 넣어서 보여준다.  card는
예전에는 panel이라고 했는데, bootstrap5로 오면서 card로 바꼈다. 다음을
참조한다. <https://getbootstrap.com/docs/5.0/components/card/>

</div>


## table 갱신하기 {#table-갱신하기}

<div class="note">

table에 있는 값을 주기적으로 갱신 시키는 가장 간단한 방법은 refresh
button을 만들고 table을 갱신하거나, 혹은 settimeout으로 주기적으로
refresh를 할 수 있다. 아래는 js로 구현한것이고, 그냥 난 rails에서
link_to에 추가했다. bootstrap의 property를 link_to에 추가하는 법도
나와 있다. 유용한 tip이다.

</div>


### button refresh {#button-refresh}

>  $(document).ready(function () {
>     $("button").click(function () {
> 	location.reload(true);
> 	alert('Reloading Page');
>     });
> });

<!--quoteend-->

>  &lt;!-- &lt;script&gt;
>      setTimeout("location.reload();",10000);
>      &lt;/script&gt;
> --&gt;

-   rails

    <div class="note">

    &lt;%= link_to 'refresh', pressure_path, { :class =&gt; 'btn btn-secondary my-2', 'data-toggle' =&gt; 'tooltip', 'data-placement' =&gt; 'bottom', :title =&gt; 'button or auto?'} %&gt;

    </div>


### check box refresh (주기적 refresh) {#check-box-refresh--주기적-refresh}

<div class="note">

흔히 생각하길, js코드에서 checkbox를 보고 on이라면
setTimeout("location.reload();,10000)하고 off일경우 아무것도
안처리하는 코드를 넣으면 될 것이라고 생각한다. 그러나 제대로 동작하지
않는다. 가정을 해보자. , html코드에서 checked되어 있고, js로 아래에
if(checked) setTimeout else noting.이라고 되어 있다면, 계속
setTimeout이 실행된다.  만일 사용자가 off로 바꾸면 어떻게 되는가?
off로 바꾸어도 동일하다. 왜냐면, 처리하는 eventhandler가 없기
때문이다.  그러면 eventhandler를 만들자. event handler를 어떻게 만들
것인가? eventhandler에서 무엇을 처리할 것이고 어디에 위치 시킬 것인가?
이전의 if문도 있어야 하는가? 없어야 하는가? 복잡해진다.
eventhandler만 있다고 가정하자.

html에서 checkbox가 checked가 되어 있고 ,event가 발생해서 off상태가
되었을때, 아무것도 하지 않는다. 이렇게 되면 문제다. 왜냐, html은
on이기 때문에 갱신이 일어나야 하는데, 아무것도 하지 않기 때문이다.

html에서 checkbox가 uncheck가 되어 있고, event가 발생해서 on 상태가
되면 어떻게 되는가? event로 인해 setTimeout(10초)으로 인해, page를
다시 요청한다. 요청받은 html을 수행하면 기존의 html의 checkbox가
uncheck가 된다. 그런데 이것은 사용자가 on이라는 event를 발생시켜 계속
갱신하겠다는 뜻인데, 다시 html을 수행하면서 갱신하지 않겠다는 상태로
돌아간다.

이 문제를 해결하지 않고는 한개의 handler로 해결 할 수 없다. 이 문제를
다시 생각해 보자. 이 문제의 근본적인 문제는 이전 page에서 설정된
값이(사용자가 turn on/off) 다음 페이지 연결에도 필요하다는
것이다. 다음 페이지 연결시에 이전 설정값을 반영해 줘야 한다. 예를
들어서 사용자가 on이라고 설정했는데, 다음 page html은 default가
checked아니라면 화면에는 off로 나오기 때문이다. 그래서 이전 페이지
설정 정보를 html에 반영해야 한다. 이것은 흡사 login session과 비슷한
원리다. REST의 STATEFUL이란게 이런것이다.  이것을 어떻게 할 것인가?
ajax를 사용해야 한다. ajax 사용법은 아래 적겠다.

다시 말하자면, check box refresh는 checkbox의 상태에 따른 refresh
설정이다. 예를 들어 on/off 버튼이 있어서 이에 따른 refresh를
결정한다고 하자. 이것은 webpage에 on/off 상태(state)가 있는
것이다. 상태가 있는 것은 상태에 따른 결정이 달라진다. 반면에 button을
눌러서 refresh하는 것은 상태가 없다. page에 상태가 없기 때문에 상태에
따른 결정을 할 필요가 없다. 즉 상태가 없는 page를 refresh한다는 건
동일한 page를 refresh하는 것과 같다. 반면에 상태가 있다는 것은 상태에
따라 refresh화면이 달라지고 동작이 달라진다고 볼 수 있다.

</div>


### Ajax를 사용한 처리 {#ajax를-사용한-처리}

<div class="note">

ajax를 사용해야 한다고 했다. ajax는 jquery를 사용한다. js를 rails
6에서 사용하기 위해서는 webpacker에서 js를 어떻게 처리하는지 알아야
한다. js는 2가지가 있다. 외부 library package를 가져와서 사용하는
경우와 본인이 작성한 package를 사용하는 경우가 있다. 이 두 가지를
어떻게 설정하고 test하는지 먼저 알아보고, 그 다음 jquery 사용해서
ajax를 실행하는 것을 해야 한다.

</div>


#### webpacker js처리 {#webpacker-js처리}

<div class="note">

css처리와 비슷하게 javascript도 pack을 만들어 사용한다. pack은 여러개
만들수 있다.

</div>


## table refresh switch를 session에 저장[별도] {#table-refresh-switch를-session에-저장-별도}

-   목표

    <div class="important">

    pressure 화면에는 table이 있다. 이 table은 외부에서 data가 저장되고
    있다. 하지만, 화면의 table은 갱신되고 있지 않다. 주기적으로 갱신하고
    싶은게 목적이다. 그래서 check button을 만들었다. checkbutton이
    check되어 있다면, setTimeout으로 주기적으로 data를 ajax로 얻어와서
    append()로 뿌려줄 것이다. check button이 check되지 않았다면, data를
    가져올 필요가 없다. 이 처리를 하는데, 난관이 하나있다. checkbutton을
    check한 후, 다른 controller로 이동했다고 하자. 예를 들어, 다시
    home으로 이동했다. 그리고 다시 pressure화면으로 이동했을때,
    checkbutton은 check된 상태일까? 이 질문은 checkbutton이 stateful한
    것인가?라는 질문이다. 만일 stateful하다면 다른 page로 이동
    시(rails에서는 다른 controller이동 시) 그 상태가 유지되어야
    한다. 그런데 별다른 처리를 하지 않은 지금은 당연히 상태가 유지되지
    않는다. 즉, stateful하지 않다. 그래서 첫번째 quest는 어떻게
    stateful하게 만들것인가? 하는 것이다. 즉 check button을 pressure
    page에서 check한 후, home으로 이동한 후, 다시 pressure page로
    이동했을때, check상태로 유지해야 한다. 또한 check button을 pressure
    page에서 uncheck한 후, home으로 이동한 후, 다시 pressure page로 이동
    했을 때, uncheck상태로 유지 시켜야 한다. 이렇게 된다면 stateful한
    것이다. 그 다음에 주기적인 작업을 할 수 있을 것이다.

    </div>

-   **stateful의 개요**

<div class="note">

위에서 말한 checkbutton을 check후 다른 page로 갔다가 다시 돌아왔을 때
값을 유지하기 위해서는 저장할수 있는 무언가가 있어야 한다. 그 방식으로
2가지가 있다. session과 cache다.

-   **session의 사용**

session은 stateful한 상태를 만드는 가장 쉬운 방법이다. login을 할때
만들어지는 session에 값을 저장해서 stateful하게 만들수 있다. 그런데
login을 하면 수행되는 controller에서 session에 값을 저장해야 하는데,
지금 login controller는 없다. devise gem으로 만들었기 때문이다. devise
gem은 controller가 제공되지 않는다. 그래서 session을 이용하기 위해선
devise gem controller를 재정의하는 방식과 다른 controller에서 처리하는
방식이 있다.

-   **cache의 사용**

cache도 session과 비슷하게 server에서 다른 page에서도 특정한 값을 유지
시킬 수 있다. 마치 전역변수 같이 동작한다. Rails.cache라는 함수를
사용한다. 이 방식과 session을 사용하는 방식은 거의 동일하기 때문에, 난
이 방식은 사용하지 않을 것이다.

</div>

-   **session 사용**

    <div class="tip">

    [1] **customize controller사용** : session에 checkbutton의 상태값을 언제
    저장하는가? login처리를 하는 controller에서 저장한다.. devise gem은
    controller를 제공하지 않지만, 재정의가 가능하다. 재정의 하는 방법은
    devise gem의 wiki에 가면 customize controller에 대해서 설명했다. 그
    방식을 따르면 controller에서 session을 사용할 수 있다. session을
    통해서 stateful한 기능을 구현할 수 있다. 이 방식은 login이 성공했을때,
    controller단에서 session설정이 가능하다는 장점이 있다.

    [2] **기존 controller의 사용**:
    나는 이 방식을 사용할 것이다. session[:switch_value]라는 객체에 switch라는 checkbutton의 상태 값을 유지시킬 것이다. 방법은 다음과 같다. table이 보여지는 page가 속한 controller에 처음 방문하면, session[:switch_value]는 아무런 설정이 없다.그래서 그  값은 nil일 것이다.. 여기에 초기값을 설정하고(초기값은 false다.),  초기 값에 따라 page에서 checkbutton은 check가 될 수가 있고 안될 수 있게 html에 &lt;% if session[:switch_value] %&gt;와 같은 ruby code를  embeded해서 처리할 것이다.. 초기값을 false로 했기 때문에, browser에서 처음 page를 다운받으면 checkbutton은 false로 보일 것이다. 그 다음은 checkbutton을 클릭했을 때, 그 값이 변경된다. 그런데 이런 변경은, 즉 checkbutton event처리는 javascript에서 변경이 된다. javascript에서의  변경은 server가 아닌 client단에서 이루어진다.  반면에 초기값을 session에 설정하는 작업이라던가? session의 값을 바탕으로 html에 적용하는 과정은 모두 server에 있는 session개체에서 이루어진다. client단의  javascript는 server에 있는 session개체에 접근 할 수가 없다. checkbutton을 check하고 uncheck할때 session에 값을 변경해야 하는데, 어떻게 javascript가 server의 session개체의 값(상태)를 변경할 것인가? ajax를 사용하기로 한다. ajax를 사용해서 server의 session객체의 상태값을 변경 시켜줘야 한다. 이렇게 해줘야 다음과 같은 시나리오에 문제가 없다. 어떤 시나리오냐면, table과 checkbutton이 있는 page에서 checkbutton을 check한다.그러면 화면상에 checkbutton은 check되어 보인다. 그리고 home으로 이동한다. 그리고 다시 table과 checkbutton이 있는  page로 이동한다. 그러면 checkbutton은 uncheck상태가 된다. 왜냐? server의 session객체는 초기값인 false를 가지고 있기 때문이다.  javascript에서 server의 session객체의 값을 true로 상태변경을 해주지 않았기 때문이다. 그래서 ajax로 server의 session객체에 true로 설정해줘야 한다. 이렇게 해주면, 사용자가 다른 page로 이동하고 다시 와도, 초기값으로 설정된 값으로 보이는게 아니라, javascript에서 설정된 값으로 보이게 된다. stateful해진다. 여기까지 하면 checkbutton의 상태값은 page이동후에도 유지된다. 그러나 우리가 원하는것은 checkbutton이 check되면 주기적으로 table이 갱신되는 것이다. 주기적으로 뭔가를 하려면,  setInterval함수를 사용한다. 갱신은  ajax로 table 데이터를 받아 와서 html로 뿌려줘야 한다. jquery에 append함수를 사용하면 된다. 여기서 질문. 주기적 작업은 계속 background로 도는가? setInterval로 data를 가져오는 작업은 한번 trigger되면 계속되는가? 그렇지 않다. javascript가 수행되는 환경에서만 동작한다. 즉 table과 switch checkbutton이 있는 page를 다운받을 때 js도 같이 다운받고 주기적 갱신 작업이 실행된다. 이러다가 사용자가 home화면으로 이동하면 home page를 다운받고, home의 js도 다운받아서 다른 js를 수행한다. 즉, table과 switch가 있는 page를 계속 보고 있다면, 주기적 작업이 실행되는 것이다. 다른 page로 이동하면 다른 js를 실행할 뿐이다. 그래서 switch를 check하면, 주기적 갱신을 하고, uncheck하면 멈춰야 한다. 멈추는 것은 clearInterval함수를 사용한다.

    </div>

-   server에서 상태를 유지해야 하는 switch

<a id="figure--"></a>

{{< figure src="/img/rails/session1.png" caption="<span class=\"figure-number\">Figure 45: </span>session1" width="600px" >}}

-   **내가 원하는 것은?**

    <div class="important">



    </div>

-   **결론: session을 사용하자. 그리고 before_action을 사용하자.**

    <div class="important">

    before_action :set_switcher, only: [:show, :edit, :update :destroy]
    controller에 위와 같이 작성하면, only에 정의된 action들이 수행하기 전에 set_switcher라는 함수를 실행하라는 뜻이다.

    </div>


## d3 or c3 chart or chart.js 구현하기 {#d3-or-c3-chart-or-chart-dot-js-구현하기}


## sidekiq, whenever gem 사용법 {#sidekiq-whenever-gem-사용법}


## [부록] webpacker-bootstrap settings {#부록-webpacker-bootstrap-settings}

-   개요

<div class="note">

bootstrap을 적용시키는 가장 간단한 방법은 CDN을 사용하는
것이다. 그렇지 않고 본인이 만든것을 적용 할려면 webpacker를 사용해야
한다. webpacker가 하는 일은 한곳으로 js,cs, image file을 모으고,
compile해서 하나의 entry file로 만드는 것이다. 만들어진 entry file을
필요한 web page에 포함시켜 사용하면 된다. entry file은 포함될 파일
목록을 가지고 있다. 참고로 webpacker가 만드는 entry파일은 ngix란
webserver가 지정한 곳으로 서비스 된다. webpacker는 목록파일을 가져와서
compile하고 최종 파일을 특정위치에 놓는다. 그리고 nginx는 특정위치를
지정해서 서비스 한다. webpacker가 목록 파일을 가져오는 위치, compile한
후 결과 파일을 올려놓는 위치, 이 모든 것이 config/webpacker.yml파일에
기술되어 있다. 또한 Nginx는 webpacker가 최종파일로 올려놓는 위치를
알아야 한다. 이 위치는 /etc/nginx/sites-enabled에서 설정한다.

</div>


### css나 js, image가 저장될 폴더 정하기 {#css나-js-image가-저장될-폴더-정하기}

<div class="note">

page를 만들기전에 제일 먼저 할 것은 bootstrap을 사용하기 위해 bootstrap.css와 bootstrap.js를 처리하는 것이다. 나는 모든 assets를 webpacker로 관리할 예정이다. 그래서 webpacker가 모든 asset을  관리한다는 뜻으로  app/javascript의 이름을 frontend로 변경하기로 한다.

-   app/javascript를 app/frontend로 변경한다.
-   webpacker.yml을 수정한다.
-   js를 위한 js폴더를 만든다.
-   css를 위한 css폴더를 만든다.
-   image를 위한 images란 폴더를 만든다.
-   react를 사용한다면 components라는 폴더를 만들텐데, 난 만들지 않는다.
-   아래에 보면 channel이란 폴더가 보일텐데, 이것은 actioncable을 위한 폴더다.

</div>

<a id="figure--"></a>

{{< figure src="/img/rails/source_path.png" caption="<span class=\"figure-number\">Figure 46: </span>source_path" width="600px" >}}

<a id="figure--"></a>

{{< figure src="/img/rails/frontend1.png" caption="<span class=\"figure-number\">Figure 47: </span>frontend1" width="600px" >}}


### pack 폴더에 있는 packing할 항목 설정하기 - pack설정 {#pack-폴더에-있는-packing할-항목-설정하기-pack설정}

<div class="note">

위에 app/frontend를 보면 packs라는 폴더가 보인다. packs 폴더안에
파일은 pack, entry point라고 부르는데, 하나의 entry point에는 포함될
js나 css를 지정하고 있다. 포함된 js나 css가 compile이란 과정을 통해서
최종적으로 entry file이 만들어 지고, 이것이 html에서 참조되는
방식이다. 이 entry point에 포함될 css나 js파일들은 npm이나 yarn으로
system에 설치된 js나 css도 포함시킬 수 있다는 게 특이하다.  이 말은
node package를 rails에서 사용할 수 있다는 말이다. 그래서 client에서
react 사용이 가능한 것이다.  pack을 만들기 위해서는 우선, pack이
참조하는 node package나 js파일이 있다는 가정에서 출발한다. 이것이
준비되어 있을 때 pack파일에서는 이것을 지정하기만 하면 된다. 그런데
우선 참조하는 js가 2가지 종류가 있다. system에 설치된 js와 개발자가
만든 js의 2가지 종류가 있다.  system에 설치된 js를 포함시키는 방법과,
우리가 만든 js를 폴더 형태로 포함하는 방식은 다르다. 물론 import로
가져오는 방식은 동일하나, node package의 경우, module화가 되어 있기
때문에 import A from B의 형태로 가져오고 _app/frontend/js에 있는
폴더들은 import 경로형태로 가져온다. app/frontend_ 아래의 모든
folder들은 entry point를 만들기 위해 준비되어 있는 폴더와 파일이라고
보면 된다. 실제 html에서 참조는 import가 아닌 다른 형태로
참조한다. 우선 이미 작성되어 있는 application.js라는 entry point를
살펴보자.

</div>

<a id="figure--"></a>

{{< figure src="/img/rails/assets2.png" caption="<span class=\"figure-number\">Figure 48: </span>assets2" width="600px" >}}


### bootstrap을 application.js란 pack에  packing하기 [ js pack하기 ] {#bootstrap을-application-dot-js란-pack에-packing하기-js-pack하기}

<div class="note">

bootstrap을 rails에서 사용하려면, bootstrap이 system에 깔려 있던가, 아니면 down받은 bootstrap패키지를 app/frontend/js와 app/frontend/css폴더에 넣어져 있어야 한다. bootstrap은 yarn으로 system에 깔기로 한다.
yarn add bootstrap
yarn add @popperjs/core@^2.9.3

</div>

<a id="figure--"></a>

{{< figure src="/img/rails/yarn.png" caption="<span class=\"figure-number\">Figure 49: </span>yarn" width="600px" >}}

<div class="note">

app/frontend/pack/application.js에 bootstrap을 packing하려고 한다. 이미 bootstrap은 system에  설치되어 있다. 설치되어 있거나, app/frontend/js에 있는 js파일들은 pack에서는 import구문으로 가져올 수 있다. 그런데 여기서는 좀 색다르게 한다. 위에서 적은 참고 site를 말한다. 여튼  /app/frontend/js/bootstrap_js_files.js라는 파일을 만들고, 거기에 bootstrap의 js를 import로 쭉 나열하고 필요하지 않은 것을 주석처리 한 후에 pack에서 bootstrap_js_files.js를 import하는 방식이다. 그대로 해보자. 여기서 base_component는 지워야 한다.

1.  app/frontend/js/bootstrap_js_files.js라는 파일을 만든다.
2.  아래와 같이 사용할 component만 import한다.
    =&gt; 목록은 bootstrap을 source download받으면 목록을 알수 있다.

</div>

<a id="figure--"></a>

{{< figure src="/img/rails/boot1.png" caption="<span class=\"figure-number\">Figure 50: </span>boot" width="600px" >}}

<div class="note">

1.  application.js pack에 해당 js를 import한다. 이렇게 하면 js에 대한 pack작업은 끝이 나게 된다.

</div>

<a id="figure--"></a>

{{< figure src="/img/rails/boot2.png" caption="<span class=\"figure-number\">Figure 51: </span>boot2" width="600px" >}}


### css pack하기 {#css-pack하기}

<div class="note">

1.  application.scss란 pack을 만들자. 해당 pack에선 bootstrap의 source파일에 있는 bootstrap.scss를 load한다. bootstrap.scss에는 사용되는 모든 css가 import되어 있다. 마치 위에서 bootstrap 의 js파일이 목록화 되어 있던 것과 비슷한 파일이다. 이 파일을 import하면 된다.

</div>

<a id="figure--"></a>

{{< figure src="/img/rails/boot3.png" caption="<span class=\"figure-number\">Figure 52: </span>boot3" width="600px" >}}


### pack 적용하기 [ css &amp; js ] {#pack-적용하기-css-and-js}

<div class="note">

1.  pack을 만들었으면 이를 적용 하면된다. pack자체는 하나의 scss이고, js파일이다.  모든 scss를 bundling했기에  하나의 scss파일이고,  모든 js를 bundling했기에 하나의 js파일이다. 이 파일을 적용하는 것은 view에서 page에 해당하는 html.erb에 보면,
    &lt;head&gt; 태그 내부에 삽입할 수도 있고, layouts/application.html.erb안에 있는 &lt;head&gt;안에 삽입할 수도 있다. layout은 모든 page에 공통으로 적용되는 바탕이 되는 html이기 때문이다. 삽입하는 방법은 stylesheet_pack_tag, javascript_pack_tag를 넣는 방식이다.

</div>

>  &lt;!DOCTYPE html&gt;
> &lt;html&gt;
>   &lt;head&gt;
>     &lt;title&gt;Myapp&lt;/title&gt;
>     &lt;meta name="viewport" content="width=device-width,initial-scale=1"&gt;
>     &lt;%= csrf_meta_tags %&gt;
>     &lt;%= csp_meta_tag %&gt;
>
>   &lt;!-- Warning !! ensure that "stylesheet_pack_tag" is used, line below --&gt;
>   &lt;%= stylesheet_pack_tag 'application', media: 'all', 'data-turbolinks-track': 'reload' %&gt;
>   &lt;%= javascript_pack_tag 'application', 'data-turbolinks-track': 'reload' %&gt;
> &lt;/head&gt;
>
>   &lt;body&gt;
>     &lt;%= yield %&gt;
>   &lt;/body&gt;
> &lt;/html&gt;

<a id="figure--"></a>

{{< figure src="/img/rails/boot4.png" caption="<span class=\"figure-number\">Figure 53: </span>boot4" width="600px" >}}


### test하기 {#test하기}

<div class="note">

-   1) rails assets:clobber
-   2) rails webpacker:compile
-   3) rails server

</div>

<a id="figure--"></a>

{{< figure src="/img/rails/clobber.png" caption="<span class=\"figure-number\">Figure 54: </span>clobber" width="600px" >}}

<a id="figure--"></a>

{{< figure src="/img/rails/compile1.png" caption="<span class=\"figure-number\">Figure 55: </span>compile" width="600px" >}}


### server에 적용 확인 {#server에-적용-확인}

<div class="note">

server에 적용되는지 확인하기 위해서 cap production deploy를 한다.
실제 적용되지 않는다.
우선 server에 접속해서 yarn으로 package 설치 작업은 root에서, myapp에서 2번 설치했다.
server에 접속하면 404에러가 4개가 떴다.
/config/environments/production.rb에서 config.assets.digest = true로 설정하니 에러가 2개 뜬다.
해결하기 위해서  config.public_file_server.enabled configures = true를 했더니 별 반응 없다.
최종적으로 nginx의 /etc/nginx/sites-enabled/에 있는 설정파일에서 pack의 위치(location block)을 명시적으로 지정해주고 설정을 변경했더니 동작했다.

</div>

<a id="figure--"></a>

{{< figure src="/img/rails/nginx_solved.png" caption="<span class=\"figure-number\">Figure 56: </span>nginx_solved" width="600px" >}}


## [부록] turbolink와 jquery {#부록-turbolink와-jquery}

<div class="note">

turbo link와 jquery는 충돌이 난다. 그래서 둘중 하나만 선택해야
한다. 난 jquery를 선택했다.

</div>


## [부록] ajax 사용법 1 {#부록-ajax-사용법-1}

-   ajax 개요

<div class="note">

-   ajax는 page를 다운로드 한 이후에 server에게 data를 요청하고 받을 수가 있다.
-   page 갱신의 경우: 예를 들면 page의 table이나 graph의 data를 갱신해야 하는 경우, page를 refresh를 시키는 방법은 구식이다. 이것은 server에서 주기적으로 page를 전송하는 형태이기 때문이다. 처음에만 page를 받아오고, 그 다음 부터는 ajax를 주기적으로 실행 시켜서 server로 부터 받아온 data를 보여주는 식으로 해야 한다.

</div>

-   ajax 사용법

    <div class="important">

    ajax는 server에 data를 요청한다. data를 받고 받은 데이터를 html로 보여주어야 한다. 어떻게 할 것인가? 또한 주기적으로 보여줘야 한다. 어떻게 할것인가? 여러부분으로 나눠야 할 듯하다.

    </div>
-   [ view 영역 처리 ]

    <div class="tip">

    테이블이나 graph같은 것을 주기적으로 갱신 시키는 일은 html에서 하지 않는다. html에서는 table이나 graph를 둘러싼 div에 id를 정해놔야 한다. 왜냐면 갱신 시키는 javascript에서 해당 id를 참조하기 때문이다. 왜 참조하는가? 해당 id로 정해진 div영역을 다시 html으로 만들어서 append할 것이기 때문이다. 여튼 처음 사용자로 부터 요구로 인해 받아지는 page에는 해당 그래프나 테이블을 포함하는 부모 tag만 있는다. 그래서 html만 다운 받으면 그 부분은 아무것도 표시되지 않을 것이다. html 파싱과 렌더링이 끝난후에 js가 수행되는데, js는  js.append를 사용해서 그 표시가 되지 않는 부모 tag의 자식에 html을 붙일 수 있다.

    </div>

-   [ javascript 처리 ]

    <div class="tip">

    javascript에서는 여러가지를 해야 한다.

    -   주기적 작업
    -   server와 data통신 시 data를 주고 받는 작업.
    -   받은 data를 처리시 html을 append

    </div>

    ```nil
    $(function() {
                   timer = setInterval( function () {
                           $.ajax ({
                                   "url" : "[받아올 내용이 있는 URL]",  // ----- (1)
                                   cache : false,
                                   success : function (html) { // ----- (2)
                                           [받아온 내용을 처리할 부분] // ----- (3)
                                           [받아온 내용은 변수 html로 전달]
                                   }
                           });
                   }, 30000); // 30초에 한번씩 받아온다.
           });
    ```
-   server단 처리

<div class="note">

server단에서는 controller에서 ajax와 통신을 한다. db에서 받은 data를 전달하고, 그 외에 client에서 보낼 data가 있다면 전송하는 작업을 해야 한다.

</div>


## [부록] ajax 사용법 2 {#부록-ajax-사용법-2}


### 실제 구현 {#실제-구현}


#### 개요 {#개요}

<div class="note">

ajax를 사용하는 상황을 보여주려 한다. 현상황은  db가 있고, 이 db의 내용을 table로 보여준다. db의 데이터는 외부로 부터 계속 끊임없이 저장되기 때문에, 우리는 주기적으로 갱신해서 보여줄 필요가 있다. 그래서 view에는 switcher라는 check box를 달았다. switcher checked되면 자동갱신, uncheck면, 자동 갱신을 하지 않는다.또한, refresh 버튼도 만들었다. refresh button을 누르면 한차례 갱신을 한다. 이것을 어떻게 구현할 것인가?

-   [첫번째 방식]
    switcher를 구현 하기 위해서, js로 event handler를 달았다. check가 되어 있으면, setInterval로 주기적인 page reload를 한다.  refresh button도 동일하다. reload방식을 사용했다. button을 누르면 client에서 page를 요청하고 server가  client로 page를 보내주는 방식이다.  그럴싸하다. 그런데 여기엔 문제가 있다.

-   [문제점과 해결책]

reload 방식은 우선 화면이 깜박이는 문제가 있다. client가 page를 다시 요청하고 받은 page를 browser가 화면에 다시 보여주기 때문이다. 더 큰 문제는 switcher의 상태가 유지 되지 않는다는 것이다.  예를 들어보자. 사용자가 switcher(checkbox)를 turn on했다. 그러면 다시 off가 된다. 왜냐면 page를 다시 다운 받는데, down받은 html문서에는 checkbox는 off상태이기 때문이다. 문제가 있다. 여기서 다른 조건문을 여러개 써서 해결할 수는 있다. 그런데, 다음같은 경우는 어떨까?
table page에서  다른 page로 이동한다. 그리곤 다시 table page로 돌아온다.  switcher는 on상태일까? off상태일까?  답은 off상태이다. 이 문제는 근본적인 문제를 얘기한다. page의 어떤 요소에 대한 상태정보를 server가 유지하지 못하기 때문이다. http통신이 원래 그렇다. page가 가진 어떤 상태를 다른 상태가 알수없다. 연결을 끊어버리니...page간의 상관관계가 없다. 그래서  page사이를 이동하면 특정한 상태를 유지하려는 시도가 있다. cookies다. session도 cookies의 일종이다. login하는 것을 생각하면 된다. login할 때 사용자 정보가 다른 page로 이동해도 유지되는 것도 state를 유지하는 방식이다. 우리가 해결해야 하는 것은 상태를 유지시켜야 하는 작업이다.(stateful해야 한다.) 말을 두서 없이 썼다. 다시 단계별로 설명해 보겠다.

</div>

<div class="important">

-   (1) 처음 table page로 방문한다.
-   (2) browser는 table page의 html문서를 다운받는다.
-   (3) browser는 html문서를 parsing해서 dom을 만든다. (이 때 switcher의 상태는 off :왜냐? html에 하드코딩되어 있으니까.)
-   (4) browser는 html문서를 화면에 보여준다.
-   (5) 사용자가 switcher를 turn on한다.
-   (6) browser의 js가 switcher의 상태에 반응을 한다. reload를 요청한다.
-   (7) browser는 html 문서를 다운받는다.
-   (8) browser는 다시 parsing한다. (이 때 switch의 상태는 off다. 왜냐 다시 받는 html문서에 switcher는 off로 하드코딩되어 있으니까)
-   결론: 사용자가 switcher를 on해도 다시 다운받는 html문서에는 off로 되어 있기 때문에 사용자의 on action은 무시된다. 이를 해결하려면, server 단에서(controller)에서 switcher의 상태를 유지하고 있어야 한다. 그값을 기반해서 html문서의 switcher의 상태를 check할 필요가 있다. 그러면 이것을 어떻게 처리할 것인가? 내가 생각하는 가장 좋은 방식은 login session을 이용하는 것이다. 사용자가 login을 할때 session을 만들텐데, 그 session에 swticher의 상태정보를 저장하는 방식이다. 이런식으로 구현하려면 우선 login처리가 되어야 한다. 그런데 아래 방식은 login을 고려하지 않았다. login을 고려한 방식은 쓰지 않은 이유는 내가 지금 login처리과정을 모르기 때문이다.

</div>


### login을 고려하지 않은 방식 {#login을-고려하지-않은-방식}


#### (1) ajax를 사용하기 위해서 jquery를 설치 한 후 application.js에 import하자. 그런후, application.html.erb에 적용 {#1--ajax를-사용하기-위해서-jquery를-설치-한-후-application-dot-js에-import하자-dot-그런후-application-dot-html-dot-erb에-적용}

<div class="note">

-   yarn add jquery

</div>

<a id="figure--"></a>

{{< figure src="/img/rails/ajax1_1.png" caption="<span class=\"figure-number\">Figure 57: </span>ajax1_1" width="600px" >}}

<a id="figure--"></a>

{{< figure src="/img/rails/ajax1_2.png" caption="<span class=\"figure-number\">Figure 58: </span>ajax1_2" width="600px" >}}

-   import 위치 확인

<a id="figure--"></a>

{{< figure src="/img/rails/ajax1_3.png" caption="<span class=\"figure-number\">Figure 59: </span>ajax1_3" width="600px" >}}

<div class="note">

import 'jquery/dist/jquery.js' 로 하면 된다. 이렇게 하면 안된다. import 'jquery/src/jquery.js'로 해야 에러가 나지 않는다.

</div>

-   import

<a id="figure--"></a>

{{< figure src="/img/rails/ajax1_4.png" caption="<span class=\"figure-number\">Figure 60: </span>ajax1_4" width="600px" >}}

<div class="note">

전체 page에 jquery를 적용할 것이다. bootstrap보다 상위에 import한다.

</div>

<a id="figure--"></a>

{{< figure src="/img/rails/ajax1_5.png" caption="<span class=\"figure-number\">Figure 61: </span>ajax1_5" width="600px" >}}


#### (2) ajax를 이용하는 js pack을 만든다. (뼈대만) {#2--ajax를-이용하는-js-pack을-만든다-dot--뼈대만}

<div class="note">

water_meters_index, pressure_sensors_index라는 pack을 2개 만든다. 2개의 code는 거의 동일하다. 나중에 refactoring이 필요하겠지만, 우선은 그대로 간다.

</div>

-   packs

<a id="figure--"></a>

{{< figure src="/img/rails/ajax1_7.png" caption="<span class=\"figure-number\">Figure 62: </span>ajax1_7" width="600px" >}}

<div class="note">

이 pack에서는 2가지를 한다. 맨처음 html을 download 받을때,
switcher라는 checkbox의 check여부에 따른 동작 구현, 두번째로 사용자가
이미 download되어 browser에 보여지는 checkbox에 대한 event handler를
구현인데. 하지만 미완성이다.  단지 동작된다는 것만
확인한다. 완성하려면, 전체 동작에 맞춰 server와 view단이 어떻게
동작하는 지 이해해야 하기 때문이다.

</div>


#### (3) 전체 동작에 대한 이해 (stateful) {#3--전체-동작에-대한-이해--stateful}

<div class="note">



</div>


### login을 고려한 방식 {#login을-고려한-방식}


## [부록] link_to helper 사용법 {#부록-link-to-helper-사용법}


## [부록] form_for helper사용법 {#부록-form-for-helper사용법}


## [부록] 지도 관련 사용법 {#부록-지도-관련-사용법}


## [부록] I18n 사용법 {#부록-i18n-사용법}


## [부록] byebug 사용법 {#부록-byebug-사용법}

<div class="note">

gem install byebug를 Gemfiles에서 development mode에서 설치한다. 그런
다음 debug하는 곳에 byebug라는 문장을 넣는다. 그러면 해당 문장이
실행될 때 break가 걸린다.

</div>

<div class="important">

l-, list : 소스코드를 10줄 보여준다.
s: step by step
n: next

</div>


## [부록] debugger (javascript) 사용법 {#부록-debugger--javascript--사용법}

<div class="note">

javascript debugging은 byebug로 할 수 없다. byebug로 할 수 있는 것은
controller와 html.erb다. 즉 server단에서 처리가 되는 것은 byebug로
가능하나, client로 다운 받은 후에 실행되는 js는 debugger라고
breakpoint를 걸어서 사용한다.

chrome에서 &lt;inspect&gt;를 실행하고 &lt;source&gt;를 선택한 이후, page refresh를
하면 debugger; 에서 break가 걸린다.

</div>


## [Error처리] - warning처리 (The loose option must be..) {#error처리-warning처리--the-loose-option-must-be-dot-dot}

<div class="note">

cap production deploy를 하다보면 이 warning이 엄청 나온다.

</div>

<a id="figure--"></a>

{{< figure src="/img/rails/warning1.png" caption="<span class=\"figure-number\">Figure 63: </span>warning1" width="600px" >}}

-   **해결**

    <div class="important">

    아래와 같이 처리한다.

    </div>

<a id="figure--"></a>

{{< figure src="/img/rails/warning2.png" caption="<span class=\"figure-number\">Figure 64: </span>warning2" width="600px" >}}
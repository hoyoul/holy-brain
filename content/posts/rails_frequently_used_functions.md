+++
title = "[rails] frequently used functions"
author = ["holy"]
description = "예전 자료 정리중."
date = 2023-08-02T00:00:00+09:00
draft = true
+++

## Frequently used Functions {#frequently-used-functions}


### Provide &amp; yield function {#provide-and-yield-function}

<div class="note">

test할 때 주로 사용되는 function이다. view의 경우 controller에서 값이 넘어와서  처리하는 경우가 많다. 이것을 테스트 할때 provide와 yield를 같이 사용한다. 예를 들어보자.

</div>

<div class="verse">

&nbsp;&lt;% provide(:title, "About") %&gt;<br />
&nbsp;&lt;html&gt;<br />
&nbsp;&nbsp;&nbsp;&nbsp;&lt;head&gt;<br />
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&lt;title&gt; &lt;%= yield(:title) %&gt; | Ruby on Rails Tutorial Sample App&lt;/title&gt;<br />
&nbsp;&nbsp;&nbsp;&nbsp;&lt;/head&gt;<br />
&nbsp;&nbsp;&nbsp;&nbsp;...<br />
&lt;/html&gt;<br />

</div>


### link_to {#link-to}

<div class="note">

link_to는 메뉴판에 메뉴를 나타낸다. 즉 link를 나타내는데, 형식은 다음과 같다. button도 메뉴가 될 수 있다. class에 button을 추가하면 버튼도 메뉴다. 이미지도 메뉴가 될 수 있다. image_tag를 내부 인자로 가지면 된다.
image_tag는 단지 이미지 resource를 나타낼 뿐이다.

</div>

> &lt;%= link_to "sample app", '#'&gt;
> &lt;%= link_to "Sign up now!", '#', class: "btn btn-lg bt-primary" %&gt;
> &lt;%= link_to image_tag("rails.png", alt: "Rails logo"), "<http://rubytutorials.org>" %&gt;

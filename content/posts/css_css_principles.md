+++
title = "[css] css principles"
author = ["holy"]
description = "my thoughts of css principles"
date = 2023-08-12T00:00:00+09:00
draft = true
+++

## html 문서의 본질 {#html-문서의-본질}


### html 문서란? {#html-문서란}

html은 문자열로된 문서다. 혹은 도화지로 봐도 된다. 눈에 보이지 않는
line으로 구성되어 있다. html tag를 사용하면 같은 문자열이라도 크게,
작게 표현할 수 있다. 꾸미기가 된다. 어떤 문자는 두껍게, italic으로
꾸미기가 된다. 하지만 옛날 이야기다. css가 없던 아주 오래전엔 tag를
이용해서 시각적인 문서를 만들었다. 지금은 css다. html의 tag들은 이미
useless한 구성품이 되었다. 문서의 골격만 잡는 철골 구조물이 되었고, 그
구조물을 만드는건 div태그다. 한마디로 결론내면, html문서는 div태그로
이루어졌다고 보면 된다. div는 박스다. 그리고 html문서도 박스형태다.


### div 태그 {#div-태그}

div안에는 문자열,그림과 같은 resource들을 담고 있고, 이 박스는 자신이
포함된 박스에 한줄을 전체 차지한다. 물이 채워진 비커가 있다고 하자. 이
비커에 박스를 넣는다고 생각하자. 박스를 넣으면 수면위에 뜬다. 윗칸을
채운다. 또 다른 박스를 넣으면 수면위로 올라가 다음줄에 박스를
차지한다. 박스가 줄줄이 있다고 생각하면 된다.박스가 자신을 담고 있는
비커의 수면을 다 차지하기 때문에 다음에 순서대로 박스가 쌓여지게 되는
것이다.  html에서 span이란 박스도 있다. 이것은 내용물 만큼만 채워진
박스이기 때문에 비커에 박스를 넣으면 수면위 빈자리를 찾아서 채워지면서
쌓이게 된다. 이런 tag를 inline tag라고 부른다. span태그도 살펴봤지만,
위에서도 말했듯이 html문서에서는 div태그만 알면 된다. 가장 기본이 되는
tag다. div 태그의 크기는 유동적이다. 왜냐? 어떤 resource가 담겨질지
모르기 때문이다. div의 크기를 결정하는 width, height를
생각해보자. html문서가 주어지고, div태그가 있다고 하면, div태그의
width는 한줄을 다 차지 한다고 했다. 왜냐면 부모가 html문서라서 width는
문서의 width가 곧 div의 width가 된다. 만일 부모가 400px의 width를 갖는
상자라면, 자식 상자의 width도 400px이 되는 것이다. 한줄을 꽉 채우는
width를 갖게 된다. 그러면, height는 어떻게 될까? div 박스는 resource를
채운다. resource의 height가 div의 height를 결정한다. 따라서 아무런
resource가 없는 div는 height가 0이 된다.


### div외에 사용되는 tag {#div외에-사용되는-tag}

div태그가 html문서를 이루는 뼈대고 거의 모든 문서는 div태그만으로 해서
나타낼수 있다. 하지만, h1-h3까지의 문자열 tag, img태그, input,
button과 같은 form tag들은 특정 목적을 위해 사용된 고정된
tag들이다. 그래서 이런 태그들도 div와 더불어 사용된다.


## css {#css}

html로 만들것은 이제, div태그와 문자열 뿐이다. div태그와 문자열로
건물의 뼈대만 만든다. 나머지는 모두 css로 보여준다. 이것을 가장
간명하게 보여주는 것은 [css zengarden](https://www.csszengarden.com/) 이다. 여기서 zen garden은 동일한
html문서가 css에 따라 어떻게 다양한 모습으로 보여주는지를 확인
시켜준다.


## css 사용법 {#css-사용법}

html문서를 div를 사용해서 만든다. div에는 문자열,동영상,이미지와 같은
resource들이 들어간다. 여기서 꾸며야 한다고 판단되는 div가 있을 수
있다. 이 때 표시를 한다. html문서에서 class나 id로 표시한다. css는
html문서에 표시한 class,id를 선택자라고 한다. 이말은 css에서 꾸미기로
결정한,선택한 구조물이라는 뜻이다. class와 id의 차이에 대해서
말해보자.

```text
"사과" "사과" "오렌지" "오렌지"
```

4개의 문자열이 있다. 4개의 문자열이 각각 div 태그로 만들어졌다고 하자.

```html
<div>사과</div>
<div>사과</div>
<div>오렌지</div>
<div>오렌지</div>
```

이때 사과는 빨간색 오렌지는 노란색으로 표시하고 싶다고 하자. 그럴때,
html문서의 사과와 오렌지에 각각 class로 표시를 하는 것이다.

```html
<div class="apple">사과</div>
<div class="apple">사과</div>
<div class="orange">오렌지</div>
<div class="orange">오렌지</div>
```

이렇게 class로 표시하면, css가 꾸민다. id는 html page가 나타내는
resource에서 유니크한 모양이나 색깔을 갖는 경우 처리한다.


## css 적용법 {#css-적용법}

보통 디자이너가 있을경우 figma로 된 파일을 준다. 그러면 front-end가
그거대로 모양을 만든다. [여기](https://www.youtube.com/watch?v=tIC9MfxGOow) 참조
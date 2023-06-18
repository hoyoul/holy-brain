+++
title = "[website] about my brain blog and homepage"
author = ["holy"]
description = "homepage와 brain이란 blog를 만들었다. 이것의 사용법을 적어보려한다. 왜냐면 둘다 org파일들로 부터 page들을 만드는 복잡한 처리과정이라서 시간이 지나면 까먹을 수 있기 때문이다."
date = 2023-06-16T00:00:00+09:00
draft = true
+++

## My homepage {#my-homepage}

-   참조: [from here]({{< relref "website_make_main_homepage" >}}) (만들당시 기록한 note)
-   주소: <https://frege2godel.me/>
-   github id: holy2frege
-   github repo(dev,publish): main-blog,holy2frege.github.io


### 사용법 {#사용법}


#### clone {#clone}

local에 repo가 clone되어 있지 않다면 clone부터 한다.

<a id="figure--main page"></a>

{{< figure src="/img/blog_homepage/mainblog1.png" caption="<span class=\"figure-number\">Figure 1: </span>main page" width="600px" >}}


#### article 수정 {#article-수정}

main page는 만드는데 하루 or 이틀 정도 걸렸는데, 그만큼 page만 만든
것이다. 그래서 간단하다. org 폴더에 가면 index.org파일 하나밖에 없다.
2nd-level의 headline에 보면 'CUSTOM_ID: page'가 보일텐데, 그
headline이 articles를 모아놓은 page라고 보면 된다. 거기서 원하는
page를 생성하거나 수정하면 된다.


#### m-x org-publish-all {#m-x-org-publish-all}

emacs의 설정파일에는 위 명령어를 수행하는 code가 이미 있다. html변환과
css,js를 처리를 구현하고 있다. 따라서 수행하면 public/index.html이
만들어진다.


#### git 반영 {#git-반영}

dev repo와 publish repo인 main-blog, main-blog/public에서 git 반영을
한다. 만일 안될때는 multi-account github problem이다.


## My brain blog {#my-brain-blog}

-   주소: <https://braindump.frege2godel.me/?stackedPages=%2F>


### 사용법 {#사용법}

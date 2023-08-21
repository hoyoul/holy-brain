+++
title = "[website] about my braindump blog and homepage usage"
author = ["holy"]
description = "homepage와 brain이란 blog를 만들었다. 이것의 사용법을 적어보려한다. 왜냐면 둘다 org파일들로 부터 page들을 만드는 복잡한 처리과정이라서 시간이 지나면 까먹을 수 있기 때문이다."
date = 2023-06-16T00:00:00+09:00
draft = true
+++

## my blogs {#my-blogs}

나는 3개의 blog를 운영하고 있다. main-blog,braindump,portfolio다.


### main-blog(holy2frege) {#main-blog--holy2frege}


#### 기본정보 {#기본정보}

-   참조: [from here]({{< relref "website_make_main_homepage" >}}) (만들당시 기록한 note)
-   homepage 운영 주소: <https://frege2godel.me/>
-   github address: <https://github.com/holy2frege/main-blog>
-   github id: holy2frege
-   github email: holy2frege.nil@gmail.com
-   github repo(dev,publish): main-blog(submodule:holy2frege.github.io)
-   pat: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


### braindump {#braindump}


#### 기본정보 {#기본정보}

-   참조:
-   homepage 운영 주소: <https://braindump.frege2godel.me/>
-   github address: <https://github.com/hoyoul/holy-brain>
-   github id: hoyoul
-   github email: hoyoul.park@gmail.com
-   github repo(dev,publish): holy-brain(submodule:hoyoul.github.io)
-   pat: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


### portfolio(holytofrege) {#portfolio--holytofrege}


#### 기본정보 {#기본정보}

-   참조:
-   homepage 운영 주소: <https://frege2godel.me/>
-   github address: <https://github.com/holyToFrege/holyToFrege.github.io>
-   github id: holytofrege
-   github email: holy_frege@fastmail.com
-   github repo(dev,publish): holytofrege (submodule이 없다.)
-   pat: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


## my blogs 설치 {#my-blogs-설치}


#### local에 repo설치 {#local에-repo설치}

<!--list-separator-->

-  clone하기

    local에 repo가 clone되어 있지 않다면 main-blog를 clone부터
    한다. clone할때는 ssh방식으로 한다. ssh를 하는 이유는 multiple
    account문제 때문이다. 관련된 글은 [여기]({{< relref "github_multi_account_github_problem" >}})를 참조한다. ssh처리를 마친 후에
    clone한다. 참조에도 나와 있듯이 prefix를 github.com에 붙여서
    clone한다. 예를 들어서 holytofrege의 경우 아래와 같이 clone한다.

    ```text
    git clone git@github.com-holytofrege:holyToFrege/holyToFrege.github.io.git
    ```

    clone하면 아래와
    같은 directory구조를 볼 수 있다.

    <a id="figure--main page"></a>

    {{< figure src="/img/blog_homepage/mainblog1.png" caption="<span class=\"figure-number\">Figure 1: </span>main page" width="600px" >}}

<!--list-separator-->

-  git pull

    우선, 처음 clone했기 때문에 git pull을 해서 sync를 맞춘다.

    ```text
    git pull
    ```

<!--list-separator-->

-  git submodule init &amp; git submodule update

    이제 publishing repo를 가져와야 한다. 가져오면 public폴더에 다운받게
    된다. submodule이 있는 blog는 main-blog와 braindump다. 두개의 blog는
    개발 repo와 publish repo 두개를 운영한다. main-blog나 braindump를
    clone했으면, 아래 작업을 해준다.

    ```text
    git submodule init
    git submodule update
    ```

    이렇게 하면 .gitmodules에 정의된 주소에서 데이터를 가져온다. 만일
    문제가 있다면, .gitmodules를 살펴봐야 한다. 성공했다면 public 폴더로
    들어간다.

    ```text
    cd public
    git status
    ```

    보면 HEAD가 detach되어 있다.

<!--list-separator-->

-  git checkout main

    ```text
    git checkout main
    git status
    ```

    떨어진 HEAD를 붙여준다. git status하면 HEAD가 main에 있는 것을 확인할
    수 있다.

    여기서 다음과 같이 하라고 하는데

    ```text
    git submodule foreach git checkout main
    git submodule update --remote --merge
    git checkout main
    ```

<!--list-separator-->

-  git pull

    다시 한번 sync를 해준다.

    ```text
    git pull
    ```


## main-blog 사용법 {#main-blog-사용법}

local에 설치는 대략적으로 끝났다. 이제 local에서 사용방법을 살펴보자.


### main-blog 사용법 {#main-blog-사용법}


#### [step 1] article 수정 {#step-1-article-수정}

이제 문서를 만들거나 수정하면 된다. main-blog의 org 폴더에 가면
index.org파일 하나밖에 없다.  2nd-level의 headline에 보면 'CUSTOM_ID:
page'가 보일텐데, 그 headline이 articles를 모아놓은 page라고 보면
된다. 거기서 원하는 page를 생성하거나 수정하면 된다. 수정이 끝나면
다음 단계로 가자.


#### [step 2] m-x org-publish-all {#step-2-m-x-org-publish-all}

emacs의 설정파일에는 위 명령어를 수행하는 code가 이미 있다. html변환과
css,js를 처리를 구현하고 있다. 따라서 수행하면 public/index.html이
만들어진다.


#### [step 3] git 반영 {#step-3-git-반영}

dev repo인 main-blog 폴더로 간다. git pull을 하고 git push를
한다. main-blog/public으로 이동한다. 마찬가지로 git 반영을 한다. 만일
처음이라면, 포맷하고 다시 시작하는 경우에는 git push할 때 PAT를
입력해도 git config --global로 user이름과 email 설정이
필요하다. 설정을 하면 push가 되고 keychain에 등록된다. 처음이 아닐때
안될 때는 multi-account github problem이다. 즉 이미 osxkeychain에 다른
PAT가 저장되어 있기 때문이다. keychain app을 실행시켜서 login
type이면서 github을 찾는다. 그리고 지운다. 그리고 다시 terminal에서
git push를 한다. id: holy2frege와 아래 pat을 입력하면 새로운
keychain이 만들어지고 push가 된다.

-   pat

    <div class="verse">

    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<br />

    </div>


## braindump 사용법 {#braindump-사용법}


### 사용법 {#사용법}


#### [step1] 문서 작성및 수정 {#step1-문서-작성및-수정}

org-roam에서 문서를 작성하기 때문에 emacs.org에서 org-roam 경로가
맞는지 확인한다. 매번 computer 설치시 위치가 바뀌기 때문에 알아서 잘
설정한다.

<div class="verse">

(org-roam-directory "~/hoyoul_projects/holy-brain/org") ; replace with your path<br />

</div>

emacs로 들어간다.

-   C-c r f로 문서를 수정하거나 만든다. 만들때는 영어로 title을 만들어야 한다.
-   만든 문서에 yasnippet(C-c s)를 눌러서 org_head_for_blog라는 미리만든
    yasnippet추가한다. 그리고 문서를 작성한다. 이 snippet은 별거
    없다. 제목,날짜, description template을 채우는 것이다.


#### [step 2] make all {#step-2-make-all}

문서 작성이 끝났으면, shell로 나간다. shell에서 다음과 같이 입력한다.

```shell
cd holy-brain
make all
```

terminal에서 make all을 하면 org파일이 모두 md로 바뀐다.


#### [step 3] hugo -d {#step-3-hugo-d}

이미 hugo는 깔려있어야 한다. 안 깔려 있다면, brew install hugo를
실행해서 설치한다.

```shell
brew install hugo
hugo -D
```

이상태에서 hugo -d를 하면 md가 html로 바뀌면서
public폴더에 들어가게 된다.


#### [step 6] git push {#step-6-git-push}

git add, commit, push를 한다.

```shell
git add .
git commit -m "create sth"
git push
```

다음과 같은 에러가 날 수 있다.

<div class="verse">

remote: Permission to hoyoul/holy-brain.git denied to holy2frege.<br />
fatal: unable to access 'https://github.com/hoyoul/holy-brain.git/': The requested URL returned error: 403<br />

</div>

이전에 사용했던 github 정보때문이다. holy2frege라는 user name으로
push할려니 문제가 생기는 것이다. 우선 급한대로 다음과 같이 하자.

<div class="verse">

git remote set-url origin <https://hoyoul@github.com/hoyoul/holy-brain.git><br />

</div>

그리고 pw를 물어보면 아래 값을 넣자.

-   pat

<div class="verse">

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<br />

</div>


#### [step 7] public 폴더 {#step-7-public-폴더}

실제 반영되는 publish 폴더다. 이것을 git push해줘야 웹페이지가
반영된다.

```shell
git add .
git commit -m "create sth"
git push
```

이렇게 해주면 반영이 끝난다.


#### [step2] 문서 작성 tip {#step2-문서-작성-tip}

<!--list-separator-->

-  fieldset legend

    위에서 org_head_for_blog에서 설정한 time, author, email,
    description정보를 기입하면, 그것은 main.css의 fieldset legend와
    mapping되서 legend css처리를 한다.

    <a id="figure--legend"></a>

    {{< figure src="/img/blog_homepage/legend1.png" caption="<span class=\"figure-number\">Figure 2: </span>legend" width="600px" >}}

<!--list-separator-->

-  headlevel

    headlevel은 4개만 정의 했다. org에서 headline을 그대로 사용한다.

    -   level1

        <a id="figure--level1"></a>

        {{< figure src="/img/blog_homepage/headlevel1.png" caption="<span class=\"figure-number\">Figure 3: </span>level1" width="600px" >}}
    -   level2

        <a id="figure--level2"></a>

        {{< figure src="/img/blog_homepage/headlevel2.png" caption="<span class=\"figure-number\">Figure 4: </span>level2" width="600px" >}}
    -   level3

        <a id="figure--level3"></a>

        {{< figure src="/img/blog_homepage/headlevel3.png" caption="<span class=\"figure-number\">Figure 5: </span>level3" width="300px" >}}
    -   level4

        <a id="figure--level3"></a>

        {{< figure src="/img/blog_homepage/headlevel4.png" caption="<span class=\"figure-number\">Figure 6: </span>level4" width="300px" >}}

<!--list-separator-->

-  underline

    underline은 \_로 둘러싸게 하면 된다.

    <a id="figure--underline"></a>

    {{< figure src="/img/blog_homepage/underline.png" caption="<span class=\"figure-number\">Figure 7: </span>underline" width="300px" >}}

<!--list-separator-->

-  equal

    eqaul 두개로 둘러 싸면 아래와 같은 모양이 나온다.

    <a id="figure--equal"></a>

    {{< figure src="/img/blog_homepage/equal.png" caption="<span class=\"figure-number\">Figure 8: </span>equal" width="200px" >}}

<!--list-separator-->

-  todo

    todo는 org에서 C-c C-t로 만든다. 이것을 org에서 기술하면 아래와 같이
    보인다.

    <a id="figure--todo"></a>

    {{< figure src="/img/blog_homepage/todo.png" caption="<span class=\"figure-number\">Figure 9: </span>todo" width="400px" >}}

<!--list-separator-->

-  verse

    begin_verse로 시작되는 verse block 다음과 같이 보인다.

    <a id="figure--verse"></a>

    {{< figure src="/img/blog_homepage/verse.png" caption="<span class=\"figure-number\">Figure 10: </span>verse" width="600px" >}}

<!--list-separator-->

-  source &amp; example &amp; text

    source block은 color가 지원되고, example과 text는 highlight를 지원하지
    않는 차이가 있다.

    <a id="figure--source"></a>

    {{< figure src="/img/blog_homepage/source.png" caption="<span class=\"figure-number\">Figure 11: </span>source" width="600px" >}}

    <a id="figure--example"></a>

    {{< figure src="/img/blog_homepage/example.png" caption="<span class=\"figure-number\">Figure 12: </span>example" width="600px" >}}

<!--list-separator-->

-  기타 blocks

    tip,warning,important,attention은 거의 비슷한 모양이다. 이것들 모두
    yasnippet으로 정의했기 때문에 shortcut으로 사용하면 된다. 모양은
    다음과 같다.

    <a id="figure--tip"></a>

    {{< figure src="/img/blog_homepage/tip.png" caption="<span class=\"figure-number\">Figure 13: </span>tip" width="600px" >}}

    <a id="figure--warning"></a>

    {{< figure src="/img/blog_homepage/warning.png" caption="<span class=\"figure-number\">Figure 14: </span>warning" width="600px" >}}

    <a id="figure--important"></a>

    {{< figure src="/img/blog_homepage/important.png" caption="<span class=\"figure-number\">Figure 15: </span>important" width="600px" >}}

    <a id="figure--attention"></a>

    {{< figure src="/img/blog_homepage/attention.png" caption="<span class=\"figure-number\">Figure 16: </span>attention" width="600px" >}}

<!--list-separator-->

-  table

    org에서 많이 쓰는 구조 중에 table이 있다. 다음 예를 보자.

    | 온도      | -4 | -3 | -2 | -1 | 0 | 1 | 2 | 3 | 4  |
    |---------|----|----|----|----|---|---|---|---|----|
    | 아이스크림 판매량 | -6 | -4 | -2 | 0  | 2 | 4 | 6 | 8 | 10 |

    보기 좋게 세로로 변경하자.

    | 온도 | 아이스크림 판매량 |
    |----|-----------|
    | -4 | -6        |
    | -3 | -4        |
    | -2 | -2        |
    | -1 | 0         |
    | 0  | 2         |
    | 1  | 4         |
    | 2  | 6         |
    | 3  | 8         |
    | 4  | 10        |


## portfolio 사용법 {#portfolio-사용법}

portfolio는 새로 추가한건데, 다른 blog를 추가할 때 참조하면
된다. holytofrege라는 github repo를 사용하는것에
유념하자. holy2frege라는 main-blog하고 햇갈릴 수 있기 때문이다.


### domain설정 {#domain설정}

frege2godel이라는 domain에 subdomain을 만들어야 한다. 나는 가비아에서
domain을 구입했기 때문에 가비아에서 portfolio.frege2gode.me라는
CNAME의 domain을 설정했다.

<a id="figure--domain"></a>

{{< figure src="/img/blog_homepage/domain.png" caption="<span class=\"figure-number\">Figure 17: </span>domain" width="600px" >}}


### 사용법 {#사용법}

portfolio는 publish폴더가 없다. reveal을 사용하기 때문에, emacs에서
index.org를 수정하고, export할때 reveal을 사용하면 index.html이
만들어진다.

```text
cd holytofrege
git add .
git commit
git push
```

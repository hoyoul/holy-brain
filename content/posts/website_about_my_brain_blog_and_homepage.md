+++
title = "[website] about my braindump blog and homepage usage"
author = ["holy"]
description = "homepage와 brain이란 blog를 만들었다. 이것의 사용법을 적어보려한다. 왜냐면 둘다 org파일들로 부터 page들을 만드는 복잡한 처리과정이라서 시간이 지나면 까먹을 수 있기 때문이다."
date = 2023-06-16T00:00:00+09:00
draft = true
+++

## My homepage {#my-homepage}

-   참조: [from here]({{< relref "website_make_main_homepage" >}}) (만들당시 기록한 note)
-   homepage 운영 주소: <https://frege2godel.me/>
-   github source 주소:
-   github address: <https://github.com/holy2frege/main-blog>
-   github id: holy2frege
-   github email:
-   github repo(dev,publish): main-blog,holy2frege.github.io
-   pat:


### 사용법 {#사용법}


#### [step1] repo가져오기 (clone) {#step1-repo가져오기--clone}

local에 repo가 clone되어 있지 않다면 main-blog를 clone부터
한다. clone할때는 ssh방식으로 한다. ssh를 하는 이유는 multiple
account문제 때문이다. 관련된 글은 [여기]({{< relref "github_multi_account_github_problem" >}})를 참조한다.  clone하면 아래와
같은 directory구조를 볼 수 있다.

<a id="figure--main page"></a>

{{< figure src="/img/blog_homepage/mainblog1.png" caption="<span class=\"figure-number\">Figure 1: </span>main page" width="600px" >}}

<!--list-separator-->

-  git pull

    git pull을 해서 sync를 맞춘다.

<!--list-separator-->

-  git submodule init &amp; git submodule update

    이제 publishing repo를 가져와야 한다. publishing repo는
    holy2frege.github.io다. 이 repo는 main-blog안에 public폴더와
    mapping되어 있다. 현재는 비워져 있다. public폴더로 진입해서 git
    clone으로 가져와야 할까? 가져오지 않는다. mapping되어 있다는것은
    main-blog에서 mapping정보를 가지고 있기 때문에, 다른 방법을
    사용한다. mapping에 대한 정보는 main-blog의 .gitmodules에 있다. git
    submodule init과 git submodule update를 통해서
    holy2.frege.github.io를 가져올 수 있다. 이렇게 가져온 repo는 HEAD가
    detach되어 있다.

<!--list-separator-->

-  git checkout main

    git submodule foreach git checkout main: 그래서 git submodule foreach
    git checkout main을 해준다. git status를 해도 detach되어 있다면 git
    checkout main을 다시 해준다. git submodule update --remote --merge
    해서 다시 update를 했다. 그런데도 detached head라서 git checkout
    main을 해주었다.

<!--list-separator-->

-  git pull

    git pull (in public): 그리고 public 폴더에서 git pull을 했다.


#### [step 2] article 수정 {#step-2-article-수정}

이제 문서를 만들거나 수정하면 된다. org 폴더에 가면 index.org파일
하나밖에 없다.  2nd-level의 headline에 보면 'CUSTOM_ID: page'가
보일텐데, 그 headline이 articles를 모아놓은 page라고 보면 된다. 거기서
원하는 page를 생성하거나 수정하면 된다. 수정이 끝나면 다음 단계로
가자.


#### [step 3] m-x org-publish-all {#step-3-m-x-org-publish-all}

emacs의 설정파일에는 위 명령어를 수행하는 code가 이미 있다. html변환과
css,js를 처리를 구현하고 있다. 따라서 수행하면 public/index.html이
만들어진다.


#### [step 4] git 반영 {#step-4-git-반영}

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

    <div class="important">

    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

    </div>


## My braindump blog {#my-braindump-blog}

-   homepage 운영주소: <https://braindump.frege2godel.me/?stackedPages=%2F>
-   github source 주소:
-   github repo(dev,publish):holy-brain, hoyoul.github.io
-   github address: <https://github.com/hoyoul/holy-brain>
-   github id: hoyoul
-   github email: hoyoul.park@gmail.com
-   pat:

    <div class="important">

    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

    </div>


### 사용법 {#사용법}


#### [step1] repo 가져오기 clone {#step1-repo-가져오기-clone}

<div class="important">

git clone <https://github.com/hoyoul/holy-brain.git>

</div>

git pull을 한다.


#### [step2] submodule 가져오기 {#step2-submodule-가져오기}

-   public과 mapping된 submodule을 가져온다.

    <div class="important">

    git submodule init
    git submodule update

    </div>
-   public폴더로 들어가서 update한다.

    <div class="important">

    git submodule foreach git checkout main
    git submodule update --remote --merge
    git checkout main

    </div>

git checkout main을 하고 git status를 하면 HEAD detach가
사라진다. 위에서 git checkout main만 해도 될듯한데, 잘 모르겠다. 그
다음 git pull을 한다.


#### [step3] 문서 작성및 수정 {#step3-문서-작성및-수정}

org-roam에서 문서를 작성하기 때문에 emacs.org에서 org-roam 경로가
맞는지 확인한다.

<div class="important">

(org-roam-directory "~/hoyoul_projects/holy-brain/org") ; replace with your path

</div>

-   C-c r f로 문서를 수정하거나 만든다. 만들때는 영어로 title을 만들어야 한다.
-   만든 문서에는 org_head_for_blog라는 미리만든 yasnippet의 형식에 맞춰
    문서를 작성한다. 제목,날짜, description template을 채우는 것이다.


#### [step3-추가] 문서 작성 tip {#step3-추가-문서-작성-tip}

<!--list-separator-->

-  fieldset legend

    roam으로 문서를 만들고 yasnippet(C-c s)에서 org_head_for_blog를
    선택하면 모든 blog의 article이 가져야 하는
    time,author,email,description정보가 들어가고, 그것은 main.css의
    fieldset legend로 css처리를 한다.

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

        {{< figure src="/img/blog_homepage/headlevel3.png" caption="<span class=\"figure-number\">Figure 5: </span>level3" width="600px" >}}
    -   level4

        <a id="figure--level3"></a>

        {{< figure src="/img/blog_homepage/headlevel4.png" caption="<span class=\"figure-number\">Figure 6: </span>level4" width="600px" >}}

<!--list-separator-->

-  underline

    underline은 \_로 둘러싸게 하면 된다.

    <a id="figure--underline"></a>

    {{< figure src="/img/blog_homepage/underline.png" caption="<span class=\"figure-number\">Figure 7: </span>underline" width="600px" >}}

<!--list-separator-->

-  equal

    eqaul 두개로 둘러 싸면 아래와 같은 모양이 나온다.

    <a id="figure--equal"></a>

    {{< figure src="/img/blog_homepage/equal.png" caption="<span class=\"figure-number\">Figure 8: </span>equal" width="600px" >}}

<!--list-separator-->

-  todo

    todo는 org에서 C-c C-t로 만든다. 이것을 org에서 기술하면 아래와 같이
    보인다.

    <a id="figure--todo"></a>

    {{< figure src="/img/blog_homepage/todo.png" caption="<span class=\"figure-number\">Figure 9: </span>todo" width="600px" >}}

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


#### [step 4] make all {#step-4-make-all}

terminal에서 make all을 하면 org파일이 모두 md로 바뀐다.


#### [step 5] hugo -d {#step-5-hugo-d}

이미 hugo는 깔려있어야 한다. 안 깔려 있다면, brew install hugo를
실행해서 설치한다. 이상태에서 hugo -d를 하면 md가 html로 바뀌면서
public폴더에 들어가게 된다.


#### [step 6] git push {#step-6-git-push}

git add, commit, push를 한다. 다음과 같은 에러가 날 수 있다.

<div class="important">

remote: Permission to hoyoul/holy-brain.git denied to holy2frege.
fatal: unable to access 'https://github.com/hoyoul/holy-brain.git/': The requested URL returned error: 403

</div>

이전에 사용했던 github 정보때문이다. holy2frege라는 user name으로
push할려니 문제가 생기는 것이다. 우선 급한대로 다음과 같이 하자.

<div class="important">

git remote set-url origin <https://hoyoul@github.com/hoyoul/holy-brain.git>

</div>

그리고 pw를 물어보면 아래 값을 넣자.

-   pat

<div class="important">

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

</div>

-   public folder: 이것도 마찬가지다.

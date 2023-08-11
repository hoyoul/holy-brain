+++
title = "[emacs] tex install and usage (latex)"
author = ["holy"]
description = "emacs에서 tex사용"
date = 2023-07-23T00:00:00+09:00
draft = true
+++

## Local에서의 설치 {#local에서의-설치}


## [Local-step1] macTex 설치 {#local-step1-mactex-설치}

mac에서는 tex배포판으로 macTex를 다은 받아 설치한다.  [여기](https://tug.org/mactex/mactex-download.html)에서 다운 <br/>
받는다. mac-tex는 live-tex라는 배포판이 있는데, 거기에 mac관련 요소를 <br/>
추가해서 만든 배포판이다. <br/>


## [Local-step2] tex-live update {#local-step2-tex-live-update}

Launchpad에 TeX Live Utility가 있을 것이다. 실행한 후에 패키지 <br/>
업데이트 다 해준다. <br/>

<a id="figure--texlive-update"></a>

{{< figure src="/img/tex/tex-update.png" caption="<span class=\"figure-number\">Figure 1: </span>texlive-update" width="600px" >}} <br/>


## [Local-step3] 사설 repo등록(CTAN and KTUG) {#local-step3-사설-repo등록--ctan-and-ktug}

tlmgr은 brew와 같은 package manager다. brew처럼 저장소에서 package를 <br/>
가져와서 설치한다. CTAN이 저장소에 해당한다. 영어로된 package는 ctan을 <br/>
사용하면 되지만, 한글관련해서는 KTUG를 repository로 등록해서 <br/>
한글폰트같은것을 down받아 사용할려면, KTUG도 등록해서 사용해야 한다. <br/>
[여기](http://wiki.ktug.org/wiki/wiki.php/KtugPrivateRepository)를 참조했다. <br/>


### main repo 변경 {#main-repo-변경}

```text
sudo tlmgr option repository https://mirror.kakao.com/CTAN/systems/texlive/tlnet/
```

main repo를 kakao서버로 해서 등록했는데, pinning에서 version문제가 <br/>
있었다. 그래서 아래와 같이 다른 repo로 변경하니 다른 에러가 났다. <br/>

```text
sudo tlmgr option repository http://mirror.ctan.org/systems/texlive/tlnet
```

그래서 다시 처음의 kakao repo를 다시실행하니 제대로 되었다. 만일 처음 실행한다면, <br/>


### 사설 repo(한국)등록 {#사설-repo--한국--등록}

```text
sudo tlmgr repository add https://mirror.ischo.org/KTUG/texlive/tlnet ktug
```


### pinning추가 {#pinning추가}

```text
sudo tlmgr pinning add ktug "*"
```

pinning은 ktug라는 사설저장소에서 어떤 package를 tlmgr로 <br/>
관리할것인지를 정할 수 있게하는 명령어 이다. 여기서 \*는 전부 등록해서 <br/>
관리하겠다는 뜻이다.  그런데 다음과 같은 에러가 난다. <br/>

<a id="figure--pinning error"></a>

{{< figure src="/img/tex/tex-pinning.png" caption="<span class=\"figure-number\">Figure 2: </span>pinning error" width="600px" >}} <br/>

이것은 main repo설치와 관련된 문제다. main repo를 제대로 설치하면 <br/>
문제없이 지나간다. <br/>


## [Local-step4] 한글 폰트 다운로드 &amp; 등록 {#local-step4-한글-폰트-다운로드-and-등록}

step3에서 KTUG라는 사설 repo를 등록한것은 한글 폰트를 다운받기 <br/>
위함이다. <br/>

```text
sudo tlmgr install nanumttf hcr-lvt
```


## [Local-step5] TexLIVE update {#local-step5-texlive-update}

이제 전체 package를 update하자. <br/>

```text
sudo tlmgr update --all --self
```


## [Local-step6] XELATEX를 위한 font 설정 {#local-step6-xelatex를-위한-font-설정}

[여기](http://wiki.ktug.org/wiki/wiki.php/%EC%84%A4%EC%B9%98%ED%95%98%EA%B8%B0MacOSX/MacTeX)에 보면 Mactex를 설치하기의 xelatex설정 부분이 있다. 이것을 <br/>
따라한다. <br/>

참고로 tex는 크게 tex계열과 latex계열이 있다. 두개는 모두 사용법도 다르고 <br/>
구조도 다르다. 나는 tex문서를 만들고 pdf로 만들려는 목적이기 때문에 <br/>
XETEX가 아닌 XELATEX를 설치한다. XELATEX가 latex계열이기 <br/>
때문이다. <br/>

위의 링크에서 Xelatex의 설정이라고 해서 xelatex에 대한 설정인줄 <br/>
알았는데, 그게 아니라, mac os의 폰트 관리와 Mactex의 폰트관리가 서로 <br/>
달라서 호환이 안되는 문제가 있다. 이문제를 해결하는 방법을 <br/>
써놓았다. 아무래도 xelatex를 사용하는데 있어서 한글로 인한 문제가 많이 <br/>
있어서 그런듯하다. <br/>


### mactex에서 system font찾기. {#mactex에서-system-font찾기-dot}

```text
sudo vi /usr/local/texlive/2023/texmf.cnf
```

파일을 열고 다음을 추가한다. <br/>

```text
OSFONTDIR = {~/Library/Fonts//;/Library/Fonts//;/System/Library/Fonts//}
```

보다시피 os의 font가 설치된 directory를 나열한다. mac의 os는 3개의 <br/>
directory에 저장되어 있기 때문에, mactex가 해당 font-directory에서 <br/>
font를 찾을 수 있는 경로를 추가해주는 것이다. <br/>


### system에서 mactex font찾기. {#system에서-mactex-font찾기-dot}

이제 반대로 mac에서도 mactex에 설치된 font를 가져올 수 있어야 <br/>
한다. 사용자의 ~/Library/Fonts 아래에 TeX Live의 트루타입과 오픈타입 <br/>
폴더를 링크해두는 방법이 있다. <br/>

```text
# cd ~/Library/Fonts
ln -s /Library/TeX/Root/texmf-dist/fonts/truetype ~/Library/Fonts/
ln -s /Library/TeX/Root/texmf-dist/fonts/opentype ~/Library/Fonts/
```


## 요약 {#요약}

이렇게 하면, local에서 설치가 끝났다. 그러면 어디서든지 tex파일을 <br/>
만들고 shell에서 pdflatex를 하면 pdf파일을 만들 수 있다. <br/>

```tex
\documentclass{oblivoir},
\begin{document}
\section{헬로우}
안녕하세요, Hello World.
\end{document}
```

예를 들어서, emacs에서 위와 같이 hello.tex를 만들고, C-c C-c를 누르면 <br/>
pdf메뉴가 보인다. <br/>

<a id="figure--tex1"></a>

{{< figure src="/img/tex/tex1.png" caption="<span class=\"figure-number\">Figure 3: </span>tex1" width="600px" >}} <br/>

근데 pdf파일을 보면 한글이 나오지 않는다. 왜냐면 기본적으로, mactex던 <br/>
live-tex같은 배포폰은 영문만 지원한다. 위에서 KTUG라는 repo를 등록하고 <br/>
update했다. 한글폰트도 설치했었다. 한글을 출력할수 있는 package를 <br/>
깔았다는 얘기다. 다만 사용할 줄을 모르는 것이다. oblivoir라는 <br/>
한글나오는 documentclass가 있다. 다음과 같이 하면 한글이 나오게 된다. <br/>

```tex
\documentclass{oblivoir},
\begin{document}
\section{헬로우}
안녕하세요, Hello World.
\end{document}
```

한글을 나오게 하는 다른 방법으로 kotex라는 package를 설치하는 방법도 <br/>
있다. 아래와 같이 하면 된다. <br/>

```tex
\usepackage{kotex}  
\begin{document}
\section{헬로우}
안녕하세요, Hello World.
\end{document}
```

잠깐 한글에 대한 설명을 해야겠다. tex에서 글을 쓰는 방식은 template을 <br/>
이용해서 문서를 작성한다. 가장 유명한 문서 template은 <br/>
article이다. 그리고 좀 더 modern한 memoir같은 문서 template이 나오게 <br/>
된다. 이 template은 모두 영어를 기본으로 한다. 한글이 안 <br/>
써진다. 위처럼 한글이 pdf로 출력이 되질 않는다. 그런데 ktug라는 곳에서 <br/>
kotex라는 package를 만들어서, article과 memoir같은 영어권에서만 <br/>
사용하던 documentclass를 한글에서 사용할 수 있게 했다. 즉, <br/>
documentclass를 article로 하고 usepackage{kotex}로 하면 한글을 쓸수 <br/>
있게 했다. 그런데 한글이 조금 부자연스러워서 memoir에 한글을 잘나오게 <br/>
하는 documentclass를 아예 만들었다. 이게 oblivoir다. 즉 kotex라는 <br/>
package가 없어도, documentclass{oblivoir}를 하면 한글을 사용할 수 <br/>
있다. <br/>

<div class="note">

memoir는 book, report, article 같은 클래스의 일종입니다. 이것들 모두 <br/>
외국 사람들이 만들었으니 저절로 한글 타이포그래피를 지원하지는 <br/>
않죠. 예를 들자면, chapter를 "제 1 장"과 같은 형식으로 만들어주지는 <br/>
않죠.  memoir + kotex: <br/>

한글을 쓸 수 있게 해줍니다. 폰트 설정을 하지 않아도 디폴트로 은글꼴을 <br/>
쓰게 해줍니다. (함초롬으로 바꿀까 하는 얘기도 있었는데 바뀌었는지 <br/>
모르겠습니다) 한글을 쓸 수 있게 한다는 것은 단지 글자들을 식자하는 데 <br/>
불과한 것이 아닙니다. 자간 조정, 줄바꿈 등 여러 부분에서 한글 <br/>
타이포그래피를 구현할 수 있게 해줍니다. 그러나 이것은 여전히 chapter <br/>
이름이나 contents 이름을 한글로 바꿔주지는 않습니다. <br/>

oblivoir = memoir + kotex + alpha <br/>

oblivoir는 위에서 말씀드린 것들 뿐만 아니라 다른 여러 가지 기능을 <br/>
제공합니다. 한글 관련 클래스 옵션도 많이 제공하고요. 이것은 실인즉 <br/>
여러 가지 한글 타이포그래피를 보완하는 하위 패키지들을 포함합니다. <br/>

저는 이런저런 이유로 memoir + memhangul-x를 씁니다. <br/>
이 각각의 경우는 조금씩 다른 결과물을 내놓는데, 이렇게 정리할 수 <br/>
있겠습니다. <br/>

1.  영문 문서에서 한글을 이따금 써야 할 경우 <br/>

memoir + kotex <br/>

한글 낱글자 한두 개 정도만 식자해야 하는 경우라면 kotex을 쓰지 않고 <br/>
fontspec으로 한글 폰트를 쓸 수 있게 하는 것만으로도 <br/>
충분합니다. fontspec 없이 xetex 폰트 명령을 이용해도 됩니다. <br/>

1.  오로지 한글 문서를 만들 경우 <br/>

oblivoir 밖에 없습니다. <br/>

1.  오로지 영문 문서를 만들 경우 <br/>

memoir (물론 book, report, article, koma 등 다른 클래스를 써도 되지요) <br/>

1.  영문 문서를 한글로 번역하는 경우, 또는 그 반대인 경우 <br/>

이게 제가 memoir + memhangul-x를 쓰는 이유입니다. <br/>
쉽게 보자면 memoir나 oblivoir 둘 중 하나만 쓰면 될 것 같은데 왜 <br/>
kotex를 따로 만들었느냐? (역사적으로 보면 뒤바뀐 표현이지만) <br/>
book, report, article, 또는 amsmath 시리즈 클래스 등 많은 클래스들이 <br/>
있는데, 그것들이 모두 oblivoir처럼 한글화(?)되어 있지 않습니다. <br/>
그러면 memoir는 한글화할 만큼 유별난 놈이냐? <br/>
그렇습니다. memoir는 다른 클래스와 비교할 수 없을 만큼 (koma 시리즈 <br/>
클래스도 좋다고 하는데) 초강력 울트라 하이퍼 수퍼 만능 클래스입니다. <br/>
memoir 클래스는 수식과 그래픽을 제외하면 사용자가 필요로할 법한 모든 <br/>
것들을 제공합니다. <br/>
memoir 설명서를 정독해 볼 만한 가치가 여기에 있습니다. <br/>

</div>


## [emacs] org 설정. {#emacs-org-설정-dot}

emacs를 단순히 tex문서를 작성하고 pdf로 뽑아내는데 사용하지 <br/>
않는다. 주로 emacs는 org문서를 작성하고 이를 pdf로 나타내는데 사용한다. <br/>

org문서에서 한글을 사용하려면, org의 header에 다음과 같은걸 추가하는 <br/>
방법이 있고, emacs.org설정파일에 설정할 수 있다. <br/>

```text
    #+LATEX_COMPILER: xelatex          
  #+LATEX_CLASS: article
  #+LATEX_CLASS_OPTIONS: [12pt]
  #+latex_header: \usepackage[a4paper,top=1cm,bottom=1cm,left=1cm,right=1cm]{geometry}
  #+latex_header: \usepackage{fontspec}
  , #+latex_header: \setmainfont{NanumGothic}                  
  #+latex_header: \setmainfont{Arial}
  #+latex_header: \usepackage{kotex}
# 줄 간격이 좁아서 늘림
#+LATEX_HEADER: \linespread{1.4}
# 페이지 마진을 줄임
#+LATEX_HEADER: \usepackage[scale=0.8]{geometry}
```


## org에서 oblivoir {#org에서-oblivoir}

oblivoir를 사용하려면 우선 설치해야 한다. <br/>

```text
~  sudo tlmgr install kotex-oblivoir
```

이렇게 설치하고 emacs의 설정파일도 설치해야 한다. <br/>

```emacs-lisp
(add-to-list 'org-latex-classes
          '("oblivoir"
                                      "\\documentclass{oblivoir}"
                                      ("\\section{%s}" . "\\section*{%s}")
                                      ("\\subsection{%s}" . "\\subsection*{%s}")
                                      ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
                                      ("\\paragraph{%s}" . "\\paragraph*{%s}")
                                      ("\\subparagraph{%s}" . "\\subparagraph*{%s}")))
```

이렇게 설치하면 org에서 pdf로 변환할 때 oblivior class를 사용하게 <br/>
된다. latex header에 kotex를 사용할 필요는 없고, <br/>


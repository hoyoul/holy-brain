+++
title = "[dart] install dart and flutter on emacs"
author = ["holy"]
description = "install dart and flutter."
date = 2023-08-26T00:00:00+09:00
draft = true
+++

## dart lsp {#dart-lsp}


### install dart sdk {#install-dart-sdk}

local system에 dart sdk를 설치한다.

```text
brew install dart-sdk
```


### emacs 설정 {#emacs-설정}

dart-mode를 설정한다. flutter를 위해 hook을 건다.

```emacs-lisp
(use-package dart-mode
  :ensure t
  ;; Optional
  :hook (dart-mode . flutter-test-mode))
```

lsp를 사용하기 위해서 다음과 같이 설정한다.

```emacs-lisp
(setq package-selected-packages
  '(dart-mode lsp-mode lsp-dart lsp-treemacs flycheck company
    ;; Optional packages
    lsp-ui company hover))

(when (cl-find-if-not #'package-installed-p package-selected-packages)
  (package-refresh-contents)
  (mapc #'package-install package-selected-packages))

(add-hook 'dart-mode-hook 'lsp)

(setq gc-cons-threshold (* 100 1024 1024)
      read-process-output-max (* 1024 1024))
```


### 사용법 {#사용법}

emacs에서 확장자가 .dart인 파일을 열면 자동으로 dart lsp가
연결된다. 여기서 M-x lsp-dart-run을 실행하면 다음과 같은 화면을
갖는다.

<a id="figure--dart1"></a>

{{< figure src="/img/dart/dart1.png" caption="<span class=\"figure-number\">Figure 1: </span>dart1" width="600px" >}}


## flutter 설치 {#flutter-설치}

flutter를 설치하기 위해선, dart-mode가 이미 활성화되었다고
가정한다. 위에서 dart-mode는 이미 활성화되었다. flutter sdk는 이미
local에 설치되어 있어야 한다. flutter 홈페이지에서 sdk를
document/libraries/ 아래 설치했다. 이 경로를 setting해 주어야 한다.

```emacs-lisp
(use-package flutter
  :after dart-mode
  :bind (:map dart-mode-map
              ("C-M-x" . #'flutter-run-or-hot-reload))
  :custom
  (flutter-sdk-path "~/Documents/Libraries/flutter/"))
```


## emacs를 사용해서 개발하기 {#emacs를-사용해서-개발하기}

flutter sdk를 설치하고 path를 잡아주면, flutter가 제공하는 여러 유용한
기능을 사용할 수 있다.  emacs에서 사용하기 위해선 cmd에서 처리할 것들이 있다.
알아보자.


### [step-1] flutter create project명 {#step-1-flutter-create-project명}

terminal에서 위 명령을 치면 project가 만들어진다.

```nil
flutter create hello
```

이것은 android studio에서 project를 만들면 보여지는 수많은 file들을
그대로 똑같이 만들어준다. 그래서 emacs를 사용해서 개발할려면 이렇게
project를 만들고, lib/main.dart에서 코딩하면 된다.


### [step-2] ios simulator띄우기 {#step-2-ios-simulator띄우기}

ios simulator를 띄우면, 띄어진 simulator가 마치 server와 같은 역할을
하게 된다. android studio나 emacs에서 코드를 작성하면 작성된 코드가
build되어 server쪽으로 전송되어 실행되게 된다.

```text
open -a Simulator
```

terminal에서 실행하거나, emacs라면 M-x dap-debug를 실행하면
simulator를 띄울 수 있다.

```text
dap-debug
```

이것은 android studio를 개발할때와 과정이
똑같다. android studio에서도 ios simulator를 먼저 실행한다.


### [step-3] flutter run {#step-3-flutter-run}

code를 작성이 끝났으면, ios simulator에서 실행되는 것을 보고
싶다. 이럴때는 terminal에서 아래 명령을 실행한다.

```text
flutter run
```

이렇게 하면, code가 빌드되어 simulator에서 동작한다. emacs에서도

```text
M-x flutter run
```

을 통해서 실행할 수 있다.


### tip hot-restart {#tip-hot-restart}

android studio에 보면 hot-restart라는 기능이 있다. ios simulator를
실행하고 재시작없이 변경된 코드만 simulator에 적용하는 기술이다.

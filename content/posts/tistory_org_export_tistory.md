+++
title = "[tistory] org export tistory"
author = ["holy"]
description = "org를 export해서 tistory에 발행하려고 한다."
date = 2023-09-01T00:00:00+09:00
draft = true
+++

## org-export-dispatch에 메뉴 작성 {#org-export-dispatch에-메뉴-작성}


### 게시함수 작성 {#게시함수-작성}

C-c C-e를 누르면 export dispatch에 menu를 선택하면 tistory에 글이
게시되게 하고 싶다. 그러면 tistory에 글을 게시하는 함수가
필요하다. tistory는 api를 제공한다. 그래서 함수를 만든다.

```emacs-lisp
(defun org-export-to-tistory ()
  (interactive)
  ;; 여기에 Tistory로 게시하는 코드 작성
  (message "Tistory로 발행되었습니다."))

```


### menu 작성 {#menu-작성}

그리고 menu를 만들어야 한다.

```emacs-lisp
(with-eval-after-load 'ox
  (define-key org-mode-map (kbd "C-c C-e") 'org-export-dispatch))

(define-key org-export-dispatch-menu [t] '("Tistory" . org-export-to-tistory))

```

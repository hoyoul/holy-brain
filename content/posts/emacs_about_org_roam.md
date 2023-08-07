+++
title = "[emacs] about org-roam"
author = ["holy"]
description = "옛날 자료 취합중"
date = 2023-08-06T00:00:00+09:00
draft = true
+++

## org-roam이란? {#org-roam이란}

여러개의 note를 link로 연결시켜서 관리한다. hierarchy하지
않다. html문서에서 다른 문서를 hyperlink로 연결하는 것과
비슷하다. org문서라는게 다른다. 여튼 문서와 문서를 연결하는 link가
핵심이다.


## 설치 {#설치}

-   requirement

    <div class="note">

    c/c++ compiler (gcc or clang;맥은 builtin compiler가 있음.),
    sqlitedb(brew로 설치함)

    </div>
-   emacs settings(최종 설정)

<!--listend-->

```emacs-lisp
(use-package org-roam
  :ensure t
  :init
  (setq org-roam-v2-ack t)
  :custom
  (org-roam-directory "~/RoamNotes")
  (org-roam-completion-everywhere t)
  (setq org-roam-dailies-capture-templates
        '(("d" "default" entry "* %<%I:%M %p>: %?"
           :if-new (file+head "%<%Y-%m-%d>.org" "#+title: %<%Y-%m-%d>\n"))))
  :bind (("C-c r l" . org-roam-buffer-toggle)
         ("C-c r f" . org-roam-node-find)
         ("C-c r i" . org-roam-node-insert)
         :map org-mode-map
         ("C-M-i" . completion-at-point)
         :map org-roam-dailies-map
         ("Y" . org-roam-dailies-capture-yesterday)
         ("T" . org-roam-dailies-capture-tomorrow))
  :bind-keymap
  ("C-c r d" . org-roam-dailies-map)
  :config
  (require 'org-roam-dailies) ;; Ensure the keymap is available
  (org-roam-db-autosync-mode))

```

-   org-roam-directory: roam note가 담겨질 directory, 반드시 설정해야 한다.
-   setq org-roam-v2-ack t: 설정하지 않으면, warning이 엄청 많이 생긴다.
-   completion-at-point, org-roam-completion-everywhere를 설정하면, C-c
    r i로 insert를 찾아서 link를 만드는 것보다 훨씬 빠르게 link를 만들수
    있다.


## 사용법 {#사용법}

-   [shortcuts]
    -   (1) C-c r f : find node, node를 찾는다. 없으면 만들 수도
        있다. 만들때는 해당 단어에 해당하는 node가 없을때만 가능하다.
    -   (2) C-c r i : find node처럼 node를 찾은 후 현재 note안에서 link를
        만든다.
    -   (2-1) C-M-i: node안에서 자동으로 link를 만든다. link
        자동완성이라고 보면 된다.
    -   (3) C-c r l : backlink를 보여준다.  backlink는 org-roam의
        특징이다. 자신을 참조하는 note를 보여준다.


## journal 사용 {#journal-사용}

-   journal:  journal은 일기와 비슷한 매일 기록이다.

[settings]

-   journal은 별도의 폴더에 기록된다. journal을 기록하기 위해선, roam이 저장되는 폴더에 daily라는 폴더를 만들어야 한다. 혹은 별도의 setting을 해도 된다.
    (setq org-roam-dailies-directory "journal/")
-   capture template
    C-c r d n 을 누르면 capture template이 생기면서 journal을 사용할 수 있다. 각 항목(entry)마다 시간이 추가되고, 파일 template에는 날짜로 저장된다. 아래에 capture template에 보면, entry에 시간이 출력되도록 default로 설정되어 있다. 그리고 파일에는 title이 기록되게 되어 있다.
    ```emacs-lisp
    (setq org-roam-dailies-capture-templates
        '(("d" "default" entry "* %<%I:%M %p>: %?"
           :if-new (file+head "%<%Y-%m-%d>.org" "#+title: %<%Y-%m-%d>\n"))))
    ```

[shortcuts]

-   C-c r d n : 새로운 journal 작성(capture template 사용)
-   C-c r d d : 쓴 journal의 확인
-   C-c r d y : yesterday journal 확인
-   C-c r d t : tomorrow journal 확인
-   C-c r d v : 특정 날짜로 이동해서 note 확인
-   C-c r d c : 특정 날짜로 이동해서 note작성
-   C-c r d f : daily note에서 forward 이동
-   C-c r d b : daily note에서 back으로 이동


## 편한 기능 {#편한-기능}

-   org mode에서 가장 중요한 기능은 org-agenda와 org-export, org-babel이라고 할 수 있다. 그중 일정관리에 대해 알아본다.
-   [org-agenda- 일정 보기]
-   todo, project tag, schedule(deadline)을 통해 일정을 기록한다.
-   기록된 일정을 org-agenda로 본다.
-   ios app과 동기화도 가능하다.


## org-id-get-create {#org-id-get-create}

org-roam문서(node)가 일반 org문서와 다른점은 id를 가지고 있다는
것이다. org-roam-node-find(C-c r f)로 node를 만들면 id를 property에
갖는 org문서가 만들어진다. org문서에서 org-id-get-create하면 id를
만들어서 node로 만들 수 있다.


## node연결 {#node연결}

C-c r i (org-roam-node-insert)를 사용해서 다른 node와 연결할 수 있다.


## backlinks {#backlinks}

link는 내가 다른 노드를 access한다. 즉 내가 다른 node의 주소나 id를
알아야 한다. A에서 link로 B를 연결했다면, A에서 B를 클릭하면 B로
이동이 가능하다. 반면 backlink는 나를 참조하는 node를
알려준다. B에서는 자기 자신을 누가 참조하는지 잘 모른다. 그런데
backlink를 사용해서 A가 나를 참조한다는 것을 알 수 있다.
org-roam-buffer-toggle(C-c r l)을 실행하면 새로운 window pane이 열리고
backlink node를 보여준다.
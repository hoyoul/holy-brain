+++
title = "[emacs] straight usage"
author = ["holy"]
description = "straight 사용법"
date = 2023-10-04T00:00:00+09:00
draft = true
+++

## straight란? {#straight란}

package가 melpa,elpa같은 중앙집권적인 repo에만 있지 않음. 개인이
관리하는 package도 있기 때문에, repo에 없는 package를 가져와서
사용할려는 목적으로 사용되었으나, use-package와 integration되어서
use-package의 기능도 사용할 수 있게 됨. 즉 package를 가져오고,
설치하는 기능도 straight에서 할수 있음. 즉 use-package가 하던 기능의
upgrade된 버전으로 볼 수 있다.


## 사용법 {#사용법}

설치는 다음과 같이 한다.

```emacs-lisp
(defvar bootstrap-version)
(let ((bootstrap-file
       (expand-file-name "straight/repos/straight.el/bootstrap.el" user-emacs-directory))
      (bootstrap-version 6))
  (unless (file-exists-p bootstrap-file)
    (with-current-buffer
        (url-retrieve-synchronously
         "https://raw.githubusercontent.com/radian-software/straight.el/develop/install.el"
         'silent 'inhibit-cookies)
      (goto-char (point-max))
      (eval-print-last-sexp)))
  (load bootstrap-file nil 'nomessage))

```

straight를 쓸려고 하면 이렇게 그냥 copy &amp; paste로 붙여야 한다. 이
상태에서 straight를 사용하려면,

```emacs-lisp
(straight-use-package
 ...
 ...)
```

위와 같은 형태로 사용하는데, use-package와 integration해서 사용을 많이
한다. 그렇게 하기 위해서 위의 설정 다음에 다음을 추가한다.

```emacs-lisp
(straight-use-package 'use-package)
```

이렇게 하면 use-package로 straight기능을 사용할 수 있다. 예를 들어서,

```emacs-lisp
(use-package sth
:straight t)
```

이런 식으로 사용할 수 있다.

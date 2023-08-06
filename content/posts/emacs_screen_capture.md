+++
title = "[emacs] screen capture"
author = ["holy"]
description = "emacs에서 screen capture."
date = 2023-08-05T00:00:00+09:00
draft = true
+++

## screencasting {#screencasting}

emacs화면을 녹화하는 것이다. gif 움짤로 저장한다. M-x
gif-screencastmode를 enable한 후 C-x g를 하면 영상 촬영이 시작되고 C-x
g를 하면 영상이 저장된다. emacs만 저장한다. 저장 위치는
~/Videos/emacs/에 저장된다. 저장된 gif는 sequential로 확인한다.


## requirement {#requirement}

brew install로 다음을 설치한다.

-   scrot: brew install --cask scoot
-   gifsicle
-   imagemagick
-   ffmpeg
-   mplayer


## emacs 설치 {#emacs-설치}

.emacs 파일에 다음과 같이 추가한다.

```emacs-lisp
(use-package gif-screencast
  :ensure t
  :commands (gif-screencast-mode))
```

그런데 나는 좀 더 복잡하게 설정했다.  [여기](https://github.com/Ambrevar/emacs-gif-screencast)를 참조했다.

```emacs-lisp
(use-package gif-screencast
  :ensure t
  :commands (gif-screencast-mode)
  :config
  (setq gif-screencast-scale-factor 2.0)
  (add-hook 'after-init-hook #'gif-screencast-mode)
  :bind ("C-x C-g" . 'gif-screencast-start-or-stop))

(with-eval-after-load 'gif-screencast
  (setq gif-screencast-args '("-x")) ;; To shut up the shutter sound of `screencapture' (see `gif-screencast-command').
  (setq gif-screencast-cropping-program "mogrify") ;; Optional: Used to crop the capture to the Emacs frame.
  (setq gif-screencast-capture-format "ppm")) ;; Optional: Required to crop captured images.

```


## 사용방법(예전글) {#사용방법--예전글}

Emacs에서 gif-screencast-mode를 활성화합니다. M-x gif-screencast-mode
명령어를 실행합니다. commands는 해당 명령어를 실행해야 load가
됩니다. .emacs 파일에 다음과 같이 추가하면 자동으로 실행합니다.

```emacs-lisp
(add-hook 'after-init-hook #'gif-screencast-mode)
```

녹화를 시작하려면 C-x C-g 키를 누릅니다. 녹화할 영역을 선택하고(방법을
까먹었다.), Enter 키를 누릅니다. 녹화를 멈추려면 C-x C-g 키를 다시
누릅니다. 녹화할 영역이 선택되지 않으면 디폴트로 현재 emacs창이
캡쳐된다.  녹화된 GIF 파일은 현재 작업 중인 디렉토리에 저장됩니다.  위
방법을 사용하여 macOS에서도 Emacs 화면을 GIF로 녹화할 수 있습니다.


## 저장되는 위치(예전글) {#저장되는-위치--예전글}

-   ~/Videos/emacs/
-   M-x customize로 설정할 수 있다.
    gif-screencast-output-directory


## 녹화영역이 이상한경우 {#녹화영역이-이상한경우}

scale factor를 조정한다. 클수록 영역이 커진다.


## 녹화 키 설정 {#녹화-키-설정}

C-x C-g로 시작과 멈춤이 된다. gif-screencast-mode를 사용해서 enable한
이후에 사용해야 한다.

;;; use-package대신 straight.el을 설치,왜냐면 ox-hugo는 melpa같은 repo에 없고 github에서 관리되는 package이기 때문
;;;
(defvar bootstrap-version)
(defvar straight-base-dir)
(defvar straight-fix-org)
(defvar straight-vc-git-default-clone-depth 1)
(defvar publish--straight-repos-dir)

(setq gc-cons-threshold 83886080 ; 80MiB
      straight-base-dir (expand-file-name "../.." (or load-file-name buffer-file-name))
      straight-fix-org t
      straight-vc-git-default-clone-depth 1
      publish--straight-repos-dir (expand-file-name "straight/repos/" straight-base-dir))

(let ((bootstrap-file
       (expand-file-name "straight/repos/straight.el/bootstrap.el" user-emacs-directory))
      (bootstrap-version 5))
  (unless (file-exists-p bootstrap-file)
    (with-current-buffer
        (url-retrieve-synchronously
         "https://raw.githubusercontent.com/raxod502/straight.el/develop/install.el"
         'silent 'inhibit-cookies)
      (goto-char (point-max))
      (eval-print-last-sexp)))
  (load bootstrap-file nil 'nomessage))

;; straight.el로 org와 ox-hugo설치
;; (straight-use-package
;;  '(org-mode :type git
;;             :host github
;;             :repo "emacs-straight/org-mode"
;;             :files ("*.el" "lisp/*.el" "contrib/lisp/*.el")))
(straight-use-package 'org)
(straight-use-package
 '(ox-hugo :type git
           :host github
           :repo "kaushalmodi/ox-hugo"
           :nonrecursive t))

(require 'find-lisp)



(defun holy/publish_md (file)
  (setq file1 (replace-regexp-in-string "'" "" file))  
  (message "현재 버퍼의 인코딩 방식: %s" (symbol-name buffer-file-coding-system))
  (message "현재 시스템의 로케일 인코딩 방식: %s" (symbol-name locale-coding-system))
  (message "전달받은 값: %s" file)
  (message "file1('제거)의 값: %s" file1)
  (with-current-buffer (find-file-noselect file1)
    (setq org-hugo-base-dir "..")
    (org-hugo-export-wim-to-md)))

(message "Done!")

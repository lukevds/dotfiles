; -*- lexical-binding: t -*-

(add-to-list 'default-frame-alist
             '(font . "DejaVu Sans Mono-15"))

(set-face-attribute 'default nil :height 220)
(set-face-attribute 'italic nil :underline nil)

(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)

(context-menu-mode 1)
(global-visual-line-mode 1)
(column-number-mode 1)

(setq org-startup-with-inline-images t)

(keymap-global-set "C-x C-b" #'ibuffer)

(require 'org-capture)

(setq org-capture-templates
      '(("a" "Avulsas" entry
	 (file "/home/lvds/Documents/avulsas.org")
	 "* %^{PROMPT}\n%T\n%?")))

(defvar meta-space-map (make-sparse-keymap)
  "Keymap where I store key bindings that I want to access in any mode.")

(keymap-set meta-space-map "o c" #'org-capture)

(keymap-global-set "M-SPC" meta-space-map)

(require 'org-tempo)

(org-babel-do-load-languages
 'org-babel-load-languages
 '((emacs-lisp . t)
   (shell . t)
   (haskell . t)))

(require 'eat)
(keymap-set meta-space-map "RET" #'eat)
(keymap-global-set "C-x p e" #'eat-project)

(require 'magit)

(setq dired-listing-switches "-alh")
(setq dired-guess-shell-alist-user '(("\\.\\(mp4\\|webm\\|mkv\\)\\'" "mpv")
				     ("\\.\\(mp3\\|opus\\|m4a\\)\\'" "mpv --player-operation-mode=pseudo-gui")))
(setq dired-dwim-target t)

(setq isearch-lazy-count t)

(require 'pdf-tools)
(pdf-tools-install)
(pdf-loader-install)

(require 'org-pdftools)
(add-hook 'org-mode-hook #'org-pdftools-setup-link)
(require 'org-noter-pdftools)

(require 'haskell-mode)

(defun search-youtube (arg query)
  (interactive "P
MSearch on YouTube: ")
  (call-process-shell-command
   (concat "firefox " (when arg "--new-window ")
  	   "'"
	   "https://www.youtube.com/results?search_query="
  	   query
	   "'")
   nil
   0
   nil))

(defun search-minewiki (arg query)
  (interactive "P
MSearch on Minecraft Wiki: ")
  (call-process-shell-command
   (concat "firefox " (when arg "--new-window ")
  	   "'"
	   "https://minecraft.fandom.com/wiki/Special:Search?scope=internal&navigationSearch=true&query="
  	   query
	   "'")
   nil
   0
   nil))

(defun search-archwiki (arg query)
  (interactive "P
MSearch on ArchWiki: ")
  (call-process-shell-command
   (concat "firefox " (when arg "--new-window ")
  	   "'"
	   "https://wiki.archlinux.org/index.php?search="
  	   query
	   "'")
   nil
   0
   nil))

(defun search-wikipedia (arg query)
  (interactive "P
MSearch on English Wikipedia: ")
  (call-process-shell-command
   (concat "firefox " (when arg "--new-window ")
  	   "'"
	   "https://en.wikipedia.org/w/index.php?search="
  	   query
	   "'")
   nil
   0
   nil))

(keymap-set meta-space-map "s y" #'search-youtube)
(keymap-set meta-space-map "s m" #'search-minewiki)
(keymap-set meta-space-map "s a" #'search-archwiki)
(keymap-set meta-space-map "s w" #'search-wikipedia)

;; (setq tab-width 2)
(setq css-indent-offset 2)
(defun disable-indent-tabs-mode ()
  (indent-tabs-mode -1))
(add-hook 'prog-mode-hook #'disable-indent-tabs-mode)
(add-hook 'conf-mode-hook #'disable-indent-tabs-mode)
;; (setq indent-tabs-mode nil)

(setq ring-bell-function 'ignore)

(setq read-file-name-completion-ignore-case t)

(setq find-name-arg "-iname")

(setq make-backup-files nil)

(setq bookmark-save-flag 1)

(defun conf-outline-level-comments ()
  (1- (length (match-string 0))))

(defun conf-mode-outline-setup ()
  (outline-minor-mode 1)
  (setq-local outline-regexp " #+")
  (setq-local outline-level #'conf-outline-level-comments))

(add-hook 'conf-mode-hook #'conf-mode-outline-setup)

(load-file (concat user-emacs-directory "./secrets.el"))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(auth-source-save-behavior nil)
 '(safe-local-variable-values
   '((geiser-repl-per-project-p . t)
     (eval with-eval-after-load 'yasnippet
	   (let
	       ((guix-yasnippets
		 (expand-file-name "etc/snippets/yas"
				   (locate-dominating-file
				    default-directory ".dir-locals.el"))))
	     (unless (member guix-yasnippets yas-snippet-dirs)
	       (add-to-list 'yas-snippet-dirs guix-yasnippets)
	       (yas-reload-all))))
     (eval with-eval-after-load 'tempel
	   (if (stringp tempel-path)
	       (setq tempel-path (list tempel-path)))
	   (let
	       ((guix-tempel-snippets
		 (concat
		  (expand-file-name "etc/snippets/tempel"
				    (locate-dominating-file
				     default-directory
				     ".dir-locals.el"))
		  "/*.eld")))
	     (unless (member guix-tempel-snippets tempel-path)
	       (add-to-list 'tempel-path guix-tempel-snippets))))
     (eval with-eval-after-load 'git-commit
	   (add-to-list 'git-commit-trailers "Change-Id"))
     (eval setq-local guix-directory
	   (locate-dominating-file default-directory ".dir-locals.el"))
     (eval setq-local org-structure-template-alist
	   (cons '("hs" . "src haskell :results output")
		 org-structure-template-alist))
     (org-structure-template-alist cons
				   '("hs"
				     . "src haskell :results output")
				   org-structure-template-alist)
     (eval progn (require 'lisp-mode)
	   (defun emacs27-lisp-fill-paragraph (&optional justify)
	     (interactive "P")
	     (or (fill-comment-paragraph justify)
		 (let
		     ((paragraph-start
		       (concat paragraph-start
			       "\\|\\s-*\\([(;\"]\\|\\s-:\\|`(\\|#'(\\)"))
		      (paragraph-separate
		       (concat paragraph-separate
			       "\\|\\s-*\".*[,\\.]$"))
		      (fill-column
		       (if
			   (and
			    (integerp emacs-lisp-docstring-fill-column)
			    (derived-mode-p 'emacs-lisp-mode))
			   emacs-lisp-docstring-fill-column
			 fill-column)))
		   (fill-paragraph justify))
		 t))
	   (setq-local fill-paragraph-function
		       #'emacs27-lisp-fill-paragraph))
     (eval add-to-list 'completion-ignored-extensions ".go")
     (org-todo-keyword-faces
      ("CANCELED" :inherit font-lock-comment-face :weight bold))
     (org-log-done . time)
     (org-refile-targets
      (nil :regexp "\\(Concluídas\\|Descartadas\\)"))
     (eval modify-syntax-entry 43 "'")
     (eval modify-syntax-entry 36 "'")
     (eval modify-syntax-entry 126 "'")
     (geiser-guile-binary "guix" "repl") (geiser-insert-actual-lambda)
     (org-blank-before-new-entry (heading . auto)
				 (plain-list-item . auto))
     (org-list-description-max-indent . 5)
     (org-list-two-spaces-after-bullet-regexp)
     (org-confirm-babel-evaluate))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

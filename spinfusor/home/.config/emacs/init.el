; -*- lexical-binding: t -*-

(load-file (concat user-emacs-directory "./common.el"))

(add-to-list 'default-frame-alist
             '(font . "DejaVu Sans Mono-15"))

(set-face-attribute 'default nil :height 220)
(set-face-attribute 'italic nil :underline nil)

(setq org-startup-with-inline-images t)

(setq org-capture-templates
      '(("a" "Avulsas" entry
	 (file "/home/lvds/Documents/avulsas.org")
	 "* %^{PROMPT}\n%T\n%?")
        ("b" "Atividade do dia" entry (file+olp+datetree "/home/lvds/Documents/diarias.org")
         "* TODO %?")))

(plist-put org-format-latex-options :scale 2.2)

(org-babel-do-load-languages
 'org-babel-load-languages
 '((emacs-lisp . t)
   (shell . t)
   (haskell . t)
   (scheme . t)))

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

(setq outline-minor-mode-cycle t)

(defun conf-outline-level-comments ()
  (- (length (match-string 0)) 2))

(defun conf-mode-outline-setup ()
  (outline-minor-mode 1)
  (setq-local outline-regexp "^# \\*+")
  (setq-local outline-level #'conf-outline-level-comments))

(add-hook 'conf-mode-hook #'conf-mode-outline-setup)

(require 'geiser)
(require 'geiser-guile)
(setq geiser-guile-binary '("guix" "repl"))

(setq erc-nick "muaddibb")

(require 'elfeed)

(setq elfeed-feeds
      '("http://nullprogram.com/feed/"
        "http://www.50ply.com/atom.xml"
        "https://sachachua.com/blog/feed/"
        "https://planet.emacslife.com/atom.xml"
        "https://planet.guix.gnu.org/atom.xml"
        "https://karthinks.com/index.xml"
        "https://susam.net/feed.xml"))

(load-file (concat user-emacs-directory "./secrets.el"))

(setq custom-file (concat user-emacs-directory "custom.el"))
(load custom-file)

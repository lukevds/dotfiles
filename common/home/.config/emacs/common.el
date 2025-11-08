; -*- lexical-binding: t -*-

(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)

(context-menu-mode 1)
(global-visual-line-mode 1)
(column-number-mode 1)

(setq org-startup-with-inline-images t)

(keymap-global-set "C-x C-b" #'ibuffer)

(require 'org-capture)

(defvar meta-space-map (make-sparse-keymap)
  "Keymap where I store key bindings that I want to access in any mode.")

(keymap-global-set "M-SPC" meta-space-map)

(keymap-set meta-space-map "o c" #'org-capture)

(require 'org-tempo)

(require 'eat)
(keymap-set meta-space-map "RET" #'eat)
(keymap-global-set "C-x p e" #'eat-project)

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

(require 'magit)

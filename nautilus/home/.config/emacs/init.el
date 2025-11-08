; -*- lexical-binding: t -*-

(global-visual-line-mode 1)
(column-number-mode 1)

(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)
(context-menu-mode 1)

(setq dired-listing-switches "-alh")

(require 'org-capture)

(require 'org-tempo)

(org-babel-do-load-languages
 'org-babel-load-languages
 '((emacs-lisp . t)
   (shell . t)))

(require 'eat)
(require 'magit)

(defun activate-fill-column-indicator ()
  (display-fill-column-indicator-mode 1))

(add-hook 'git-commit-mode-hook #'activate-fill-column-indicator)

(keymap-global-set "C-x p e" #'eat-project)

(defun open-project-in-code ()
  (interactive)
  (call-process-shell-command
   (concat "code "
	   (project-root (project-current t)))
   nil 0 nil))

(defun open-file-in-code ()
  (interactive)
  (call-process-shell-command
   (concat "code "
	   (expand-file-name
	    (read-file-name "open in code: ")))
   nil 0 nil))

(setq auto-mode-alist
      (cons '("\\.vue\\'" . web-mode)
	    auto-mode-alist))

(setq highlight-symbol-idle-delay
      0.05)

(add-hook 'prog-mode-hook
	  #'highlight-symbol-mode)

(require 'treemacs)

(defvar meta-space-map (make-sparse-keymap)
  "Keymap where I store key bindings that I want to access in any mode.")

(keymap-set meta-space-map "C-t" #'treemacs-select-window)
(keymap-set meta-space-map "t" #'treemacs)

(keymap-global-set "M-SPC" meta-space-map)

;; (require 'lsp-mode) ; usar pacotes q melhoram performance, ver se resolve

(load-file (concat user-emacs-directory "./secrets.el"))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages '(eat magit))
 '(safe-local-variable-values '((org-confirm-babel-evaluate))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
(put 'scroll-left 'disabled nil)

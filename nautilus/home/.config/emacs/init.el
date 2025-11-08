; -*- lexical-binding: t -*-

(load-file (concat user-emacs-directory "./common.el"))

(org-babel-do-load-languages
 'org-babel-load-languages
 '((emacs-lisp . t)
   (shell . t)))

(defun activate-fill-column-indicator ()
  (display-fill-column-indicator-mode 1))

(add-hook 'git-commit-mode-hook #'activate-fill-column-indicator)

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

(keymap-set meta-space-map "C-t" #'treemacs-select-window)
(keymap-set meta-space-map "t" #'treemacs)

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

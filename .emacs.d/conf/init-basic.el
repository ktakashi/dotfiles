(defun toggle-truncate-line ()
  (interactive)
  (if truncate-lines
      (setq truncate-lines nil)
    (setq truncate-lines t))
  (recenter))
;; toggle
(global-set-key "\C-c\C-l" 'toggle-truncate-line)

(set-default-coding-systems 'utf-8-unix)

(define-key global-map "\C-h" 'delete-backward-char)

;; no backup files
(setq backup-inhibited t)

(display-time-mode t)
(show-paren-mode t)
(transient-mark-mode t)
;; no start up
(setq inhibit-startup-message t)
;; don't need tool bar
(tool-bar-mode 0)

;; buffer info
(column-number-mode t)
(line-number-mode t)

;; 80 x 40
(if window-system
    (setq initial-frame-alist '((width . 80) (height . 40))))

;; user info
(setq user-full-name "Takashi Kato")
(setq user-mail-address "ktakashi@ymail.com")

;; auto install
(require 'auto-install)
(setq auto-install-directory "~/.emacs.d/elisp/")

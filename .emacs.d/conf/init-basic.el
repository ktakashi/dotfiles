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

;; 2 panel with 80x66 (height should taken from available height, but I'm lazy)
(if window-system
    (when window-system
      (setq initial-frame-alist '((width . 167) (height . 66)))
      (split-window-horizontally)
      ))

;; user info
(setq user-full-name "Takashi Kato")
(setq user-mail-address "ktakashi@ymail.com")

;; Melpa
(require 'package)
(let* ((no-ssl (and (memq system-type '(windows-nt ms-dos))
                    (not (gnutls-available-p))))
       (proto (if no-ssl "http" "https")))
  (add-to-list 'package-archives
	       (cons "melpa" (concat proto "://melpa.org/packages/")) t)
  (when (< emacs-major-version 24)
    ;; For important compatibility libraries like cl-lib
    (add-to-list 'package-archives
		 '("gnu" . (concat proto "://elpa.gnu.org/packages/")))))
(package-initialize)

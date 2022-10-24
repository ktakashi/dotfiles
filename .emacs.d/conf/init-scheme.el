(setq scheme-program-name "sash -i")
(autoload 'scheme-mode "cmuscheme" "Major mode for Scheme." t)
(autoload 'run-scheme "cmuscheme" "Run an inferior Scheme process." t)

(require 'scheme)
(require 'cl)

(defun scheme:insert-export ()
  (interactive)
  (let ((sym (current-word))
	(saved-pos (point)))
    (goto-char (car (nth 9 (syntax-ppss))))
    (let ((export-pos (search-forward "(export" nil t)))
      (cl-labels ((flatten-rename (export)
		    (mapcan (lambda (e)
			      (if (and (listp e) (eq 'rename (car e)))
				  (mapcar #'cadr (cdr e))
				(list e))) 
			    (cdr export)))
		  (check-export ()
		    (goto-char (- export-pos 7))
		    (let ((exports (flatten-rename (read (current-buffer)))))
		      (goto-char export-pos)
		      (not (member (intern sym) exports))))
		  (move-until-the-end ()
		    (ignore-errors (while t (forward-sexp)))
		    (point)))
	(if export-pos
	  (if (check-export)
	      (let ((last (move-until-the-end)))
		(message "Exporting %s `%s'" last sym)
		(goto-char last)
		(insert "\n" sym)
		(let ((p (point)))
		  (indent-for-tab-command)
		  (setq saved-pos (+ saved-pos (string-width sym) 1
				     (- (point) p)))))
	    (message "Duplicate exort `%s`" sym))
	  (message "No export clause found"))))
    (goto-char saved-pos)
    sym))

(define-key scheme-mode-map "\M-\C-E" 'scheme:insert-export)

(setq cmuscheme-load-hook
      '((lambda () (define-key inferior-scheme-mode-map "\C-c\C-t"
     'favorite-cmd))))

(put 'and-let* 'scheme-indent-function 1)
(put 'begin0 'scheme-indent-function 0)
(put 'call-with-client-socket 'scheme-indent-function 1)
(put 'call-with-input-conversion 'scheme-indent-function 1)
(put 'call-with-input-file 'scheme-indent-function 1)
(put 'call-with-input-process 'scheme-indent-function 1)
(put 'call-with-input-string 'scheme-indent-function 1)
(put 'call-with-iterator 'scheme-indent-function 1)
(put 'call-with-output-conversion 'scheme-indent-function 1)
(put 'call-with-output-file 'scheme-indent-function 1)
(put 'call-with-output-string 'scheme-indent-function 0)
(put 'call-with-temporary-file 'scheme-indent-function 1)
(put 'call-with-values 'scheme-indent-function 1)
(put 'dolist 'scheme-indent-function 1)
(put 'dotimes 'scheme-indent-function 1)
(put 'if-match 'scheme-indent-function 2)
(put 'let*-values 'scheme-indent-function 1)
(put 'let-args 'scheme-indent-function 2)
(put 'with-args 'scheme-indent-function 2)
(put 'let-keywords* 'scheme-indent-function 2)
(put 'let-match 'scheme-indent-function 2)
(put 'let-optionals* 'scheme-indent-function 2)
(put 'let-syntax 'scheme-indent-function 1)
(put 'let-values 'scheme-indent-function 1)
(put 'let/cc 'scheme-indent-function 1)
(put 'let1 'scheme-indent-function 2)
(put 'letrec-syntax 'scheme-indent-function 1)
(put 'make 'scheme-indent-function 1)
(put 'multiple-value-bind 'scheme-indent-function 2)
(put 'match 'scheme-indent-function 1)
(put 'smatch 'scheme-indent-function 1)
(put 'parameterize 'scheme-indent-function 1)
(put 'parse-options 'scheme-indent-function 1)
(put 'receive 'scheme-indent-function 2)
(put 'rxmatch-case 'scheme-indent-function 1)
(put 'rxmatch-cond 'scheme-indent-function 0)
(put 'rxmatch-if 'scheme-indent-function 2)
(put 'rxmatch-let 'scheme-indent-function 2)
(put 'syntax-rules 'scheme-indent-function 1)
(put 'with-syntax 'scheme-indent-function 1)
(put 'unless 'scheme-indent-function 1)
(put 'until 'scheme-indent-function 1)
(put 'when 'scheme-indent-function 1)
(put 'while 'scheme-indent-function 1)
(put 'with-builder 'scheme-indent-function 1)
(put 'with-error-handler 'scheme-indent-function 0)
(put 'with-error-to-port 'scheme-indent-function 1)
(put 'with-input-conversion 'scheme-indent-function 1)
(put 'with-input-from-port 'scheme-indent-function 1)
(put 'with-input-from-process 'scheme-indent-function 1)
(put 'with-input-from-string 'scheme-indent-function 1)
(put 'with-iterator 'scheme-indent-function 1)
(put 'with-module 'scheme-indent-function 1)
(put 'with-output-conversion 'scheme-indent-function 1)
(put 'with-output-to-port 'scheme-indent-function 1)
(put 'with-output-to-process 'scheme-indent-function 1)
(put 'with-output-to-string 'scheme-indent-function 1)
(put 'with-port-locking 'scheme-indent-function 1)
(put 'with-string-io 'scheme-indent-function 1)
(put 'with-time-counter 'scheme-indent-function 1)
(put 'with-signal-handlers 'scheme-indent-function 1)
(put 'with-locking-mutex 'scheme-indent-function 1)
(put 'guard 'scheme-indent-function 1)
(put 'library 'scheme-indent-function 3)

(put 'stream-let 'scheme-indent-function 2)
;; scheme-mode
;(autoload 'scheme-smart-complete "scheme-complete" nil t)
;(eval-after-load 'scheme
;  '(progn (define-key scheme-mode-map "\t" 'scheme-complete-or-indent)))
;(autoload 'scheme-get-current-symbol-info "scheme-complete" nil t)
;(add-hook 'scheme-mode-hook
;          (lambda ()
;            (make-local-variable 'eldoc-documentation-function)
;            (setq eldoc-documentation-function 'scheme-get-current-symbol-info)
;            (eldoc-mode t)
;            (setq lisp-indent-function 'scheme-smart-indent-function)))

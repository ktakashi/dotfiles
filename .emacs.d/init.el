(defun add-to-load-path (&rest paths)
  (mapc '(lambda (path)
	   (add-to-list 'load-path path))
	(mapcar 'expand-file-name paths)))

(add-to-load-path "~/.emacs.d/elisp"
		  "~/.emacs.d/elisp/color-theme"
		  "~/.emacs.d/conf")

(load "init-basic")
(load "init-auto-complete")
(load "init-cmake")
(load "init-gdb")
(load "init-scheme")

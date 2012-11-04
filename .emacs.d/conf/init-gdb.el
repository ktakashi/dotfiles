(setq gdb-many-windows t)
(setq gdb-use-separate-io-buffer t)
(add-hook
 'gdb-mode-hook
 '(lambda ()
    (global-set-key [f2] 'gud-break)
    (global-set-key [f3] 'gud-remove)
    (global-set-key [f4] 'gud-run)
    (global-set-key [f5] 'gud-cont)
    (global-set-key [f6] 'gud-finish)
    (global-set-key [f7] 'gud-display)
    (global-set-key [f8] 'gud-print)
    (global-set-key [f9] 'gud-next)
    (global-set-key [f10] 'gud-step)

    (setq mode-line-format
	  "2:break 3:clear 4:run 5:continue 6:finish 7:display 8:print 9:next 10:step")))

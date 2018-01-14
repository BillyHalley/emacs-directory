(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-enabled-themes (quote (tango-dark))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(require 'package)
(let* ((no-ssl (and (memq system-type '(windows-nt ms-dos))
		    (not (gnutls-available-p))))
       (proto (if no-ssl "http" "https")))
  (add-to-list 'package-archives (cons "melpa-stable" (concat proto "://stable.melpa.org/packages/")) t)
  (when (< emacs-major-version 24)
    ;; For important compatibility libraries like cl-lib
    (add-to-list 'package-archives '("gnu" . (concat proto "://elpa.gnu.org/packages/")))))
(package-initialize)

(add-to-list 'load-path "~/.emacs.d/lisp/")


;; Calendar and Diary
(add-hook 'diary-list-entries-hook 'diary-sort-entries t)
(setq diary-file "~/.emacs.d/diary")
(add-hook 'calendar-load-hook
	  (lambda () (calendar-set-date-style 'european)))

(setq calendar-week-start-day 1
      calendar-day-name-array ["Domenica" "Lunedì" "Martedì" "Mercoledì"
			       "Giovedì" "Venerdì" "Sabato"]
      calendar-month-name-array ["Gennaio" "Febbraio" "Marzo" "Aprile" "Maggio"
				 "Giugno" "Luglio" "Agosto" "Settembre"
				 "Ottobre" "Novembre" "Dicembre"])

;; Line Numbers
(global-linum-mode 1)
(setq linum-format "%4d \u2502 ")

;; Prolog stuff
(autoload 'prolog-mode "prolog" "Major mode for editing Prolog programs." t)
(add-to-list 'auto-mode-alist '("\\.pl\\'" . prolog-mode))

(require 'ediprolog)
(global-set-key [f7] 'ediprolog-dwim)


;; Windows
(require 'windows)
(require 'recentf)

;; -- Load the saved windows automatically on boot
(add-hook 'window-setup-hook 'resume-windows)

;; -- Save place in file
(setq-default save-place t)

;; --  Use this command to quit and save your setup
(define-key ctl-x-map "C" 'see-you-again)

;; -- Set up window saving!! Place at end of .emacs file
(win:startup-with-window)



;;; Load path
(add-to-list 'load-path "~/emacs/site-lisp")
(add-to-list 'load-path "~/emacs/lisp")

;;; Lisp (SLIME) interaction
(setq inferior-lisp-program "/usr/local/bin/sbcl")
(add-to-list 'load-path "~/.slime")
(require 'slime)
(slime-setup)

;;; Automatic syntax highlighting
(global-font-lock-mode t)

;;; Match parentheses
(show-paren-mode 1)

;;; Correctly indent lisp code
(add-hook 'lisp-mode-hook '(lambda ()
   (local-set-key (kbd "RET") 'newline-and-indent)))

;;; Transient mark mode
(transient-mark-mode)

;;; Autoindent
(define-key global-map (kbd "RET") 'newline-and-indent)
(add-hook 'f90-mode-hook
	    (lambda () (local-set-key (kbd "RET") 'reindent-then-newline-and-indent)))


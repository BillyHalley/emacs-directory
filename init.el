(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-faces-vector
   [default default default italic underline success warning error])
 '(ansi-color-names-vector
   ["#212526" "#ff4b4b" "#b4fa70" "#fce94f" "#729fcf" "#e090d7" "#8cc4ff" "#eeeeec"])
 '(ansi-term-color-vector
   [unspecified "#2e2e2e" "#bc8383" "#7f9f7f" "#d0bf8f" "#6ca0a3" "#dc8cc3" "#8cd0d3" "#b6b6b6"])
 '(custom-enabled-themes (quote (custom-tango-dark)))
 '(custom-safe-themes
   (quote
    ("5e3f1b0c80e2f16f137a944ad601edc51a6441173e89d6c021bad582ff5bc312" "c8e0b45383d094ed9b818cdd02381cf6251f6efca83c98c4bff67eb91e61ff9f" "88bc19a48aff3dd8097c87161986c2650e0e90ad671a3ac4bb68d0565317c37b" "69b3ba0d5b9e664124cd4a46f302713cb879fb54d61948de27fe81c33da5c4f9" "9371d4ab88d660529e7ca6160df597e5179384876220c26a8ffc1c565daa0cde" "9281b67d98e7fb02db46831e0223480d84ce083d7b40d5d84b5805dbc6ee3797" "a67b6cb65db241e033b6aed5eeaf0805a1b62e598cedc605c71d003a1d5c00c6" "7e47ded9f23f6b4c069f19569935efdc5ac8811e0854bf64ca94bdb20ad7b929" "971f0e2533cd75c460e137538110b4ccc6057d846f6b5c34e6ab4776e298823c" "1a094b79734450a146b0c43afb6c669045d7a8a5c28bc0210aba28d36f85d86f" default)))
 '(custom-theme-directory "~/.emacs.d/themes"))
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
  ;; Comment/uncomment these two lines to enable/disable MELPA and MELPA Stable as desired
  (add-to-list 'package-archives (cons "melpa" (concat proto "://melpa.org/packages/")) t)
  ;;(add-to-list 'package-archives (cons "melpa-stable" (concat proto "://stable.melpa.org/packages/")) t)
  (when (< emacs-major-version 24)
    ;; For important compatibility libraries like cl-lib
    (add-to-list 'package-archives '("gnu" . (concat proto "://elpa.gnu.org/packages/")))))
(package-initialize)

(add-to-list 'load-path "~/.emacs.d/lisp/")

;; Setup load-path, autoloads and your lisp system
;; Not needed if you install SLIME via MELPA
(add-to-list 'load-path "~/.emacs.d/slime")
(require 'slime-autoloads)
(setq inferior-lisp-program "/opt/sbcl/bin/sbcl")


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


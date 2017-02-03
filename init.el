;;;------------------------------------
;;; Tested on Emacs 23.1, 24.3.1
;;;
;;; Aims to maximize the productivity
;;; while minimize the package to be installed 
;;; and configuration steps
;;;------------------------------------


;;;-----------------------------------
;;; OS-Level Setup:
;;;
;;; 1. Change the cursor type to "block" for terminal simulator
;;;    and set the color of cursor to #AF1212 (R:175, G:18, B:18)
;;;
;;;
;;;-----------------------------------

;;------------------------------------
;; Emacs System
;;------------------------------------

;; Mac specific setup
(cond
 ((string-equal system-type "darwin") ; mac OSX
  ;; We want to emacs able to find 'gdb' under $HOME/bin (i.e. /Users/zeyuan/bin)
  ;; the 'gdb' under 'bin' is a symbolic soft link to the 'ggdb', which is gdb installed via macports
  (setenv "PATH" "/Users/zeyuan/bin:$PATH" t)
  (add-to-list 'exec-path "/Users/zeyuan/bin")
  ))

; Want Emacs to automatically run a server on startup if it's not running
(load "server")
(unless (server-running-p) (server-start))

; Load package.el for emacs version lower than 24
(when (< emacs-major-version 24)
    (load
      (expand-file-name "~/.emacs.d/package.el")
    )
)
(require 'package) ; import package
(add-to-list 'package-archives
              '("melpa" . "https://melpa.org/packages/"))
(when (< emacs-major-version 24)
   ; For important compatibility libraries like cl-lib
   (add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/")))
(package-initialize) ; initialize package

; Start emacs ido mode on default
(setq ido-enable-flex-matching t)
(setq ido-everywhere t)
(ido-mode 1)

; use graphviz-dot-mode
(add-to-list 'auto-mode-alist '("\\.dot\\'" . graphviz-dot-mode))

; load the theme
(load-theme 'manoj-dark)

; Disable menu bar
(menu-bar-mode -1)

; Disable tool bar
(when (fboundp 'tool-bar-mode)
  (tool-bar-mode -1))

; Disable scroll bar
(when (fboundp 'scroll-bar-mode)
  (scroll-bar-mode -1))

; Enable default Wind Move keybindings
; (i.e. S-right move point to the right window to the current frame)
; note: this disable shift selection
(when (fboundp 'windmove-default-keybindings)
  (windmove-default-keybindings))

; Auto show completions for execute-extended-command
(icomplete-mode 1)

; Disable Emacs welcome screen
(setq inhibit-startup-message t)

; Enable "Which function mode". It will show you which function cursor is in
(which-function-mode 1)

; Set font type & size
'(default ((t (:height 140 :family "DejaVu Sans Mono")))) ;notice, the value is in 1/10pt, so 120 will be 12pt
(set-face-attribute 'default nil :height 160)

; Keep a list of recently opened files
(recentf-mode 1)

; Highlights the matching pair when the point is over parentheses
(show-paren-mode 1)

; Deactive tabs to be used for indentation (force myself to use space for indentation)
(setq-default indent-tabs-mode nil)

; Make whitespace-mode use just basic coloring
(setq whitespace-style (quote (spaces tabs newline space-mark tab-mark newline-mark)))

; Differentiate two names when files are the same
(require 'uniquify)
(custom-set-variables
 '(delete-selection-mode nil)
 '(scroll-bar-mode (quote right))
 '(uniquify-buffer-name-style (quote forward) nil (uniquify)))

; Forces the messages to 0, and kills the *Messages* buffer - thus disabling it on startup.
(setq-default message-log-max nil)
(kill-buffer "*Messages*")

; Activates the auto-comple mode and enable AC mode everywhere
(require 'auto-complete)
(global-auto-complete-mode t)
(defun auto-complete-mode-maybe ()
 (auto-complete-mode 1))

;; Makes *scratch* empty.
(setq initial-scratch-message "")

;; Removes *scratch* from buffer after the mode has been set.
(defun remove-scratch-buffer ()
  (if (get-buffer "*scratch*")
      (kill-buffer "*scratch*")))
(add-hook 'after-change-major-mode-hook 'remove-scratch-buffer)

;; Removes *messages* from the buffer.
;;(setq-default message-log-max nil)
;;(kill-buffer "*Messages*")

;; Removes *Completions* from buffer after you've opened a file.
(add-hook 'minibuffer-exit-hook
          '(lambda ()
             (let ((buffer "*Completions*"))
               (and (get-buffer buffer)
                    (kill-buffer buffer)))))

;; Don't show *Buffer list* when opening multiple files at the same time.
(setq inhibit-startup-buffer-menu t)

;; Show only one active window when opening multiple files at the same time.
(add-hook 'window-setup-hook 'delete-other-windows)


;;------------------------------------
;; Key bindings
;;------------------------------------

(global-set-key (kbd "C-x C-b") 'ibuffer) ; replace "list-buffers" with "ibuffer"
(global-set-key (kbd "<f8>") 'execute-extended-command) ; bind with 'M-x' by default
;(global-set-key "\C-m" 'newline-and-indent) ; make Emacs auto-indent my C code 
(global-set-key (kbd "<home>") 'move-beginning-of-line)
(global-set-key (kbd "<end>") 'move-end-of-line)
(global-set-key (kbd "<f4>") 'undo)
(global-set-key (kbd "<f5>") 'yank)
(global-set-key (kbd "<f6>") 'kill-region)


;;------------------------------------
;; Make frequently used commands short
;;------------------------------------

(defalias 'lml 'list-matching-lines)
(defalias 'gl 'goto-line)
(defalias 'rs 'replace-string)
(defalias 'qrr 'query-replace-regexp)
(defalias 'qr 'query-replace)
(defalias 'list-buffers 'ibuffer) ; always use ibuffer
(defalias 'yes-or-no-p 'y-or-n-p) ; y or n is enough
(defalias 'rb 'revert-buffer)
(defalias 'rof 'recentf-open-files) ; list recently opened files
(defalias 'cy 'clipboard-yank); copy the text from clipboard
(defalias 'ck 'clipboard-kill-region); copy the text to clipboard
(defalias 'cr 'comment-region);
(defalias 'ucr 'uncomment-region);

;;----------------------------------
;; Global modes setting
;;----------------------------------

; Please uncomment the following block if you want to turn off electric-indent-mode globally
;(when (fboundp 'electric-indent-mode) 
;   (electric-indent-mode -1))

;;----------------------------------
;; CC modes (C, C++, Java)
;;----------------------------------

(require 'cc-mode)
(setq c-default-style "bsd"); DB2 coding style
(setq-default c-basic-offset 2)

;;----------------------------------
;; Perl
;;----------------------------------

(setq perl-indent-level 2)

; turn off auto indentation (electric-indent-mode) for perl
(defun perl-mode-disable-auto-indent()
 (electric-indent-mode -1))
(add-hook 'perl-mode-hook 'perl-mode-disable-auto-indent)

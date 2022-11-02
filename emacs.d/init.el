;; (package-initialize)

(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/") t)

(load-theme 'solarized-dark t)

(setq-default
 gc-cons-threshold 100000000   ; increase memory limit before running a GC
 global-mark-ring-max 500      ; increase global mark ring size
 mark-ring-max 500             ; increase mark ring size
 kill-ring-max 500             ; increase kill ring size
 inhibit-startup-message t     ; do not show startup message
 inhibit-splash-screen t       ; do not show splash screen
 truncate-lines t              ; truncate lines (instead of wrap)
 indent-tabs-mode nil          ; use spaces to indent
 tab-width 4                   ; tabs appear as 4 spaces
 split-width-threshold 181     ; min width to split window horizontially
 split-height-threshold 120    ; min width to split window vertically
 reb-re-syntax 'string         ; use string syntax for regexp builder
 show-trailing-whitespace t    ; highlight trailing whitespace
 mode-require-final-newline t  ; add a newline to end of file
 kill-whole-line t             ; kill-line and move-up if at start of line
 gdb-many-windows t            ; gdb launch shows all windows
 gdb-show-main t               ; gdb launch shows main function
 abbrev-mode t                 ; enables global abbreviation mode (auto spellcheck fix)
 org-startup-indented t        ; starts org mode in indented mode
 desktop-auto-save-timeout 30  ; saves emacs desktop to disk every 30 seconds
 scroll-step 1
 scroll-conservatively 10000
 )

(column-number-mode t)         ; show column numbers in the mode-line
(delete-selection-mode t)      ; selected region is replaced upon typing new text
(global-hl-line-mode t)        ; highlight current line
(which-function-mode t)        ; show current function in mode bar
(show-paren-mode t)            ; show matching parens
(transient-mark-mode t)        ; enable text highlighting
(global-font-lock-mode t)      ; enable syntax highlighting
(global-display-line-numbers-mode t) ; enable line numbers (replaces old linum-mode)
; (global-linum-mode t)          ; show line numbers in gutter
; (setq linum-format "%4d \u2502 ") ; add separation between the line number gutters and the body text
(global-subword-mode t)        ; enable CamelCase awareness for word-based operations
(global-auto-revert-mode t)    ; automatically sync buffers with disk
(fset 'yes-or-no-p 'y-or-n-p)  ; replace yes/no prompts with y/n
(toggle-save-place-globally t) ; saves place in files between emacs sessions
;; (desktop-save-mode t)          ; saves open buffer list to disk between emacs sessions

(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(set-language-environment "UTF-8")
(prefer-coding-system 'utf-8)

;; (set-default-font "Ubuntu Mono-14")

; (remove-hook 'find-file-hook 'vc-find-file-hook)
; (remove-hook 'find-file-hook 'vc-refresh-state)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   '("7f1d414afda803f3244c6fb4c2c64bea44dac040ed3731ec9d75275b9e831fe5" default))
 '(package-selected-packages
   '(diff-hl git-gutter color-theme-solarized solarized-theme helm dash color-theme)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(hl-line ((t (:underline t)))))


;;;;;;;;;;
;; helm ;;
;;;;;;;;;;
(require 'helm)

; Replace builtin commands with helm equivalents
(global-set-key (kbd "M-x")                          'undefined)           ; must do before remapping M-X
(global-set-key (kbd "M-x")                          'helm-M-x)            ; replace M-x with helm version
(global-set-key (kbd "M-y")                          'helm-show-kill-ring) ; replace M-y with helm version
(global-set-key (kbd "C-x C-f")                      'helm-find-files)     ; replace C-x C-f with helm version
(define-key global-map [remap list-buffers]          'helm-mini)           ; replace C-x C-b with helm version

; Additional helm commands
(global-set-key (kbd "C-c <SPC>")                    'helm-mark-ring)

;;;;;;;;;;;;;;;;
;; git-gutter ;;
;;;;;;;;;;;;;;;;
(require 'git-gutter)

(global-git-gutter-mode t)
(custom-set-variables
 '(git-gutter:modified-sign ">>")
 '(git-gutter:added-sign "++")
 '(git-gutter:deleted-sign "--")
 '(git-gutter:unchanged-sign "  ")
 '(git-gutter:separator-sign "|"))
(set-face-foreground 'git-gutter:separator "#657b83") ; solarized-base00
(set-face-background 'git-gutter:unchanged "#073642") ; solarized-base02

(set-face-background 'git-gutter:modified "#b58900") ; solarized-yellow
(set-face-foreground 'git-gutter:modified "black")

(set-face-background 'git-gutter:added "#859900") ; solarized-green
(set-face-foreground 'git-gutter:added "black")

(set-face-background 'git-gutter:deleted "#dc322f") ; solarized-red
(set-face-foreground 'git-gutter:deleted "black")

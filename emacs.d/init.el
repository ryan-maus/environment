(require 'package)
(add-to-list 'package-archives '("melpastable" . "http://stable.melpa.org/packages/") t)
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/") t)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   '(helm-projectile helm-rg projectile undo-tree avy goto-last-change git-gutter expand-region multiple-cursors blamer company dap-mode flycheck helm helm-lsp helm-xref use-package which-key lsp-treemacs lsp-ui solarized-theme lsp-mode)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

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
(global-subword-mode t)        ; enable CamelCase awareness for word-based operations
(global-auto-revert-mode t)    ; automatically sync buffers with disk
(fset 'yes-or-no-p 'y-or-n-p)  ; replace yes/no prompts with y/n
(toggle-save-place-globally t) ; saves place in files between emacs sessions
;; (desktop-save-mode t)          ; saves open buffer list to disk between emacs sessions

(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(set-language-environment "UTF-8")
(prefer-coding-system 'utf-8)


;;;;;;;;;;
;; helm ;;
;;;;;;;;;;
(use-package helm)

; Replace builtin commands with helm equivalents
(global-set-key (kbd "M-x")                 'undefined)           ; must do before remapping M-X
(global-set-key (kbd "M-x")                 'helm-M-x)            ; replace M-x with helm version
(global-set-key (kbd "M-y")                 'helm-show-kill-ring) ; replace M-y with helm version
(define-key global-map [remap list-buffers] 'helm-mini)           ; replace C-x C-b with helm version
(global-set-key (kbd "C-c x")               'helm-mark-ring)      ; show recent marks
(global-set-key (kbd "C-x C-f")             'helm-find-files)


;;;;;;;;;;;;;
;; company ;;
;;;;;;;;;;;;;
(use-package company)

(add-hook 'after-init-hook 'global-company-mode)

;;;;;;;;;;;;;;;;;;;;;;;
;; LSP configuration ;;
;;;;;;;;;;;;;;;;;;;;;;;
(use-package lsp-mode
  :commands (lsp lsp-deferred)
  :init (setq
         lsp-keymap-prefix "C-c l"
         lsp-idle-delay 0.1)
  :hook ((c++-mode . lsp-deferred)
         (c-mode . lsp-deferred)
         (lsp-mode . lsp-enable-which-key-integration))
  :bind (("M-/" . company-complete))
)

(use-package lsp-ui
  :commands lsp-ui-mode
  )

(use-package helm-lsp
  :commands helm-lsp-workspace-symbol
  )

(use-package treemacs)
(use-package lsp-treemacs
  :commands lsp-treemacs-errors-list
  )

(use-package dap-mode)

(use-package dap-cpptools)

(use-package which-key
  :config (which-key-mode)
  )


;;;;;;;;;;;;
;; Blamer ;;
;;;;;;;;;;;;
(use-package blamer
  :ensure t
  :defer 20
  :custom
  (blamer-idle-time 0.5)
  (blamer-min-offset 70)
  :custom-face
  (blamer-face ((t :foreground "#7a88cf"
                    :background nil
                    :height 140
                    :italic t)))
  :config
  (global-blamer-mode 1))
(global-set-key (kbd "C-c i") 'blamer-show-commit-info)
(setq blamer-max-commit-message-length 120)


;;;;;;;;;;;;;;;;;;;;;;
;; multiple-cursors ;;
;;;;;;;;;;;;;;;;;;;;;;
(use-package multiple-cursors)

(global-set-key (kbd "C-c .") 'mc/mark-next-like-this)


;;;;;;;;;;;;;;;;;;;
;; expand-region ;;
;;;;;;;;;;;;;;;;;;;
(use-package expand-region)

(global-set-key (kbd "C-c =") 'er/expand-region)


;;;;;;;;;;;;;;;;
;; git-gutter ;;
;;;;;;;;;;;;;;;;
(use-package git-gutter
  :init (setq
         git-gutter:added-sign "++"
         git-gutter:deleted-sign "--"
         git-gutter:modified-sign ">>"
         git-gutter:separator-sign "|"
         git-gutter:unchanged-sign "  ")
  :config (set-face-foreground 'git-gutter:separator "#657b83") ; solarized-base00
          (set-face-background 'git-gutter:unchanged "#073642") ; solarized-base02
          (set-face-background 'git-gutter:modified "#b58900") ; solarized-yellow
          (set-face-foreground 'git-gutter:modified "black")
          (set-face-background 'git-gutter:added "#859900") ; solarized-green
          (set-face-foreground 'git-gutter:added "black")
          (set-face-background 'git-gutter:deleted "#dc322f") ; solarized-red
          (set-face-foreground 'git-gutter:deleted "black")
  )
(global-git-gutter-mode t)


;;;;;;;;;;;;;;;;;;;;;;
;; goto-last-change ;;
;;;;;;;;;;;;;;;;;;;;;;
(use-package goto-last-change)

(global-set-key (kbd "C-q") 'goto-last-change)


;;;;;;;;;
;; avy ;;
;;;;;;;;;
(use-package avy)

(global-set-key (kbd "C-c SPC") 'avy-goto-char-timer)
(global-set-key (kbd "C-x o") 'ace-window)


;;;;;;;;;;;;;;;
;; undo-tree ;;
;;;;;;;;;;;;;;;
(use-package undo-tree
  :init (setq
         undo-tree-visualizer-diff t
         undo-tree-visualizer-timestamps t)
  :bind (("C-c /" . undo-tree-visualize))
  )
(global-undo-tree-mode)


;;;;;;;;;;;;;;;;
;; projectile ;;
;;;;;;;;;;;;;;;;
(use-package projectile
  :bind (("C-c s" . helm-projectile-rg)
         ("C-c f" . helm-projectile-find-file))
  )

(use-package helm-projectile)

(projectile-mode +1)
;(define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map)


;;;;;;;;;;;;;;;;;;;;
;; electric-pairs ;;
;;;;;;;;;;;;;;;;;;;;
(electric-pair-mode 1)
(setq electric-pair-pairs
      '((?\' . ?\')
        (?\{ . ?\})))

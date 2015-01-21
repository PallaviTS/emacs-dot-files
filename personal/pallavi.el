;; F11 = Full Screen
(defun toggle-fullscreen (&optional f)
  (interactive)
  (let ((current-value (frame-parameter nil 'fullscreen)))
    (set-frame-parameter nil 'fullscreen
                         (if (equal 'fullboth current-value)
                             (if (boundp 'old-fullscreen) old-fullscreen nil)
                           (progn (setq old-fullscreen current-value)
                                  'fullboth)))))
(global-set-key [f4] 'toggle-fullscreen)

;; Disable tool-bar
(tool-bar-mode -1)

;; Disable Menu Bar
(menu-bar-mode t)

(defun disable-guru-mode ()
  (guru-mode -1)
  )
(add-hook 'prelude-prog-mode-hook 'disable-guru-mode t)

(global-linum-mode +1)
;; revert the current buffer
(defun refresh-file ()
  (interactive)
  (revert-buffer t t t))
(global-set-key [f5] 'refresh-file)

;; projectile settings
(define-key projectile-mode-map [?\s-d] 'projectile-find-dir)
(define-key projectile-mode-map [?\s-p] 'projectile-switch-project)
(define-key projectile-mode-map [?\s-f] 'projectile-find-file)
(define-key projectile-mode-map [?\s-g] 'projectile-grep)

;; toggle screen
;;(global-set-key (kbd "M-n") 'toggle-fullscreen)

;; comment and uncomment
(global-set-key (kbd "M-/") 'comment-or-uncomment-region)

;; set screen dimensions for mac
;; (set-frame-size (selected-frame) 160 52)

(prelude-require-package 'key-chord)
(key-chord-mode 1)
(key-chord-define-global "uu" 'ag-project)
(key-chord-define-global "qq" 'ag-project-at-point)
(key-chord-define-global "jj" 'ace-jump-word-mode)
(key-chord-define-global "jk" 'ace-jump-char-mode)
(key-chord-define-global "jl" 'ace-jump-line-mode)
(key-chord-define-global "JJ" 'prelude-switch-to-previous-buffer)
(key-chord-define-global "yy" 'browse-kill-ring)

;; robe mode
(add-hook 'ruby-mode-hook 'robe-mode)

;;load theme
;(load-theme 'solarized-dark t)
(add-hook 'find-file-hook (lambda () (linum-mode 1)))
(add-hook 'find-file-hook (lambda () (adaptive-wrap-prefix-mode 1)))
(add-hook 'find-file-hook (lambda () (visual-line-mode 1)))

(add-hook 'pallavi-code-modes-hook
          (lambda () (linum-mode 1)))
(add-hook 'ruby-mode-hook
          (lambda () (run-hooks 'pallavi-code-modes-hook)))

(set-frame-font "Monaco 15")

;; Display continuous lines
(setq-default truncate-lines nil)

;; Prettify yml
(require 'yaml-mode)
(add-to-list 'auto-mode-alist '("\\.yml$" . yaml-mode))
;; Truncate
(setq-default truncate-partial-width-windows nil)
;; Set cursor to color
(set-cursor-color "red")

(setq default-frame-alist
      '((cursor-color . "red")))

;; Enable copy and pasting from clipboard
(setq x-select-enable-clipboard t)

;;some custom functions, stolen for internet
(defun geosoft-forward-word ()
  ;; Move one word forward. Leave the pointer at start of word
  ;; instead of emacs default end of word. Treat _ as part of word
  (interactive)
  (forward-char 1)
  (backward-word 1)
  (forward-word 2)
  (backward-word 1)
  (backward-char 1)
  (cond ((looking-at "_") (forward-char 1) (geosoft-forward-word))
        (t (forward-char 1))))
(defun geosoft-backward-word ()
  ;; Move one word backward. Leave the pointer at start of word
  ;; Treat _ as part of word
  (interactive)
  (backward-word 1)
  (backward-char 1)
  (cond ((looking-at "_") (geosoft-backward-word))
        (t (forward-char 1))))

(global-set-key [C-right] 'geosoft-forward-word)
(global-set-key [C-left] 'geosoft-backward-word)

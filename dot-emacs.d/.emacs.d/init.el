(require 'package)
(setq package-enable-at-startup nil)
(add-to-list 'package-archives
	     '("melpa" . "https://melpa.org/packages/"))
(package-initialize)
;; Bootstrap `use-package'
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(setq-default inhibit-startup-message t ; don't show default emacs startup screen
 window-combination-resize t            ; Resize windows proportionally
 display-time-default-load-average nil  ; don't show system load time in modeline
 indent-tabs-mode nil                   ; stop using tabs to indent
 indent-tabs-mode nil 			        ; use spaces not tab
 tab-width 4 				            ; change default tab width
 )

;; toggle features that are turned off in a fresh Emacs install
(put 'downcase-region 'disabled nil) ; allow me to use C-x C-l (downcase region)
(put 'upcase-region 'disabled nil) ; allow me to use C-x C-u (capitalize
(put 'narrow-to-region 'disabled nil) 	; allow me to narrow to region

;; Tweaking Registers

;; Useful Register setup when appending/prepending
(setq register-separator ?+)
(set-register register-separator "\n\n")

;; Useful functionality
(add-hook 'before-save-hook 'delete-trailing-whitespace) ; remove trailing whitespace on save
(add-hook 'after-save-hook
  ;; Emacs will make a script file executable if it decides it is one
  'executable-make-buffer-file-executable-if-script-p)

(tool-bar-mode -1)			; remove toolbar
(menu-bar-mode -1)			; delete menu bar
(scroll-bar-mode -1) 			; remove scroll bar

;; Prompts that require 'yes' or 'no' accept 'y' or 'n'
(fset 'yes-or-no-p 'y-or-n-p)

;; Remember cursor position, for emacs 25.1 or later
(save-place-mode 1)

(display-time-mode 1) ; display time in modeline

(setq ns-pop-up-frames nil       ; open files in an exising frame
  )

(blink-cursor-mode 0)			; stop cursor blinking
(global-hl-line-mode +1)		; highlight current active line

;; Change default hl-line face
(with-eval-after-load 'hl-line
  (set-face-background 'hl-line "#f0f5ff"))

;; Add some minor color theme
(set-face-attribute 'default nil :background "floral white")
(set-face-attribute 'font-lock-comment-face nil :foreground "DarkSeaGreen4")
(set-face-background 'region "LightSteelBlue")

;; jump to file useful for opening imgs in html 'img' tag
(global-set-key (kbd "<f8>") 'find-file-at-point)
(global-set-key (kbd "<C-M-return>") 'delete-other-windows)

;; s-z for commonly used keys
(define-prefix-command 'my-super-z-map)
(global-set-key (kbd "C-z") 'my-super-z-map)

;; (define-key my-super-z-map (kbd "f") 'counsel-rg)	   ; find in current working directory

(define-key my-super-z-map (kbd "o") 'browse-url-at-point)
(define-key my-super-z-map (kbd "r") 'revert-buffer)
(define-key my-super-z-map (kbd "a") 'add-file-local-variable-prop-line)

(setq dired-recursive-copies (quote always) ; “always” means no asking
      dired-recursive-deletes (quote top) ; “top” means ask once
      dired-dwim-target t)

(add-hook 'dired-mode-hook '(lambda ()
                              (dired-hide-details-mode 1)))

(put 'dired-find-alternate-file 'disabled nil)

;; (define-prefix-command 'my/magit-prefix-key)
;; (global-set-key (kbd "C-c m") 'my/magit-prefix-key)

;; (define-key my/magit-prefix-key (kbd "s") 'magit-status)
;; (define-key my/magit-prefix-key (kbd "d") 'magit-dispatch)
;; (define-key my/magit-prefix-key (kbd "c") 'magit-clone)
;; (define-key my/magit-prefix-key (kbd "i") 'magit-init)

;; (setq magit-completing-read-function 'ivy-completing-read)



;; (add-hook 'after-init-hook 'global-company-mode)

;; ;; With this code, yasnippet will expand the snippet if company didn't complete the word
;; ;; replace company-complete-common with company-complete if you're using it
;; ;; https://gist.github.com/sebastiencs/a16ea58b2d23e2ea52f62fcce70f4073
;; (advice-add 'company-complete :before (lambda () (setq my-company-point (point))))
;; (advice-add 'company-complete :after (lambda ()
;;                      (when (equal my-company-point (point))
;;                        (yas-expand))))
;; (with-eval-after-load 'company
;;     (setq company-echo-delay 0   ; disable the delay
;;       company-idle-delay 0
;;       company-tooltip-limit 10
;;       company-tooltip-align-annotations t
;;       company-minimum-prefix-length 2))


;; (setq python-shell-interpreter "python3"
;;   python-indent-offset 4)

;; (elpy-enable)


;; (defun pyvenv-venv-dwim ()
;;   "Ask to activate a virtual environment or deactivate one if active."
;;   (interactive)
;;   (if pyvenv-virtual-env
;;       (pyvenv-deactivate)
;;     (call-interactively 'pyvenv-activate)))



;; (add-hook 'js-mode-hook 'js2-minor-mode)
;; (add-to-list 'interpreter-mode-alist '("node" . js2-mode)) ; hook it in for shell scripts running via node.js
;; (setq js-indent-level 2
;;       js-chain-indent t)



;; (setq geiser-mode-auto-p nil) ; don't automatically load geiser in scheme buffers


;; ;; Set up for Skribilo files
;; (add-to-list 'auto-mode-alist '("\\.skr\\'" . scheme-mode))
;; (autoload 'skribe-mode "skribe.el" "Skribe mode." t)

;; show-paren-mode t) ; toggle highlighting matching paren

;; (electric-layout-mode 1)  ; adds electricity after inserting chars e.g. in  js ';' starts new line

;; (electric-indent-mode +1) ; toggle on the fly re-indentation

;; ;; Electric Pairs
;; (add-hook 'mhtml-mode-hook 'electric-pair-local-mode)
;; (add-hook 'emacs-lisp-mode-hook 'electric-pair-local-mode)
;; (add-hook 'clojure-mode-hook 'electric-pair-local-mode)
;; (add-hook 'lisp-interaction-mode-hook 'electric-pair-local-mode)
;; (add-hook 'web-mode-hook 'electric-pair-local-mode)
;; (add-hook 'ielm-mode-hook 'electric-pair-local-mode)
;; (add-hook 'js-mode-hook 'electric-pair-local-mode)
;; (add-hook 'org-mode-hook 'electric-pair-local-mode)
;; (add-hook 'scheme-mode-hook 'electric-pair-local-mode)
;; (add-hook 'python-mode-hook 'electric-pair-local-mode)
;; (add-hook 'css-mode-hook 'electric-pair-local-mode)
;; (add-hook 'less-css-mode-hook 'electric-pair-local-mode)

;; ;; add extra pairs for org mode
;; (defvar org-electric-pairs '((?/ . ?/) (?= . ?=)) "Electric pairs for org-mode.")
;; (defun org-add-electric-pairs ()
;;   (setq-local electric-pair-pairs (append electric-pair-pairs org-electric-pairs))
;;   (setq-local electric-pair-text-pairs electric-pair-pairs))
;; (add-hook 'org-mode-hook 'org-add-electric-pairs)

;; ;; add extra pairs for js-mode
;; (defvar js-mode-electric-pairs '((?` . ?`)) "Electric pairs for js-mode.")
;; (defun js-mode-add-electric-pairs ()
;;   (setq-local electric-pair-pairs (append electric-pair-pairs js-mode-electric-pairs))
;;   (setq-local electric-pair-text-pairs electric-pair-pairs))
;; (add-hook 'js-mode-hook 'js-mode-add-electric-pairs)
;; (add-hook 'mhtml-mode-hook 'js-mode-add-electric-pairs) ; needs it for `script` tags

;; ;; add extra pairs for web mode (jinja)
;; (defvar web-mode-jinja-electric-pairs '((?% . ?%)) "Electric pairs for web-mode.")
;; (defun web-mode-add-jinja-electric-pairs ()
;;   (setq-local electric-pair-pairs (append electric-pair-pairs web-mode-jinja-electric-pairs)))
;; (add-hook 'web-mode-hook 'web-mode-add-jinja-electric-pairs)

;; ;; Subword Mode
;; (add-hook 'js-mode-hook 'subword-mode)
;; (add-hook 'c-mode-hook 'subword-mode)
;; (add-hook 'c++-mode-hook 'subword-mode)
;; (add-hook 'clojure-mode-hook 'subword-mode)

(global-prettify-symbols-mode t)

(defun my-add-pretty-lambda ()
    "Make some word or string show as pretty Unicode symbols"
    (push '("lambda" . 955) prettify-symbols-alist)	      ; λ
    (push '("->" . 8594) prettify-symbols-alist)              ; →
    (push '("=>" . 8658) prettify-symbols-alist)              ; ⇒
    (push '("map" . 8614) prettify-symbols-alist) 	      ; ↦
	        )

(add-hook 'tex-mode-hook 'my-add-pretty-lambda)

(add-hook 'js-mode-hook (lambda ()
			      "Beautify Javascript Keywords"
			      (my-add-pretty-lambda)))

(add-hook 'org-mode-hook (lambda ()
			       "Beautify Org Checkbox Symbol"
			       (push '("[ ]" .  "▢") prettify-symbols-alist)
			       (push '("*" .  "◉") prettify-symbols-alist)
			       (push '("[X]" . "☑" ) prettify-symbols-alist)
			       (push '("[-]" . "❍" ) prettify-symbols-alist)))

(add-hook 'emacs-lisp-mode-hook
	      (lambda ()
	        "Beautify Emacs Symbols"
	        (push '("<=" . "≤") prettify-symbols-alist)))
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages (quote (use-package))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

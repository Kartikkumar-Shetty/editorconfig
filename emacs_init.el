;; this is a init code for the eamcs text editor enivronment
;; this is a init code for the eamcs text editor enivronment

;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
;;Custom code added to load the melpa packages.
(require 'package)
(setq package-enable-at-startup nil)
(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/"))

(package-initialize)

;;Treemacsd use-packages package
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))


(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:inherit nil :stipple nil :background "#141414" :foreground "#F8F8F2" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 100 :width normal :foundry "CF  " :family "Ubuntu Mono"))))
 '(auto-dim-other-buffers-face ((t (:background "#141414")))))


(set-background-color "#141414")
;;This is to change the defualt window to scratch buffer
;;(add-hook 'window-setup-hook 'on-after-init)


;;Remove the toolbar and menubar
(tool-bar-mode -1)
(menu-bar-mode -1)

;;Setting up mydefualt shell as bash
(defvar my-term-shell "/bin/bash")
(defadvice ansi-term (before force-bash)
  (interactive (list my-term-shell)))
(ad-activate 'ansi-term)

;;ad alias for yes or no
(defalias 'yes-or-no-p 'y-or-n-p)

;;set a shortcut for the terminal
(global-set-key (kbd "<s-return>") 'ansi-term)

;;scrolling os too much, lets reduce it to scroll line by line
(setq scroll-conservatively 100)
(scroll-bar-mode -1)

;;disable ring bell function
(setq ring-bell-function 'ignore)

;;highlight the line where the cusror is
;;highlight only when using the gui that is windows system not when
;;emacs is opened in the terminal mode
(when window-system (global-hl-line-mode t))

;;enable highlight for terminal as well
(global-hl-line-mode t)

;;dont change the forecolor of the current line
(when window-system (set-face-foreground 'highlight nil))

;;make the font face bold of the current line
(when window-system (set-face-bold 'highlight 1))

(when window-system (set-face-background 'highlight "#222222"))

;;lambda and other pretty symbols will get printed
(when window-system (global-prettify-symbols-mode t))


;;disable autosaving and backup of unsaved files
(setq make-backup-file nil)
(setq auto-save-default nil)

;;show a beacon where the cusrsor is present
(use-package beacon
  :ensure t
  :init
  (beacon-mode 1))


;;Enable ido mode
(setq ido-enable-flex-matching nil)
(setq ido-create-new-buffer 'always)
(setq ido-everywhere t)
(ido-mode 1)
;;set ido mode to vertical
(use-package ido-vertical-mode
  :ensure t
  :init
  (ido-vertical-mode 1))

;;enable ido mode files traversing with C-n C-p
(setq ido-vertical-define-keys 'C-n-and-C-p-only)

;;installl smex that will show u M-x function suggestions, check for alternates to smex
(use-package smex
  :ensure t
  :init  (smex-initialize)
  :bind  ("M-x" . smex))


;; enable ibuffer to make witiching buffers easy:
;;there is an expert mode that helps you delete files without prompting for a yes or no, activte it later
(global-set-key (kbd "C-x b") 'ibuffer)
(global-set-key (kbd "<C-tab>") 'ibuffer)

;;enable ido for buffer list
(global-set-key (kbd "C-x C-b") 'ido-switch-buffer)

;;enable AVY this lets you search for a particular latters and go to them in a jiffy
(use-package avy
  :ensure t
  :bind
  ("M-s" . avy-goto-word-1))


;;highlight the hex color code to the color of the hex value using Rainbow package e.g. #00FF00
(use-package rainbow-delimiters
  :ensure t)
(use-package highlight-parentheses
  :ensure t)
(highlight-parentheses-mode)

;;Adding efficient window switch package called switch Window
(use-package switch-window
  :ensure t
  :config
  (setq switch-window-input-style 'minibuffer)
  (setq switch-window-increase 4)
  (setq switch-window-threshold 2)
  :bind
  ([remap other-window] . switch-window))

(global-set-key [remap other-window] 'switch-window)
(setq switch-window-shortcut-style 'qwerty)
(setq switch-window-qwerty-shortcuts
      '("a" "s" "d" "f" "j" "k" "l" ";" "w" "e" "i" "o"))

;;Sortcut to switch frames along with C-x o
(global-set-key (kbd "C-x C-o") 'other-window)

;;autocomplete the parentheses and others
(setq electric-pair-pairs '(
                           (?\( . ?\))
                           (?\[ . ?\])
                           (?\" . ?\")
                           (?\' . ?\')
                           (?\{ . ?\})
                           ))
(electric-pair-mode t)

;;Killing whole word from anywhere inside the word
(defun kill-whole-word ()
  (interactive)
  (backward-word)
  (kill-word 1))
(global-set-key (kbd "C-c w w") 'kill-whole-word) ;;kill whole word

;;add package to allow sudo edit
(use-package sudo-edit
  :ensure t
  :bind ("s-e" . sudo-edit))


;;showlines and columns
(line-number-mode 1)
(column-number-mode 1)
;;display line number in the margins using nlinum
;; (use-package nlinum
;;   :ensure t
;;   :init(nlinum-mode 1))
(use-package hlinum
  :ensure t)
(hlinum-activate)
(global-linum-mode t)
(setq linum-format "%3d \u2502")

;;kill current buffer on C-x k
(defun kill-cur-buffer ()
  (interactive)
  (kill-buffer (current-buffer)))
(global-set-key (kbd "C-x k") 'kill-cur-buffer)

;;create function to copy a whole line from anywhere inside the line
(defun copy-whole-line ()
  (interactive)
  (save-excursion
    (kill-new
     (buffer-substring
      (point-at-bol)
      (point-at-eol)))))
(global-set-key (kbd "C-c w l") 'copy-whole-line)  ;;copy whole line

;;short cut to kill all buffer: be very careful when using this

(defun kill-all-buffers ()
  (interactive)
  (mapc 'kill-buffer (buffer-list)))
(global-set-key (kbd "C-M-s-k") 'kill-all-buffers)

;;highight the rounf=d brackets to keep track of if all all closed, using rainbow package
(use-package rainbow-delimiters
  :ensure t)



;;create you own startup screen and dashboard
(use-package dashboard
  :ensure t
  :config
  (dashboard-setup-startup-hook)
  (setq dashboard-items '((recents . 10)))
  (setq dashboard-banner-logo-title "Welcome,  Master K")
  (setq dashboard-startup-banner "/home/kartik/Pictures/gnu.png"))

;;show clock
(setq display-time-24hr-format t)
(display-time-mode t)


;;adding dmenu , shows menu in the minibuffer
(use-package dmenu
  :ensure t
  :bind
  ("s-SPC" . 'dmenu))


;;add package symn, that shows the metrics on memory and cpu utilization
(use-package symon
  :ensure t
  :bind
  ("s-h" . symon-mode))

;;you can run emacs as an desktop manager refere to lecture 14


;;display kill-ring so that we can select which selected text we want to paste
;;using Meta-y (from the cipboard)
(use-package popup-kill-ring
  :ensure t
  :bind ("M-y" . popup-kill-ring))

;;macro allows you to record keystrkes and replay them.press  F3 to start and F4 to
;;end the macro, every time you press F4 it will repeat.
;;you can have multiple macros as well.you can also use C-u number F4
;; the macro can be saved using M-x name-last-kbd-macro and then use M-x to invoke it.
;;the macro will be gone on reopening emacs, the other function insert-kbd-macro helps us get the deleted macro back.
;;Macro for increase sequence numbers lie excel F3 0 F3
;;emacs records functions(which is tracking on keystrokes)
;; also look at kmacro

;;project-explorer installation
(use-package treemacs
  :ensure t
  :bind
  ("C-x C-p" . treemacs)
  ("C-c 0" . treemacs-select-window))
(setq treemacs-filewatch-mode t)
(setq treemacs-indentation-string " ")
(setq treemacs-no-png-images t)
(setq treemacs-fringe-indicator-mode t)
(setq treemacs-git-mode 'extended)
(setq treemacs-show-hidden-files t)
(setq treemacs-sorting 'alphabetic-asc)
(setq treemacs-recenter-after-file-follow t)
(setq split-width-threshold 0)




(use-package treemacs-projectile
  :after treemacs projectile
  :ensure t)

;frame border
(fringe-mode -1)

;;set cursor mode to bar
(setq cursor-type 'bar)

;;(treemacs-follow-mode 1)

;;ihecsec: help switich between multiple emacs config in case you are woring with multiple programming languages


;;installing Go Packages

;;installing Go mode
(use-package go-mode
  :ensure t)

;;install intellisense for GO
(use-package company
  :ensure t)
(add-hook 'after-init-hook 'global-company-mode)

 (use-package company-go
   :ensure t
   :bind
   ("C-c <SPC>" . company-go))

 (setq company-tooltip-limit 20)                      ; bigger popup window
 (setq company-idle-delay .3)                         ; decrease delay before autocompletion popup shows
 (setq company-echo-delay 0)                          ; remove annoying blinking
 (setq company-begin-commands '(self-insert-command)) ; start autocompletion only after typing
 (setq company-tooltip-align-annotations 't)
 (setq global-auto-complete-mode 't)

 (use-package company-quickhelp
   :ensure t)
 (company-quickhelp-mode)

;;install gotags from command line for this
;;go-direx installation, shows meta data of the file i.e. list of variables, functions etc
(use-package go-direx
  :ensure t)
;;go-direx-pop-to-buffer run this command to  see the mesta data of the file
;;(define-key go-mode-map (kbd "C-c C-j") 'go-direx-pop-to-buffer) un comment if the bind above does not work

(use-package popwin
  :ensure t)
(setq display-buffer-function 'popwin:display-buffer)

;;Installing go-eldoc, provides information about symbols on which the cursor is
(use-package go-eldoc
  :ensure t)
(add-hook 'go-mode-hook 'go-eldoc-setup)

;;(define-key go-mode-map (kbd "C-c C-t") 'go-add-tags)


;;install package go-delve for debugging
(use-package go-dlv
:ensure t)

;;Adds JSON, YAML, TOML, HCL tags on struct fields
(use-package go-add-tags
  :ensure t
  :bind
  ("C-c C-t" . 'go-add-tags))


;;GO LANG Error Checks, may be like build
(use-package go-errcheck
  :ensure t)


;;Fill the instance of Struct with the fields
(use-package go-fill-struct
 :ensure t)
;;(defun my-go-fill-struct ()
;;  (interactive)
;;  (local-set-key (kbd "C-c C-e") 'go-fill-struct))
;;(add-hook 'go-mode-hook 'my-go-fill-struct)


;;Installs go-gen-test which generates test functions for the selcted functions
(use-package go-gen-test
  :ensure t)
(defun my-go-gen-test-setup ()
  (interactive)
  (local-set-key (kbd "C-c C-g") 'go-gen-test-dwim))
(add-hook 'go-mode-hook 'my-go-gen-test-setup)

;;This package is not required, this package changes the GOPAth for a Buffer i beleive
;;(use-package go-gopath
;;  :ensure t)


;;Setting up go Imports, adds automatic imports after save, can invoke import using the below short cuts
(use-package go-imports
  :ensure t)

(use-package go-guru
  :ensure t)

(use-package golint
  :ensure t)

;;highlights the syntax errors
(use-package flycheck-golangci-lint
  :ensure t
  :hook (go-mode . flycheck-golangci-lint-setup))

(defun go-mode-setup ()
  (go-eldoc-setup)
  (setq gofmt-command "goimports")
  (add-hook 'before-save-hook 'gofmt-before-save)
  (add-hook 'go-mode-hook 'gofmt-before-save)
  (local-set-key (kbd "M-.") 'godef-jump))
(add-hook 'go-mode-hook 'go-mode-setup)

;; (setq gofmt-command "goimports");; instead to gofmt run goimports since goimports runs formatting internally
;; (add-hook 'go-mode-hook 'go-guru-hl-identifier-mode)
;; (add-hook 'go-mode-hook 'go-imports-insert-import)
;; (add-hook 'go-mode-hook 'go-imports-insert-reload-packages-list)
;; (add-hook 'go-mode-hook 'golint)
(add-hook 'go-mode-hook 'rainbow-mode)
(add-hook 'go-mode-hook 'smart-tabs-mode)

(provide 'go-mode-autoloads)
;; (add-hook 'go-mode-hook 'gofmt-before-save)
(add-hook 'before-save-hook 'gofmt-before-save)

(add-hook 'go-mode-hook (lambda ()
                          (set (make-local-variable 'company-backends) '(company-go))
                          (company-mode)))


;;Adding new key for Go-guru-go to defination
(bind-key "C-c j"  'go-guru-definition) ;; for terminal mode


;;Adding go-impl package to impleeent any interface by provideing the interface name and the requred struct name; it seems it works only on go interface and not user defined interfaces
(use-package go-impl
:ensure t)


;;adding package go test
(use-package gotest
  :ensure t)

;;adding go debugger
(use-package go-dlv
  :ensure t)


;;Enable go-mode only for .go file extensions
(add-to-list 'auto-mode-alist '("\\.go\\'" . go-mode))
;;TODO: Packages to be added
;;golint
;;gotest



;;(add-hook 'go-mode-hook 'go-dlv)
;;(add-hook 'go-mode-hook 'go-impl)
;;(add-hook 'before-save-hook 'gofmt-before-save)




;;shortcuts for resizing frames
(global-set-key (kbd "M-<down>") 'shrink-window)
(global-set-key (kbd "M-<up>") 'enlarge-window)
(global-set-key (kbd "M-<left>") 'shrink-window-horizontally)
(global-set-key (kbd "M-<right>") 'enlarge-window-horizontally)


;;shortcuts for cursor movments
(global-set-key (kbd "<C-right>") 'forward-word)
(global-set-key (kbd "<C-left>") 'backward-word)


;;switch frames shortcut
(global-set-key (kbd "C-c <C-up>") 'windmove-up)
(global-set-key (kbd "C-C <C-down>") 'windmove-down)
(global-set-key (kbd "C-c <C-left>") 'windmove-left)
(global-set-key (kbd "C-c <C-right>") 'windmove-right)

(global-set-key (kbd "C-c <up>") 'windmove-up)
(global-set-key (kbd "C-C <down>") 'windmove-down)
(global-set-key (kbd "C-c <left>") 'windmove-left)
(global-set-key (kbd "C-c <right>") 'windmove-right)

(global-set-key (kbd "s-<up>") 'windmove-up)
(global-set-key (kbd "s-<down>") 'windmove-down)
(global-set-key (kbd "s-<left>") 'windmove-left)
(global-set-key (kbd "s-<right>") 'windmove-right)




;; Toggle Comment Uncomment line
 (global-set-key (kbd "C-c .") 'comment-line)

;;refactoring tool for go lang
(use-package godoctor
  :ensure t)



;;scroll in place without moving cursor
(defun kb-scroll-up-hold-cursor ()
  "Scroll up one position in file."
  (interactive)
  (scroll-up-command 1))

(defun kb-scroll-down-hold-cursor ()
  "Scroll down one position in file."
  (interactive)
  (scroll-up-command -1))

;;use these functions if you want to move the cusor with the scroll
(defun kb-scroll-up ()
  "Scroll up one position in file, move cursor with the scroll."
  (interactive)
  (scroll-up-command -1)
  (forward-line -1))

(defun kb-scroll-down ()
  "Scroll down one position in file, move cursor with the scroll."
  (interactive)
  (scroll-up-command 1)
  (forward-line 1))

(bind-key "M-<up>"  'kb-scroll-up-hold-cursor)
(bind-key "M-<down>"  'kb-scroll-down-hold-cursor)

;;Disable terinal background

;;Adding projectile package for project management, this will intergrate with treemacs
(use-package projectile
  :ensure t
  :bind (("C-c p" . projectile-switch-open-project)
	 ("C-x p" . projectile-switch-project))
  :config
  (projectile-global-mode)
  (setq projectile-enable-caching t))

(use-package treemacs-projectile
  :ensure t)

;;smart backspace
(use-package smart-backspace
  :ensure t
  :bind("C-c <C-DEL>" . smart-backspace))

(use-package smart-tabs-mode
  :ensure t
  :config
  (setq indent-tab-mode t))

;;find replace in buffer
(defun replace-in-buffer ()
  (interactive)
  (save-excursion
    (if (equal mark-active nil) (mark-word))
    (setq curr-word (buffer-substring-no-properties (mark) (point)))
    (setq old-string (read-string "OLD string:\n" curr-word))
    (setq new-string (read-string "NEW string:\n" old-string))
    (query-replace old-string new-string nil (point-min) (point-max))
    )
  )

(global-set-key (kbd "C-c h") 'replace-in-buffer)

(global-set-key (kbd "M-p") 'find-name-dired)

;;overwrite the selected values
(delete-selection-mode 1)

	
;;change cursor type to bar
(setq-default cursor-type '(bar . 3))

;;Save backup file at a different location
(setq backup-directory-alist '(("." . "~/.emacs.d/backup"))
  backup-by-copying t    ; Don't delink hardlinks
  version-control t      ; Use version numbers on backups
  delete-old-versions t  ; Automatically delete excess backups
  kept-new-versions 20   ; how many of the newest versions to keep
  kept-old-versions 5    ; and how many of the old
  )


(set-face-attribute 'region nil :background "#808080" :foreground "#ffffff")



(use-package company-posframe
  :ensure t)
(setq company-posframe-mode 1)

(put 'upcase-region 'disabled nil)

;; (use-package company-childframe
;;   :ensure t)
;; (company-childframe-mode t)

;;Cassandra Plugin
(use-package cql-mode
  :ensure t)
;;Enable go-mode only for .go file extensions
(add-to-list 'auto-mode-alist '("\\.cql\\'" . cql-mode))

;;Indenatation vertical lines
(use-package highlight-indent-guides
  :ensure t)
(setq highlight-indent-guides-method 'character)

(add-hook 'prog-mode-hook 'highlight-indent-guides-mode)


(setq highlight-indent-guides-auto-odd-face-perc 25)
(setq highlight-indent-guides-auto-even-face-perc 25)
(setq highlight-indent-guides-auto-character-face-perc 25)


(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(Linum-format "%7i ")
 '(ansi-color-faces-vector
   [default bold shadow italic underline bold bold-italic bold])
 '(ansi-color-names-vector
   (vector "#839496" "#dc322f" "#859900" "#b58900" "#268bd2" "#d33682" "#2aa198" "#eee8d5"))
 '(beacon-color "#dc322f")
 '(compilation-message-face (quote default))
 '(custom-enabled-themes (quote (darkokai)))
 '(custom-safe-themes
   (quote
    ("37ba833442e0c5155a46df21446cadbe623440ccb6bbd61382eb869a2b9e9bf9" "a77ced882e25028e994d168a612c763a4feb8c4ab67c5ff48688654d0264370c" "3860a842e0bf585df9e5785e06d600a86e8b605e5cc0b74320dfe667bcbe816c" "c5ad91387427abc66af38b8d6ea74cade4e3734129cbcb0c34cc90985d06dcb3" "84d2f9eeb3f82d619ca4bfffe5f157282f4779732f48a5ac1484d94d5ff5b279" "b9e9ba5aeedcc5ba8be99f1cc9301f6679912910ff92fdf7980929c2fc83ab4d" "c74e83f8aa4c78a121b52146eadb792c9facc5b1f02c917e3dbb454fca931223" "218bc69ef19fd1f681cdded7b85924e41242fe87a6033df823499822f1397f1a" "3e160974b9e3e1b53270d1fb5bbaf56f0c689017e177972f72584bf096efc4cc" "4aee8551b53a43a883cb0b7f3255d6859d766b6c5e14bcb01bed572fcbef4328" "bffa9739ce0752a37d9b1eee78fc00ba159748f50dc328af4be661484848e476" "aaffceb9b0f539b6ad6becb8e96a04f2140c8faa1de8039a343a4f1e009174fb" "8dc7f4a05c53572d03f161d82158728618fb306636ddeec4cce204578432a06d" "a27c00821ccfd5a78b01e4f35dc056706dd9ede09a8b90c6955ae6a390eb1c1e" "3c83b3676d796422704082049fc38b6966bcad960f896669dfc21a7a37a748fa" "bd7b7c5df1174796deefce5debc2d976b264585d51852c962362be83932873d9" default)))
 '(fci-rule-character-color "#202020")
 '(fci-rule-color "#073642")
 '(frame-background-mode (quote dark))
 '(fringe-mode 4 nil (fringe))
 '(highlight-changes-colors (quote ("#FD5FF0" "#AE81FF")))
 '(highlight-tail-colors
   (quote
    (("#3C3D37" . 0)
     ("#679A01" . 20)
     ("#4BBEAE" . 30)
     ("#1DB4D0" . 50)
     ("#9A8F21" . 60)
     ("#A75B00" . 70)
     ("#F309DF" . 85)
     ("#3C3D37" . 100))))
 '(magit-diff-use-overlays nil)
 '(main-line-color1 "#1E1E1E")
 '(main-line-color2 "#111111")
 '(main-line-separator-style (quote chamfer))
 '(package-selected-packages
   (quote
    (darkokai-theme soothe-theme grandshell-theme cyberpunk-2019-theme highlight-parentheses highlight-parantheses hlinum company-box company-quickhelp uniquify helm use-package treemacs-projectile symon switch-window sudo-edit spacemacs-theme smex smart-tabs-mode smart-mode-line-powerline-theme smart-backspace rainbow-mode rainbow-delimiters popwin popup-kill-ring nlinum naquadah-theme monokai-theme ido-vertical-mode idle-highlight-in-visible-buffers-mode highlight-numbers highlight-indent-guides gotest golint godoctor go-snippets go-imports go-impl go-imenu go-guru go-gen-test go-fill-struct go-errcheck go-eldoc go-dlv go-direx go-add-tags focus firecode-theme dracula-theme dmenu diminish dashboard cql-mode company-go company-childframe color-theme-sanityinc-solarized calmer-forest-theme beacon)))
 '(pdf-view-midnight-colors (quote ("#b2b2b2" . "#262626")))
 '(pos-tip-background-color "#FFFACE")
 '(pos-tip-foreground-color "#272822")
 '(powerline-color1 "#1E1E1E")
 '(powerline-color2 "#111111")
 '(sml/mode-width
   (if
       (eq
	(powerline-current-separator)
	(quote arrow))
       (quote right)
     (quote full)))
 '(sml/pos-id-separator
   (quote
    (""
     (:propertize " " face powerline-active1)
     (:eval
      (propertize " "
		  (quote display)
		  (funcall
		   (intern
		    (format "powerline-%s-%s"
			    (powerline-current-separator)
			    (car powerline-default-separator-dir)))
		   (quote powerline-active1)
		   (quote powerline-active2))))
     (:propertize " " face powerline-active2))))
 '(sml/pos-minor-modes-separator
   (quote
    (""
     (:propertize " " face powerline-active1)
     (:eval
      (propertize " "
		  (quote display)
		  (funcall
		   (intern
		    (format "powerline-%s-%s"
			    (powerline-current-separator)
			    (cdr powerline-default-separator-dir)))
		   (quote powerline-active1)
		   (quote sml/global))))
     (:propertize " " face sml/global))))
 '(sml/pre-id-separator
   (quote
    (""
     (:propertize " " face sml/global)
     (:eval
      (propertize " "
		  (quote display)
		  (funcall
		   (intern
		    (format "powerline-%s-%s"
			    (powerline-current-separator)
			    (car powerline-default-separator-dir)))
		   (quote sml/global)
		   (quote powerline-active1))))
     (:propertize " " face powerline-active1))))
 '(sml/pre-minor-modes-separator
   (quote
    (""
     (:propertize " " face powerline-active2)
     (:eval
      (propertize " "
		  (quote display)
		  (funcall
		   (intern
		    (format "powerline-%s-%s"
			    (powerline-current-separator)
			    (cdr powerline-default-separator-dir)))
		   (quote powerline-active2)
		   (quote powerline-active1))))
     (:propertize " " face powerline-active1))))
 '(sml/pre-modes-separator (propertize " " (quote face) (quote sml/modes)))
 '(vc-annotate-background nil)
 '(vc-annotate-color-map
   (quote
    ((20 . "#dc322f")
     (40 . "#cb4b16")
     (60 . "#b58900")
     (80 . "#859900")
     (100 . "#2aa198")
     (120 . "#268bd2")
     (140 . "#d33682")
     (160 . "#6c71c4")
     (180 . "#dc322f")
     (200 . "#cb4b16")
     (220 . "#b58900")
     (240 . "#859900")
     (260 . "#2aa198")
     (280 . "#268bd2")
     (300 . "#d33682")
     (320 . "#6c71c4")
     (340 . "#dc322f")
     (360 . "#cb4b16"))))
 '(vc-annotate-very-old-color nil)
 '(weechat-color-list
   (quote
    (unspecified "#272822" "#3C3D37" "#F70057" "#F92672" "#86C30D" "#A6E22E" "#BEB244" "#E6DB74" "#40CAE4" "#66D9EF" "#FB35EA" "#FD5FF0" "#74DBCD" "#A1EFE4" "#F8F8F2" "#F8F8F0"))))

(use-package helm
  :ensure t)

;;stop emacs from opening file in new frame
(setq menu-bar-select-buffer-function 'switch-to-buffer)

;;adding fancier powerline
(use-package powerline
  :ensure t)
(powerline-default-theme)

(use-package smart-mode-line
  :ensure t)
(sml/setup)
(setq sml/theme 'respectful)

;;(add-to-list 'sml/replacer-regexp-list '("^~/Git-Projects/" ":Git:") t)



;;add package diminish so that minor modes are not always displyed on the space line
(use-package diminish
  :ensure t
  :init
  (diminish 'hungry-delete-mode)
  (diminish 'beacon-mode)
  (diminish 'which-key-mode)
  (diminish 'rainbow-mode)
  (diminish 'projectile-mode)
  (diminish 'eldoc-mode)
  (diminish 'company-mode)
  (diminish 'company-posframe-mode))

;;if there are multiple buffer with same name then show the parent directory name
(require 'uniquify)
(put 'downcase-region 'disabled nil)

;;Change selection color
(set-face-attribute 'region nil :background "#696969")


;;Display file path in the title bar 
(setq frame-title-format
  '(:eval
    (if buffer-file-name
        (replace-regexp-in-string
         "\\\\" "/"
         (replace-regexp-in-string
          (regexp-quote (getenv "HOME")) "~"
          (convert-standard-filename buffer-file-name)))
      (buffer-name))))

;;set the face of the comments to italic
(set-face-attribute 'font-lock-comment-face nil :italic t :slant 'italic)
(set-face-attribute 'font-lock-constant-face nil :italic t :slant 'italic)
(set-face-attribute 'font-lock-string-face nil :italic t :slant 'italic)
(set-face-attribute 'font-lock-type-face nil :italic t :slant 'italic :bold t)
(set-face-attribute 'font-lock-keyword-face nil :bold t)

;;Window settings
;;Remove the toolbar and menubar and scrollbar
      (require 'package)
      (package-initialize)	
      (setq package-enable-at-startup nil)		  		      
            (add-to-list 'package-archives			           
                   '("melpa" . "https://melpa.org/packages/")) 
(require 'org)
    (unless (package-installed-p 'use-package)
        (package-refresh-contents)
        (package-install 'use-package))

(require 'org)
(org-babel-load-file "~/.emacs.d/config.org")


;;THIS CODE IS DEPENDENT ON THE THEME INSTALL IN .ORG FILE
(require 'dap-go)
(require 'python-mode)

;;(defun cursor-color ()
 ;; (progn
     ;; Set cursor color
   ;;  (set-cursor-color "#F9A602")
     ;;))
;;(add-hook 'after-init-hook (lambda () (load-theme 'doom-tomorrow-night)(cursor-color)))
;;(add-hook 'after-init-hook (lambda () (cursor-color)))
(add-hook 'after-init-hook (lambda () (load-theme 'doom-tomorrow-night)(set-face-foreground 'line-number "#808080")))

;;(setq python-shell-interpreter "/usr/local/bin/python3")
;;(setq shell-file-name "zsh")
;;(setq shell-command-switch "-ic")

;;(let ((base00 "#171717")))
;;(setq-default dap-python-executable "python3")
;;(set-language-environment "UTF-8")


;;(setenvi "PYTHONIOENCODING" "utf-8") (add-to-list 'process-coding-system-alist '("elpy" . (utf-8 . utf-8))) (add-to-list 'process-coding-system-alist '("python" . (utf-8 . utf-8))) (add-to-list 'process-coding-system-alist '("flake8" . (utf-8 . utf-8)))
;;(setq elpy-rpc-python-command "python3")

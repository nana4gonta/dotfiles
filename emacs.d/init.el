;; http://d.hatena.ne.jp/syohex/20111117/1321503477
;; load environment value
(load-file (expand-file-name "~/.emacs.d/shellenv.el"))
(dolist (path (reverse (split-string (getenv "PATH") ":")))
  (add-to-list 'exec-path path))

;; http://d.hatena.ne.jp/tomoya/20090807/1249601308
;; system-type predicates
(setq darwin-p  (eq system-type 'darwin)
      ns-p      (eq window-system 'ns)
      carbon-p  (eq window-system 'mac)
      linux-p   (eq system-type 'gnu/linux)
      cygwin-p  (eq system-type 'cygwin)
      nt-p      (eq system-type 'windows-nt)
      meadow-p  (featurep 'meadow)
      windows-p (or cygwin-p nt-p meadow-p))

;; http://unknownplace.org/memo/2013/01/21/1/
(let*
    ((user-emacs-directory
      (substring (or load-file-name "~/.emacs.d/init.el") 0 -7))
     (conf-list (list
		 "theme.el"
		 "init.el"
                 "el-get.el"
		 "midnight.el"
		 ;; Major mode
		 "csharp-mode.el"
		 "d-mode.el"
		 "haskell-mode.el"
		 "js2-mode.el"
		 "markdown-mode.el"
		 "org-mode.el"
		 "python-mode.el"
		 "ruby-mode.el"
		 "twittering-mode.el"
		 "typescript-mode.el"
                 )))
  (progn
    (dolist (conf conf-list)
      (load (concat user-emacs-directory "conf/" conf)))

    (and (equal window-system 'ns)
	 (setq cocoa '("cocoa-init.el" "cocoa-font.el" "cocoa-server.el"))
         (dolist (conf cocoa)
	   (load (concat user-emacs-directory "conf/" conf)))
	 
	 (cond (file-exists-p "~/Gentoo")
	     (progn
	       (setq gentoo '("gentoo-prefix-exec-path.el" "gentoo-init.el"))
	       (dolist (conf gentoo)
		 (load (concat user-emacs-directory "conf/" conf))))))
 
    (and (equal system-type 'windows-nt)
     	 (dolist (conf (list "windows-init.el"
     			     "windows-font.el"
     			     ))
    	   (load (concat user-emacs-directory "conf/" conf))))

    ;; (and (equal system-type 'gnu/linux)
    ;; 	 (dolist (conf (list "linux-init.el"
    ;; 			     "linux-init.el"
    ;; 			     ))
    ;; 	   (load (concat user-emacs-directory "conf/" conf))))

    (and (null window-system)
         (dolist (conf (list "nw-init.el"))
           (load (concat user-emacs-directory "conf/" conf))))))

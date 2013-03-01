(if (file-exists-p "~/Gentoo")
    (cond 
     ((file-exists-p "~/Gentoo/bin/zsh")
      (setq shell-file-name "~/Gentoo/bin/zsh"))
     ((file-exists-p "~/Gentoo/bin/bash")
      (setq shell-file-name "~/Gentoo/bin/bash"))
     ((file-exists-p "~/Gentoo/bin/tcsh")
      (setq shell-file-name "~/Gentoo/bin/bash")))
  (cond 
   ((file-exists-p "/bin/zsh")
    (setq shell-file-name "bin/zsh"))
   ((file-exists-p "/bin/bash")
    (setq shell-file-name "/bin/bash"))
   ((file-exists-p "/bin/tcsh")
    (setq shell-file-name "/bin/bash"))))


(let*
    ((path (list
	    "~/Gentoo/usr/bin"
	    "~/Gentoo/bin"
	    "~/Gentoo/opt/bin"
	    "~/Gentoo/usr/sbin"
	    "~/.rbenv/shims")))
  (dolist (p path)
    (add-to-list 'exec-path (expand-file-name p))
    (setenv "PATH" (concat (expand-file-name p) ":" (getenv "PATH")))))

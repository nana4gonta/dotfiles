(defun my-js-indent-function ()
  (interactive)
  (save-restriction
    (widen)
    (let* ((inhibit-point-motion-hooks t)
           (parse-status (save-excursion (syntax-ppss (point-at-bol))))
           (offset (- (current-column) (current-indentation)))
           (indentation (espresso--proper-indentation parse-status))
           node)

      (save-excursion

        ;; I like to indent case and labels to half of the tab width
        (back-to-indentation)
        (if (looking-at "case\\s-")
            (setq indentation (+ indentation (/ espresso-indent-level 2))))

        ;; consecutive declarations in a var statement are nice if
        ;; properly aligned, i.e:
        ;;
        ;; var foo = "bar",
        ;;     bar = "foo";
        (setq node (js-node-at-point))
        (when (and node
                   (= js-NAME (js-node-type node))
                   (= js-VAR (js-node-type (js-node-parent node))))
          (setq indentation (+ 2 indentation))))

      (indent-line-to indentation)
      (when (> offset 0) (forward-char offset)))))


(defun my-indent-sexp ()
  (interactive)
  (save-restriction
    (save-excursion
      (widen)
      (let* ((inhibit-point-motion-hooks t)
             (parse-status (syntax-ppss (point)))
             (beg (nth 1 parse-status))
             (end-marker (make-marker))
             (end (progn (goto-char beg) (forward-list) (point)))
             (ovl (make-overlay beg end)))
        (set-marker end-marker end)
        (overlay-put ovl 'face 'highlight)
        (goto-char beg)
        (while (< (point) (marker-position end-marker))
          ;; don't reindent blank lines so we don't set the "buffer
          ;; modified" property for nothing
          (beginning-of-line)
          (unless (looking-at "\\s-*$")
            (indent-according-to-mode))
          (forward-line))
        (run-with-timer 0.5 nil '(lambda(ovl)
                                   (delete-overlay ovl)) ovl)))))

(defun my-js-mode-hook ()
  (setq js-indent-lebel 2
        indent-tabs-mode nil
        c-basic-offset 2)
  (c-toggle-auto-state 0)
  (c-toggle-hungry-state 1)
  (set (make-local-variable 'indent-line-function) 'my-js-indent-function)
  (define-key js-mode-map [(meta control |)] 'cperl-lineup)
  (define-key js-mode-map [(meta control \;)] 
    '(lambda()
       (interactive)
       (insert "/* -----[ ")
       (save-excursion
         (insert " ]----- */"))
       ))
  (define-key js-mode-map [(return)] 'newline-and-indent)
  (define-key js-mode-map [(backspace)] 'c-electric-backspace)
  (define-key js-mode-map [(control d)] 'c-electric-delete-forward)
  (define-key js-mode-map [(control meta q)] 'my-indent-sexp)
  (if (featurep 'js-highlight-vars)
    (js-highlight-vars-mode))
  (message "My JS hook"))

(add-hook 'js-mode-hook 'my-js-mode-hook)

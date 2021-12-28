

(defconst jai-builtins)

(defconst jai-keywords)

(defconst jai-constants)

(defconst jai-typenames)

(defconst jai-import ()
  "^#"
)


(defvar jai-mode-syntax-table
  (let ((st (make-syntax-table)))
    (modify-syntax-entry ?/ ". 124b" st)
    (modify-syntax-entry ?* ". 23" st)
    ;; newline and formfeed end comments
    (modify-syntax-entry ?\n "> b" st)
    (modify-syntax-entry ?\f "> b" st)
    st)
  "Syntax table for Jai mode")


(set-syntax-table jai-mode-syntax-table)

(setq jai-font-lock-keywords
      (let* (
	     ;; Define keywords
         (jai-keywords '("cast" "it" "type_info" "size_of"))
	 (jai-keywords '("if" "else" "then" "while" "for" "switch" "case" "struct" "enum"
    "return" "new" "remove" "continue" "break" "defer" "inline" "no_inline"
    "using" "SOA"))
	 (jai-constants '("null" "true" "false"))
	 (jai-typenames '("int" "u64" "u32" "u16" "u8"
    "s64" "s32" "s16" "s8" "float"
    "float32" "float64" "string"
    "bool"))
	 ;; Generate a regex string for each category of keywords
		       
	     )))

(add-hook 'jai--mode
	  (lambda ()
	    (set (make-local-variable 'comment-start) "/*")
	    (set (make-local-variable 'comment-end) "*/")))


;;;###autoload
(define-derived-mode jai-mode c-mode "jai mode"
  "Major mode for editing JAI"
    ;; code for syntax highlighting
       (setq font-lock-defaults '((jai-font-lock-keywords))))


;; add the mode to the `features' list
(provide 'jai-mode)








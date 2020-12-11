;;; org-fnf --- A custom org-html layout.
;;; (c) Abraham Aguilar a.aguilar@ciencias.unam.mx
;;;
;;; Commentary:
;;; Simply a custom org-html layout



;;; Code:
(require 'ox-html)

(org-export-define-derived-backend 'fnf-html 'html
  :translate-alist '((inner-template . fnf-html-inner-template)
                     (template . fnf-html-template))
  :menu-entry '(?f "Export as f&f" fnf-html-export-to-file))


(defun fnf-html-inner-template (contents info)
  "Return body of document string after HTML conversion.

CONTENTS is the transcoded contents string.
INFO is a plist containing export options"
  (concat
   "<div class=\"row\" >"
   "<div class=\"col-1\" >"
   "</div>"
   "<div class=\"col-3\" >"
   (let ((title (and (plist-get info :with-title)
                     (plist-get info :title))))
     (when title
       (format "<h1 class=\"title\" id=\"title\">%s</h1>"
               (org-export-data title info))))
   "</div>"
   "<div class=\"col\" ></div>"
   "</div>"

   "<div class=\"row\" >"
   "<div class=\"col-1\" >"
   "</div>"
   "<div class=\"col-3\" >"
   contents
   "</div>"
   "<div class=\"col\" ></div>"
   "</div>"

   "<div class=\"row\" >"
   "<div class=\"col-1\" >"
   "</div>"
   "<div class=\"col-3\" >"
   (org-html-footnote-section info)
   "</div>"
   "<div class=\"col\" ></div>"
   "</div>"))


(defun fnf-html-template (contents info)
  "Return ducument string after HTML conversion.

CONTENTS is the transcoded contents string.
INFO is a plist holding export options"
  (concat
   "<!doctype html>\n"
   "<html>\n"
   "<head>\n"
   "<meta charset=\"UTF-8\">"
   "<title>\n"
   (let ((title (and (plist-get info :with-title)
                     (plist-get info :title))))
     (if title
         (format "%s" (org-export-data title info))
       "Full & Faithful"))
   "</title>\n"
   "<link rel=\"stylesheet\" href=\"css/styles.css\" >"
   (org-html--build-mathjax-config info)
   "</head>\n"
   "<body>\n"
   contents
   "</body>\n"
   "</html>\n"))


(defun fnf-html-export-to-file
    (&optional async subtreep visible-only body-only ext-plist)
  "Export as custom fnf html file."
  (interactive)
  (let ((outfile (org-export-output-file-name ".html" subtreep)))
    (org-export-to-file 'fnf-html outfile
      async subtreep visible-only body-only ext-plist)))

(provide 'org-fnf)
;;; org-fnf ends here

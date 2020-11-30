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
   "<r-grid columns=\"8\">\n <r-cell span=\"1\">\n </r-cell> <r-cell span=\"7\">\n"
   (let ((title (and (plist-get info :with-title)
                     (plist-get info :title))))
     (when title
       (format "<h1 class=\"title\" id=\"title\">%s</h1>"
               (org-export-data title info))))
   "</r-cell>\n </r-grid>\n"
   "<r-grid columns=\"8\">\n <r-cell span=\"1\">\n</r-cell><r-cell span=\"5\">\n"
   contents
   "</r-cell>\n</r-grid>\n"
   "<r-grid columns=\"8\">\n <r-cell span=\"1\">\n</r-cell><r-cell span=\"5\">\n"
   (org-html-footnote-section info)
   "</r-cell>\n</r-grid>\n"))


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
   "<link rel=\"stylesheet\" href=\"http://rsms.me/raster/raster2.css\" >"
   "<style>\n" "@import url('https://fonts.googleapis.com/css2?family=B612+Mono&family=Oswald:wght@500;700&family=Roboto:ital,wght@0,400;0,700;1,400&display=swap');"
   "</style>\n"
   "<style>\n"
   "body {font-size: 1.8vw; line-height: 1.2; font-family: 'Roboto', sans-serif;}"
   "h2:first-child { margin-top: initial; margin-top: 6.854vw;}"
   "h2 {font-size: 2.618rem; font-family: 'Oswald', sans-serif;
            font-weight:500;
            letter-spacing: 0.1vw; margin-bottom: 2vw;
            margin-top: 40px; display: block;
            text-transform: uppercase;}"
   "h1.title {font-size: 6.854rem; font-family: 'Oswald', sans-serif;
            font-weight:700;
            letter-spacing: 0.1vw; display: block; margin-bottom: 50px;
            text-transform: uppercase;}"
   "a {background-image: linear-gradient(120deg, magenta 0%, coral 80%, green 100%);
           background-repeat: no-repeat;
           background-size: 100% 0.15em;
           background-position: 0 82%;
           transition: background-size 0.25s ease-in;}
        a:hover{background-image: linear-gradient(120deg, #f5d8d1 0%, #f3e9d1 80%, #edf2d2 100%);
             background-size: 100% 88%; color: black;}
        .footref {font-size: 1.2vw; vertical-align: super;}
        .footnum {font-size: 1.2vw;}
        .footnum:after {content: \". \"; line-height: 0.8vw;}
        .footdef {line-height:0.8.vw;}
        .footpara {display: inline;font-size: 1.2vw; line-height:0.8vw;}"
   ".src {margin-bottom: 4.05vw; margin-top: 4.05vw;}"
   "</style>\n"
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

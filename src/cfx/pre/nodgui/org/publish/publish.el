(progn
  (org-setup "//n133906/home/_namatv/public_html/Site/CFD/" (home-ancestor 2))
   
  (setq org-publish-project-alist 
        `(,(org-pub-list "org-root"  "") ;; Корневой файл
          ,(org-pub-list "org"       "org") ;; Корневой файл
          ,(org-att-list "png" "png" "org/img") ;; Указания о публикации el          
          ))
  (org-web-list))

(progn
  (require 'ox-publish)
  (setq org-publish-use-timestamps-flag nil)
  (setq org-confirm-babel-evaluate nil) ; выполнение всех блоков кода без подтверждения  
  (org-publish-project "website"))

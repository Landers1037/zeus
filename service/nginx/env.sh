# 域名
export name_mysite=renj.io
export name_blog=blog.renj.io
export name_mgek=mgek.cc
export name_mgekdoc=doc.mgek.cc
export name_resume=me.renj.io
export name_mgekfile=file.mgek.cc
export name_jjservice=app.renj.io
export name_jjgo=api.renj.io
export name_jjgo_page=jjgo.renj.io
export name_proxy=proxy.renj.io
export name_cooki=cooki.renj.io
export name_home=home.renj.io

# 静态文件的路径
# 静态文件都是以_frontend结尾标注的
app_root=/renj.io/apps
export path_blog=${app_root}/blog_frontend
export path_resume=${app_root}/resume
export path_mgekfile=${app_root}/mgekfile
export path_holding=${app_root}/holding
export path_jjservice=${app_root}/jjservice_frontend
export path_jjgo=${app_root}/jjgo_frontend

# ssl
export ssl_pem=/usr/local/nginx/ssl/full_chain.pem
export ssl_key=/usr/local/nginx/ssl/private.key

# 其他
export static_mysite=${app_root}/mysite/app/static
export mgek_image=${app_root}/mgek/static/images
export mgekdoc_image=${app_root}/mgek/static
export blog_image_path=${app_root}/blog/images
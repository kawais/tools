# 自动生成缩略图脚本
php thum.php path [width]
```
ex: php thum.php app/PC_Theme/src/images 200
```

# 资源文件md5更新
php filemd5.php index.html
1. 将当前目录下所有文件生成md5列表文件md5.js [{文件名md5:文件内容md5}...]
2. 将index.html中的js，css文件引用加入md5值 change <script src='a.js' to <script src='a.js?_=md5'
@echo off
setlocal enabledelayedexpansion

:: 设置根目录为当前目录
set "root=%cd%"

:: 开始生成 HTML 文件
echo ^<html^> > index.html
echo ^<head^>^<title^>PDF 电子书目录^</title^>^</head^> >> index.html
echo ^<body^> >> index.html
echo ^<h1^>PDF 文件列表^</h1^> >> index.html

:: 遍历所有 PDF 文件，获取相对路径
for /r %%f in (*.pdf) do (
    set "fullpath=%%f"
    :: 计算相对路径（替换根目录，并将 \ 转为 / 以符合 HTML href）
    set "relpath=!fullpath:%root%\=!"
    set "relpath=!relpath:\=/!"
    :: 输出链接到 HTML
    echo ^<p^>^<a href="!relpath!" target="_blank"^>!relpath!^</a^>^</p^> >> index.html
)

:: 结束 HTML
echo ^</body^> >> index.html
echo ^</html^> >> index.html

echo 生成完成！请打开 index.html 查看。
$root = Get-Location
$html = @"
<!DOCTYPE html>
<html lang="zh">
<head>
    <meta charset="UTF-8">
    <title>电子书 PDF 目录</title>
    <style>
        body { font-family: 'Segoe UI', sans-serif; margin: 20px; }
        ul { list-style-type: none; padding-left: 20px; }
        li.folder { font-weight: bold; color: #444; margin: 8px 0; }
        li.file a { color: #0066cc; text-decoration: none; }
        li.file a:hover { text-decoration: underline; }
    </style>
</head>
<body>
<h1>PDF 文件目录</h1>
<ul>
"@

function Add-Folder {
    param($path, $level)
    $relPath = $path | Resolve-Path -Relative
    if ($relPath -ne '.\') {
        $html += " " * ($level * 4)
        $$ html += "<li class='folder'> $$([System.IO.Path]::GetFileName($path))</li>`n"
        $html += " " * ($level * 4)
        $html += "<ul>`n"
    }

    Get-ChildItem $path | ForEach-Object {
        if ($_.PSIsContainer) {
            $html += Add-Folder $_.FullName ($level + 1)
        }
        elseif ($_.Extension -eq '.pdf' -or $_.Extension -eq '.PDF') {
            $rel = $_.FullName | Resolve-Path -Relative
            $rel = $rel -replace '^\.\\',''
            $name = $_.Name
            $html += " " * (($level + 1) * 4)
            $$ html += "<li class='file'><a href=' $$($rel -replace '\\','/')' target='_blank'>$name</a></li>`n"
        }
    }

    if ($relPath -ne '.\') {
        $html += " " * ($level * 4)
        $html += "</ul>`n"
    }
    return $html
}

$html += Add-Folder $root 0
$html += "</ul></body></html>"

$html | Out-File -FilePath "index.html" -Encoding utf8
Write-Host "生成完成！请用浏览器打开 index.html"
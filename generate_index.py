import os

def generate_html(root_dir, output_file='index.html'):
    html_content = '<html>\n<head>\n<title>PDF 电子书目录</title>\n</head>\n<body>\n<h1>PDF 文件列表</h1>\n<ul>\n'
    
    # 遍历目录树
    for dirpath, dirnames, filenames in os.walk(root_dir):
        # 获取相对路径
        rel_dir = os.path.relpath(dirpath, root_dir)
        if rel_dir != '.':
            html_content += f'<li><strong>{rel_dir}</strong>\n<ul>\n'
        
        # 添加 PDF 文件链接
        for filename in filenames:
            if filename.lower().endswith('.pdf'):
                rel_path = os.path.join(rel_dir, filename).replace('\\', '/')
                if rel_path.startswith('./'):
                    rel_path = rel_path[2:]
                html_content += f'<li><a href="{rel_path}" target="_blank">{filename}</a></li>\n'
        
        if rel_dir != '.':
            html_content += '</ul>\n</li>\n'
    
    html_content += '</ul>\n</body>\n</html>'
    
    # 写入文件
    with open(output_file, 'w', encoding='utf-8') as f:
        f.write(html_content)
    
    print('生成完成！请打开 index.html 查看。')

# 在当前目录运行
generate_html('.')
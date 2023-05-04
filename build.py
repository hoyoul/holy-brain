#!/usr/bin/env python

import glob
from pathlib import Path

# source 설정
files = glob.glob("/Users/holy/MyProjects/holy-brain/org/*.org")

# rule을 정의 [build.ninja의 작성]
# build를 org폴더의 org파일 개수만큼 생성 [build.ninja 작성]
with open('build.ninja', 'w',encoding='utf-8') as ninja_file:
    ninja_file.write("""
rule org2md
  command = emacsclient -ne \"(holy/publish_md \\"$in\\")"
  description = org2md $in
    """)
    for f in files:
        path = Path(f)
        output_file = f"content/{path.with_suffix('.md').name}"
        ninja_file.write(f"""
build {output_file}: org2md {path}
""")

# 지금껏 작성한 build.ninja를 실행        
import subprocess
subprocess.call(["ninja"])

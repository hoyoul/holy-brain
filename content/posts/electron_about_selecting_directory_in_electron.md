+++
title = "[electron] about selecting directory in electron"
author = ["holy"]
description = "selecting directory in electron"
date = 2023-08-14T00:00:00+09:00
draft = true
+++

## electron에서 folder에 접근하기에 대한 생각 {#electron에서-folder에-접근하기에-대한-생각}

내가 만드는 webtoon downloader의 경우 폴더를 선택하고, 선택된 폴더에
저장하는 기능이 있다. electron의 web browser(chromium)에서 local의
file system에 접근하는 건 보안때문에 제대로 동작하지 않는다. 그래서
그것에 대한 조사가 필요했다.


### webkitdirectory {#webkitdirectory}

html page에서 choose input 폴더는 &lt;input&gt;태그에 webkit directory
option을 줘서 만든다.

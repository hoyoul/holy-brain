+++
title = "hugo korean encoding problem"
author = ["holy"]
description = "hugo에서 website로 만들때, 한글문제가 있다."
date = 2023-06-07T00:00:00+09:00
draft = true
+++

## org-roam과 한글 {#org-roam과-한글}

org-roam에서 title을 한글로 하면 한글명의 org파일이 만들어지고,
ox-hugo를 실행하면 contents/posts에 md파일이 만들어진다. 이 상태에서
hugo를 사용해서 md파일을 html로 만들게 된다. md파일을 전처리 하는
과정에서 title이름의 폴더를 만들고 index.html을 만들게 된다. 따라서
title을 한글로 만들면, public폴더에는 한글 폴더가 있게 된다.


## hugo의 문제 {#hugo의-문제}

development환경에서는

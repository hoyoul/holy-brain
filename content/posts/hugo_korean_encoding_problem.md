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

한글 폴더가 있다는게 development환경에서는 문제가 되지 않는다. 그런데
production환경에서는 한글폴더를 읽지 못하는 문제가 있다. config.toml에
다음과 같이 설정을 했지만, 해결하지 못했다.

```text
languageCode = "ko"
hasCJKLanguage = true
```


## 해결책 {#해결책}

그럼 어떻게 할것인가? 그냥 org-roam에서 title을 작성할때, 영어로
쓰자. 고칠려고 애는 쓸만큼 썼다. 5시간동안 했는데 해결책을
못찾았다. 너무 시간을 쏟을 필요가 없다.

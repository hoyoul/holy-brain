+++
title = "[emacs] database sql usage"
author = ["holy"]
date = 2023-08-04T00:00:00+09:00
draft = true
+++

## db client {#db-client}

사람들은 db client로 GUI db client를 사용한다. 내경우 phpadmin에서
querious로 바꿨탔다. querious3에서 querious4로 upgrade로 추가 비용을
내라고 해서, upgrade는 안한 상태다. emacs에서 db client를 사용하는
방법을 기술해 보자.


## db server 설치 {#db-server-설치}


### mariadb {#mariadb}

```text
brew install mariadb
```


### postgres {#postgres}

```emacs-lisp
brew install postgres
```

+++
title = "[mysql] restore db and table"
author = ["holy"]
description = "옛날 자료 취합"
date = 2023-08-06T00:00:00+09:00
draft = true
+++

## data backup and restore in mysql {#data-backup-and-restore-in-mysql}


### database 백업 및 복원 {#database-백업-및-복원}

<div class="attention">

mysql의 백업과 복원은 간단하다. &gt;(redirection)을 쓰면 되기 때문이다.
우선 backup하려는 db를 선택하고 shell에서 다음 명령어를 실행 하면 된다.

```text
mysqldump -uroot -p mydb > mydb.sql
```

복원에 앞서 db를 만들어놔야 한다. 그런 다음 백업 파일로부터 db를 복원한다.

```text
mysql -uroot -p mynewdb < mydb.sql
```

database의 백업과 복원은 이렇게 하면 된다.

</div>


### table의 백업과 복원 {#table의-백업과-복원}

<div class="attention">

table의 백업과 복원도 어렵지 않다.

우선 백업은 다음과 같다.

```text
mysqldump -uroot -p db명 table명 > 백업파일
```

복원도 원하는 db를 정해주고 redirection하면 된다.

```text
mysql -uroot -p db명 <백업파일
```

</div>


## query를 파일에 저장 {#query를-파일에-저장}


###  {#d41d8c}

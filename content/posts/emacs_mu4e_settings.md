+++
title = "[emacs] mu4e settings"
author = ["holy"]
description = "emacs에서 mail관리"
date = 2023-07-22T00:00:00+09:00
draft = true
+++

## 기본 단계. {#기본-단계-dot}

<div class="note">

gmail이나 fastmail은 외부에 있는 email server다. 그림에선 remote Mail
Server로 보면 된다. local에서는 이 email server에 smtp나 imap과같은
protocol을 연결해서 email을 보내거나 가져올수 있다. 하지만, emacs에서
직접 smtp나 imap를 연결하진 않는다. smtp나 imap과 연결하는 것은 local
daemon인 mbsync가 그 역할을 한다. emacs에서는 mu4e라는 front UI가
있는데, 이 mu4e는 mbsync라는 daemon에게 명령을 내릴 뿐이다. email을
가져오거나 보내는 명령을 내린다.

<a id="figure--"></a>

{{< figure src="./img/mu4e1.png" alt="neural network" caption="<span class=\"figure-number\">Figure 1: </span>overview mu4e" title="Neural network representation" width="100%" height="100%" >}}

</div>


## [step 1] remote email server setting {#step-1-remote-email-server-setting}


### gmail settings {#gmail-settings}

-   gmail을 먼저 imap,smtp or pop3를 사용할 지 여부를 setting해야
    한다. 그래야 mbsync와 통신이 가능하다. 우리는 imap을 사용할
    것이다.
    ```text
    gmail setting 에서 enable imap.
    ```
-   [gmail settings]

<a id="figure--"></a>

{{< figure src="./img/mu4e2.png" alt="neural network" caption="<span class=\"figure-number\">Figure 2: </span>gmail settings" title="Neural network representation" width="100%" height="100%" >}}

<a id="figure--"></a>

{{< figure src="./img/mu4e3.png" alt="neural network" caption="<span class=\"figure-number\">Figure 3: </span>gmail settings2" title="Neural network representation" width="100%" height="100%" >}}


### fastmail settings {#fastmail-settings}

-   fastmail에서는 imap을 enable하지 않아도 된다.


## [step 2] mbsync setting {#step-2-mbsync-setting}

-   mbysync에서 하는일은 gmail과 fastmail과 같은 email server와 통신하기
    위한 인증작업.
-   gmail과 fastmail에서 받은 email을 local에 저장하기 위한 폴더 생성
    -   .maildir폴더에 인증파일과 mail을 저장할 폴더 생성.


### mbsync 설치 {#mbsync-설치}

-   isync가 mbsync다.

<!--listend-->

```text
brew install isync
```


### openssl {#openssl}


#### openssl 설치 {#openssl-설치}

-   mbsync가 gmail이나 fastmail과 같은 email에 연결하기 위해선 보안

작업을 해야 한다. openssl을 설치하고 opessl로 인증서를 가져온다.

```text
brew install openssl
brew link openssl --force
```


#### openssl로 인증서 가져오기 {#openssl로-인증서-가져오기}

<!--list-separator-->

-  gmail

    ```text
    openssl s_client -connect imap.gmail.com:993 -showcerts
    ```

    위 명령을 내리면, 3개의 fingerprint가 출력되는 데(즉, begin
    certificate, end certificate로 끝난다.), 이것이 모두
    인증서다. 이것을 복사해서 저장해야 한다. 저장 위치를 난
    _Users/hoyoul_.maildir/certs 여기에 했다. 파일 이름은 순서대로,
    gmail.crt, google.crt, Equifax.crt로 한다.
    이것을 .mbsyncrc라는 설정파일에 다음과 같이 기술한다.

    ```text
    CertificateFile /Users/hoyoul/.maildir/certs/gmail.crt
    CertificateFile /Users/hoyoul/.maildir/certs/google.crt
    CertificateFile /Users/hoyoul/.maildir/certs/Equifax.crt
    ```

<!--list-separator-->

-  fastmail

    ```text
    openssl s_client -connect imap.fastmail.com:993 -showcerts
    ```

    -   fastmail은 2개의 certs가 있다.

    <!--listend-->

    ```text
    CertificateFile /Users/hoyoul/.maildir/certs/fm.crt
    CertificateFile /Users/hoyoul/.maildir/certs/fastmail.crt
    ```


### app password {#app-password}


#### app password {#app-password}

-   .mbsynce를 설정하기에 앞서서, 인증관련 처리를 하나 더 해줘야
    한다. 여기서는 gmail에서 mail을 가져오거나, 보내야 하는데,
    app-password를 발급받아야 한다.


#### app password 발급 방법 {#app-password-발급-방법}

<!--list-separator-->

-  gmail

    <a id="org508511d"></a>

    ![](./img/app_pwd.png)
    여기서 발급받은 key는 .mbsyncrc에 pass에 넣어준다.

<!--list-separator-->

-  fastmail

    ![](./img/app_pw_fastmail.png)
    =&gt; eadu273mnpjmpt74


### .mbsyncrc 설정 {#dot-mbsyncrc-설정}

-   ~/.mbsyncrc라는 mbsync 설정파일을 만든다. 아래 내용을 복사해서 사용한다.

<!--listend-->

```text
#------------------------------------------------------
# 2개의 imap을 사용한다. 각각의 이름을 Imap account라고 한다.
# (1) gmail => gmailcon
# (2) fastmail => fastmailcon
#------------------------------------------------------
IMAPAccount gmailcon
Host imap.gmail.com
Port 993
User hoyoul.park@gmail.com
Pass gsrupwxkyiepvjwh
AuthMechs LOGIN
SSLType IMAPS
CertificateFile /Users/holy/.maildir/certs/gmail.crt
CertificateFile /Users/holy/.maildir/certs/google.crt
CertificateFile /Users/holy/.maildir/certs/Equifax.crt

#------------------------------------------------------
# gmail의 store를 정의한다. store는 group of mailbox이며,
# 원격에 있는 gmail store와 다운받은 local의 store가 있다.
#------------------------------------------------------

IMAPStore gmail-store
Account gmailcon

MaildirStore local-store
Path ~/.maildir/Gmail/
Inbox ~/.maildir/Gmail/Inbox
SubFolders Verbatim
# -----------------------------------------------------------
#[gmail channel] channel은 동기화를 담당한다. channel을 만들면
# master와 slave의 동기화를 하겠다는 뜻이다.  master와 slave는 gmail과
# local의 store를 말한다. patterns의 *는 모든 mail box를
# 뜻한다. local에서 mailbox를 만들어도 gmail에 동일하게 mailbox가
# 만들어지고, gmail에서 mailbox를 만들어도 local에 생긴다.  그런데,
# maildirstore에 보면 inbox라는 mailbox가 기술된것을 볼 수 있다.
# inbox는 default mailbox로 gmail server에 있다.  master와 slave에
# 있는 모든(*) mailboxes를 동기화 한다.  양쪽에 없는 mailbox가 있다면
# 만든다.
#------------------------------------------------------

#All mail
Channel my-channel
Far :gmail-store:
Near :local-store:
Patterns *
Create Both
Sync Pull
SyncState *


#------------------------------------------------------
# [fastmail 설정]
#------------------------------------------------------
IMAPAccount fastmailcon
Host imap.fastmail.com
Port 993
User holy_frege@fastmail.com
Pass eadu273mnpjmpt74
AuthMechs LOGIN
SSLType IMAPS
CertificateFile /Users/holy/.maildir/certs/fm.crt
CertificateFile /Users/holy/.maildir/certs/fastmail.crt

IMAPStore fastmail-remote
Account fastmailcon

MaildirStore fastmail-local
Path ~/.maildir/Fastmail/
Inbox ~/.maildir/Fastmail/INBOX/
Trash ~/.maildir/Fastmail/Trash/
SubFolders Verbatim

Channel fastmail
Far :fastmail-remote:
Near :fastmail-local:
Patterns *
Expunge None
CopyArrivalDate yes
Sync All
Create Both
SyncState *
```

-   .maildir/Gmail과 .maildir/Fastmail 폴더가 있어야 한다.


### test {#test}

-   실제 email server에서 local로 메일을 가져오는지 test한다.
    ```text
    mbsync -a
    ```


### 기본 개념 {#기본-개념}


#### 용어들 {#용어들}

-   stores: mailbox들을 group화한게 store가 있다. store는 remote와
    local이 있다. remote와 마찬가지로 local에도 mapping되는 store가 있다.

    <a id="figure--remote store"></a>

    {{< figure src="./img/store.png" caption="<span class=\"figure-number\">Figure 6: </span>remote store" >}}
-   channel: remote와 local의 mailbox들은 서로 대응되어 연결되어
    있다. 이것을 channel이라고 한다.
-   mailbox: store에는 mailbox들이 있다.

    <a id="figure--"></a>

    {{< figure src="./img/mu4e4.png" alt="neural network" caption="<span class=\"figure-number\">Figure 7: </span>mail box" title="Neural network representation" width="50%" height="50%" >}}


#### 참고 {#참고}

1.  <http://manpages.ubuntu.com/manpages/xenial/man1/mbsync.1.html>
2.  <https://manpages.debian.org/testing/isync/mbsync.1.en.html>
3.  group: channel을 묶은것을 의미한다.
4.  maildir stores: store는 mailbox의 collection을 의미한다. maildir은 local을 의미한다.
5.  IMAP stores:  IMAP을 사용하는 server의 mailbox collection을 의미한다. gmail에 있는 모든
    mailbox들을 나타낸다고 봐도 된다.


## [step 3] mu4e 설정 {#step-3-mu4e-설정}


### mu설치 {#mu설치}

-   mu는 mbsync의 maildir에 있는 mail들을 indexing해서 빠른 검색을
    가능하게 해주고, emacs에서 사용할 수 있게 해준다. mu가 곧 emacs의
    mu4e이기 때문이다.
-   mu4e(emacs mail app)를 위해선 mu package를 system에 설치 해야
    한다.
    ```text
    brew install mu
    ```
-   설치한 mu에는 mu를 사용하는 emacs lisp파일을 제공한다. 이 경로는
    emacs설정시에 사용된다.
    ```text
    /usr/local/share/emacs/site-lisp/mu/mu4e
    ```


### mu 초기화 {#mu-초기화}

-   mu init으로 db를 만든다.
-   원리는 다음과 같다. mail이 저장된 local directory인 .maildir을
    mu에게 알려주면 indexing해서 db에 저장한다.

<!--listend-->

```text
mu init --maildir=~/.maildir
```

{{< figure src="./img/mu4e5.png" alt="neural network" caption="<span class=\"figure-number\">Figure 8: </span>mu init" title="Neural network representation" width="100%" height="100%" >}}


### mu testing {#mu-testing}

-   mu를 초기화 한 후, mu index로 maildir로부터 mail을 가져와서
    indexing을 해주어야 한다. mu index를 한다. testing을 위해서, mu
    find로 google로 시작되는 메일을 찾아보자.

<!--listend-->

```text
mu index
mu find google
```


## [step3] mu4e 설정 {#step3-mu4e-설정}

-   mu를 설치했기 때문에, mu4e도 설치할 수 있다. mu 설치시 mu4e를
    제공하기 때문이다.


### mu4e 설정 {#mu4e-설정}

-   mu4e는 email server에서 mail을 받을 뿐이다. 보내기 위해선 smtp도
    같이 설정한다.
    ```text
    (add-to-list 'load-path "/usr/local/Cellar/mu/1.4.13/share/emacs/site-lisp/mu/mu4e/")
    (require 'mu4e)
    (require 'smtpmail)
    (setq mu4e-maildir (expand-file-name "~/.maildir"))

    (setq mail-user-agent 'mu4e-user-agent)
    (setq mu4e-drafts-folder "/[Gmail].Drafts")
    (setq mu4e-sent-folder   "/[Gmail].Sent Mail")
    (setq mu4e-trash-folder  "/[Gmail].Trash")

    ;; smtp mail setting; these are the same that `gnus' uses.
    (setq
       message-send-mail-function   'smtpmail-send-it
       smtpmail-default-smtp-server "smtp.gmail.com"
       smtpmail-smtp-server         "smtp.gmail.com"
       smtpmail-local-domain        "gmail.com")
    ```


### mu4e 설정 설명 {#mu4e-설정-설명}


#### mu4e 경로및 load {#mu4e-경로및-load}

-   emacs에서 아래를 설정한다.  mu를 설치했을 때 얻은
    site-lisp의 경로다. mu를 설치하면, emacs에서 사용할 수 있게 mu4e
    app을 제공해주기 때문이다.  그래서 (require 'mu4e)가 가능하다.

<!--listend-->

```text
(add-to-list 'load-path "/usr/local/share/emacs/site-lisp/mu/mu4e")
# (add-to-list 'load-path "/usr/local/Cellar/mu/1.4.13/share/emacs/site-lisp/mu/mu4e/")
(require 'mu4e)
```


## mu4e 기본 사용법 {#mu4e-기본-사용법}

<div class="note">

기본 사용법은 아래를 참고한다.

{{< figure src="./img/mu4e6.png" caption="<span class=\"figure-number\">Figure 9: </span>기본 사용법" >}}

key binding은 다음과 같다.

{{< figure src="./img/mu4e7-1.png" caption="<span class=\"figure-number\">Figure 10: </span>key binding" >}}

{{< figure src="./img/mu4e7-2.png" caption="<span class=\"figure-number\">Figure 11: </span>keybinding2" >}}

</div>


## mu4e 사용법 (update) {#mu4e-사용법--update}

<div class="note">

C-c C-u: 언제 어디서나 update할 수 있다.

</div>


## mu4e 사용법 (편지 쓰기) {#mu4e-사용법--편지-쓰기}

<div class="note">

1.  M-x mu4e로 들어간다.
2.  편지 쓰기 (C를 누른다) ;; 언제 어디서든 Capital C를 누르면 된다.
3.  attachment( C-c C-a를 누른다. )
4.  작성을 완료한다. ( C-c C-c )

5.  cc 추가
6.  C-c C-f C-c (cc field가 만들어진다.)

7.  bcc 추가
8.  C-c C-f C-b (bcc field가 만들어진다.)

</div>


## mu4e 사용법 (답장 편지) {#mu4e-사용법--답장-편지}

<div class="note">

1.  편지 읽기
2.  R(reply)를 누른다.
3.  작성을 완료한다.(C-c C-c)

</div>


## mu4e 사용법 (org mode에서 편지쓰기) {#mu4e-사용법--org-mode에서-편지쓰기}

-   mu4e-org를 사용한다.
    ```text
    (require 'mu4e-org)
    ```

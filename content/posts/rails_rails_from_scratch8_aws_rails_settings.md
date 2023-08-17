+++
title = "[rails] rails from scratch8 aws rails settings"
author = ["holy"]
date = 2023-08-04T00:00:00+09:00
draft = true
+++

## AWS EC2 Server Settings {#aws-ec2-server-settings}


### AWS 계정 만들기 {#aws-계정-만들기}

<a id="figure--aws1"></a>

{{< figure src="/img/web_monitoring/aws1.png" caption="<span class=\"figure-number\">Figure 1: </span>aws1" width="600px" >}}


## AWS EC2와 Web Server Settings(ROR) {#aws-ec2와-web-server-settings--ror}


### EC2 생성 {#ec2-생성}

-   login한 후에 aws ec2를 만들자.

<a id="figure--aws2"></a>

{{< figure src="/img/web_monitoring/aws2.png" width="600px" >}}

1.  Launch instance 실행

<a id="figure--launch instance를 만들자."></a>

{{< figure src="/img/web_monitoring/launchinstance.png" caption="<span class=\"figure-number\">Figure 2: </span>launch instance" width="1000px" height="150px" >}}

1.  ubuntu 20.04를 선택

<a id="figure--ubuntu20.04"></a>

{{< figure src="/img/web_monitoring/ubuntu.png" caption="<span class=\"figure-number\">Figure 3: </span>ubuntu 20.04 image 선택" width="1000px" >}}

3)instance를 설정한다.

<a id="figure--instance설정"></a>

{{< figure src="/img/web_monitoring/instance.png" caption="<span class=\"figure-number\">Figure 4: </span>instance 설정" width="1000px" >}}

1.  storage(EBS)설정 (돈이 들어간다.)

<a id="figure--ebs 설정한다."></a>

{{< figure src="/img/web_monitoring/default.png" caption="<span class=\"figure-number\">Figure 5: </span>ebs  설정한다." width="1000px" >}}

1.  보안관리자(Security Group)

<a id="figure--http 추가"></a>

{{< figure src="/img/web_monitoring/network.png" caption="<span class=\"figure-number\">Figure 6: </span>http추가" width="1000px" >}}

1.  key 생성

<a id="figure--key"></a>

{{< figure src="/img/web_monitoring/key.png" caption="<span class=\"figure-number\">Figure 7: </span>key" width="1000px" >}}


### SSH 접속 settings {#ssh-접속-settings}

<a id="figure--aws3"></a>

{{< figure src="/img/web_monitoring/aws3.png" caption="<span class=\"figure-number\">Figure 8: </span>aws3" width="600px" >}}

1.  받은 pem 키를 chmod 0400으로 설정한 후 ~/.ssh/ 에 넣는다.
2.  ec2의 주소를 check한 후 ssh로 접속해보자.

<a id="figure--ssh1"></a>

{{< figure src="/img/web_monitoring/ssh1.png" width="1000px" >}}

> ssh -i ~/.ssh/ec2_keys.pem ubuntu@주소

aws에서 설정할 때 얻은 ssh pem 키와 주소를 사용해서 ssh접속을 한다. 주소는 dns주소 혹은 ip주소를 사용해도 된다. 아래에 보면 ubuntu계정으로 접속한 것을 볼 수 있다.

<a id="figure--connectio"></a>

{{< figure src="/img/web_monitoring/connection.png" caption="<span class=\"figure-number\">Figure 9: </span>connection" width="1000px" >}}


### root password설정과 root로 ssh 연결 {#root-password설정과-root로-ssh-연결}

<a id="figure--root pw 설정"></a>

{{< figure src="/img/web_monitoring/root_pw.png" caption="<span class=\"figure-number\">Figure 10: </span>root password설정" width="1000px" >}}

1.  ssh 접속을 root로 할 수 있게 설정
    -   ubuntu로 접속한다.
    -   sudo vi /etc/ssh/sshd_config에서

        > '#PermitRootLogin prohibit-password를
        > PermitRootLogin prohibit-password yes로 바꾼다.
2.  su root를 사용해서 root로 switch한다.
3.  cd로 home/.ssh으로 이동
4.  mv authorized_key authorized_key_bak
5.  cp _home/ubuntu_.ssh/authorized_keys .
    현재 ubuntu계정의 ssh키만 aws ec2에 접속할 수 있는 이유는 authorized_key때문이다. 이 key를 root에 복사해서 root로
    접근할 수 있게 하는 것이다.
6.  service sshd restart

<a id="figure--ssh처리"></a>

{{< figure src="/img/web_monitoring/ssh처리.png" caption="<span class=\"figure-number\">Figure 11: </span>ssh 처리" width="1000px" >}}

1.  root로 접근이 되는 지 확인해 본다.

<a id="figure--root ssh"></a>

{{< figure src="/img/web_monitoring/rootssh.png" caption="<span class=\"figure-number\">Figure 12: </span>root ssh" width="1000px" >}}


### deploy를 위한 계정 설정 {#deploy를-위한-계정-설정}

<a id="figure--aws4"></a>

{{< figure src="/img/web_monitoring/aws4.png" caption="<span class=\"figure-number\">Figure 13: </span>aws4" width="600px" >}}

1.  ssh root로 접근
2.  deploy계정 생성

<a id="org0a3256d"></a>

<img src="/img/web_monitoring/deployaccount.png" alt="deployaccount.png" width="600px" />
나머지 설정도 해준다.

1.  deploy계정에도 ubuntu, root처럼 ssh 접근이 가능하게 설정한다.

    > -   sudo mkdir _home/deploy/_.ssh
    > -   sudo cp _home/ubuntu/_.ssh/authorized\__keys  _home/deploy/_.ssh
    > -   sudo chown -R deploy:deploy _home/deploy/_.ssh
    > -   sudo service sshd restart
    > -   sudo usermod -aG sudo deploy

2.  test를 해본다.


### ruby 설정 (deploy계정으로) {#ruby-설정--deploy계정으로}

<a id="figure--"></a>

{{< figure src="/img/web_monitoring/aws5.png" caption="<span class=\"figure-number\">Figure 15: </span>루비 설치" width="600px" >}}

<a id="figure--deploy2"></a>

{{< figure src="/img/web_monitoring/deploy2.png" caption="<span class=\"figure-number\">Figure 16: </span>deploy2" width="1000px" >}}

<div class="note">

(1) curl -s(silent)L(location) nodejs 12.x  =&gt; nodejs를 install한다.

(2) yarn -s(silent)S(show errors) =&gt; yarn으로 부터 public key를 가져와서 apt-key 저장소에 등록한다. 그래야 apt로 다운받을 수 있다.

(3) deb <https://dl.yarnpkg.com/debian/> stable main" | sudo tee /etc.. =&gt; deb로 시작하는것은 3rd party program의 저장소를 가르킨다. sources.list.d/yarn.list는 yarn을 down 받을 수 있는 저장소의 위치를 yarn.list에 기술하면 install할 수 있다.

(4) sudo apt-get install로 필요한 library를 설치한다. 위의 과정들은 nodejs, yarn, redis를  apt-get install로 설치하기 위한 과정이라고 보면 된다.

</div>


### rbenv 설정(deploy계정으로) {#rbenv-설정--deploy계정으로}

<a id="figure--aws6"></a>

{{< figure src="/img/web_monitoring/aws6.png" caption="<span class=\"figure-number\">Figure 17: </span>aws6" width="600px" >}}

<a id="figure--deploy3"></a>

{{< figure src="/img/web_monitoring/deploy3.png" caption="<span class=\"figure-number\">Figure 18: </span>deploy3" width="1000px" >}}

<div class="note">

1.  git clone 으로 .rbenv를 설치한다.
2.  .rbenv/bin을 path에 등록한다.   =&gt; 이것은 설치한 rbenv의 실행파일을 실행할 수 있게 하는 것이다.
3.  eval rbenv init - &gt;&gt; ~/.bashrc    =&gt; rbenv를 사용하기 위해선 rbenv init을 해주어야 하는데, 매번 system을 시작할 때 해주기가 그래서 shell script파일에 기술해준다.
4.  ruby-build =&gt; ruby-build는 rbenv plugin이다. ruby-build를 설치하면, rbenv-install이 있어서 ruby를 설치할 수 있다.
5.  ruby-build의 path도 추가
6.  rbenv-vars도 rbenv의 plugin이다. rbenv에서 환경변수를 사용할 수 있게 한다.

</div>


### bundler설정 (deploy계정으로) {#bundler설정--deploy계정으로}

<a id="figure--"></a>

{{< figure src="/img/web_monitoring/aws7.png" caption="<span class=\"figure-number\">Figure 19: </span>aws7" width="600px" >}}

<a id="figure--bundler"></a>

{{< figure src="/img/web_monitoring/bundler.png" caption="<span class=\"figure-number\">Figure 20: </span>bundler" width="1000px" >}}

bundler는 최신 버전을 설치해도 되지만, 오래된 gem들은 설치가 안되는 문제가 있어서 낮은 버전의 bundler를 실행해야 한다고 한다.


### Nginx &amp; Passenger 설정 (deploy 계정으로) {#nginx-and-passenger-설정--deploy-계정으로}

<a id="figure--"></a>

{{< figure src="/img/web_monitoring/aws8.png" caption="<span class=\"figure-number\">Figure 21: </span>nginx &amp; passenger" width="600px" >}}

<a id="figure--nginx & passenger"></a>

{{< figure src="/img/web_monitoring/nginx.png" caption="<span class=\"figure-number\">Figure 22: </span>nginx&amp;passenger" width="600px" >}}

<div class="note">

1.  key server에 key를 등록
2.  phusion passenger를 설치하기 위해서, source.list.d에 등록한다. 이렇게 해야 apt-get install로 설치할 수 있다.
3.  nginx는 여러종류가 있다. (nginx-full, nginx-extra...) =&gt; nginx-extra(extended version)을 사용하고, library passenger module을 설치한다.

ps:  NGINX는 모듈로 구성되어 있다. nginx에 사용되는 module은 /etc/nginx/modules-enabled/폴더에 있는데, 이미 동작되는 모듈이고, 여기에 module을 넣으면 동작된다.
ps: /usr/share/nginx/modules-available/에는 사용가능한 module들이 있다.

1.  passenger를 설치했기 때문에, passenger는 /usr/share에 있는 사용가능한 module이기 때문에, Nginx의 /etc/nginx/modules-enabled/폴더에 넣어줘야 된다.

</div>

즉 위의 과정은 nginx와 passenger를 설치한 후에, passenger모듈을 nginx에 연동한것이다. Nginx의 설정파일은 /etc/nginx/conf.d에 있고, 모듈들의 설정도 여기서 한다.

1.  passenger config 파일 수정

    > sudo vi /etc/nginx/conf.d/mod-http-passenger.conf

    아래와 같이 수정한다.

<a id="figure--passenger config"></a>

{{< figure src="/img/web_monitoring/pruby.png" caption="<span class=\"figure-number\">Figure 23: </span>passenger config" width="600px" >}}

passenger 설정을 끝맞쳤는데 전체적인 과정을 살펴볼 필요가 있다.

<a id="figure--aws9"></a>

{{< figure src="/img/web_monitoring/aws9.png" caption="<span class=\"figure-number\">Figure 24: </span>aws9" width="600px" >}}

web server는 3개로 구성되어 있다.http server에 해당하는 nginx가 있고, 동적인 문서를 만들어내기 위한 WAS에 해당하는 Phusion Passenger가 있다. 그리고 동적인 page를 만들어내는 rails application이 있다.
http server는 정적인 파일(test.html, test.png..)을 처리한다. 반면 was는 동적인 파일(test.php,test.asp,test.rb)에 대한 처리를 담당한다. 즉 예를 들어,  gateway단에서 nginx가 요청을 받고 동적인 파일인 경우, passenger에게 넘기게 된다.

-   그림설명

Nginx를 설치하고 passenger는 module로 설치했다. 즉 모든것인 nginx안에 포함된 형태다. 외부에서 볼때는 nginx 하나 밖에 안 보인다. nginx설정파일에서 모든 설정을 담당한다. passenger모듈에 대한 설정은 nginx에서 설정파일을 호출하는 식으로 한다. nginx에서는 sites-enabled에 있는 myapp이란 rails application 설정을 호출한다. 즉 nginx가 기동되면, 설정파일을 읽는데, nginx설정파일을 읽고, 그 다음 passenger, 그 다음, rails application설정을 읽는 것이다. 그 이름은 myapp이다.

1.  nginx를 다시 시작한다.

    > sudo service nginx start
2.  nginx 접속 해 본다.

<a id="figure--nginx"></a>

{{< figure src="/img/web_monitoring/nginx2.png" caption="<span class=\"figure-number\">Figure 25: </span>nginx" width="600px" >}}

1.  nginx에 우리의 app을 연결한다.

<a id="figure--nginx with myapp"></a>

{{< figure src="/img/web_monitoring/nginx3.png" caption="<span class=\"figure-number\">Figure 26: </span>nginx associates with my app" width="600px" >}}

기존에 연결된 default를 제거하고, 대신 myapp을 설정한다.
그리고 다시 nginx를 다음과 같이 reload한다.

> sudo service nginx reload

-   **Problem**: 예상치 못한 에러 발생

<a id="org3ec3f18"></a>

<img src="/img/web_monitoring/nginx4.png" alt="nginx4.png" width="1000px" />
journalctl -xe를 실행해서 에러의 원인이 뭔지 알고 싶었다. 다음과 같은 메시지가 있었다.

<a id="org9a40c73"></a>

<img src="/img/web_monitoring/pam.png" alt="pam.png" width="600px" />
더 정확한 확인을 위해서 nginx의 log를 확인해 보자

<a id="org1c422fb"></a>

<img src="/img/web_monitoring/errorlog.png" alt="errorlog.png" width="1000px" />
위에 보면 gzip_static_on에 문제가 있어 보인다.

-   **solution**: server의 site-enabled/설정파일에서  gzip_static on으로 고쳤다.


### Mariadb Database 설치하기 (deploy 계정으로 접속해서) {#mariadb-database-설치하기--deploy-계정으로-접속해서}

<a id="figure--aws10"></a>

{{< figure src="/img/web_monitoring/aws10.png" caption="<span class=\"figure-number\">Figure 29: </span>aws10" width="600px" >}}

1.  우선 system을 업그레이드한다.

    > sudo apt update &amp;&amp; sudo apt-get -y upgrade

2.  sudo apt-get install -y mariadb-server
    mariadb server를 설치한다.
3.  sudo apt-get install -y mariadb-client
    mariadb client를 설치한다.
4.  sudo apt-get install -y libmariadbclient-dev
5.  sudo mysql_secure_installation
    root pw를 설정한다.
    1.  password를 묻는다. 이것은 system password, sudo에 대한..그래서 1234를 입력
    2.  validation production : y
    3.  root pw 입력:root1234, 참고로 deploy계정은 pw:user1234
    4.  anonmous user 삭제:y
    5.  remote :n
    6.  testdb delete :y
    7.  privileges table reload: y
6.  sudo mysql -u root -p
    mariadb 설치후에 바로 접속을 시도 해도 접속이 된다.

<a id="figure--mysql"></a>

{{< figure src="/img/web_monitoring/connection.png" caption="<span class=\"figure-number\">Figure 30: </span>mysql connection" width="400px" >}}

1.  mariadb에서 database와 user를 만든다.

<a id="figure--db & user"></a>

{{< figure src="/img/web_monitoring/db_create.png" caption="<span class=\"figure-number\">Figure 31: </span>db &amp; user" width="400px" >}}

rails app도 myapp으로 했지만, db에서 database도 myapp으로 통일한다.
aws에서 만든 계정인 deploy를 db에서도 접근할 수 있게 db에도 만든다.

<div class="note">

mysql -uroot -p로 접속해서, myapp이라는 database를 만든다. 해당 database에 접근할 계정은 ec2계정의 deploy계정과 동일하다. 그래서 deploy라는 계정을 db에도 만들고, db에서 myapp이라는 database를 접근할 수 있게 한다. 즉 deploy라는 계정으로 ec2접속, db접속을 할 수 있게 해야 capistrano로 CI/CD를 할 수 있는 것이다.

</div>


### Capistrano설정 {#capistrano설정}


#### capistrano의 일반적 처리과정. {#capistrano의-일반적-처리과정-dot}

<a id="figure--capistrano"></a>

{{< figure src="/img/web_monitoring/capistranod.png" caption="<span class=\"figure-number\">Figure 32: </span>capistrano" width="600px" >}}

1.  aws(운영서버)에 접속할 pem이 있는지 확인. pem이 있다면 ssh로 접속한다.
2.  git을 접속할수 있는지 확인(ssh permission), ssh key가 있다면 접속
3.  git source를 배포 서버에 복사 (이 과정이 git:check, git:install....)
4.  Gem을 bundler를 이용해서 설치(이 과정이 bundler:check, bundler:install...)
5.  nginx를  restart


#### Gemfile 설정 {#gemfile-설정}

Local로 다시 들어간다. myapp으로 간다. Gemfiles에 다음을 추가한다. 추가할 때 group :development에 할당하자.
이 과정은 capistrano package를 설치하겠다는 것이다.

> gem 'capistrano', '~&gt; 3.11'
> gem 'capistrano-rails', '~&gt; 1.4'
> gem 'capistrano-passenger', '~&gt; 0.2.0'
> gem 'capistrano-rbenv', '~&gt; 2.1', '&gt;= 2.1.4'

이렇게 작성 하고  다음을 실행한다.

> bundle
> cap install STAGES=production

bundle을 실행하면, gemfile에 기술된 gem들이 install된다. capistrano도 installed되어서 cap이란 명령어를 실행할 수 있다.
cap install을 실행하면, deploy를 위한 설정 파일(.rb)들을 만들어 낸다.
만일 cap명령어를 실행하나 수행되지 않을 때는 rbenv rehash를 하고 다시 실행한다.

<a id="org0d3383a"></a>

 <img src="/img/web_monitoring/rehash.png" alt="rehash.png" width="400px" />
cap으로 만들어지는 파일은 capfile, deploy.rb, staging.rb,production.rb같은 deploy같은 설정파일들이다.


#### Capfile 설정 {#capfile-설정}

capfile은 배포설정 파일을 load할 뿐이다. 실제 설정은 load되는 파일에서 한다.

> require 'capistrano/rails'
> require 'capistrano/passenger'
> require 'capistrano/rbenv'
>
> set :rbenv_type, :user
> set :rbenv_ruby, '3.0.1'


#### config/deploy.rb 설정 {#config-deploy-dot-rb-설정}

<a id="figure--deploy septtings"></a>

{{< figure src="/img/web_monitoring/deploysettings.png" caption="<span class=\"figure-number\">Figure 34: </span>deploy settings" width="600px" >}}


### Capistrano Error {#capistrano-error}


#### Thread error {#thread-error}

<a id="org38d3aec"></a>

<img src="/img/web_monitoring/cap1.png" alt="cap1.png" width="600px" />
=&gt; cap은 aws에 접근할 수 있는 pem키가 없다면, cap이 진행되지 않고 바로 exception이 난다.
ssh-add 를 사용해서 key를 등록한다. ssh-add ~/.ssh/company-ec2-keys.pem을 수행한다.


#### git:check error-permission denied error {#git-check-error-permission-denied-error}

<a id="org80abe84"></a>

<img src="/img/web_monitoring/cap2.png" alt="cap2.png" width="600px" />
   =&gt; ssh-add ~/.ssh/id-rsa 를 해보면 될 수 있다.


#### git:create_release master error {#git-create-release-master-error}

=&gt; set branch main in deploy.rb


#### bundle:install {#bundle-install}

=&gt; [arm64-darwin-20] but your local platform is x86_64-linux

<a id="org327b2f9"></a>

   <img src="/img/web_monitoring/deploy_local.png" alt="deploy_local.png" width="600px" />
이것의 원인은 capistrano처리중에 github에서 rails app source를 가지고 와서 배포서버의 release폴더에 넣은 후에 bundler를 실행할 때 발생되는 에러같다. bundler가 Gemfile.lock을 실행하는 데 Platform이 local에서는 arm64-darwin-20은 정해져 있으나, x86-64-linux가 기술되어 있지 않다는 것이다. local에서는 bundle lock --add-platform x86_64-linux를 실행해서 변경할 수 있다고 하는데, Gemfile.lock에서 x86_64-linux가 추가된 것을 확인할 수 있다. 그런데 실제 배포server의 release폴더에 있는 Gemfile.lock에는 반영되지 않은 것을 볼 수 있다. 이것의 원인을 찾고자, 배포 서버에 접속해서 log를 살펴보았다.

> less /home/deploy/myapp/current/log/production.log

별다른 내용은 없었다. 그래서 release폴더에서 bundle을 실행했고, bundle lock --add-platform x86_64-linux를 실행했다. 그랬더니 다음과 같은 에러가 발생했다.

<a id="figure--deploy 배포 서버"></a>

{{< figure src="/img/web_monitoring/deploy_server.png" caption="<span class=\"figure-number\">Figure 38: </span>deploy 배포서버" width="600px" >}}

이 에러는 nokogiri를 설치할때 발생되는 에러같다. gorails에서 처음에 nokogiri를 설정할 때 처리해야 할 것들이 적힌곳이 있다. 그것과 관련이 있는지는 모르겠다. Gemfile과 Gemfile.lock은 구조가 많이 다르다. Gemfile에는 몇개의 package만 적혀 있고, Gemfile.lock에는 Gemfile에서 명시했던 package를 구성하는 세부 package들이 버전별로 나열되어 있는거 같다. nokogiri란 package는 Gemfile에는 기술 되어 있지 않으나, Gemfile.lock에는 기술되어 있는거 같다.

=&gt; 해결책
우선 cap production deploy할 때, 배포 서버에서 실행하는것은 무조건 github의 내용이다. 만일 local에서 무언가를 고치거나, 수정했다면, github에 commit한 후에 cap production deploy를 해야할 듯하다.


### bundler:install, Failed to build gem native extension {#bundler-install-failed-to-build-gem-native-extension}

<a id="orga6ba257"></a>

<img src="/img/web_monitoring/bundle_error.png" alt="bundle_error.png" width="600px" />
이 문제에 대한 처리 과정은 다음과 같다.

<a id="orgb8dd941"></a>

<img src="/img/web_monitoring/extsolution1.png" alt="extsolution1.png" width="600px" />\\

우선 위에 적힌대로 해보자. 그런데, 근본적인
문제는 mysql2 설치 문제다. 배포 서버에 들어가서 mysql2를 설치해 보자.
동일한 에러가 발생한다.

<a id="org1c9e8aa"></a>

<img src="/img/web_monitoring/mysql2error.png" alt="mysql2error.png" width="600px" />
=&gt; 해결 :  sudo apt-get install libmysqlclient-dev를 설치하니 무사히 설치되었다.


### deploy:migrating error {#deploy-migrating-error}

<a id="orgfbb7209"></a>

   <img src="/img/web_monitoring/mysqlhosterror.png" alt="mysqlhosterror.png" width="600px" />
우선 mysql관련 설정환경을 배포 서버의 .rbenv-vars파일에 기술했었는데, 그게 문제일 수도 있다는 생각이 들었다. capistrano가 db에 접속을 해야 하는데, 접속은 URL로 하고, URL정보는 .rbenv-vars파일에 기술했기 때문이다. 그래서 다음과 같이 .rbenv-vars파일을 변경해 보았다.

> vi _home/deploy/myapp_.rbenv-vars
> DATABASE_URL=mysql2://deploy@localhost:/myapp

다른 에러가 발생했다.

<a id="figure--mysqlsocketerror"></a>

{{< figure src="/img/web_monitoring/mysqlsocketerror.png" caption="<span class=\"figure-number\">Figure 43: </span>mysqlsocketerror" width="600px" >}}

배포 서버에서 mysql이 제대로 설치 되지 않은거 같다. 그래서 gorails에서 나온대로 다시 mysql-server, myssql-client, libmysqlclient-dev를 설치해본다. mysql-server 설치에 문제가 있음을 알 수 있었다. 여튼 설치를 끝내고,  sudo mysql_secure_installation를 실행하면 다음과 같은 에러가 있음을 알 수 있다.

<a id="figure--secure-connection"></a>

{{< figure src="/img/web_monitoring/secure_connection.png" caption="<span class=\"figure-number\">Figure 44: </span>secure_connection" width="600px" >}}


### db관련 에러가 계속해서 나올경우 {#db관련-에러가-계속해서-나올경우}

mysql과 mariadb를 모두 삭제한다.

>  apt-get remove --purge mysql\*
> apt-get remove --purge mysql
> apt-get remove --purge mariadb
> apt-get remove --purge mariadb\*
> apt-get --purge remove mariadb-server
> apt-get --purge remove python-software-properties

한번에 삭제가 안되면 한 두번 실행한다.

그리고 다시 mariadb를 설치해본다. 설치과정은 다음과 같다.

> sudo apt-get install -y mariadb-server mariadb server를 설치한다.
> sudo apt-get install -y mariadb-client mariadb client를 설치한다.
> sudo apt-get install -y libmariadbclient-dev

그리고 cap production deploy를 하면 또 다시 다른 에러가 나온다.

<a id="figure--socket error"></a>

{{< figure src="/img/web_monitoring/socketerror2.png" caption="<span class=\"figure-number\">Figure 45: </span>socket error" width="600px" >}}

이것은 /tmp/mysql.sock을 찾을 수 없다는 건데, database.yml에 보면 socket정보가 tmp/mysql.sock에 있기 때문이다. 실제 배포 서버는 socket이 저장되는 위치는 var/run/mysqld/mysql.sock이다. 그래서 이것을 바꿔줘야 하는데, database.yml에서 바꿔준 다음 반드시 github에 반영해야 한다. 왜냐면 capistrano는 github의 내용을 바탕으로 실행하기 때문이다.

그러면 socket 문제는 해결된다. 하지만, Access denied 문제가 발생된다.

<a id="figure--socket"></a>

{{< figure src="/img/web_monitoring/socketerror3.png" caption="<span class=\"figure-number\">Figure 46: </span>socket" width="600px" >}}

db에 deploy계정이 있는지 확인해 본다. 또한 myapp이란 db가 있는지도 확인해 본다.
myapp이란 db에 deploy가 접근할수 있도록 권한을 부여해야 하기 때문이다.
없으면 만든다.

> sudo mysql -uroot -p
> show databases;  //check if myapp db exists
>  use mysql
> select User, Plugin, Host from user;  //check if deploy account exists
> drop user 'deploy'@'localhost'; or drop user 'deploy'@'';
> CREATE DATABASE IF NOT EXISTS myapp;
> CREATE USER IF NOT EXISTS 'deploy'@'localhost' IDENTIFIED BY '$omeFancyPassword123';
> CREATE USER IF NOT EXISTS 'deploy'@'%' IDENTIFIED BY '$omeFancyPassword123';
> GRANT ALL PRIVILEGES ON myapp.\* TO 'deploy'@'localhost';
> GRANT ALL PRIVILEGES ON myapp.\* TO 'deploy'@'%';
> FLUSH PRIVILEGES;


### cap production deploy 하자마자 sshkit error {#cap-production-deploy-하자마자-sshkit-error}

<a id="org68abed3"></a>

<img src="/img/web_monitoring/capproduction.png" alt="capproduction.png" width="600px" />
이것은 aws pem키가 등록되지 않았다는 에러다. ssh-add ~/.ssh/company-ec2-keys.pem로 등록을 해야 한다.


### git permission error {#git-permission-error}

<a id="org6ef77d8"></a>

<img src="/img/web_monitoring/gitcheckerror.png" alt="gitcheckerror.png" width="600px" />
이것은 git ssh public key가 등록되지 않았다는 에러다. ssh-add ~/.ssh/id_rsa로 등록을 해준다.


### phusion messager is not running {#phusion-messager-is-not-running}

<a id="figure--passenger error"></a>

{{< figure src="/img/web_monitoring/passengererror0.png" caption="<span class=\"figure-number\">Figure 49: </span>passenger error" width="600px" >}}

cap production deploy했을때 별다른 이상없이 통과되어 해당 web server로 접속하면, 위와 같은 에러가 발생되는데, 다시 cap production deploy 진행과정을 보니 다음과 같은 문제가 있었다.

<a id="figure--passenger error"></a>

{{< figure src="/img/web_monitoring/passengererror.png" caption="<span class=\"figure-number\">Figure 50: </span>passenger error" width="600px" >}}

<a id="figure--passenger3"></a>

{{< figure src="/img/web_monitoring/passengererror3.png" caption="<span class=\"figure-number\">Figure 51: </span>passenger error3" width="600px" >}}

그래서 /va/log/nginx/error.log로 가서 어떤 에러인지 확인해봤다.

<a id="figure--passenger log error"></a>

{{< figure src="/img/web_monitoring/passengerlog.png" caption="<span class=\"figure-number\">Figure 52: </span>passenger error" width="600px" >}}

근데 찝찝했던건, gorails에서 세팅을 제대로 하지 않았다는 것이다.

<a id="figure--go rails settings"></a>

{{< figure src="/img/web_monitoring/gorails.png" caption="<span class=\"figure-number\">Figure 53: </span>gorails settings" width="600px" >}}

=&gt; 해결
배포서버로 접속해서 myapp/.rbenv-vars파일을 만들고 그냥 복사 붙여넣기 했다.
그게 좀 찝찝해서 database_url도 변경하고, 어디서 보고 변경했는지는 잘 기억이 안나지만, 그것도 변경하고, RAILS_MASTER_KEY도 ohai가 아닌, myapp/config/master.key파일을 읽고 그 hash값을 붙여넣으니 문제가 해결되었다. 정확한 내용은 모르지만, 접속관련한 중요한 사항들을 secret.yml에 넣었다고 한다. 이 secret.yml이 버전이 올라가면서 변경된 것이다. 왜냐하면 rails에서 app을 만들자마자 git을 만들고, 배포를 위해서 github에 저장하는데, 접속정보는 중요한 파일이라서 github에 그대로 노출될 수 있기 때문이다. 그래서 예전에는 개발자가 gitignore로 github에 올라가지 않게 했는데, 보안 문제로 이번에 완전 바꾼거다. .authinfo.gpg를 만들고 저장하면, 저장한게 자동으로 암호화 되어, gpg key가 있어야 편집이 가능하듯이, 접속정보를 가지고 있는 credentials.yml.enc는 암호화되어 있고, master key가 있어야 접근할 수 있는 구조다. 그래서 배포를 하는 capistrano는 master key정보가 있어야 한다. 이것을 배포 서버의 myapp/.rbenv-vars파일의  mastser_key변수에 넣어주면, capistrano는 credentials.yml.enc에 접근할수 있는 것이다. 그러면 위에 적힌 SECRET_BASE는 어떻게 설정하는가?

우선 credentials.yml.enc를 편집하는 방법을 보자. local에서 myapp/config로 들어간 이후,

> EDITOR=vim rails credentials:edit

이렇게 하면 credentials를 읽을 수 있다.

<a id="org1403bb3"></a>

<img src="/img/web_monitoring/credentials.png" alt="credentials.png" width="600px" />
그리고 secret_key_base를 볼 수 있다. 이것을 복사해서 운영서버로 가서 myapp/.rbenv-vars에 붙여넣기 한다.

이렇게 하고 cap production deploy를 실행해보자.

<a id="figure--result1"></a>

{{< figure src="/img/web_monitoring/final_deploy1.png" caption="<span class=\"figure-number\">Figure 55: </span>result1" width="600px" >}}

<a id="figure--result2"></a>

{{< figure src="/img/web_monitoring/final_deploy2.png" caption="<span class=\"figure-number\">Figure 56: </span>result2" width="600px" >}}

<a id="figure--result3"></a>

{{< figure src="/img/web_monitoring/final_deploy3.png" caption="<span class=\"figure-number\">Figure 57: </span>result3" width="600px" >}}

<a id="figure--result4"></a>

{{< figure src="/img/web_monitoring/final_deploy4.png" caption="<span class=\"figure-number\">Figure 58: </span>result4" width="600px" >}}

<a id="figure--result5"></a>

{{< figure src="/img/web_monitoring/final_deploy5.png" caption="<span class=\"figure-number\">Figure 59: </span>result5" width="600px" >}}

이제 <http://3.34.94.252> 에 접속해 보자.
다음과 같은 에러가 나온다.

<a id="figure--error"></a>

{{< figure src="/img/web_monitoring/error.png" caption="<span class=\"figure-number\">Figure 60: </span>error" width="600px" >}}

에러의 원인을 찾아보기 위해서 운영서버의 /myapp/log/production.log를 보면 다음과 같은 에러가 있다.

<a id="figure--routing error"></a>

{{< figure src="/img/web_monitoring/routingerror.png" caption="<span class=\"figure-number\">Figure 61: </span>routing error" width="600px" >}}

routing error다. 이것은 routes.rb에 처리하는 루틴이 없기 때문이다. 그런데 local에서는 routes.rb에 처리 루틴이 없는데도 welcome page가 보인다.  무슨 차이가 있는지 모르겠지만, capistrano를 통해서 운영서버에 배포하고 연결을 시도 했을 때는 welcome page가 보이지 않는다.  그래서 간단히 hello world를 출력하는 코드를 만들어봤다.


#### routes.rb {#routes-dot-rb}

> get "/articles", to: "articles#index"


#### rails g controller {#rails-g-controller}

> rails g controller Articles index --skip-routes


#### index.html.erb {#index-dot-html-dot-erb}

> &lt;h1&gt; hello hoyoul&lt;/h1&gt;

위와 같이 하고 github에 저장한후 cap production deploy를 사용해서 운영서버에 배포한후 url로 접근하면 해당 페이지를 볼 수 있다.

<a id="figure--hello"></a>

{{< figure src="/img/web_monitoring/hello .png" caption="<span class=\"figure-number\">Figure 62: </span>hello" width="600px" >}}


### nginx 설정과  log위치 [ubuntu] {#nginx-설정과-log위치-ubuntu}

> /etc/nginx/nginx.conf [설정]
>  /var/log/nginx/error.log [log]
> tails -f /var/log/nginx/error.log

nginx는 일반적인 설정을 한뒤 가상 호스트를 위한 설정 파일을 실행한다.

> /etc/nginx/sites-enabled/myapp

을 실행한다.


### passenger log file {#passenger-log-file}

passenger가 nginx에 통합되어 설치되어 있어서 동일한 log를 사용한다고 보면 된다.


## AWS 계정 설정(root and IAM) {#aws-계정-설정--root-and-iam}


### root계정 처리 {#root계정-처리}

AWS을 사용하면 root계정으로 login하면 안된다. IAM 사용자 계정을 사용해야 한다. root계정은 보안문제로 MFA(Multi Factor Authentication)을 꼭 설정해야 한다.

<a id="figure--IAM1"></a>

{{< figure src="/img/web_monitoring/root1.png" caption="<span class=\"figure-number\">Figure 63: </span>ROOT" width="600px" >}}

<a id="figure--"></a>

{{< figure src="/img/web_monitoring/root2.png" caption="<span class=\"figure-number\">Figure 64: </span>ROOT2" width="600px" >}}

<a id="figure--root3"></a>

{{< figure src="/img/web_monitoring/root3.png" caption="<span class=\"figure-number\">Figure 65: </span>root3" width="600px" >}}

<a id="figure--root4"></a>

{{< figure src="/img/web_monitoring/root4.png" caption="<span class=\"figure-number\">Figure 66: </span>root4" width="600px" >}}

설치할 MFA기기는 가상기기이고, 내 경우, google authenticator를 설치했다.
중간에 보면 **show QR code** 가 있다. 이것을 누르면 QR code가 보인다. 그리고 code1과 code2를 기입한다.

<a id="org54ed206"></a>

<img src="/img/web_monitoring/root5.png" alt="root5.png" width="600px" />
이제 root에 대한 MFA처리가 끝났다.

<a id="org81f028c"></a>

<img src="/img/web_monitoring/root6.png" alt="root6.png" width="600px" />
앞으로 root login은 mfa로 묻는다.
이제 IAM계정을 만든다.


### IAM 계정 처리(group and user) {#iam-계정-처리--group-and-user}

보통은 group을 만들고 group에 permission을 준 다음에 user를 넣어주지만, 작은 조직의 경우, user만을 생성해서 관리해도 된다.

<a id="figure--"></a>

{{< figure src="/img/web_monitoring/user1.png" caption="<span class=\"figure-number\">Figure 69: </span>user 생성" width="600px" >}}

<a id="figure--"></a>

{{< figure src="/img/web_monitoring/user2.png" caption="<span class=\"figure-number\">Figure 70: </span>user 생성" width="600px" >}}

위와같이 user id를 만들고, pw를 설정한다. pw를 임시로 설정하고, 실제 login시 사용자가 설정하도록 한다.

<a id="orgbb9ff41"></a>

<img src="/img/web_monitoring/user3.png" alt="user3.png" width="600px" />
정책을 선택한다.

<a id="figure--user 생성"></a>

{{< figure src="/img/web_monitoring/user4.png" caption="<span class=\"figure-number\">Figure 72: </span>user 생성" width="600px" >}}

<a id="org722f27d"></a>

<img src="/img/web_monitoring/user5.png" alt="user5.png" width="600px" />
tag 생성은 넘어간다.

<a id="figure--"></a>

{{< figure src="/img/web_monitoring/user6.png" caption="<span class=\"figure-number\">Figure 74: </span>user 생성" width="600px" >}}

<a id="figure--"></a>

{{< figure src="/img/web_monitoring/user7.png" caption="<span class=\"figure-number\">Figure 75: </span>user 생성" width="600px" >}}

이제 user가 만들어졌고, login할 수 있는 account ID 가 만들어져서 접속할 수 있게 되었다.
위에 account id를 로긴할 때 입력하면 된다.
참고로 account ID는 모든 IAM 계정들은 동일한 값을 갖는다.

<a id="figure--"></a>

{{< figure src="/img/web_monitoring/user8.png" caption="<span class=\"figure-number\">Figure 76: </span>user 생성" width="600px" >}}


## AWS 고정 IP 설정 {#aws-고정-ip-설정}

<a id="figure--eip"></a>

{{< figure src="/img/web_monitoring/eip.png" caption="<span class=\"figure-number\">Figure 77: </span>elastic IP" width="600px" >}}

AWS에서 ec2를 만들면, public ip이지만, 이것은 고정된 ip가 아니다. DHCP처럼 ec2는 재시작할 때 마다, ip를 갱신하는 과정을 거친다. 이를 고정 IP로 하기 위해선, elastic ip를 사용한다.  설정방법은 그냥 default로 진행하는건데, 이렇게 할때, option은 어떻게 설정해야 하는가? 하는 문젠데 설명이 나와 있진 않다.

<a id="figure--eip2"></a>

{{< figure src="/img/web_monitoring/eip2.png" caption="<span class=\"figure-number\">Figure 78: </span>eip2" width="600px" >}}

위와 같이 해주면 elastic ip가 만들어졌다. 만들어진 elastic ip를 ec2와 연결하는 과정이 필요하다.
다시 ec2 dashboard로 접속한다. 거기서 elastic ip를 선택한다.

<a id="figure--eip3"></a>

{{< figure src="/img/web_monitoring/eip3.png" caption="<span class=\"figure-number\">Figure 79: </span>eip3" width="600px" >}}

<a id="figure--"></a>

{{< figure src="/img/web_monitoring/eip4.png" caption="<span class=\"figure-number\">Figure 80: </span>eip4" width="600px" >}}

여기까지 하면 elastic ip를 만들고 ec2와 연동하는 것까지 완료가 되었다. 이제 확인해 보자.
ec2 dashboard로 접근한다. 그 다음 ec2 instance의 정보를 보자.

<a id="figure--"></a>

{{< figure src="/img/web_monitoring/eip5.png" caption="<span class=\"figure-number\">Figure 81: </span>eip5" width="600px" >}}


## AWS DNS 주소 할당과정 {#aws-dns-주소-할당과정}

<a id="figure--"></a>

{{< figure src="/img/web_monitoring/Route_53_1.png" caption="<span class=\"figure-number\">Figure 82: </span>route53" width="600px" >}}

<a id="org30430bd"></a>

<img src="/img/web_monitoring/route_53_1-2.png" alt="route_53_1-2.png" width="600px" />
위에서 원하는 domain주소를 구입할 수 있다. 가격은 그렇게 비싸지 않은듯 하다.
domain주소를 구입한 후에 등록을 한다.

<a id="figure--route53"></a>

{{< figure src="/img/web_monitoring/route_53_1-3.png" caption="<span class=\"figure-number\">Figure 84: </span>route53" width="600px" >}}

<a id="figure--route53"></a>

{{< figure src="/img/web_monitoring/route_53_1-4.png" caption="<span class=\"figure-number\">Figure 85: </span>route53" width="600px" >}}

<a id="figure--route53"></a>

{{< figure src="/img/web_monitoring/route_53_1-5.png" caption="<span class=\"figure-number\">Figure 86: </span>route53" width="600px" >}}


## AWS domain주소와 EC2연동 {#aws-domain주소와-ec2연동}

<a id="figure--route53"></a>

{{< figure src="/img/web_monitoring/route_53_2.png" caption="<span class=\"figure-number\">Figure 87: </span>route53" width="600px" >}}

<a id="figure--route53"></a>

{{< figure src="/img/web_monitoring/route_53_2-1.png" caption="<span class=\"figure-number\">Figure 88: </span>route53" width="600px" >}}

<a id="figure--route53"></a>

{{< figure src="/img/web_monitoring/route_53_3.png" caption="<span class=\"figure-number\">Figure 89: </span>route 53" width="600px" >}}

<a id="figure--route53"></a>

{{< figure src="/img/web_monitoring/route_53_4.png" caption="<span class=\"figure-number\">Figure 90: </span>route 53" width="600px" >}}


## AWS domain주소에서 www추가 방법 {#aws-domain주소에서-www추가-방법}

<div class="note">

이것은 간단하다. route53을 이용하면 된다.

</div>

-   route53으로 이동한다.

<a id="figure--"></a>

{{< figure src="/img/web_monitoring/www1.png" caption="<span class=\"figure-number\">Figure 91: </span>www1" width="600px" >}}

-   host zone을 click해서 이동한다.

<a id="figure--"></a>

{{< figure src="/img/web_monitoring/www2.png" caption="<span class=\"figure-number\">Figure 92: </span>www2" width="600px" >}}

-   alias만드는 법
-   create record를 선택하고 아래 그림처럼 처리하면 된다.

<a id="figure--"></a>

{{< figure src="/img/web_monitoring/www3.png" caption="<span class=\"figure-number\">Figure 93: </span>www3" width="600px" >}}


## AWS EC2 instance type변경 {#aws-ec2-instance-type변경}

<div class="note">

현재 t2.micro 프리티어를 사용한다. t1.micro의 사양은 다음과 같다.

1.  cpu core:1개
2.  memory: 1Gbits
3.  SSD: 8G bytes

우선 t2.small로 변경하려 한다.
t2는 cpu core2개와 memory가 2Gbits를 사용한다.

</div>


### 변경 과정 {#변경-과정}

<div class="note">

(1) EC2를 stop한다.

</div>

<a id="figure--"></a>

{{< figure src="/img/web_monitoring/ec2_1.png" caption="<span class=\"figure-number\">Figure 94: </span>ec2_1" width="600px" >}}

<div class="note">

(2) instance settings =&gt; change instance type을 선택한다.

</div>

<a id="figure--"></a>

{{< figure src="/img/web_monitoring/ec2_2.png" caption="<span class=\"figure-number\">Figure 95: </span>ec2_2" width="600px" >}}

<div class="note">

(3) t2.small을 선택한다. 이것만 하면 된다.

</div>


## AWS EC2 size변경 {#aws-ec2-size변경}


### EBS 볼륨 확장 {#ebs-볼륨-확장}

<div class="note">

ec2의 용량을 변경하기로 한다. 지금 현재 크기는 t2.micro라서 8G를 사용한다. 이를 50G를 늘리려고 한다.
EBS의 볼륨 확장과,  파일 시스템 확장이 필요하다.

-   EBS 볼륨 확장 선택을 먼저한다.
-   확장하고자 하는 size를 변경한다.
-   그리고 ok를 계속하면 볼륨변경이 된다.

</div>

<a id="figure--"></a>

{{< figure src="/img/web_monitoring/ec2_3.png" caption="<span class=\"figure-number\">Figure 96: </span>ec2_3" width="600px" >}}

<a id="figure--"></a>

{{< figure src="/img/web_monitoring/ec2_4.png" caption="<span class=\"figure-number\">Figure 97: </span>ec2_4" width="600px" >}}


### EBS 파일 시스템 확장 {#ebs-파일-시스템-확장}

<div class="note">

ebs볼륨을 확장한 이후에, 다시 system을 킨다. 그리고 ssh 접속을 한다.

-   lsblk로 block정보를 본다. volume과 partition정보를 볼 수 있다. 우리는 aws에서 volume을 50G로 정했다.
-   partition에도 50G가 할당되었기 때문에 growpart로 증가시킬 필요는 없다.
-   즉 제대로된 정보가 반영되었다고 본다.

</div>

<a id="figure--"></a>

{{< figure src="/img/web_monitoring/ec2_5.png" caption="<span class=\"figure-number\">Figure 98: </span>ec5" width="600px" >}}

<a id="figure--"></a>

{{< figure src="/img/web_monitoring/ec2_6.png" caption="<span class=\"figure-number\">Figure 99: </span>ec2_6" width="600px" >}}


## AWS https 접근처리 {#aws-https-접근처리}

<div class="note">

AWS에서 https를 처리하는 방식은 2가지가 있다. 첫번째는 AWS의 서비스를 이용하는 방식과 자체적으로 하는 방식이 있다. https는 domain name에 대한 인증서를 발급받는 과정이 필요한데, AWS의 경우, 인증서를 받는것은 ACM(Amazon Certificates Manager)에서 발급 받을 수 있다. 또한 AWS에서는 load balancer를 통해서 ACM과 router53이 유기적으로 연결되어 있어서 domain name으로 요청하는 사람에 대해서 인증서 발급처리를 도맡아 한다. load balancer는 비용이 있다. 작은 서비스를 사용할 때는 돈들여 가며 할 필요가 없다고 느껴지지만, 큰 장점이 있다. ddos공격을  aws가 막아준다는 것이다. third-party 인증서를 발급받을 경우, ACM이나 load-balancer를 사용하지 않을 수 있다. 그러나 load-balancer를 사용하지 않으면 ddos공격에 취약해진다. 우선 나는 ACM과 load-balancer를 사용하기로 한다.

</div>


### 인증서 발급 {#인증서-발급}

<div class="note">

https로 접근하기 위해서는 SSL 인증서를 발급받아야 한다. 인증서에 대해서 간략하게 설명하면, 보안 통신을 할때, public key와 private  key로 메시지를 encrypt해서 서로 통신을 하게 되는데, 이렇게 되면 보내고 받는 message는 encrypt가 되어 문제는 없으나, 정작 내가 message를 주고 받는 당사자가 해커 일수 있다. 해커가 은행 site를 만들어서 login하는 사람에게 자신의 public key를 전송해서 통신을 해도 모른다는 것이다. 이것을 방지하기 위해서 통신하는 대상이 진짜인가? 가짜인가?는 인증서로 증명된다. 인증서는 권위가 있는 기관으로 부터 인증 받는다. 인증서안에는 public key가 있기 때문에 encrypt된 message통신이 가능하다. 여튼 server를 만드는 사람이 사용자에게 나는 진짜 이 site가 맞다라고 확실하게 말할 수 있는 것은 인증서가 있기 때문이다. server를 만들때 인증서를 만들어야 하는데, aws를 사용하기 때문에 aws로 부터 발급받을 수 있다. 그 과정이다.

1.  certificate manager로 들어간다.
2.  provision certificate를 선택한다.
3.  amazon의 공인 인증서를 요청한다.
4.  지금 사용하는 domain이름을  추가한다.
5.  검증방법을 선택한다. 나는 route53을 사용하기 때문에, DNS validate를 사용한다.
6.  tag는 사용하지 않는다.
7.  최종 요청을 한다.
8.  pending되고 처리가 되지 않는다. route53에 cname을 추가하는 과정을 거쳐야 한다. 이 과정을 거치면 인증서가 발급된다.
    cname레코드가 추가되는 이유는 검증용이다. cname record를 추가하는 과정에서 domain name을 입력한다. domain name으로 aws에 있는 ec2에 접근한다고 하자. aws에 의해서 domain name에 대한 검증을 해야 한다. 이때 사용되는게 cname이다. 일반적으로 사람들이  domain name으로 ec2에 접근을 하면 aws에 있는 route53에서 해당 domain name으로 query를 한다. 만일 A Record로 기술 되어있다면, IP주소를 return한다. A record는 domain name:ip쌍으로 되어 있어서 ip주소를 value로 갖는다. CNAME 레코드는 좀 다르다. CNAME record의  값은 또 다른 domain name 주소다. 그래서 cname은 다른 domain주소를 return한다. 여기서 cname주소를 추가한것은 aws 검증용 서버로 보내기 위함이다. 아래 보면 arecord의 예도 보인다.

</div>

<a id="figure--"></a>

{{< figure src="/img/web_monitoring/cname1.png" caption="<span class=\"figure-number\">Figure 100: </span>cname1" width="600px" >}}

<a id="figure--"></a>

{{< figure src="/img/web_monitoring/a_record.png" caption="<span class=\"figure-number\">Figure 101: </span>a record" width="600px" >}}

<div class="note">

1.  certificate manager에서 인증서가 발급되었는지 확인하자.
2.  route53에서 cname이 추가되었는지도 확인해보자.

</div>

<a id="figure--"></a>

{{< figure src="/img/web_monitoring/cert1.png" caption="<span class=\"figure-number\">Figure 102: </span>certificate manager" width="600px" >}}

<a id="figure--"></a>

{{< figure src="/img/web_monitoring/cert2.png" caption="<span class=\"figure-number\">Figure 103: </span>certificate manager2" width="600px" >}}

<a id="figure--"></a>

{{< figure src="/img/web_monitoring/cert3.png" caption="<span class=\"figure-number\">Figure 104: </span>certificate manager3" width="600px" >}}

<a id="figure--"></a>

{{< figure src="/img/web_monitoring/cert4.png" caption="<span class=\"figure-number\">Figure 105: </span>certificate manager4" width="600px" >}}

<a id="figure--"></a>

{{< figure src="/img/web_monitoring/cert5.png" caption="<span class=\"figure-number\">Figure 106: </span>certificate manager5" width="600px" >}}

<a id="figure--"></a>

{{< figure src="/img/web_monitoring/cert6.png" caption="<span class=\"figure-number\">Figure 107: </span>certificate manager" width="600px" >}}

<a id="figure--"></a>

{{< figure src="/img/web_monitoring/cert7.png" caption="<span class=\"figure-number\">Figure 108: </span>cert7" width="600px" >}}

-   domain name의 smartwatercare를 click하면, route53에 CNAME을 추가하는게 보일 것이다.

<a id="figure--"></a>

{{< figure src="/img/web_monitoring/cert8.png" caption="<span class=\"figure-number\">Figure 109: </span>cert8" width="600px" >}}

-   cname을 route53에 추가한다.

<a id="figure--"></a>

{{< figure src="/img/web_monitoring/cert9.png" caption="<span class=\"figure-number\">Figure 110: </span>cert9" width="600px" >}}

<a id="figure--"></a>

{{< figure src="/img/web_monitoring/cert10.png" caption="<span class=\"figure-number\">Figure 111: </span>cert10" width="600px" >}}

-   certificate manager로 들어가서 인증서가 발급되었는지 확인해 보자.

<a id="figure--"></a>

{{< figure src="/img/web_monitoring/cert11.png" caption="<span class=\"figure-number\">Figure 112: </span>cert11" width="600px" >}}

-   route53으로 들어가서 cname이 추가되었는지 확인해보자.

<a id="figure--"></a>

{{< figure src="/img/web_monitoring/cert12.png" caption="<span class=\"figure-number\">Figure 113: </span>cert12" width="600px" >}}


### load balancer 설정 {#load-balancer-설정}

-   ec2 -&gt; load balancer로 이동한다.

<a id="figure--"></a>

{{< figure src="/img/web_monitoring/load1.png" caption="<span class=\"figure-number\">Figure 114: </span>load balancer1" width="600px" >}}

-   load balancer를 설정한다.

<a id="figure--"></a>

{{< figure src="/img/web_monitoring/load2.png" caption="<span class=\"figure-number\">Figure 115: </span>load_balance2" width="600px" >}}

<a id="figure--"></a>

{{< figure src="/img/web_monitoring/load3.png" caption="<span class=\"figure-number\">Figure 116: </span>load_balance3" width="600px" >}}

<a id="figure--"></a>

{{< figure src="/img/web_monitoring/load4.png" caption="<span class=\"figure-number\">Figure 117: </span>load_balance4" width="600px" >}}

<a id="figure--"></a>

{{< figure src="/img/web_monitoring/load5.png" caption="<span class=\"figure-number\">Figure 118: </span>load_balance5" width="600px" >}}

-   error 발생

<div class="note">

1.  load-balancer의 이름은 유일해야 한다.
2.  Figure97-4번을 보면 target group을 설정해야 한다. 이 부분이 없으면 load balancer를 만들 수 없다.

</div>

-   target group 생성

<a id="figure--"></a>

{{< figure src="/img/web_monitoring/load6.png" caption="<span class=\"figure-number\">Figure 119: </span>load6" width="600px" >}}

<a id="figure--"></a>

{{< figure src="/img/web_monitoring/load7.png" caption="<span class=\"figure-number\">Figure 120: </span>load7" width="600px" >}}

-   health check는 그냥 넘어갔다. 그리고  register target이라는 화면이 나왔다.

<a id="figure--"></a>

{{< figure src="/img/web_monitoring/load8.png" caption="<span class=\"figure-number\">Figure 121: </span>load8" width="600px" >}}

-   target group설정이 끝났다. 이제 다시 load balancer를 만드는 과정으로 다시 돌아간다. 지금 만든 target group으로 설정한다. 그러면 load balancer가 다 만들어졌다. 그런데 접속이 안된다. 443포트를 열었다.

<a id="figure--"></a>

{{< figure src="/img/web_monitoring/load9.png" caption="<span class=\"figure-number\">Figure 122: </span>load9" width="600px" >}}

-   route53에서 A record를 삭제 해보았다.
-   그래도 안된다.

    <div class="warning">

    최종적으로 우선 https는 적용하지 않기로 했다.

    </div>


## rails 개발 참조 사이트 {#rails-개발-참조-사이트}

-   [gorails](https://gorails.com) : 설치, deploy 관련 sites
-   [rubyonrails](https://rubyonrails.org): ruby on rails 개발 sites

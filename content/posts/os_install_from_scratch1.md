+++
title = "[os] install from scratch1"
author = ["holy"]
description = "맥북 처음 설치시 해야할것들."
date = 2023-08-23T00:00:00+09:00
draft = true
+++

## system preference {#system-preference}

제일 먼저할 것은 우선 system preference에서 설정한다.

<a id="figure--res"></a>

{{< figure src="/img/install/system.png" caption="<span class=\"figure-number\">Figure 1: </span>system" width="600px" >}}


## App Store {#app-store}

App store login 에서 필요한것들 다 다운 받는다. 그 중 res를
다운받는다. 왜냐하면 모니터 세팅부터 해야 하기 때문이다.

<a id="figure--res"></a>

{{< figure src="/img/install/res.png" caption="<span class=\"figure-number\">Figure 2: </span>res" width="600px" >}}


## karabiner {#karabiner}

karabiner를 다운받고 caps-lock을 설정한다.

<a id="figure--caps lock"></a>

{{< figure src="/img/install/karabiner.png" caption="<span class=\"figure-number\">Figure 3: </span>caps lock" width="600px" >}}


## brew 설치 {#brew-설치}

[여기](https://brew.sh/)로 이동해서 다음을 terminal에서 실행한다.

```shell
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```


## iterm2 설치 {#iterm2-설치}

```shell
brew install --cask iterm2
```


## zsh 설치 {#zsh-설치}

iterm2를 실행한 후

```shell
brew install zsh
```

zsh를 실행한다.


## oh-my-zsh 설치 {#oh-my-zsh-설치}

```shell
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```


## zsh theme 설정 {#zsh-theme-설정}

.zshrc를 열고 theme를 바꾼다.

```emacs-lisp
Agnoster
```

iterm2를 재시작 한다. 그러면, font가 깨져 있을 것이다.


## font 설치 {#font-설치}

emacs를 설치할때, font까지 설치하는 script를 만들었지만, 그냥 여기서
설치하기로 한다. brew로 설치하기로 한다.


### fira-code font {#fira-code-font}

1.  brew tap homebrew/cask-fonts
2.  brew install --cask font-fira-code


### d2-coding {#d2-coding}

1.  brew tap homebrew/cask-fonts  
2.  brew install font-d2coding


### hack-nerd font {#hack-nerd-font}

1.  brew install --cask font-hack-nerd-font


## font 설정 on iterm2 {#font-설정-on-iterm2}

Profiles -&gt; Text -&gt; Hack Nerd Font Mono 설정


## prompt 설정- 컴퓨터 이름 제거 {#prompt-설정-컴퓨터-이름-제거}

[여기](https://imcreator.tistory.com/166)를 참조한다.
.zshrc에 마지막 줄에 다음을 추가한다.

```shell
# user@hostname에서 user만 보이기
prompt_context() {
   if [[ "$USER" != "$DEFAULT_USER" || -n "$SSH_CLIENT" ]]; then
     prompt_segment black default "%(!.%{%F{yellow}%}.)$USER"
   fi
}
```


## prompt 설정- current directory 설정 {#prompt-설정-current-directory-설정}

<a id="org02ffe6f"></a>

<img src="/img/os/dcolor1.png" alt="dcolor1.png" width="400px" />
위 color를 변경하는 것은 theme에서 설정한다.

```shell
cd ~/.oh-my-zsh/themes/
vi agnoster.zsh-theme
```

아래를 고친다. 076으로 고쳤다.

```shell
# Dir: current working directory
prompt_dir() {
  prompt_segment 076 $CURRENT_FG '%~'
}
```


## prompt 설정 - newline 추가 {#prompt-설정-newline-추가}

한줄에 명령어를 나열하기엔 공간이 모자란다. 다음과 같이 theme 파일을
연다.

```shell
vi ~/.oh-my-zsh/themes/agnoster.zsh-theme
```

```shell
build_prompt() {
  RETVAL=$?
  prompt_status
  prompt_virtualenv
  prompt_aws
  prompt_context
  prompt_dir
  prompt_git
  prompt_bzr
  prompt_hg
  prompt_newline # 해당 위치에 꼭 입력해주어야 합니다.
  prompt_end
}

# 해당 내용을 추가합니다.
prompt_newline() {
  if [[ -n $CURRENT_BG ]]; then
    echo -n "%{%k%F{$CURRENT_BG}%}$SEGMENT_SEPARATOR
%{%k%F{blue}%}$SEGMENT_SEPARATOR"
  else
    echo -n "%{%k%}"
  fi

  echo -n "%{%f%}"
  CURRENT_BG=''
}
```


## prompt 설정 - emoji 추가하기 {#prompt-설정-emoji-추가하기}

.zshrc에서 추가한다. 해당 파일을 연다.

```shell
prompt_context() {
  # Custom (Random emoji)
  emojis=("⚡️" "🔥" "🇰 " "👑" "😎" "🐸" "🐵" "🦄" "🌈" "🍻" "🚀" "💡" "🎉" "🔑" "🚦" "🌙")
  RAND_EMOJI_N=$(( $RANDOM % ${#emojis[@]} + 1))
  prompt_segment black default "holy ${emojis[$RAND_EMOJI_N]} "
}
```


## zsh-autosuggestions 설정 {#zsh-autosuggestions-설정}

이 기능은 미리 예측되는 명령어를 흑백톤으로 보여준다.

1.  brew install zsh-autosuggestions
2.  verbose에서 나온 코드를 추가한다.
    ```shell
    source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh
    ```


## zsh-highlighting {#zsh-highlighting}

prompt다음에 사용자가 명령어를 쓰면 color로 highlighting된다.

1.  brew install zsh-syntax-highlighting
2.  verbose에서 나온 코드를 추가한다.
    ```shell
    source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
    ```


## ls color설정 {#ls-color설정}

ls를 했을때 folder와 file을 color로 구분하기 위해서 다음과 같이
세팅한다. .zshrc파일을 연다.

```shell
if [[ -x "$(command -v gls)" ]]; then
  alias ls='gls --color=auto'
  if [[ -x "$(command -v gdircolors)" ]]; then
    eval "$(gdircolors -b)"
  fi
fi
export LSCOLORS="ExGxFxdxCxdadahbadacec"
```


## iterm2 color theme 설정 {#iterm2-color-theme-설정}

snazzy theme를 적용하자.

1.  mkdir util &amp;&amp; cd util
2.  curl -LO <https://raw.githubusercontent.com/mbadolato/iTerm2-Color-Schemes/master/schemes/Snazzy.itermcolors>
3.  iterm2 settings-&gt; color theme -&gt; import snazzy해서 사용한다.


## iterm2 나머지 설정 {#iterm2-나머지-설정}

1.  Title bar style
    Appearance &gt; General&gt; Theme: Minial
2.  Title bar 밑에 1px 라인제거
    Appearance &gt; Windows &gt; Show line under title bar when the tab bar is not visible: 체크 안함 
3.  폰트 크기 및 줄간격 변경
    Profiles &gt; Text: 폰트사이즈 15로 변경
    Profiles &gt; Text: n/n 줄간격 130으로 변경
4.  margin 수정
    Appearance &gt; Panes &gt; Side margins: 20
    Appearance &gt; Panes &gt; Top &amp; bottom margins: 10
5.  탭 선 제거
    Advanced -&gt;In minimal theme, how prominent should the tab outline be?: 0
6.  Unicode 설정
    Profiles-&gt;Text-&gt;Unicode normalization form:NFC


## neofetch 설정 {#neofetch-설정}

[여기](https://younsl.github.io/blog/setup-neofetch-on-iterm2/)를 참조하자.

1.  brew install neofetch 
2.  brew install imagemagick 
3.  mkdir -p ~/.config/neofetch/images 
4.  사진을 해당 폴더에 옮긴다. 
5.  vi ~/.config/neofetch/config.conf 여기에 써야하는건 검색요. 
6.  .zshrc에 neofetch추가  
7.  iterm2에서 advanced 설정: Disable potentially insecure escape sequences → No로 설정, Show inline images at retina resolution → No로 설정 


## Icloud 처리 {#icloud-처리}

나는 icloud의 document와 desktop을 동기화해서 사용한다. 다음과 같이 설정하자.

<a id="figure--icloud1"></a>

{{< figure src="/img/os/icloud1.png" caption="<span class=\"figure-number\">Figure 5: </span>icloud1" width="400px" >}}

<a id="figure--icloud2"></a>

{{< figure src="/img/os/icloud2.png" caption="<span class=\"figure-number\">Figure 6: </span>icloud2" width="400px" >}}

<a id="figure--icloud3"></a>

{{< figure src="/img/os/icloud3.png" caption="<span class=\"figure-number\">Figure 7: </span>icloud3" width="400px" >}}


## discord 설치와 switching account {#discord-설치와-switching-account}

```emacs-lisp
brew install --cask discord
```

나는 회사 email 계정이 이미 있는 상태에서, email
부계정(hoyoul+a10@whitebrew.com)으로 가입했기 때문에 정상적인 login을
하면 회사의 server가 보이지 않는다. 그래서 위의 부계정으로 login해도
되지만, 정 계정으로 login하고 switch accounts로 계정변경해서 사용할 수
있다.

<a id="figure--discord1"></a>

{{< figure src="/img/os/discord1.png" caption="<span class=\"figure-number\">Figure 8: </span>discord1" width="400px" >}}

<a id="figure--discord2"></a>

{{< figure src="/img/os/discord2.png" caption="<span class=\"figure-number\">Figure 9: </span>discord2" width="400px" >}}


## ripgrep 설치 {#ripgrep-설치}

emacs에서 사용하는 grep인데 먼저 설치하자.

```shell
brew install rg
```


## hugo 설치 {#hugo-설치}

blog를 사용할때 사용하는 hugo다.

```shell
brew install hugo
```


## multiple github account 설정 {#multiple-github-account-설정}

[여기]({{< relref "github_multi_account_github_problem" >}})를 참조한다.


## emacs 설치 {#emacs-설치}

[여기]({{< relref "emacs_emacs_settings_from_scratch" >}})를 참조한다.


## Tex 설치 {#tex-설치}

[여기]({{< relref "emacs_tex_install_and_usage" >}})를 참조한다.


## mu4e 설치 {#mu4e-설치}

[여기]({{< relref "emacs_mu4e_settings" >}})를 참조한다.


## anaconda설치 {#anaconda설치}

python 개발시 anaconda를 사용한다.

```emacs-lisp
brew install --cask anaconda
```

.zshrc에 추가한다.

```emacs-lisp
export PATH="/opt/homebrew/anaconda3/bin:$PATH"
```


## ruby &amp; rails 설치 {#ruby-and-rails-설치}

[다음]({{< relref "rails7_install_ruby_on_rails7" >}})을 참조한다.


## flutter 설치 {#flutter-설치}

[여기]({{< relref "flutter_how_to_install_flutter_on_m1_or_m2" >}})를 참조한다.

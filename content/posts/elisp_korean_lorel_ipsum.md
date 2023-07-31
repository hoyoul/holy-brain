+++
title = "[elisp] korean lorem ipsum"
author = ["Holy Frege"]
draft = false
+++

## introduction {#introduction}

코딩할 때, dummy 문자열을 사용할 일이 많다. 그런데 보통 lorem
ipsum으로 영어 문장을 사용한다. emacs자체가 한국어 사용자가 없다보니
한국어 관련한 작업은 모두 만들어 써야 한다. 아주 간단한 korean lorem
ipsum을 만들려고 한다.


## idea {#idea}

한국어만 나오면 된다. 단어들을 그냥 random하게 섞어서 마지막에만
"입니다"로 끝나게 한다. M-x korean-lorem-ipsum-input-sentence로 실행할
수 있게 해야 한다.


## <span class="org-todo todo TODO">TODO</span> 더 생각해야 하는것 {#더-생각해야-하는것}

lorem-ipsum처럼 sentence, paragraph, list를 만들어야한다. 그리고 진짜
그럴듯한 한국어문장을 만들려면 형태소 분석과 자연어 처리가
필요하다. 그리고 GAN을 사용해서 만들어내는것까지 할 수 있을 거
같다. 여기까지 갈려면 많은 공부를 해야한다. 중간단계로 고려할 것은
크롤링해서 문장을 가져오는것도 고려할 만 하다.


## 구현 {#구현}

난 TDD를 알긴 알지만, 현업에서 써본적은 없다. 그리고 평소에 쓰지도
않는다. 하지만, 가장 간단한 함수부터 구현한다는 생각에는
동의한다. bottom-up 방식이 합리적이다.


### M-x 동작 test {#m-x-동작-test}

nM-x korean-lorem-ipsum-input-sentence을 실행시키면 hello가 나오는
함수를 만들자.

```emacs-lisp
(defun korean-lorem-ipsum-input-sentence ()
  "print hello in calling this function made by holy"
  (interactive)
  (insert "hello"))
```

(interactive)는 이 함수를 M-x로 실행할 수 있게 한다. 그리고
insert함수는 현재 buffer 현재 위치에 실행할 수 있게 해준다.


### "hello" 대신에 random한 단어를 출력하자. {#hello-대신에-random한-단어를-출력하자-dot}

변수가 필요하다. word_bank라는 list를 만들자. 그리고 word list에서
random하게 단어뽑는거 까지 해보자.

```emacs-lisp
(defun korean-lorem-ipsum-input-sentence ()
  "print hello in calling this function made by holy"
  (interactive)
  (let* (
         (word_bank '("박호열" "이" "사랑" "아무도" "돈" "명예" "명성" "사회적 지위"))
         (my-sentence "")
         )
    (setq my-sentence (nth (random (length word_bank)) word_bank))
    (insert my-sentence)))
```

random함수는 다음과 같다.

```text
random 숫자
```

그러면 random한 값이 나온다. wordbank에서 그 값에 해당하는 cell을
꺼내기 위해서 nth를 사용했다.


### dotimes와 concat을 사용해서 문장 만들기 {#dotimes와-concat을-사용해서-문장-만들기}


#### 설명 {#설명}

단어를 concat해서 문장을 만들려면 dotimes를 써야 한다. dotimes는
for-loop로 생각하면 된다. concat과 dotimes를 사용하는 법은 다음과
같다.

-   dotimes
    ```text
    (dotimes (i 3) (sth))

    ```
    두개의 인자가 있는데, 비유에서 설명하겠다. python에서 for i in
    range(3)의 i와 range(3)과 두번째 인자가 같다고 보면 된다. _ 사용도
    가능하다. (dotimes _ 3)을 사용해도 된다. 그러면 index를 사용하지
    않겠다는 뜻이다. dotimes할때마다 concat으로 단어를 합쳐서 문장을
    만들것이다.

-   concat:
    ```text
    (concat str1 str2)
    ```
    concat은 이런 식으로 사용한다.

concat은 문자열을 합친다. 10번 반복될때마다 my-sentence변수가
계속 새로 선택된 word와 concat하면서 덧붙여지게 하려면 다음과 같이 한다.

```text
(setq my-sentence (concat my-sentence new-word)
```


#### 구현 {#구현}

위에서 설명한것을 바탕으로 구현해 보자.

```elisp
(defun korean-lorem-ipsum-input-sentence ()
  "print hello in calling this function made by holy"
  (interactive)
  (let* (
         (word_bank '("박호열이" "이상한" "사랑이라면" "아무도" "돈" "명예" "중요한" "사회적 지위"))
         (sentence-length (+ 1 (random 10)))
         (my-sentence " ")
         )
         (dotimes (_ sentence-length)
             (setq my-sentence (concat my-sentence (nth (random (length word_bank)) word_bank) " ")))
         (setq my-sentence (concat my-sentence "입니다"))
         (insert my-sentence)))
```

위에서 sentence-length를 (+1 (random 10))으로 한건 최소한 1개
단어이상이여야 한다는 것이다. 마음대로 바꿀 수 있다. 최소 3개의
단어로 이루어진 문장이라면 3으로 바꾸면 된다. 그리고 concat에서 " "
를 추가했다. concat은 다음과 같이 쓰일수 있다.

```text
(concat str1 str2 str3)
```

마지막엔 "입니다"를 추가했다.


#### melpa에 등록하자. {#melpa에-등록하자-dot}

melpa는 repo다. python에서 pip나 ruby의 gem, node의 npm들이 repo에서
package를 가져오듯이 자시만의 repo가있다. program을 만들면 그런
저장소에 저장할 수 있다. 등록 이름은 simplis absurdi korean textus:
simple meaningless korean text으로 하기로 했다.

<!--list-separator-->

-  [step1] melpa를 fork하자.

    fork에 대한 참조는 [여기]({{< relref "git_git_explained" >}})를 참조하자. 오래된 git문서이긴 하지만 git에
    대한 내용이 있다.

<!--list-separator-->

-  [step2] local computer에 clone한다.

<!--list-separator-->

-  [step3] recipes폴더로 이동한다.

<!--list-separator-->

-  [step4] package에 대한 recipe파일을 만든다.

<!--list-separator-->

-  [step5] recipe파일을 commit push

<!--list-separator-->

-  [step6] pull request

    github의 repo에 있는 pull requests 탭으로 이동한다. new pull request를
    선택해서 main브랜치에 pull request한다.

<!--list-separator-->

-  [step7] melpa관리자 승인 받을때까지 기다려야 함.

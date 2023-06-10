+++
title = "[emacs] org-babel -python"
author = ["holy"]
description = "org-babel로 org문서에 code를 넣고 실행할 수 있다. literal programming이라고 하는데, python을 사용할때 setting과 사용법을 알아보자."
date = 2023-06-10T00:00:00+09:00
draft = true
+++

## setting emacs init file {#setting-emacs-init-file}

```emacs-lisp
(org-babel-do-load-languages
 'org-babel-load-languages
 '((python . t)))
```


## default usage {#default-usage}

다음과 같이 src code block을 만든다. 코드를 입력한다.

<div class="verse">

#+BEGIN_SRC python<br>
a = 3<br>
\#+END_SRC<br>

</div>

```python
a=3
```

그리고 `C-c c` 를 눌러서 실행한다. 그러면 None이라는 결과가
나온다. code block은 함수와 같다. 위 함수를 실행해도 결과는
None이다. a값을 출력하려면 어떻게 해야 할까?

```python
a=3
return a
```

return을 사용해서 return하면 된다. 그러면 다음 예를 보자.

> ```python
> a = 3
> print(a)
> ```

결과는 a값이 나올까? 나오지 않는다.

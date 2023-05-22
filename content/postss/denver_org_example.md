+++
title = "denver org file"
author = ["Holy Frege"]
draft = false
+++

org를 html로 변환시, css처리를 해줘야 한다. org로 작성한 문서가 md로
변경되고 md에서 html로 변환되기 때문에, 그리고 ox-hugo를 사용하기
때문에 css는 별도 처리를 해줘야 한다.

This is the example
org-mode file used for the Denver Emacs org-mode introduction
talk. Everything in this talk should work without any custom settings
or installation with a reasonably recent Emacs version.

Let's start with a headline, this is kind of like Markdown's # character:


## This is an example headline {#this-is-an-example-headline}

Text can be put into the headline. You can create another headline at the same
level with another \* character


## Another headline {#another-headline}

Nesting headlines is as easy as adding another start


### Nested headline {#nested-headline}


### Another nested headline {#another-nested-headline}


#### Deeper {#deeper}


### Another headline {#another-headline}

<!--list-separator-->

-  Deeper...

    <!--list-separator-->

    -  Deeper.....


## Basic markup {#basic-markup}

You can really go as deep as you want. This is the general building block for
org-mode navigation.

Next, let's talk about some markup

-   <span class="underline">underscores let you underline things</span>
-   **stars add emphasis**
-   _slashes are italics_
-   ~~pluses are strikethrough~~
-   `equal signs are verbatim text`
-   `tildes can also be used`

You can generate lists with the `-` character (seen above), or create numbered
ones:

1.  Number one thing
2.  Number two thing
3.  Number three


## Showing and hiding headlines {#showing-and-hiding-headlines}

You can hide the contents of a headline by putting the point (cursor) or it and
hitting `TAB`.

You can also toggle hiding and showing of **all** headlines with `SHIFT-TAB`.


## Tables {#tables}

Auto expanding tables are one of the coolest features of org-mode, because
tables in Markdown just plain suck. In order to create a new table, you can
start typing it manually, or press `C-c |`, which will prompt for the table's
dimensions.

| First Name                 | Last Name           | Years using Emacs |
|----------------------------|---------------------|-------------------|
| Lee                        | Hinman              | 5                 |
| Mike                       | Hunsinger           | 2                 |
| Daniel                     | Glauser             | 4                 |
| Really-long-first-name-guy | long-last-name-pers | 1                 |


## Org-mode links {#org-mode-links}

:PROPERTIES:...

In an org-mode file, you can press `C-c l` to store a pointer to wherever you
are in the file. Then, with (or without) text highlighted hit `C-C C-l` to make
it into a link.
The example file for Magit
If you don't want to store a pointer (ie, link to a website or something), you
can just hit `C-c C-l` and type or paste the link. To manually create a link, do
something like:

The Denver Emacs Meetup Group

Writequit site

Google's web site

(ignore the \*_SRC blocks for now, we'll get there)

```fundamental
[[http://google.com/][Google]]
```

You can link to files, images, websites, emails, irc, and all kinds of things.


## Various things you can add in headers {#various-things-you-can-add-in-headers}

One of the most common uses for org-mode is a sort of "task list" or TODO list.
Org-mode supports this by allowing markers in the headline for the state of a
task. Let's look at an example:


### <span class="org-todo todo TODO">TODO</span> This is a task that needs doing {#this-is-a-task-that-needs-doing}


### <span class="org-todo todo TODO">TODO</span> Another todo task {#another-todo-task}

-   [ ] sub task one
-   [X] sub task two
-   [ ] sub task three


### Learn about org-mode {#learn-about-org-mode}


#### <span class="org-todo todo TODO">TODO</span> learn todos {#learn-todos}


#### <span class="org-todo todo TODO">TODO</span> learn other stuff {#learn-other-stuff}

You can toggle each task in a list with the `C-c C-c` keyboard shortcut.


### <span class="org-todo done DONE">DONE</span> I've already finished this one {#i-ve-already-finished-this-one}

You can change the status of a task by hitting `C-c t` in the body of a task
anywhere, which will prompt for the state to put it in.

You can create as many of these as you'd like, for example (from my own config,
use what works best for you, configuring them is a little out of scope right
here) here's what I use:


#### <span class="org-todo todo TODO">TODO</span> something that needs doing {#something-that-needs-doing}


#### <span class="org-todo done DONE">DONE</span> something that's already done {#something-that-s-already-done}


#### INPROGRESS something I'm currently doing {#inprogress-something-i-m-currently-doing}


#### WAITING waiting for someone else before doing anything {#waiting-waiting-for-someone-else-before-doing-anything}


#### NEEDSREVIEW there's a PR for this, it needs someone to look at it {#needsreview-there-s-a-pr-for-this-it-needs-someone-to-look-at-it}


#### HOLD this is in permanent hold until further notice {#hold-this-is-in-permanent-hold-until-further-notice}


#### CANCELLED I don't need this any more {#cancelled-i-don-t-need-this-any-more}


#### SOMEDAY I'd like to do this someday in the waaaaay off future {#someday-i-d-like-to-do-this-someday-in-the-waaaaay-off-future}

A lot of people just use "TODO" and "DONE" though.


### Adding tags and priorities {#adding-tags-and-priorities}

You can add tags by putting them surrounded in ":" in the headline.
Additionally, priorities


#### Headline with a tag <span class="tag"><span class="org">org</span></span> {#headline-with-a-tag}


#### Another tagged headline <span class="tag"><span class="turing">turing</span><span class="denver">denver</span></span> {#another-tagged-headline}


#### Headline with multiple tags <span class="tag"><span class="org">org</span><span class="emacs">emacs</span></span> {#headline-with-multiple-tags}

Tags are just another way of organizing things.


#### Important task {#important-task}


#### Medium task {#medium-task}


#### Non-important task {#non-important-task}

Again you can configure these, or just use the 3 built in ones.


#### <span class="org-todo todo TODO">TODO</span> <code>[1/3]</code> Task with sub headlines {#task-with-sub-headlines}

<!--list-separator-->

- <span class="org-todo todo TODO">TODO</span>  Finish thing

<!--list-separator-->

- <span class="org-todo todo TODO">TODO</span>  Finish that other thing

<!--list-separator-->

- <span class="org-todo done DONE">DONE</span>  Done with a thing


#### <code>[33%]</code> Task with sub headlines (percent cookie) {#task-with-sub-headlines--percent-cookie}

<!--list-separator-->

- <span class="org-todo todo TODO">TODO</span>  Finish thing

<!--list-separator-->

- <span class="org-todo todo TODO">TODO</span>  Finish that other thing

<!--list-separator-->

- <span class="org-todo done DONE">DONE</span>  Done with a thing


## The TODO-planner payoff {#the-todo-planner-payoff}

:PROPERTIES:...
So TODOs are all well and good, but what is a really neat feature is when you
can easily capture new TODOs and display them easily.

In order to do this, let's configure a couple of Emacs options in your emacs init:

```emacs-lisp
(require 'org)
;; Setup C-c c to capture new TODOs
(global-set-key (kbd "C-c c") 'org-capture)
;; Setup a key bind for the agenda
(global-set-key (kbd "C-c a") 'org-agenda)
;; Set up agenda to know about our file, you can use a list of files or
;; directories here
(setq org-agenda-files '("~/todo.org"))
;; A new template
(setq org-capture-templates
      '(("t" "Todo" entry (file "~/todo.org")
	 "* TODO %?\n%U\n")))
```

Now, hit `C-c c` to bring up the capture template list, then `t` to capture a
new TODO item.

Once you've captured a few TODOs, you can try out the agenda by hitting `C-c a`,
which will prompt for what agenda you'd like to see, for now hit `t` to see the
TODO list agenda.


## Exporting an org-mode buffer {#exporting-an-org-mode-buffer}

Org has a lot of export options, they are all contained behind a `C-c C-e`
export backend, exporting to HTML, markdown, plain text, pdf, etc.


## Show off other features of org-mode if we have more time {#show-off-other-features-of-org-mode-if-we-have-more-time}

Maybe not in excruciating detail, but we can show off the power and cover it in
more detail at a later time:

-   refiling (`org-refile`)
-   source code blocks
-   org-babel
-   clocking in/out
-   table formulas
-   custom agenda views
-   capturing notes (not just TODOs)
-   publishing projects remotely via TRAMP

<div class="LaTeX">

\\(a + b\\)

</div>

```emacs-lisp
(defun my/function ()
  "docstring"
  (interactive)
  (progn
    (+ 1 1)
    (message "Hi")))
```

```sh
echo $data > /tmp/foo
for i in `cat /tmp/foo`; do
  echo $i
done
```

<a id="code-snippet--say-hi"></a>
```sh
echo "hi"
```

```sh
# do some things
echo "stuff"
echo "more stuff"
echo <<hi>>
```

To enter and edit a block of text, use `C-c C-'`

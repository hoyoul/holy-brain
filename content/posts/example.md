+++
title = "Example of org to ipynb"
author = ["John Kitchin"]
draft = false
+++

## Introduction {#introduction}

I wrote this module to allow me to write lecture notes in org-mode, but export them to ipython notebooks for my students. It also makes it easier to share my work with people who don't use org-mode (although it is a one-way conversion of org to ipynb).

To use this, you have to require the ox-ipynb library. Then you can export this file with the key sequence `C-c C-e n o` to create the ipynb and open it.

In the following sections I will demonstrate a few features.


### Org-mode markup {#org-mode-markup}

You should get all the regular markup:

-   **bold text**
-   _italics_
-   <span class="underline">underlined</span>
-   ~~strikethrough~~
-   `verbatim`
-   `code`
-   superscripts, e.g. H^+
-   subscripts, e.g. CH<sub>4</sub>
-   hyperlinks: <http://github.com/jkitchin/ox-ipynb>


### Embed equations {#embed-equations}

You can use LaTeX equations like: \\(\int\_0^1 \sin x dx\\).


### Embed code and results {#embed-code-and-results}

Note that code blocks must be either "ipython" or "R", and the first
one determines the language used for all of the code blocks.

```python
import numpy as np
from scipy.integrate import quad

print(quad(lambda x: np.sin(x), 0, 1))
```

Here we force a new cell to be created with the `ipynb-newcell` directive.
\#+ipynb-newcell

This text should be in its own cell.


### Embed tables {#embed-tables}

You can create tables and they render nicely in the notebook. Note that you probably should not use the tables as data sources to code blocks because the ipython notebook does not support that.

<div class="table-caption">
  <span class="table-number">Table 1:</span>
  A table of numbers.
</div>

| x | y |
|---|---|
| 1 | 1 |
| 2 | 4 |
| 3 | 9 |


### Use ipython magic to get inline figures {#use-ipython-magic-to-get-inline-figures}

```python
%matplotlib inline
import matplotlib.pyplot as plt

z = np.linspace(0, 20 * np.pi, 500)
x = np.sin(z) * np.exp(-0.1 * z)
y = np.cos(z) * np.exp(-0.1 * z)
plt.plot(x, y)
```


### Store metadata in the ipynb {#store-metadata-in-the-ipynb}

The directive `ox-ipynb-keyword-metadata` lists file variables that should be saved as metadata in the ipynb.

We can set values as file variables like this:

{{< figure src="./screenshots/date-05-08-2017-time-08-55-41.png" >}}

On export, you can see these are stored in the metadata as:

{{< figure src="./screenshots/date-05-08-2017-time-08-56-35.png" >}}

These will show as bullets at the top of the ipynb. These are machine readable, so you can access them with any tool that can read json. You can use this to store author names, document id's, etc.

```python
import json

with open("example.ipynb") as f:
    d = json.loads(f.read())

print(d['metadata']['org'])
```


### Use HTML for fancy markup {#use-html-for-fancy-markup}

You can use html tags directly in the org file. Here are two examples.

&lt;div class="alert alert-warning"&gt;
&lt;font color="blue"&gt;This text will show up as blue.&lt;/font&gt;
You can use an alert to highlight something you want to stand out.
&lt;/div&gt;

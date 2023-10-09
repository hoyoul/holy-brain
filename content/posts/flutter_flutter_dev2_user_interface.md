+++
title = "[flutter] flutter.dev2-User Interface-introduction-hello world"
author = ["holy"]
description = "User interface's introduction"
date = 2023-09-12T00:00:00+09:00
draft = true
+++

## Hello world {#hello-world}

```dart
import 'package:flutter/material.dart';

void main() {
  runApp(
    const Center(
      child: Text(
        'Hello, world!',
        textDirection: TextDirection.ltr,
      ),
    ),
  );
```

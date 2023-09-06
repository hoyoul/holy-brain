+++
title = "[flutter] how to install flutter on bigsur"
author = ["holy"]
description = "bigsur 옛날 computer에 flutter설치"
date = 2023-08-23T00:00:00+09:00
draft = true
+++

## 요구 사항 {#요구-사항}

flutter는 최신 기기와 sw를 요구한다. 오래된 컴퓨터는 사용할 수
없다. 그런데 사용하려고 한다. 방법은 있다. 다음은 requirement다.

```text
- bigsur os
- xcode 13.2.1
- flutter sdk 2.8.1
```

최신을 설치하면 안된다. 다 옛날 버전에 맞춰서 설치한다. 그런데
computer와 xcode, flutter sdk만 버전을 낮춘다고 모든 조건이 만족되는게
아니다. ios app을 만들고 이를 실 ios 폰에서 봐야 하는데, xcode가
지원하는 실 아이폰의 os version이 있다.

```text
iOS 15.2, iPadOS 15.2, tvOS 15.2, watchOS 8.3, and macOS Monterey
12.1.
```

현재 내폰은 16.2라서 xcode와 연결해서 app을 실행할 수 없다. 15.2
이하로 downgrade하거나, 옛날폰이 있어야 한다.


## xcode {#xcode}

xcode는 git으로 버전 관리가 안되기 때문에, apple 개발자 센터에서
다운받아야 한다.
[여기](https://developer.apple.com/xcode/resources/)


## flutter {#flutter}

flutter는 최신버전을 설치하면 안된다. git으로 clone했다면, git tag에서
version을 확인한 후에, git checkout 2.8.1를 실행한다. head가
detach된다고 나오지만 신경쓰지 않아도 된다.

```text
flutter --version
```

flutter로 버전만 확인해도 변경작업이 실행된다.
system이 최신이라면 flutter는 항상 udgrade 해 놓는다.

```text
flutter upgrade
```

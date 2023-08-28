+++
title = "[dart] about package"
author = ["holy"]
description = "dart package에 관해서"
date = 2023-08-18T00:00:00+09:00
draft = true
+++

## package {#package}

program을 만들면 배포를 해야 한다. 이 배포란 것이 택배 시스템보단
온라인 쇼핑몰과 더 비슷하다. 갑자기 택배시스템이냐고? 누군가가
택배시스템으로 비유하는데, 내 생각엔 쿠팡이나 gmarket같은 쇼핑몰과
비슷하다. 개인이 project를 만들면 project를 package란 박스로 만들고
쇼핑몰에 보낸다.  melpa에 등록하거나, brew의 repo나 pypi에 package를
등록하는 것이다.  이런 major 쇼핑몰만 있는건 아니다. github이나 brew의
tap처럼 물건 파는곳은 여러군데다. 여튼 개인은 package manager를 통해서
package를 가져올 뿐이다. 만일 자신인 제품을 만들어서 쇼핑몰에
입점할려면 package를 만들 수 있어야 한다.


## package manager {#package-manager}

일반적으로 쇼핑몰에서 물건을 사는 사람들은 package를 만들고 쇼핑몰에
올리고 할 필요는 없다. 그냥 쇼핑몰에서 물건만 가져오면
된다. 쇼핑몰에서 물건을 가져올때 package manager를 사용한다. 그래서
일반 사용자들은 package manager가 package도 포장하고 창고로 이동도
하는것을 잘 모른다. 쿠팡맨들이나 택배기사들은 물건을 package로
포장하고 쇼핑몰 창고로 이동도 하는것에 명심하자.


## dart {#dart}

dart의 package manager는 pub이다. package를 취급하는 쇼핑몰은
pub.dev.site다. package manager의 사용법은 [여기](https://dart.dev/tools/pub/cmd)를 참조하자.
+++
title = "[leetcode] 1480 running sum of 1d array"
author = ["holy"]
description = "leet code expolore에서 첫번째로 제시하는 문제"
date = 2023-06-14T00:00:00+09:00
draft = true
+++

## 문제 위치 {#문제-위치}

[여기](https://leetcode.com/problems/running-sum-of-1d-array/)


## 문제 {#문제}

<div class="important">

Given an array nums. We define a running sum of an array as
runningSum[i] = sum(nums[0]…nums[i]).  Return the running sum of nums.

</div>


### example1 {#example1}

<div class="note">

Input: nums = [1,2,3,4]
Output: [1,3,6,10]
Explanation: Running sum is obtained as follows: [1, 1+2, 1+2+3, 1+2+3+4].

</div>


### example2 {#example2}

<div class="note">

Input: nums = [1,1,1,1,1]
Output: [1,2,3,4,5]
Explanation: Running sum is obtained as follows: [1, 1+1, 1+1+1, 1+1+1+1, 1+1+1+1+1].

</div>


### example3 {#example3}

<div class="note">

Input: nums = [3,1,2,10,1]
Output: [3,4,6,16,17]

</div>


### constraints {#constraints}

<div class="note">

-   1 &lt;= nums.length &lt;= 1000
-   -10^6 &lt;= nums[i] &lt;= 10^6

</div>


## 풀이 {#풀이}

```python
def test():
    nums = [1,2,3,4]
    output = []
    for index,value in enumerate(nums):
	sum = value
	for v in nums[0:index]:
	    sum = sum + v
	output.append(sum)
    return output
print(test())
```

```text
[1, 3, 6, 10]
```


## 의도 {#의도}

우선 nums라는 list에 가리키는 pointer가 2개 있어야 한다고
생각했다. double for-loop을 생각한 것은 첫번째 pointer가 가리킬 때마다
첫번째 원소부터 첫번째 pointer까지 list가 생성되고 그 list의 합을
구해야 하기때문에 2개의 pointer가 필요하다고 생각했다. 이것을
for-loop이 아닌 recursive function으로 구현하는게 더 좋을거 같긴
하지만, 언뜻 생각나는게 for-loop이였다. 구현할때 index가 필요할꺼
같아서 enumerate를 사용해서 index를 얻어왔다. 두번째 for-loop는
slicing을 이용했는데, nums[0:0]은 for-loop안으로 진입하지 못하는거
같다.

```text
for v in nums[0:index]:
```

그래서 첫번째 원소 처리를 첫번째 for-loop에서 가져온 첫번째 원소를
출력 list의 첫번째 원소값으로 하기위해 다음과 같은 처리를 했다. 이게
맞는지 모르겠다.

```text
for index,value in enumerate(nums):
    sum = value
```

accept되긴 했지만 찜찜하다.


## 참고 {#참고}

좋은 solution이 많은데, 몇개를 옮겨쓰면 다음과 같다.

```python
class Solution:
    def runningSum(self, nums: List[int]) -> List[int]:
	for i in range(1, len(nums)):
	    nums[i] += nums[i - 1]
	return nums
```

for-loop을 한개만 사용했다. nums를 계산하는 과정이 흥미롭다. 이렇게도
짤수 있구나 하는 생각이 든다. 아래에 있는 것도 신선하다. sum()가
list를 인자로 받으면 list의 모든 원소를 합하기 때문에 두번째
for-loop은 필요없다는 것을 말하고 있다.

```python
lst = []
num = 1
while len(lst) != len(nums):
    lst.append(sum((nums[0:num])))
    num += 1
return lst
```

더 간단하게 짠것도 있다. itertools라는 module의 accumulate함수를
사용한 건데, 문제를 구현한 함수 같다.

```python
from itertools import accumulate
a = [1,3,4]
print(list(accumulate(a)))
```

```python
from itertools import accumulate

class Solution:
    def runningSum(self, nums: List[int]) -> List[int]:
	return list(accumulate(nums))
```


## 요약 {#요약}

우선 내 코드는 상당히 잘못되었다. double loop를 쓴것부터
잘못되었다. 한번의 loop는 돌려야 하는건 맞는거 같다. 그리고, 업무에서는
accumulate함수를 사용하면 될것이다.

+++
title = "[leetcode] 1672 Richest Customer Wealth"
author = ["holy"]
description = "leetcode의 explore에 있는 beginner문제다."
date = 2023-06-17T00:00:00+09:00
draft = true
+++

## 문제 {#문제}

[링크](https://leetcode.com/problems/richest-customer-wealth/)

<div class="important">

You are given an m x n integer grid accounts where accounts[i][j]
is the amount of money the i​​​​​​​​​​​th​​​​ customer has in the j​​​​​​​​​​​th​​​​ bank. Return
the wealth that the richest customer has.

A customer's wealth is the amount of money they have in all their bank
accounts. The richest customer is the customer that has the maximum
wealth.

</div>


### example1 {#example1}

```text
Input: accounts = [[1,2,3],[3,2,1]]
Output: 6
Explanation:
1st customer has wealth = 1 + 2 + 3 = 6
2nd customer has wealth = 3 + 2 + 1 = 6
Both customers are considered the richest with a wealth of 6 each, so return 6.
```


### example2 {#example2}

```text
Input: accounts = [[1,5],[7,3],[3,5]]
Output: 10
Explanation:
1st customer has wealth = 6
2nd customer has wealth = 10
3rd customer has wealth = 8
The 2nd customer is the richest with a wealth of 10.
```


### example3 {#example3}

```text
Input: accounts = [[2,8,7],[7,1,3],[1,9,5]]
Output: 17
```


### constraints {#constraints}

<div class="important">

m `= accounts.length
n =` accounts[i].length
1 &lt;= m, n &lt;= 50
1 &lt;= accounts[i][j] &lt;= 100

</div>


## 생각 {#생각}

account라는 data를 사람과 bank라는 2개의 data로 나타내는데 2d array를
사용한다.


## 풀이 {#풀이}

```python
class Solution(object):
    def maximumWealth(self, accounts):
	"""
	:type accounts: List[List[int]]
	:rtype: int
	"""
	output = []
	for i,v in enumerate(accounts):
	    output.append(sum(accounts[i]))
	return max(output)
```

accept되긴 했다. 그런데 여기서 index를 얻어오기 위해서 enumerate 한것이
걸린다. 꼭 이런방법을 택했었어야 했을까?


## 참조 {#참조}

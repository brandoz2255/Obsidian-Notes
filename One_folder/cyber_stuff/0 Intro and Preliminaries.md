
+**Discrete math:** is not the same as regular math for example an interval in continuous math is in the style of between 1-10 where any number between those two real numbers 

- In Discrete math its the whats individually between 1 and 10 in the context of integers rather than real numbers such as 1 , 2 , 3 ,4 etc until 10 
- that's How discrete math works

```python
The most popular mathematician in the world is throwing a party for all of his friends. As a way to kick things off, they decide that everyone should shake hands. Assuming all 10 people at the party each shake hands with every other person (but not themselves, obviously) exactly once, how many handshakes take place?
```

- This is one of the practice problems and the first question of our homework 
- here we look at this problem as finding exactly once how many shakes take place considering 1-10 people all shake hands 
- Like mentioned before sequences so in this context once one person has shuck hands that would 9 + 8 more to go then 7+6 etc 

$$n(n-1)/2$$

- This formula would better explain it where `n` is the amount of people at the party 

[[]]


**Sequences**: Is an ordered list of elements could literally be anything as long as its ordered understanding how the order works over time is understanding the sequence

Example:
```Python
**Fibonacci Sequence:** 

The Fibonacci sequence is a classic example. It's an ordered list of numbers where each number is the sum of the two preceding ones, usually starting with 0 and 1. The sequence looks like this:

0,1,1,2,3,5,8,13,21,34,…0,1,1,2,3,5,8,13,21,34,…

Here's how it works:

- 0+1=10+1=1
- 1+1=21+1=2
- 1+2=31+2=3
- 2+3=52+3=5
- 3+5=83+5=8
- ... and so on.

Each number in the sequence depends on the two numbers that precede it. The order is crucial – change the order, and you get a completely different sequence.

Understanding this sequence involves recognizing the pattern of adding the last two numbers to get the next one. It's like a mathematical dance where each step follows a precise order. So, the Fibonacci sequence is a perfect example of how an ordered list of elements forms a sequence, and understanding the order reveals the beauty of the pattern
```

**Logic and Proposition:**  Truth value of a certain proposition will follow a sequence 

`Ex`
```Python
**Propositional Logic Example:** 

Consider two propositions, `p` and `q`, and let's explore their truth values under different scenarios.

1. p:"The sun is shining."p:"The sun is shining."
2. q:"It’s a weekend."q:"It’s a weekend."

Now, let's look at a sequence of compound propositions using logical connectives (AND, OR, NOT):

1. p∧q:"The sun is shining and it’s a weekend."p∧q:"The sun is shining and it’s a weekend."
2. p∨q:"Either the sun is shining or it’s a weekend (or both)."p∨q:"Either the sun is shining or it’s a weekend (or both)."
3. ¬p:"It’s not the case that the sun is shining."¬p:"It’s not the case that the sun is shining."

Now, we can create a sequence of truth values for these propositions based on different situations:

1. If it's a sunny weekend, then pp is true, qq is true, p∧qp∧q is true, p∨qp∨q is true, and ¬p¬p is false.
    
2. If it's a cloudy weekday, then pp is false, qq is false, p∧qp∧q is false, p∨qp∨q is false, and ¬p¬p is true.
    
3. If it's a sunny weekday, then pp is true, qq is false, p∧qp∧q is false, p∨qp∨q is true, and ¬p¬p is false.
    

In this way, the truth values of the compound propositions form a sequence based on different scenarios. Understanding how the truth values change with different combinations of truth and falsehood is a key aspect of propositional logic
```

**Combinatorics**: This is counting and combining expressions in a problem arranging objects, choosing subsets, dealing with permutations sequences help us determine whats what. 
Ex
```Python
**Example: Arranging Books on a Shelf**

Imagine you have 3 different books: A, B, and C. You want to arrange them on a shelf in different orders. Let's count the number of ways you can arrange these books.

1. **Permutations:**
    
    - If you arrange all three books in a line, you have 3 options for the first book, 2 options for the second book (since one is already placed), and 1 option for the last book. So, the total number of arrangements (permutations) is 3×2×1=63×2×1=6 ways.
    
    The possible arrangements are:
    
    - ABC
    - ACB
    - BAC
    - BCA
    - CAB
    - CBA
2. **Combinations:**
    
    - Now, let's say you want to choose 2 books to put on a table, and the order doesn't matter. This involves combinations.
    - The number of ways to choose 2 books from 3 can be calculated using the combination formula: (nk)=n!k!(n−k)!(kn​)=k!(n−k)!n!​. For this case, it's (32)=3!2!(3−2)!=3(23​)=2!(3−2)!3!​=3 ways.
    
    The possible combinations are:
    
    - AB
    - AC
    - BC
```



**Graph Theory:** Sequences of the graph can explain what is happening in a situation 

**Number Theory**: properties of integers and their sequences are explored

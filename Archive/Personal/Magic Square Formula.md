[[Lecture]] | 1.1C 

#### Magic Square

A **magic square** is in order $n$ in an arrangement of $n^2$ numbers usually integers such that the $n$ numbers in all rows are diagonals sum to the constant

This **algorithm** is defined as a square containing several distinct integers arranged so that the total sum or the numbers is the same in every row. 

#### Math
- $M = n(n^2-1)/2$
- This is the formula for the magic square which is used to make magic squares in different orders 
- If we subtract another $(n^2+1)$ we another magic square this method is called a `complementary magic square`

**Note**: Only works for odd values of $n$

![[swappy-20240907_190329.png]]

- Here is an example of the Magic Squares algorithm 

### Construction Methods

There are several ways to construct a magic square:

1. Direct Enumeration: Placing numbers manually to satisfy the constraints [4](https://en.wikipedia.org/wiki/Magic_square).
2. Continuous Enumeration Algorithms: Methods for constructing borders of any order [4](https://en.wikipedia.org/wiki/Magic_square).
3. Greek and Latin Squares Method: Using smaller squares to build larger ones [4](https://en.wikipedia.org/wiki/Magic_square).

![[swappy-20240907_190832.png]]

### Interesting Facts

1. Every 3x3 magic square of distinct positive integers follows a specific pattern [4](https://en.wikipedia.org/wiki/Magic_square).
2. Parallelograms on the Argand diagram correspond uniquely to 3x3 magic squares [4](https://en.wikipedia.org/wiki/Magic_square).

### Applications

Magic squares have applications in mathematics, cryptography, and computer science [2](https://the-algorithms.com/algorithm/magic-square).



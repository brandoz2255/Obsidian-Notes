# Home work AI solutions 

#### 1
Oh, the good ol' handshake extravaganza! Let's break it down. If there are 10 people at the party and each person shakes hands with every other person exactly once, we can calculate the total number of handshakes.

For the first person, there are 9 other people to shake hands with. The second person has already shaken hands with the first, so they have 8 new people to shake hands with. The third person has already shaken hands with the first two, leaving 7 new people, and so on.

So, you sum up the number of new handshakes for each person: 9 + 8 + 7 + 6 + 5 + 4 + 3 + 2 + 1. This sum is a classic arithmetic series.

And the formula for the sum of the first n natural numbers is n * (n + 1) / 2.

So, for 10 people, it would be 10 * (10 - 1) / 2. Let's do the math, and drumroll, please... 🥁

It's 45 handshakes! Not too shabby, huh? Now you can impress your friends at the mathematician's party with your newfound handshake knowledge. 🤝✨

## My understanding 
This is one of the practice problems and the first question of our homework 
- here we look at this problem as finding exactly once how many shakes take place considering 1-10 people all shake hands 
- Like mentioned before sequences so in this context once one person has shuck hands that would 9 + 8 more to go then 7+6 etc 

$$n(n-1)/2$$

- This formula would better explain it where `n` is the amount of people at the party 

#### 2 
Ah, the epic hot dog devouring saga! Let's unwrap this wienerful story.

So, each contestant is trying to out-chomp the previous one by eating two more hot dogs. Al starts with 1 hot dog, Bob ups the ante to 3, Carl takes it to 5, and this pattern continues.

To find out how many hot dogs Zeno, the 26th contestant, scarfed down, we can use the formula for an arithmetic sequence: an=a1+(n−1)dan​=a1​+(n−1)d, where anan​ is the nth term, a1a1​ is the first term, n is the number of terms, and d is the common difference.

In this case, an=1+(26−1)×2an​=1+(26−1)×2. Let's do some hot dog arithmetic... 🌭

an=1+25×2=1+50=51an​=1+25×2=1+50=51

So, Zeno went to town on 51 hot dogs! Now, for the grand total of hot dogs eaten, we need to sum up the entire sequence. This can be calculated using the sum of an arithmetic series formula: Sn=n2(a1+an)Sn​=2n​(a1​+an​).

Plug in the values: S26=262(1+51)S26​=226​(1+51).

Let's crunch the numbers... 🧮

S26=13×52=676S26​=13×52=676

A whopping 676 hot dogs in total! That's enough to turn any picnic into a feast. 🌭🎉

## My understanding 


#### 3 
1. Troll 1 says, "If I am a knave, then there are exactly two knights here."
    
    - If Troll 1 is a knight, the statement is irrelevant.
    - If Troll 1 is a knave, the statement is false because a knave cannot make a true statement.
2. Troll 2 claims, "Troll 1 is lying."
    
    - If Troll 2 is a knight, then Troll 1 must be lying (since knights tell the truth), making Troll 2's statement true.
    - If Troll 2 is a knave, then Troll 1 must be telling the truth (since knaves lie), making Troll 2's statement false.
3. Troll 3 declares, "Either we are all knaves or at least one of us is a knight."
    
    - If Troll 3 is a knight, the statement is true.
    - If Troll 3 is a knave, the statement is also true because it allows for the possibility of at least one knight.

Now, let's piece it together:

- If Troll 1 is a knight, then Troll 2 must be a knight as well (since Troll 2's statement is true). But this conflicts with Troll 1's statement, so Troll 1 can't be a knight.
- If Troll 1 is a knave, then Troll 2 is a knight (as Troll 1 is lying), and Troll 3 is a knight (because Troll 3's statement is true). This satisfies all conditions.

So, Troll 1 is the knave, Troll 2 is the knight, and Troll 3 is the knight. Beware of enchanted forest trolls and their tricky words! 🌲👹🔍

#### 4
Ah, the medieval road-building challenge! Let's see if these towns can pave the way to connectivity without turning it into a chaotic intersection mess.

For five towns, we can think about it in terms of connections. Each town needs a road to every other town, and we want to avoid intersections. Let's do some quick math:

- Town 1 needs roads to Towns 2, 3, 4, and 5.
- Town 2 needs roads to Towns 1, 3, 4, and 5.
- Town 3 needs roads to Towns 1, 2, 4, and 5.
- Town 4 needs roads to Towns 1, 2, 3, and 5.
- Town 5 needs roads to Towns 1, 2, 3, and 4.

Now, let's count the number of roads needed. Town 1 has 4 connections, Town 2 has 4 connections, and so on. Each town needs 4 roads, and since there are 5 towns, we would need a total of 5×4=205×4=20 roads.

But, there's a twist! Each road connects two towns, so it's counted twice. We need to divide the total count by 2 to get the actual number of roads required. So, 5×42=1025×4​=10 roads.

Now, let's check if that's possible without intersections. For each town, there are 4 other towns it needs to connect to. If you draw it out carefully, you'll find that it's indeed possible to build these roads without any intersections. So, in this medieval road adventure, the towns can achieve their connectivity dreams without chaos on the crossroads! 🏰🛣️


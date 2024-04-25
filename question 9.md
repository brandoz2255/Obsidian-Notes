Question A) 

python
### Simplifying Logical Expressions with De Morgan's Laws

Given the logical statement:
$$\[ \neg((\neg P \land Q) \lor \neg(R \lor \neg S)) \]$$

Let's apply De Morgan's Laws step by step.

## Step 1: Apply De Morgan's Laws to Inner Negations

First, apply De Morgan's Laws to \( \neg P \land Q \) and \( R \lor \neg S \):

$$\[ \neg((\neg P \land Q) \lor \neg(R \lor \neg S)) \]$$
$$\[ \neg((\neg P \land Q) \lor (\neg R \land S)) \] (De Morgan’s Laws)$$

## Step 2: Apply De Morgan's Laws to Outer Negation

Next, apply De Morgan's Laws to the negation of the entire expression:
$$
\[ \neg(\neg P \land Q) \land \neg(\neg R \land S) \]$$
$$\[ (P \lor \neg Q) \land (R \lor \neg S) \] (De Morgan’s Laws)$$

## Conclusion

The expression simplifies to:
$$\[ (P \lor \neg Q) \land (R \lor \neg S) \]$$

This result ensures that all negations are directly next to the individual variables,

Question C) part A 

| P     | Q     | R     | S     | ¬((¬P ∧ Q) ∨ ¬(R ∨ ¬S)) | (P ∨ ¬Q) ∧ (R ∨ ¬S) |
| ----- | ----- | ----- | ----- | ----------------------- | ------------------- |
| True  | True  | True  | True  | False                   | False               |
| True  | True  | True  | False | True                    | True                |
| True  | True  | False | True  | True                    | True                |
| True  | True  | False | False | True                    | True                |
| True  | False | True  | True  | False                   | False               |
| True  | False | True  | False | True                    | True                |
| True  | False | False | True  | True                    | True                |
| True  | False | False | False | True                    | True                |
| False | True  | True  | True  | False                   | False               |
| False | True  | True  | False | True                    | True                |
| False | True  | False | True  | False                   | False               |
| False | True  | False | False | True                    | True                |
| False | False | True  | True  | False                   | False               |
| False | False | True  | False | True                    | True                |
| False | False | False | True  | False                   | False               |
| False | False | False | False | True                    | True                |
|       |       |       |       |                         |                     |

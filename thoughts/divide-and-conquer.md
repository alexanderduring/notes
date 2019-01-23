# Divide and Conquer
When structuring the code, I am always trying to divide a bigger idea into some smaller ones. 

## A Bad Example
Here is a bad example with unstructured code:

```PHP
public function addFooToBar(Bar $bar, string $foo1, string $foo2)
{
    $bar->addFoo(new Foo(mb_strtoupper($foo1), $this->replaceInvalidParts($foo2)));
}
```
## Splitting the Idea into Smaller Steps
The big idea is: Add the string $foo1, which should be in uppercase and the string $foo2 having no invalid parts in it, 
both wrapped in an instance of Foo to the provided $bar.

The big idea can be divided into smaller thought:
- We need an uppercase version $upperCaseFoo1 of the string $foo1
- We need a valid version $validFoo2 of the string $foo2
- We need an instance $foo of the class Foo, made with $upperCaseFoo1 and $validFoo2
- We should add $foo to $bar

This would result in the following function:

```PHP
public function addFooToBar2(Bar $bar, string $foo1, string $foo2)
{
    $upperCaseFoo1 = mb_strtoupper($foo1);
    $validFoo2 = $this->replaceInvalidParts($foo2);
    $foo = new Foo($upperCaseFoo1, $validFoo2);
    $bar->addFoo($foo);
}
```

## Adding More Complexity
Let's make the example a bit more complex. Additionally to what we achieved so far, we also want to add an instance of the class
Baz which takes a concatenated string of the uppercase version of $foo2 and a prefixed version of $foo1.

In the first attempt the code may look like this:

```PHP
public function addFooToBar3(Bar $bar, string $foo1, string $foo2)
{
    // Initialize some variables
    $upperCaseFoo1 = mb_strtoupper($foo1);
    $prefixedFoo1 = 'prefix' . $foo1;
    $validFoo2 = $this->replaceInvalidParts($foo2);
    $upperCaseFoo2 = mb_strtoupper($foo2);
    $concatenatedFoo2AndFoo1 = $upperCaseFoo2 . $prefixedFoo1;
    
    // Create a Foo and Baz
    $foo = new Foo($upperCaseFoo1, $validFoo2);
    $baz = new Baz($concatenatedFoo2AndFoo1);
    
    // Add the Foo and Baz
    $bar->addFoo($foo);
    $bar->addBaz($baz);
}
```

## Putting Together What Belongs Together
The code in the function above is not really easy to understand. Yes we have divided everything into small steps. And yes we 
have even ordered the small steps somehow. But it still can only be understood as one monolithic block.

Look at the next example to see the difference:

```PHP
public function addFooToBar4(Bar $bar, string $foo1, string $foo2)
{
    // Add a Foo
    $upperCaseFoo1 = mb_strtoupper($foo1);
    $validFoo2 = $this->replaceInvalidParts($foo2);
    $foo = new Foo($upperCaseFoo1, $validFoo2);
    $bar->addFoo($foo);

    // Add a Baz
    $prefixedFoo1 = 'prefix' . $foo1;
    $upperCaseFoo2 = mb_strtoupper($foo2);
    $concatenatedFoo2AndFoo1 = $upperCaseFoo2 . $prefixedFoo1;
    $baz = new Baz($concatenatedFoo2AndFoo1);
    $bar->addBaz($baz);
}
```

For each of the two blocks to understand you only need the function parameters and what is in the block. You can ignore the 
other block completely. Even if you would delete one block, the other one would still work. So the two blocks do not depend on 
each other. We have split a big idea into two smaller independent thoughts.

## Level of Difficulty

What makes understanding a sentence difficult? Let's take a look at an example:

> *Anyone who feels that if so many more students whom we haven’t actually admitted are sitting in on the course than ones we have that the room had to be changed, then probably auditors will have to be excluded, is likely to agree that the curriculum needs revision.*

When you start reading this sentence you load information in your working memory (e.g. "Anyone who feels"). But when you encounter the word "that", which indicates the beginning of a *that-clause* you put the content of your working memory on your stack, to be retrieved, when the *that-clause* has endet. While more and more subsentences are opening you put additional stuff on your stack, which at the end has to be retrieved and put together in the right order to fully understand the sentence.

What your brain is doing in a recursive manner is breaking the sentence up into smaller chunks that carry simple meaning as follows:
  - C1: Students whom we have not admitted
  - C2: Students whom we have admitted
  - C3: More C1 than C2 are sitting in on the course
  - C4: So much C3, that the room has to be changed
  - C5: if C4 then auditors have to be excluded
  - C6: the curriculum needs revision
  - C7: Anyone who feels C5 is likely to agree C6

If we consider the amount of things to keep in your mind while trying to understand a sentence (or a chunk of code) as the "Level of difficulty", then last function is easier to understand than the previous one.

## Conclusions
If you take a look at the distance of variable assignments and variable usages, you can see a total difference between the 
functions addFooToBar3 and addFooToBar4.

| Variable                 | addFooToBar3 | addFooToBar4 |
|:-------------------------|-------------:|-------------:|
| $upperCaseFoo1           | 5 | 2 |
| $validFoo2               | 3 | 1 |
| $prefixedFoo1            | 3 | 2 |
| $upperCaseFoo2           | 1 | 1 |
| $concatenatedFoo2AndFoo1 | 2 | 1 |
| $foo                     | 2 | 1 |
| $baz                     | 2 | 1 |
| *Average*                | *2.6* | *1.3* |

The average distance is cut in half, which suggests that to read and understand *addFooToBar4* is half as difficult as *addFooToBar3*.

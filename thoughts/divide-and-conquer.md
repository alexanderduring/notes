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
But code in the function above is not really easy to understand. Yes we have divided everything into small steps. And yes we 
even have ordered the small steps somehow. But it still can only be understood as one monolithic block.

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

For each of the two blocks to understand you only need, the function parameters and what is in the block. You can ignore the 
other block completely. 

If we consider the amount of things to keep in your mind while trying to understand a chunk of code as the "Level of difficulty",
then last function is easier to understand than the previous one.

## Conclusions
If you take a look at the distance of variable assignments and variable usages, you can see a total difference between the 
functions addFooToBar3 and addFooToBar4.

| Variable | addFooToBar3 | addFooToBar4 |
|---------:|-------------:|-------------:|
|          |              |              |

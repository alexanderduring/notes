# Try-Catch-Finally

## Example 1

```php
try {
    echo "Try-Block";
} catch (RuntimeException $exception) {
    echo "Caught RuntimeException";
} finally {
    echo "Finally-Block";
}
```
outputs

```
Try-Block
Finally-Block
```

## Example 2

```php
try {
    echo "Try-Block";
    throw new RuntimeException();
} catch (RuntimeException $exception) {
    echo "Caught RuntimeException";
} finally {
    echo "Finally-Block";
}
```

outputs

```
Try-Block
Caught RuntimeException
Finally-Block
```

## Example 3

```php
try {
    echo "Try-Block";
    throw new Exception("Uncaught Exception");
} catch (RuntimeException $exception) {
    echo "Caught RuntimeException";
} finally {
    echo "Finally-Block";
}
```

outputs

```
Try-Block
Finally-Block
Exception: Uncaught Exception
```

## Example 4

```php
try {
    echo "Try-Block";
    throw new RuntimeException();
} catch (RuntimeException $exception) {
    echo "Caught RuntimeException";
    throw new Exception("Uncaught Exception");
} finally {
    echo "Finally-Block";
}
```

outputs

```
Try-Block
Caught RuntimeException
Finally-Block
Exception: Uncaught Exception
```

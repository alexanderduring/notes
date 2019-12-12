Let us assume, we have set up a Symfony Lock like this:

```PHP
$redisStore = new Symfony\Component\Lock\Store\RedisStore($redisConnection);
$factory = new Symfony\Component\Lock\Factory($redisStore);
$lock = $factory->createLock("mylock", 120);
```

How is a good way to use it?

Example 1:
```PHP
if ($lock->acquire()) {
    $this->doStuff();
    $lock->release();
} else {
    $logger->warning('Failed to acquire lock.');
}
```

What could go wrong here? First of all, `$this->doStuff()` could through an exception, which would prevent the lock from being released.

Example 2:
```php
if ($lock->acquire()) {
    try {
        $this->doStuff();
    } catch (Exception $exception) {
        $logger->warning('Couldn't do stuff.');
    }
    $lock->release();
} else {
    $logger->warning('Failed to acquire lock.');
}
```

With this approach we make sure, that the lock is released regardless of what exception is thrown by `$this->doStuff()`. The disadvantage is, that we need to catch all exceptions.
A better solution can be achieved using the finally block:

Example 3:
```PHP
try {
    if ($lock->acquire()) {
        $this->doStuff();
    } else {
        $logger->warning('Failed to acquire lock.');
    }
} finally {
    $lock->release();
}
```

# Class Constants
I prefer not to use class constants or at least if I use them I only do in the local scope of that class.

## Disadvantages of Class Constants
A class constant introduces a dependency. Using the constant in PHP would look like this:

```PHP
$this->adapter->setType(\Specific\Adapter::SPECIFIC_TYPE);
```

Although we injected the adapter into our class, we still have a dependency on the class Specific\Adapter. A better solution would be to define the constant in an interface.

```PHP
$this->adapter->setType(\Api\AdapterInterface::SPECIFIC_TYPE);
```

Now we removed the dependency on the specific class and our class depends on the interface Api\AdapterInterface. Which is not introducing a new dependency, because our method injectAdapter probably already did use the interface:

```PHP
public function injectAdapter(\Api\AdapterInterface $adapter)
{
    $this->adapter = $adapter;
}
```


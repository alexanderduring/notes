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

When using interface constants as parameters in function call another pitfall is waiting for the developer. If the constant is not only used as a parameter value, but is also used be the adapter to write values into the database you are hard wirering the interface to the implementation:

```PHP
class Adapter implements AdapterInterface
{
    public function setType($type)
    {
        $dbEntry = new DbEntry();
        $dbEntry->setType($type);
        $dbEntry->save();
    }
}
```

Now the list of interface constants is the same as the list of database values in the field 'type'. If you want to change your the values in your database, you would need to change the interface definition. Also the method Adapter::setType() is not very descriptive. A solution would be to introduce an abstraction layer:

```PHP
class Adapter implements AdapterInterface
{
    public function setType($type)
    {
        $dbEntry = new DbEntry();
        
        switch ($type) {
            case AdapterInterface::SPECIFIC_TYPE:
                $dbEntry->setType(self::DB_TYPE);
                break;
            case AdapterInterface::ANOTHER_TYPE:
                $dbEntry->setType(self::DB_TYPE_TWO);
                break;
        }
        
        $dbEntry->save();
    }
}
```

This way you can define and change the values that you write into your database in your own adapter. You can change them without the need to change the interface definition and you can easily see, which interface types are implemented in your adapter. The constants in your Adapter class should of course be private or at least not used outside of the class.

The questions is: Where to put the interface definition? In the context of the consumer or the implementor?

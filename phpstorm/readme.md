# PHPStorm Meta File

If you add the file .phpstorm.meta.php in the root directory of your project, it helps PHPStorm to autodetect types of services that are returned by classes that implement the Psr\Container\ContainerInterface, like the ServiceManager in Zend Framework.

Example:

```php
// PHPStorm knows, that $fooService is an instance of FooService class.
$fooService = $serviceManager->get(FooService::class);  
```

See https://www.jetbrains.com/help/phpstorm/ide-advanced-metadata.html

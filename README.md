LTUserSetting
=============

An NSUserDefault based setting store with a NSDictionary cache.
It will store the setting value in NSUserDefault standardDefault. 
## Basic Usage
- Get the setting store, which was a singleton 

    `LTUserSetting *setting = [LTUserSetting sharedStore];`
### Create/Update a setting value

 Set an object to setting store, based on key and value, the `isStore` parameter will store to NSUserDefualts if `YES`, or it just save the value in the in-memory cache, it will do a deep-copy of the value object, so the value object must support `<NSCopying>` protocol.
 
- set an object

    `[setting setKey:@"testKey" value: @1 isStore:YES];`
- Set a NSInteger, it save you some time to convert a NSInteger(long) to a NSNumber. 

    `[setting setKey:@"testKey" number: 1 isStore:YES];`
### Get/Fetch a setting value
The fetch work below, it first will fetch value from cache, if no value is fetched, fallback to `NSUserDefaults`, if fetched a value, it will store in cache, so next time you will get value from cache.

- Fetch an object from setting

   `[setting getObjectByKey: @"testKey"]`
- Fetch a string from setting

  `[setting getStringValue:@"testKey"]`
- Fetch a NSInteger from setting,
 it will perform the convert from NSNumber to an NSInteger.

  `[setting getIntValue: @"testKey"]`
## TODO
-  Default value setup, NSUserDefault have a default setup, need add an API to handle this.
-  Cache invalidate API, even through it no needed.

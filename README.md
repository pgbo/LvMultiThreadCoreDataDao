# LvMultiThreadCoreDataDao

## Introduction

LvMultiThreadCoreDataDao is an iOS framework that allows using core data conveniently and safety. It uses **ARC**. Requires **CoreData** framework. The sample test create 100 objects, 100 query operations and 100 delete operations under multi-thread.

## Adding to your project
Just copy or drag the LvMultiThreadCoreDataDao folder into your projects.

## simple use
See the demo project for the details. Follow is a simple use.
### Import header

```` objective-c
#import "LvMultiThreadCoreDataDao.h"
````

### Create a dao and setup Core Data model and db file

```` objective-c
LvMultiThreadCoreDataDao *storageDao = [[LvMultiThreadCoreDataDao alloc]init];
[storageDao setupEnvModel:@"MessageModel" DbFile:@"Message.sqlite"];
````

### Asynchronized query 
```` objective-c
[storageDao filterObjectWithFetchRequest:request handler:^(NSArray *results, NSError *err){
        if (resultHandler) {
            NSMutableArray *modelResults = [NSMutableArray array];
            for (NSMangedObject *managedObj in results) {
                **CustomModel** obj = [[**CustomModel** alloc]init];
                [self fillEntity:obj withManagedObj:managedObj];
                [modelResults addObject:obj];
            }
            resultHandler(modelResults);
        }
}];
````
### Synchronized query
```` objective-c
NSArray *results = [storageDao filterObjectWithFetchRequest:request processor:^NSArray* (NSArray *results, NSError *err){
        NSMutableArray *modelResults = [NSMutableArray array];
        for (NSMangedObject *managedObj in results) {
                **CustomModel** obj = [[**CustomModel** alloc]init];
                [self fillEntity:obj withManagedObj:managedObj];
                [modelResults addObject:obj];
        }
        return modelResults;
}];
````
### Create a new object
```` objective-c
**CustomModel** obj = [[**CustomModel** alloc]init];
// Assume obj has been initialized and its attributes has been setted values
[storageDao createNewOfManagedObjectClassName:@"**Custom Managed object class name**" operate:^(NSManagedObject *managedObj){
        [self fillManangedObj:managedObj withEntity:obj];
}];
````
### Delete a object
```` objective-c
[storageDao delObjectWithFetchRequest:request];
````




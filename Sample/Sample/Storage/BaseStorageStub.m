//
//  BaseStorageStub.m
//  GalaToy
//
//  Created by guangbo on 15/3/5.
//
//

#import "BaseStorageStub.h"

@implementation BaseStorageStub

- (instancetype)initWithStorageDao:(LvMultiThreadCoreDataDao *)storageDao
{
    if (self = [super init]) {
        _storageDao = storageDao;
    }
    return self;
}

- (void)fillManangedObj:(NSManagedObject *)managedObj withEntity:(id)entity
{

}

- (void)fillEntity:(id)entity withManagedObj:(NSManagedObject *)managedObj
{
    
}

@end

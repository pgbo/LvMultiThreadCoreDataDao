//
//  NewsStorageStub.m
//  LvDemos
//
//  Created by guangbo on 15/3/10.
//
//

#import "NewsStorageStub.h"
#import "AppDelegate.h"
#import "ManagedNews.h"

@implementation NewsStorageStub

- (void)createNews:(News *)news
{
    if (!news)
        return;
    
    __weak NewsStorageStub *weakSelf = self;
    [self.storageDao createNewOfManagedObjectClassName:[self ManagedNewsClassName] operate:^(NSManagedObject *managedObj){
        [weakSelf fillManangedObj:managedObj withEntity:news];
    }];
}

- (void)deleteNewsOfItemId:(int)itemId
{
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"(%K == %@)", ManagedNewsAttributeItemId, @(itemId)];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc]initWithEntityName:[self ManagedNewsClassName]];
    [fetchRequest setPredicate:predicate];
    
    [self.storageDao delObjectWithFetchRequest:fetchRequest];
}

- (void)deleteAllNews
{
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc]initWithEntityName:[self ManagedNewsClassName]];
//    NSArray *results = [self.storageDao filterObjectWithFetchRequest:fetchRequest processor:nil];
//    [self.storageDao filterObjectWithFetchRequest:fetchRequest handler:^(NSArray *results, NSError *err){
//        for (NSManagedObject *managedObj in results) {
//            [self.storageDao delManagedObject:managedObj];
//        }
//    }];

    [self.storageDao delObjectWithFetchRequest:fetchRequest];
}

- (NSArray *)fetchNews
{
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc]initWithEntityName:[self ManagedNewsClassName]];
    NSArray *results = [self.storageDao filterObjectWithFetchRequest:fetchRequest processor:^ NSArray* (NSArray *results, NSError *err){
        NSMutableArray *newsArray = [NSMutableArray array];
        for (NSManagedObject *managedObj in results) {
            News *item = [[News alloc]init];
            [self fillEntity:item withManagedObj:managedObj];
            [newsArray addObject:item];
        }
        return newsArray;
    }];
    
    return results;
}

- (void)fetchNewsWithHandler:(StorageStubFetchListResult)handler
{
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc]initWithEntityName:[self ManagedNewsClassName]];
    
    __weak NewsStorageStub *weakSelf = self;
    [self.storageDao filterObjectWithFetchRequest:fetchRequest handler:^(NSArray *results, NSError *err){
        NSMutableArray *newsArray = nil;
        if (results) {
            newsArray = [NSMutableArray array];
            for (NSManagedObject *managedObj in results) {
                News *item = [[News alloc]init];
                [weakSelf fillEntity:item withManagedObj:managedObj];
                [newsArray addObject:item];
            }
        }
        if (handler) {
            handler(newsArray);
        }
    }];
}

- (NSInteger)countNews
{
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc]initWithEntityName:[self ManagedNewsClassName]];
    return [self.storageDao countWithFetchRequest:fetchRequest];
}

- (void)countNewsWithHandler:(StorageStubCountResult)handler
{
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc]initWithEntityName:[self ManagedNewsClassName]];
    [self.storageDao countWithFetchRequest:fetchRequest handler:^(NSInteger count, NSError *err){
        if (handler) {
            handler(count);
        }
    }];
}

- (NSString *)ManagedNewsClassName
{
    return [NSString stringWithUTF8String:object_getClassName([ManagedNews class])];
}

#pragma mark - Override

- (void)fillManangedObj:(ManagedNews *)managedObj withEntity:(News *)entity
{
    if (!managedObj || !entity) {
        return;
    }
    
    managedObj.itemId = @(entity.itemId);
    managedObj.content = entity.content;
    managedObj.readCount = @(entity.readCount);
    managedObj.commentCount = @(entity.commentCount);
}

- (void)fillEntity:(News *)entity withManagedObj:(ManagedNews *)managedObj
{
    if (!managedObj || !entity) {
        return;
    }
    
    entity.itemId = managedObj.itemId.intValue;
    entity.content = managedObj.content;
    entity.readCount = managedObj.readCount.intValue;
    entity.commentCount = managedObj.commentCount.intValue;
}

@end

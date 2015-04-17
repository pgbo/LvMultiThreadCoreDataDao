//
//  BaseStorageStub.h
//  GalaToy
//
//  Created by guangbo on 15/3/5.
//
//

#import <Foundation/Foundation.h>
#import "LvMultiThreadCoreDataDao.h"

/**
 *  排序
 */
typedef enum {
    OrderTypeASC,   // 升序
    OrderTypeDESC   // 降序
} OrderType;


typedef void(^StorageStubFetchListResult)(NSArray* result);
typedef void(^StorageStubFetchOneResult)(id object);
typedef void(^StorageStubCountResult)(NSInteger count);

/**
 *  数据存储stub基础类
 */
@interface BaseStorageStub : NSObject

@property (nonatomic, readonly) LvMultiThreadCoreDataDao *storageDao;

- (instancetype)initWithStorageDao:(LvMultiThreadCoreDataDao *)storageDao;

/**
 *  用实体填充NSManagedObject
 *
 *  @param managedObj
 *  @param entity
 */
- (void)fillManangedObj:(NSManagedObject *)managedObj withEntity:(id)entity;

/**
 *  用NSManagedObject填充实体
 *
 *  @param entity
 *  @param managedObj
 */
- (void)fillEntity:(id)entity withManagedObj:(NSManagedObject *)managedObj;

@end

//
//  NewsStorageStub.h
//  LvDemos
//
//  Created by guangbo on 15/3/10.
//
//

#import "BaseStorageStub.h"
#import "News.h"

@interface NewsStorageStub : BaseStorageStub

- (void)createNews:(News *)news;

- (void)deleteNewsOfItemId:(int)itemId;

- (void)deleteAllNews;

- (NSArray *)fetchNews;

- (void)fetchNewsWithHandler:(StorageStubFetchListResult)handler;

- (NSInteger)countNews;

- (void)countNewsWithHandler:(StorageStubCountResult)handler;

@end

//
//  ManagedNews.h
//  LvDemos
//
//  Created by guangbo on 15/3/10.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

#define ManagedNewsAttributeItemId @"itemId"
#define ManagedNewsAttributeContent @"content"
#define ManagedNewsAttributeReadCount @"readCount"
#define ManagedNewsAttributeCommentCount @"commentCount"

@interface ManagedNews : NSManagedObject

@property (nonatomic, retain) NSNumber * itemId;
@property (nonatomic, retain) NSString * content;
@property (nonatomic, retain) NSNumber * readCount;
@property (nonatomic, retain) NSNumber * commentCount;

@end

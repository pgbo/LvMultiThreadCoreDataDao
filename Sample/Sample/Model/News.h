//
//  News.h
//  LvDemos
//
//  Created by guangbo on 15/3/10.
//
//

#import <Foundation/Foundation.h>

@interface News : NSObject

@property (nonatomic) int itemId;
@property (nonatomic) NSString * content;
@property (nonatomic) int readCount;
@property (nonatomic) int commentCount;

- (instancetype)initWithItemId:(int)itemId
                       content:(NSString *)content
                     readCount:(int)readCount
                  commentCount:(int)commentCount;

@end

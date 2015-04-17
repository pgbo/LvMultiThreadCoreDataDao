//
//  News.m
//  LvDemos
//
//  Created by guangbo on 15/3/10.
//
//

#import "News.h"

@implementation News

- (instancetype)initWithItemId:(int)itemId
                       content:(NSString *)content
                     readCount:(int)readCount
                  commentCount:(int)commentCount
{
    if (self = [super init]) {
        self.itemId = itemId;
        self.content = content;
        self.readCount = readCount;
        self.commentCount = commentCount;
    }
    return self;
}

@end

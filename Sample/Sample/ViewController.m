//
//  ViewController.m
//  MultiThreadsCoreDataDemo
//
//  Created by guangbo on 15/3/10.
//
//

#import "ViewController.h"
#import "NewsStorageStub.h"

@interface ViewController ()

@property (nonatomic, weak) IBOutlet UIButton *testButn;

@property (nonatomic, strong) NewsStorageStub *stub;

- (IBAction)clickButn:(id)sender;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    LvMultiThreadCoreDataDao *storageDao = [[LvMultiThreadCoreDataDao alloc]init];
    [storageDao setupEnvModel:@"NewsModel" DbFile:@"NewsDB.sqlite"];
    self.stub = [[NewsStorageStub alloc]initWithStorageDao:storageDao];
    
    self.testButn.enabled = YES;
}

- (IBAction)clickButn:(id)sender
{
    self.testButn.enabled = NO;
    
    [self testMulThreadNewsStorageOperates];
    
    self.testButn.enabled = YES;
}

- (void)removeAllNews
{
    if (!self.stub)
    {
        return;
    }
    StorageStubFetchListResult resultHandler = ^(NSArray *results){
        NSLog(@"results.count : %ld", results.count);
        for (News *item in results) {
            [self.stub deleteNewsOfItemId:item.itemId];
        }
    };
    
    // Way1
    [self.stub fetchNewsWithHandler:^(NSArray *results){
        resultHandler(results);
    }];
    
    // Way2
    //    NSArray *newsArray = [self.stub fetchNews];
    //    resultHandler(newsArray);
}

/**
 *  测试多线程下操作news
 */
- (void)testMulThreadNewsStorageOperates
{
    // 删除所有新闻
        [self removeAllNews];
    
    if (!self.stub)
    {
        return;
    }

    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        [NSThread sleepForTimeInterval:1];
        
        // retry
//        [self removeAllNews];
        
//        [NSThread sleepForTimeInterval:1];
        
        dispatch_queue_t queue_1 = dispatch_queue_create("queue_1", 0);
        dispatch_async(queue_1, ^{
            
            // 插入新闻
            NSLog(@"---- Begin insert!");
            for (int i = 0; i < 100; i ++) {
                News *item = [[News alloc]initWithItemId:i
                                                 content:[NSString stringWithFormat:@"%dth News content", i]
                                               readCount:3
                                            commentCount:1];
                [self.stub createNews:item];
                NSLog(@"Insert item %d", i);
                [NSThread sleepForTimeInterval:0.1];
            }
            NSLog(@"----- Finished insert!");
        });
        
        dispatch_queue_t queue_2 = dispatch_queue_create("queue_2", 0);
        dispatch_async(queue_2, ^{
            // 读新闻
            NSLog(@">>>>> Begin count news!");
            for (int i = 0; i < 100; i ++) {
                NSInteger count = [self.stub countNews];
                NSLog(@"Get news count : %ld", count);
                [NSThread sleepForTimeInterval:0.1];
                
//                [self.stub countNewsWithHandler:^(NSInteger count){
//                    NSLog(@"Get news count: %ld", count);
//                }];
                
                
//                NSArray *newsArray = [self.stub fetchNews];
//                NSLog(@"Get news count: %ld", newsArray.count);
                
                
//                [self.stub fetchNewsWithHandler:^(NSArray *results){
//                    NSLog(@"Get news count: %ld", results.count);
//                }];
                
                //            [NSThread sleepForTimeInterval:3];
            }
            NSLog(@">>>>> Finished count news!");
        });
        
        dispatch_queue_t queue_3 = dispatch_queue_create("queue_3", 0);
        dispatch_async(queue_3, ^{
            // 读新闻
            NSLog(@">>>>> Begin delete all news!");
            for (int i = 0; i < 100; i ++) {
                [self.stub deleteAllNews];
                NSLog(@"delete time: %d", i);
                [NSThread sleepForTimeInterval:0.1];
            }
            NSLog(@">>>>> Finished delete all news!");
        });
        
        NSLog(@"TEST END");
    });
}

@end

//
//  HttpClient.m
//  Haobo
//
//  Created by 张浩波 on 15/4/29.
//  Copyright (c) 2015年 zhb1991nm. All rights reserved.
//

#import "HttpClient.h"

@interface HttpClient()

@property (nonatomic,weak) HttpClient *weakSelf;

@end

@implementation HttpClient
@synthesize weakSelf,operationManagerArray;

+(id)sharedInstance {
    static HttpClient *sharedInstance;
    @synchronized(self) {
        if(!sharedInstance) {
            sharedInstance = [[HttpClient alloc] init];
        }
    }
    return sharedInstance;
}

-(instancetype)init{
    self = [super init];
    if (self) {
        operationManagerArray = [NSMutableArray array];
    }
    return self;
}

-(AFHTTPRequestOperationManager *)requestURLString:(NSString *)URLString parameters:(id)parameters method:(NSString *)method{
    AFHTTPRequestOperationManager *operationManager = [AFHTTPRequestOperationManager manager];
    if ([[method uppercaseString] isEqualToString:@"GET"]){
        [operationManager POST:URLString parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSLog(@"JSON: %@", responseObject);
            [weakSelf.operationManagerArray removeObject:operationManager];
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"Error: %@", error);
            [weakSelf.operationManagerArray removeObject:operationManager];
        }];
        [operationManagerArray addObject:operationManager];
    }else if ([[method uppercaseString] isEqualToString:@"POST"]){
        [operationManager POST:@"http://example.com/resources.json" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSLog(@"JSON: %@", responseObject);
            [weakSelf.operationManagerArray removeObject:operationManager];
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"Error: %@", error);
            [weakSelf.operationManagerArray removeObject:operationManager];
        }];
        [operationManagerArray addObject:operationManager];
    }
    return operationManager;
}

-(void)cancelOperationManager:(AFHTTPRequestOperationManager *)operationManager{
    if (!operationManager) return;
    NSUInteger index =[operationManagerArray indexOfObject:operationManager];
    if (index != NSNotFound) {
        [operationManager.operationQueue cancelAllOperations];
    }
}

-(void)cancelAllOperationManager{
    for (AFHTTPRequestOperationManager *operationManager in operationManagerArray) {
        [operationManager.operationQueue cancelAllOperations];
    }
}

@end

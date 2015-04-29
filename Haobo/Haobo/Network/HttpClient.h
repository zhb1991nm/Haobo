//
//  HttpClient.h
//  Haobo
//
//  Created by 张浩波 on 15/4/29.
//  Copyright (c) 2015年 zhb1991nm. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFHTTPRequestOperationManager.h"

@interface HttpClient : NSObject

@property (nonatomic,strong) NSMutableArray *operationManagerArray;

+(id)sharedInstance;

-(AFHTTPRequestOperationManager *)requestURLString:(NSString *)URLString parameters:(id)parameters method:(NSString *)method;

-(void)cancelOperationManager:(AFHTTPRequestOperationManager *)operationManager;

-(void)cancelAllOperationManager;


@end

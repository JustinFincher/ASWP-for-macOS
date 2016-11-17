//
//  JZASDataManager.m
//  ASWP
//
//  Created by Justin Fincher on 2016/11/18.
//  Copyright © 2016年 Justin Fincher. All rights reserved.
//

#import "JZASDataManager.h"

@implementation JZASDataManager


#pragma mark Singleton Methods

+ (id)sharedManager {
    static JZASDataManager *sharedMyManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedMyManager = [[self alloc] init];
    });
    return sharedMyManager;
}

- (id)init {
    if (self = [super init])
    {
        
    }
    return self;
}

- (void)dealloc {
    // Should never be called, but just here for clarity really.
}

- (void)getDataFromASWithResultSuccess:(void (^)(NSDictionary * data))finishBlock
                               failure:(void (^)(NSError * error))errorBlock
{
    AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
    session.responseSerializer = [AFHTTPResponseSerializer serializer];
    [session.responseSerializer.acceptableContentTypes setByAddingObject:@"application/rss+xml"];
    [session GET:@"https://www.artstation.com/artwork.rss" parameters:nil progress:nil success:^(NSURLSessionTask *task, id responseObject)
    {
        NSDictionary * dict = [[XMLDictionaryParser sharedInstance] dictionaryWithData:responseObject];
        if (dict)
        {
            finishBlock(dict);
        }else
        {
            errorBlock([NSError errorWithDomain:@"com.JustZht.ASWP" code:0 userInfo:nil]);
        }
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        errorBlock(error);
    }];
}
@end

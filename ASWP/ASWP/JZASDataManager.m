//
//  JZASDataManager.m
//  ASWP
//
//  Created by Justin Fincher on 2016/11/18.
//  Copyright © 2016年 Justin Fincher. All rights reserved.
//

#import "JZASDataManager.h"

@interface JZASDataManager()

@property (nonatomic,strong) NSDateFormatter *dateFormatter;
@property (nonatomic,strong) NSRegularExpression *artworkUrlRegex;

@end
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
        self.dateFormatter = [[NSDateFormatter alloc] init];
        [self.dateFormatter setDateFormat:@"EEE, dd MMM yyyy HH:mm:ss ZZ"];
        NSLocale *enUSPOSIXLocale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];
        [self.dateFormatter setLocale:enUSPOSIXLocale];
        NSError  *error = nil;
        NSString *pattern = @"<img alt=\"(.*?)\" src=\"(.*?)\" />";
        self.artworkUrlRegex = [NSRegularExpression regularExpressionWithPattern:pattern options:0 error:&error];
    }
    return self;
}

- (void)dealloc {
    // Should never be called, but just here for clarity really.
}

- (void)getDataFromASWithDirectCache:(BOOL)directCache
                       ResultSuccess:(void (^)(NSMutableArray * array))finishBlock
                             failure:(void (^)(NSError * error))errorBlock
{
    if (directCache)
    {
        NSData *artworksData = [[NSUserDefaults standardUserDefaults] objectForKey:@"ASAP_ArtworksData"];
        NSMutableArray *artworks = [[NSKeyedUnarchiver unarchiveObjectWithData:artworksData] mutableCopy];
        if (artworks && artworks.count > 0)
        {
            finishBlock(artworks);
        }else
        {
            errorBlock([NSError errorWithDomain:@"com.JustZht.ASWP" code:0 userInfo:nil]);
        }
    }else
    {
        AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
        session.responseSerializer = [AFHTTPResponseSerializer serializer];
        [session.requestSerializer setTimeoutInterval:15.0f];
        [session.responseSerializer.acceptableContentTypes setByAddingObject:@"application/rss+xml"];
        [session GET:@"https://www.artstation.com/artwork.rss" parameters:nil progress:nil success:^(NSURLSessionTask *task, id responseObject)
         {
             NSDictionary * dict = [[XMLDictionaryParser sharedInstance] dictionaryWithData:responseObject];
             if (dict)
             {
                 NSArray *items = [[dict objectForKey:@"channel"] objectForKey:@"item"];
                 NSMutableArray *artworks = [NSMutableArray array];
                 for (NSDictionary *singlePostDict in items)
                 {
                     NSString *title = [singlePostDict objectForKey:@"title"];
                     NSString *link = [singlePostDict objectForKey:@"link"];
                     NSString *description = [singlePostDict objectForKey:@"description"];
                     NSDate *pubDate = [self.dateFormatter dateFromString:[singlePostDict objectForKey:@"pubDate"]];
                     NSString *contentEncoded = [singlePostDict objectForKey:@"content:encoded"];
                     NSArray* matches = [self.artworkUrlRegex matchesInString:contentEncoded options:0 range: NSMakeRange(0, [contentEncoded length])];
                     for (NSTextCheckingResult* match in matches)
                     {
                         NSString *url = [contentEncoded substringWithRange:[match rangeAtIndex:2]];
                         JZASArtworkModel *newArtwork = [[JZASArtworkModel alloc] init];
                         newArtwork.artworkLink = [NSURL URLWithString:link];
                         newArtwork.artworkImageLink = [NSURL URLWithString:url];
                         newArtwork.artworkTitle = title;
                         newArtwork.artworkPubDate = pubDate;
                         newArtwork.artworkDescription = description;
                         [artworks addObject:newArtwork];
                     }
                 }
                 if (artworks.count > 0)
                 {
                     NSData *artworksData = [NSKeyedArchiver archivedDataWithRootObject:artworks];
                     [[NSUserDefaults standardUserDefaults] setObject:artworksData forKey:@"ASAP_ArtworksData"];
                     finishBlock(artworks);
                 }else
                 {
                     errorBlock([NSError errorWithDomain:@"com.JustZht.ASWP" code:0 userInfo:nil]);
                 }
                 
             }else
             {
                 errorBlock([NSError errorWithDomain:@"com.JustZht.ASWP" code:0 userInfo:nil]);
             }
         }
             failure:^(NSURLSessionTask *operation, NSError *error)
         {
             errorBlock(error);
         }];
    }
}

@end

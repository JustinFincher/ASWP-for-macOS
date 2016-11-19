//
//  JZASArtworkModel.m
//  ASWP
//
//  Created by Justin Fincher on 2016/11/18.
//  Copyright © 2016年 Justin Fincher. All rights reserved.
//

#import "JZASArtworkModel.h"

@implementation JZASArtworkModel


#pragma mark - NSCoding

- (id)initWithCoder:(NSCoder *)decoder {
    self = [super init];
    if (!self) {
        return nil;
    }
    
    self.artworkTitle = [decoder decodeObjectForKey:@"artworkTitle"];
    self.artworkDescription = [decoder decodeObjectForKey:@"artworkDescription"];
    self.artworkLink = [decoder decodeObjectForKey:@"artworkLink"];
    self.artworkImageLink = [decoder decodeObjectForKey:@"artworkImageLink"];
    self.artworkPubDate = [decoder decodeObjectForKey:@"artworkPubDate"];
    
    return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder {
    [encoder encodeObject:self.artworkTitle forKey:@"artworkTitle"];
    [encoder encodeObject:self.artworkDescription forKey:@"artworkDescription"];
    [encoder encodeObject:self.artworkLink forKey:@"artworkLink"];
    [encoder encodeObject:self.artworkImageLink forKey:@"artworkImageLink"];
    [encoder encodeObject:self.artworkPubDate forKey:@"artworkPubDate"];
}


@end

//
//  Video.h
//  SloMoVideo
//
//  Created by Chris on 10/2/15.
//  Copyright © 2015 Prince Fungus. All rights reserved.
//

#import <Foundation/Foundation.h>
@import AVFoundation;

@interface Video : NSObject

@property (nonatomic) NSURL *path;
@property (nonatomic) AVURLAsset *asset;
@property (nonatomic) UIImage *thumbnail;
@property (nonatomic) NSString *duration;
@property (nonatomic) NSString *stringPath;

@end

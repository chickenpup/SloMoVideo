//
//  VideoLibraryViewController.h
//  SloMoVideo
//
//  Created by Chris on 9/30/15.
//  Copyright © 2015 Prince Fungus. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Cell.h"
#import "Video.h"
#import "PlaybackViewController.h"
#import "UIImage+Resize.h"
#import "MediaLibrary.h"


@interface VideoLibraryViewController : UICollectionViewController

@property (nonatomic) NSMutableArray *videos;
@property (nonatomic) Video *videoToPlay;

@end

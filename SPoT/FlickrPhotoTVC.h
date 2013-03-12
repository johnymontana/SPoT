//
//  FlickrPhotoTVC.h
//  SPoT
//
//  Created by lyonwj on 3/3/13.
//  Copyright (c) 2013 William Lyon. All rights reserved.
//

#import <UIKit/UIKit.h>

#define ALL_PHOTOS_KEY @"FlickrPhotos_All"
#define PHOTO_TITLE_KEY @"PhotoTitle"
#define PHOTO_SUBTITLE_KEY @"PhotoSubtitle"
#define PHOTO_URL_KEY @"PhotoURL"

@interface FlickrPhotoTVC : UITableViewController

@property (strong, nonatomic) NSArray* photos; // of NSDictionary
@end

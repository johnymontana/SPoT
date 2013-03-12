//
//  RecentsTVC.h
//  SPoT
//
//  Created by lyonwj on 3/5/13.
//  Copyright (c) 2013 William Lyon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FlickrPhotoTVC.h"

#define ALL_PHOTOS_KEY @"FlickrPhotos_All"

@interface RecentsTVC : FlickrPhotoTVC

@property (strong, nonatomic) NSArray* photos;

@end

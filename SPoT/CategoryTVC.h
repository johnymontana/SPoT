//
//  CategoryTVC.h
//  SPoT
//
//  Created by lyonwj on 3/3/13.
//  Copyright (c) 2013 William Lyon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FlickrFetcher.h"


@interface CategoryTVC : UITableViewController


@property (strong, nonatomic) NSArray* photos;
@property (strong, nonatomic) NSArray* categories;
@property (strong, nonatomic) NSDictionary* catCount;
@end

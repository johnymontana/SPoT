//
//  ImageViewController.h
//  SPoT
//
//  Created by lyonwj on 3/3/13.
//  Copyright (c) 2013 William Lyon. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ImageViewController : UIViewController<UIScrollViewDelegate>

@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *spinner;

@property (nonatomic, strong) NSURL* imageURL;
@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong, nonatomic) NSString* photoID;
@property (strong, nonatomic) NSData* photoData;
@end

//
//  LatestFlickrPhotosTVC.m
//  SPoT
//
//  Created by lyonwj on 3/3/13.
//  Copyright (c) 2013 William Lyon. All rights reserved.
//

#import "LatestFlickrPhotosTVC.h"
#import "FlickrFetcher.h"

@interface LatestFlickrPhotosTVC ()

@end

@implementation LatestFlickrPhotosTVC



- (void)viewDidLoad
{
    [super viewDidLoad];
    //self.photos = [FlickrFetcher latestGeoreferencedPhotos];
    //self.photos = [FlickrFetcher stanfordPhotos];
	// Do any additional setup after loading the view.
    self.photos = [self getPhotosForCategoy:self.category];
}

-(NSArray*)getPhotosForCategoy:(NSString*)category
{
    NSMutableArray* photos = [[NSMutableArray alloc] init];
    
    NSArray* allPhotos = [FlickrFetcher stanfordPhotos];
    
    for (NSDictionary* photo in allPhotos)
    {
        //if ([string rangeOfString:@"bla"].location == NSNotFound) {
        
        if ([photo[FLICKR_TAGS] rangeOfString:category].location != NSNotFound)
        {
            [photos addObject:photo];
        }
    }
    
    NSSortDescriptor* titleDescriptor = [[NSSortDescriptor alloc] initWithKey:FLICKR_PHOTO_TITLE ascending:YES];
    
    NSArray* sortDescriptor = [NSArray arrayWithObject:titleDescriptor];
    
    return [photos sortedArrayUsingDescriptors:sortDescriptor];
    
    
    
    //return photos;
}

@end

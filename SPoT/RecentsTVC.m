//
//  RecentsTVC.m
//  SPoT
//
//  Created by lyonwj on 3/5/13.
//  Copyright (c) 2013 William Lyon. All rights reserved.
//

#import "RecentsTVC.h"

@interface RecentsTVC ()

@end

@implementation RecentsTVC



- (void)viewDidLoad
{
    [super viewDidLoad];
    self.photos = [self getRecents];
    [self.tableView reloadData];

}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    self.photos = [self getRecents];
    [self.tableView reloadData];
}
-(NSArray*)getRecents
{
    NSMutableArray* allRecentPhotos = [[NSMutableArray alloc] init];
    
    NSLog(@"Full NSUD: %@", [[NSUserDefaults standardUserDefaults] dictionaryForKey:ALL_PHOTOS_KEY]);
    
    for (NSDictionary* dict in [[[NSUserDefaults standardUserDefaults] dictionaryForKey:ALL_PHOTOS_KEY] allValues])
    {
        NSLog(@"Indiv: %@", dict);
        [allRecentPhotos addObject:dict];
    }
    NSLog(@"From NSUserDefaults: %@", allRecentPhotos);
    return allRecentPhotos;
}


@end

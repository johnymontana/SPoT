//
//  CategoryTVC.m
//  SPoT
//
//  Created by lyonwj on 3/3/13.
//  Copyright (c) 2013 William Lyon. All rights reserved.
//

#import "CategoryTVC.h"
#import "LatestFlickrPhotosTVC.h"

@interface CategoryTVC ()

@end

@implementation CategoryTVC


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self loadStanfordPhotosFromFlickr];
    
    [self.refreshControl addTarget:self action:@selector(loadStanfordPhotosFromFlickr) forControlEvents:UIControlEventValueChanged];
    
    
    }

-(void)loadStanfordPhotosFromFlickr
{
    [self.refreshControl beginRefreshing];
    dispatch_queue_t loaderQ = dispatch_queue_create("flickr stanford loader", NULL);
    dispatch_async(loaderQ, ^{
        NSArray* stanfordPhotos = [FlickrFetcher stanfordPhotos];
        dispatch_async(dispatch_get_main_queue(), ^{
            self.photos = stanfordPhotos;
            self.categories = [self getCategories];
            [self.refreshControl endRefreshing];
            [self.tableView reloadData];
            self.categories = [self.categories sortedArrayUsingSelector:@selector(caseInsensitiveCompare:)];
            NSLog(@"SELF.CATEGORIES: %@", self.categories);
        });
    });
    

}
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    ((LatestFlickrPhotosTVC*)segue.destinationViewController).category = self.categories[[self.tableView indexPathForCell:sender].row];
    
    [segue.destinationViewController setTitle:self.categories[[self.tableView indexPathForCell:sender].row]];
    
}
-(NSArray*)getCategories
{
    NSMutableSet* categorySet = [[NSMutableSet alloc] init];
    NSMutableArray* uniqueCategories = [[NSMutableArray alloc] init];
    NSMutableDictionary* countDict = [[NSMutableDictionary alloc] init];
    
    for (NSDictionary* dict in self.photos)
    {
        NSLog(@"%@", dict);
        NSString* cat = dict[FLICKR_TAGS];
        NSArray* indiv_cats = [cat componentsSeparatedByString:@" "];
        for (NSString* category in indiv_cats)
        {
            [categorySet addObject:category];
            countDict[category] = [NSNumber numberWithInt:([(NSNumber*)countDict[category] integerValue] + 1)];
        }
        
        NSLog(@"%@", categorySet);
    }
    
    for (NSString* cat in categorySet)
    {
        [uniqueCategories addObject:cat];
       
        
        
        
    }
    self.catCount = countDict;
    NSLog(@"%@", countDict);
    return uniqueCategories;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    // Return the number of rows in the section.
    return [self.categories count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Category";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    
    cell.textLabel.text = [self.categories objectAtIndex:indexPath.row];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@ Photos",[self.catCount[[self.categories objectAtIndex:indexPath.row]] description]];
    
    return cell;
}


@end

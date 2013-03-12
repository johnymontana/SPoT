//
//  FlickrPhotoTVC.m
//  SPoT
//
//  Created by lyonwj on 3/3/13.
//  Copyright (c) 2013 William Lyon. All rights reserved.
//

#import "FlickrPhotoTVC.h"
#import "FlickrFetcher.h"

@interface FlickrPhotoTVC ()

@end

@implementation FlickrPhotoTVC

-(void)setPhotos:(NSArray *)photos
{
    _photos = photos;
    [self.tableView reloadData];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([sender isKindOfClass:[UITableViewCell class]])
    {
        NSIndexPath* indexPath = [self.tableView indexPathForCell:sender];
        if (indexPath)
        {
            if ([segue.identifier isEqualToString:@"Show Image"])
            {
                [self synchronizeWithPhoto:self.photos[indexPath.row]];
                if ([segue.destinationViewController respondsToSelector:@selector(setImageURL:)])
                {
                    NSURL* url = [FlickrFetcher urlForPhoto:self.photos[indexPath.row] format:FlickrPhotoFormatLarge];
                    [segue.destinationViewController performSelector:@selector(setImageURL:) withObject:url];
                    [segue.destinationViewController performSelector:@selector(setPhotoID:) withObject:self.photos[indexPath.row][FLICKR_PHOTO_ID]];
                    [segue.destinationViewController setTitle:[self titleForRow:indexPath.row]];
                }
            }
        }
    }
}



-(void)synchronizeWithPhoto:(NSDictionary*)photo
{
    NSMutableDictionary* photoResultsFromUserDefaults = [[[NSUserDefaults standardUserDefaults] dictionaryForKey:ALL_PHOTOS_KEY] mutableCopy];
  
    if (!photoResultsFromUserDefaults)
    {
        photoResultsFromUserDefaults = [[NSMutableDictionary alloc] init];
    }
    
    photoResultsFromUserDefaults[photo[@"id"]]=photo;
    
    [[NSUserDefaults standardUserDefaults] setObject:photoResultsFromUserDefaults forKey:ALL_PHOTOS_KEY];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
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
    return [self.photos count];
}

-(NSString*)titleForRow:(NSUInteger)row
{
    return [self.photos[row][FLICKR_PHOTO_TITLE] description];
    
}

-(NSString*)subtitleForRow:(NSUInteger)row
{
    return [self.photos[row][FLICKR_PHOTO_DESCRIPTION][@"_content"] description];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"FlickrPhoto";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    
    cell.textLabel.text = [self titleForRow:indexPath.row];
    cell.detailTextLabel.text = [self subtitleForRow:indexPath.row];
    
    return cell;
}

@end

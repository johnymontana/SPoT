//
//  ImageViewController.m
//  SPoT
//
//  Created by lyonwj on 3/3/13.
//  Copyright (c) 2013 William Lyon. All rights reserved.
//

#import "ImageViewController.h"

@interface ImageViewController ()
@property (nonatomic, strong) UIImageView* imageView;
@end

@implementation ImageViewController

-(void)setImageURL:(NSURL *)imageURL
{
    _imageURL = imageURL;
    
    
    [self resetImage];
    
}

-(void)resetImage
{
    if (self.scrollView)
    {
        self.scrollView.contentSize = CGSizeZero;
        self.imageView.image = nil;
        
        [self.spinner startAnimating];
        
        NSFileManager* fm = [[NSFileManager alloc] init];
        //NSArray *urls = [fm URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask];
        //NSURL* cacheDir = urls[0];
        
        //NSError* err;
        
        NSString* cachesFolder = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
        
        
       // [fm createDirectoryAtURL:cacheDir withIntermediateDirectories:NO attributes:nil error:&err];
       // NSLog(@"dir create error: %@", err);
        
       // NSURL* photoURL = [[cacheDir URLByAppendingPathComponent:self.photoID] URLByAppendingPathExtension:@"jpg"];
        
        NSString* filePath = [cachesFolder stringByAppendingPathComponent:self.photoID];
        
        
        NSURL *imageURL = self.imageURL;
        
        //NSLog(@"photoURL: %@", photoURL);
        
        
        //NSLog(@"contentsOfDir: %@", [fm contentsOfDirectoryAtPath:[cacheDir absoluteString] error:&err]);
        
        //NSLog(@"error: %@", err);
        
        if ([fm isReadableFileAtPath:filePath])
        
        {
            NSLog(@"File exists");
            self.scrollView.zoomScale = 1.0;
            NSData* readFile = [NSData dataWithContentsOfFile:filePath];
            UIImage* image = [[UIImage alloc] initWithData:readFile];
            
            self.scrollView.contentSize = image.size;
            self.imageView.image = image;
            self.imageView.frame = CGRectMake(0, 0, image.size.width, image.size.height);
            [self.spinner stopAnimating];
        }
        
        else
        {
            // check if cached file exists
            // if YES, load from file
            // if NO, load from network, save file to cache
                // use id as file name 
            dispatch_queue_t imageFetchQ = dispatch_queue_create("image fetcher", NULL);
            dispatch_async(imageFetchQ, ^{
                [NSThread sleepForTimeInterval:4.0];
                [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
                NSData* imageData = [[NSData alloc] initWithContentsOfURL:self.imageURL];
                                [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
                UIImage *image = [[UIImage alloc] initWithData:imageData];
                self.photoData = imageData;
                [imageData writeToFile:filePath options:NSDataWritingAtomic error:nil];
                //NSLog(@"file write error: %@", err);
                
                if (self.imageURL == imageURL)
                {
                    
                    dispatch_async(dispatch_get_main_queue(), ^{
                        if (image)
                        {
                            self.scrollView.zoomScale = 1.0;
                            self.scrollView.contentSize = image.size;
                            self.imageView.image = image;
                            self.imageView.frame = CGRectMake(0, 0, image.size.width, image.size.height);
                            
                            //CGRect vizRect = [self.imageView convertRect:self.imageView.bounds toView:self.scrollView];
                            //[self.scrollView zoomToRect:vizRect animated:YES];                    }
                        }
                        [self.spinner stopAnimating];
                        if (self.imageView.image == image)
                        {
                            // TODO: this errors if no longer on screen ->
                            // CGRect vizRect = [self.imageView convertRect:self.imageView.bounds toView:self.scrollView];
                            //[self.scrollView zoomToRect:vizRect animated:YES];
                        }
                    });
                }
            });
            
            //[imageData writeToURL:photoURL atomically:YES];
            //if ([fm createFileAtPath:[photoURL absoluteString] contents:self.photoData attributes:nil])
            //{
            //    NSLog(@"File created");
            //}
            //else
            //{
             //   NSLog(@"file NOT created");
            //}
        }
        
        
    }
}


-(UIImageView*)imageView
{
    if (!_imageView) _imageView = [[UIImageView alloc] initWithFrame:CGRectZero];
    
    return _imageView;
}

-(UIView*)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return self.imageView;
}

-(void)viewDidLayoutSubviews
{
    //CGRect visibleRect = [self.scrollView convertRect:self.scrollView.bounds toView:self.imageView];
    
    CGRect vizRect = [self.imageView convertRect:self.imageView.bounds toView:self.scrollView];
    //self.scrollView.bounds = vizRect;
    [self.scrollView zoomToRect:vizRect animated:YES];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.scrollView addSubview:self.imageView];
    self.scrollView.minimumZoomScale = 0.2;
    self.scrollView.maximumZoomScale = 5.0;
    //self.scrollView.zoomScale = 0.2;
    self.scrollView.delegate = self;
    [self resetImage];
    
	// Do any additional setup after loading the view.
}


@end

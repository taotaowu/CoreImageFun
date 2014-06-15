//
//  WViewController.m
//  CoreImageFun
//
//  Created by 吴海涛 on 14-6-15.
//  Copyright (c) 2014年 吴海涛. All rights reserved.
//

#import "WViewController.h"

@interface WViewController ()

@end

@implementation WViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    //1
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"image" ofType:@"png"];
    NSURL *fileNameAndPath = [NSURL fileURLWithPath:filePath];
    //2
//    CIImage *beginImage = [[CIImage alloc] initWithContentsOfURL:fileNameAndPath];
    CIImage *beginImage = [CIImage imageWithContentsOfURL:fileNameAndPath];
    //3
    CIFilter *filter = [CIFilter filterWithName:@"CISepiaTone" keysAndValues:kCIInputImageKey,beginImage ,@"inputIntensity",@0.8,nil];
    CIImage *outImage = [filter outputImage];
    //4
    UIImage *newImage = [UIImage imageWithCIImage:outImage];
    self.imageView.image = newImage;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

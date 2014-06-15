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
{
    CIImage *beginImage;
    CIFilter *filter;
    CIContext *context;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    //1
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"image" ofType:@"png"];
    NSURL *fileNameAndPath = [NSURL fileURLWithPath:filePath];
    //2
//    CIImage *beginImage = [[CIImage alloc] initWithContentsOfURL:fileNameAndPath];
     beginImage = [CIImage imageWithContentsOfURL:fileNameAndPath];
    //3
     filter = [CIFilter filterWithName:@"CISepiaTone" keysAndValues:kCIInputImageKey,beginImage ,@"inputIntensity",@0.8,nil];
    CIImage *outImage = [filter outputImage];
    //5
    context = [CIContext contextWithOptions:nil];
    CGImageRef imageRef = [context createCGImage:outImage fromRect:[outImage extent]];
    UIImage *newImage = [UIImage imageWithCGImage:imageRef];
    
    //4
//    UIImage *newImage = [UIImage imageWithCIImage:outImage];
    self.imageView.image = newImage;
    CGImageRelease(imageRef);
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)amoutSliderValueChanged:(id)sender
{
    UISlider *slider = (UISlider*)sender;
    float value = slider.value;
    [filter setValue:@(value) forKey:@"inputIntensity"];
    CIImage *outImage = [filter outputImage];
    CGImageRef imageRef = [context createCGImage:outImage fromRect:[outImage extent]];
    UIImage *newImage = [UIImage imageWithCGImage:imageRef];
    self.imageView.image = newImage;
    CGImageRelease(imageRef);
}
@end















//
//  WViewController.m
//  CoreImageFun
//
//  Created by 吴海涛 on 14-6-15.
//  Copyright (c) 2014年 吴海涛. All rights reserved.
//

#import "WViewController.h"
#import  <AssetsLibrary/AssetsLibrary.h>

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
    
    [self printBuiltInFilter];
    
    
}

- (void) printBuiltInFilter
{
    NSArray *builtInFilties = [CIFilter filterNamesInCategory:kCICategoryBuiltIn];
    for(NSString *filterName in builtInFilties)
    {
        CIFilter *oneFilter = [CIFilter filterWithName:filterName];
        NSLog(@"filterName :%@",[oneFilter attributes]);
    }
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
//    CIImage *outImage = [filter outputImage];
    CIFilter *moreFilter = [self oldPhoto:[filter outputImage] withAmount:value];
    CIImage *outputImage = [moreFilter outputImage];
    CGImageRef imageRef = [context createCGImage:outputImage fromRect:[outputImage extent]];
    UIImage *newImage = [UIImage imageWithCGImage:imageRef];
//    CGImageRef imageRef = [context createCGImage:outImage fromRect:[outImage extent]];
//    UIImage *newImage = [UIImage imageWithCGImage:imageRef];
    self.imageView.image = newImage;
    CGImageRelease(imageRef);
}
- (CIFilter*)oldPhoto:(CIImage*) oldImage withAmount:(CGFloat)intensity
{
    CIFilter *filter1 = [CIFilter filterWithName:@"CIDarkenBlendMode"];
    [filter1 setValue:oldImage forKeyPath:kCIInputImageKey];
    CIFilter *filter2 = [CIFilter filterWithName:@"CIColorControls"];
    [filter2 setValue:@(1 - intensity) forKey:@"inputBrightness"];
    [filter2 setValue:@0.0 forKey:@"inputSaturation"];
    [filter2 setValue:[filter1 outputImage] forKey:kCIInputImageKey];
    return filter2;
}
#pragma mark actions
- (IBAction)loadPhoto:(id)sender
{
    UIImagePickerController *imagePickControl = [[UIImagePickerController alloc] init];
    imagePickControl.delegate = self;
    [self presentViewController:imagePickControl animated:YES completion:nil];
}

- (IBAction)savePhoto:(id)sender
{
    CIImage *savePhoto = [filter outputImage];
    CIContext *softWareContext = [CIContext contextWithOptions:@{kCIContextUseSoftwareRenderer:@(YES)}];
    CGImageRef saveImageRef = [softWareContext createCGImage:savePhoto fromRect:[savePhoto extent]];
    ALAssetsLibrary *assetLibrary = [[ALAssetsLibrary alloc] init];
    [assetLibrary writeImageToSavedPhotosAlbum:saveImageRef metadata:[savePhoto properties] completionBlock:^(NSURL *assetURL, NSError *error) {
        CGImageRelease(saveImageRef);
    }];
    
}

#pragma mark protocol
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [self dismissViewControllerAnimated:YES completion:nil];
    UIImage *pickerImage = [info objectForKeyedSubscript:UIImagePickerControllerOriginalImage];
    beginImage = [CIImage imageWithCGImage:pickerImage.CGImage];
    [filter setValue:beginImage forKeyPath:kCIInputImageKey];
    [self amoutSliderValueChanged:self.amountSlider];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:nil];
}


@end















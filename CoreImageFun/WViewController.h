//
//  WViewController.h
//  CoreImageFun
//
//  Created by 吴海涛 on 14-6-15.
//  Copyright (c) 2014年 吴海涛. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WViewController : UIViewController<UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UISlider *amountSlider;
- (IBAction)amoutSliderValueChanged:(id)sender;
- (IBAction)loadPhoto:(id)sender;

@end

//
//  ViewController.m
//  CoverImage
//
//  Created by Philip Lee on 15/9/6.
//  Copyright (c) 2015年 Philip Lee. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  
  
  CGRect rect = CGRectMake(50, 50, 300, 300);
  _coverView = [[PLCoverView alloc] initWithFrame: rect];
  
  UIImageView *bgCover = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 300, 300)];
  bgCover.image = [UIImage imageNamed:@"cover.png"];
  [_coverView addSubview: bgCover];
  
  
  UIButton *btnIcon = [[UIButton alloc] initWithFrame:CGRectMake(30, 30, 60, 60)];
  [btnIcon setImage:[UIImage imageNamed:@"btn.png"] forState:UIControlStateNormal];
  
  UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)];
  [btnIcon addGestureRecognizer:pan];
  
  _paintView = [[UIView alloc] initWithFrame:rect];
  [_paintView addSubview:btnIcon];
  _paintView.clipsToBounds = YES;
  btnIcon.center = _paintView.center;
  
  _coverView.passthroughViews = @[_paintView];
  
  UIImageView *bgView = [[UIImageView alloc] initWithFrame:rect];
  bgView.image = [UIImage imageNamed:@"yifu.png"];
  
  
  [self.view addSubview: bgView];
  [self.view addSubview: _paintView];
  [self.view addSubview: _coverView];
  
}

/**
 *  图片移动时会调用该方法
 *
 *  @param pan UIPanGestureRecognizer
 */
-(void) pan:(UIPanGestureRecognizer *)pan
{
  CGPoint translatedPoint = [pan translationInView: _paintView];
  pan.view.center = CGPointMake(pan.view.center.x + translatedPoint.x, pan.view.center.y + translatedPoint.y);
  [pan setTranslation:CGPointZero inView: _paintView];
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

/**
 *  可以在衣服上添加icon图片，之后就不能更改了。
 *
 *  @param maskImage The image which will be added to the T-shirt.
 *  @param point     The point where the maskImage will be added to.
 *  @param toImage   The T-shirt background image
 *
 *  @return The image which added mask image already.
 */
- (UIImage *)addImage:(UIImage *)maskImage inPoint:(CGPoint)point toImage:(UIImage *) toImage
{
  UIGraphicsBeginImageContext(toImage.size);
  [toImage drawInRect:CGRectMake(0, 0, toImage.size.width, toImage.size.height)];
  [maskImage drawInRect:CGRectMake(point.x, point.y,
                                   maskImage.size.width,
                                   maskImage.size.height)];
  
  UIImage *resultingImage = UIGraphicsGetImageFromCurrentImageContext();
  UIGraphicsEndImageContext();
  return resultingImage;
}

@end

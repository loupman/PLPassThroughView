//
//  CustomView.m
//  CoverImage
//
//  Created by Philip Lee on 15/9/6.
//  Copyright (c) 2015年 Philip Lee. All rights reserved.
//

#import "PLCoverView.h"

@interface PLCoverView()
-(BOOL) isPassthroughView: (UIView*) view;
@end

@implementation PLCoverView{
  BOOL testHits;
}

@synthesize passthroughViews=_passthroughViews;

-(UIView*) hitTest:(CGPoint)point withEvent:(UIEvent*)event{
  if(testHits){
    return nil;
  }
  
  if(!self.passthroughViews
     || (self.passthroughViews &&self.passthroughViews.count == 0)){
    return self;
  }else {
    
    UIView*hitView = [super hitTest:point withEvent:event];
    
    if(hitView == self) {
      //Test whether any of the passthrough views would handle this touch
      testHits =YES;
      CGPoint superPoint = [self.superview convertPoint:point fromView:self];
      UIView*superHitView = [self.superview hitTest:superPoint withEvent:event];
      testHits =NO;
      
      if([self isPassthroughView:superHitView]) {
        hitView = superHitView;
      }
    }
    
    return hitView;
  }
}

- (BOOL)isPassthroughView:(UIView*)view {
  
  if(view == nil) {
    return NO;
  }
  
  if([self.passthroughViews containsObject:view]) {
    return YES;
  }
  
  return[self isPassthroughView:view.superview];
}

-(void) dealloc
{
  self.passthroughViews =nil;
}

@end


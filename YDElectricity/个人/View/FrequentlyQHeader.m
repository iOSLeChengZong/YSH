//
//  FrequentlyQHeader.m
//  YDElectricity
//
//  Created by 元典 on 2019/2/16.
//  Copyright © 2019 yuandian. All rights reserved.
//

#import "FrequentlyQHeader.h"

@implementation FrequentlyQHeader

- (void)awakeFromNib {
    [super awakeFromNib];
    [self viewcornerRadius:5 borderWith:0.1 clearColor:YES];
    WK(weakSelf)
    [self.parentView bk_whenTapped:^{
        [weakSelf tapOpen];
    }];
    
    if (self.isOpen) {
        _indicatorImageView.backgroundColor = kRGBA(253, 207, 218, 1.0);
        _indicatorImageView.transform = CGAffineTransformRotate(_indicatorImageView.transform, M_PI / 2);
        
    }
}


- (void)tapOpen{
    if (_isOpen) {
        self.parentView.backgroundColor = [UIColor whiteColor];
        
        [UIView animateWithDuration:0.3 animations:^{
            _indicatorImageView.transform = CGAffineTransformRotate(_indicatorImageView.transform, -M_PI / 2);
        }];
    
        !_closeblock ?: _closeblock(self.indexPath);
    }else{
        
        self.parentView.backgroundColor = kRGBA(253, 207, 218, 1.0);
        
        [UIView animateWithDuration:0.3 animations:^{
            _indicatorImageView.transform = CGAffineTransformRotate(_indicatorImageView.transform, M_PI / 2);
        }];
        !_openblock ?: _openblock(self.indexPath);
    }
    self.isOpen = !self.isOpen;
}

@end

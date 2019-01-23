//
//  YDIntroHeaderCell.h
//  YDElectricity
//
//  Created by 元典 on 2018/11/29.
//  Copyright © 2018 yuandian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "iCarousel.h"

NS_ASSUME_NONNULL_BEGIN

@interface YDIntroHeaderCell : UICollectionViewCell<iCarouselDelegate,iCarouselDataSource>
@property (weak, nonatomic) IBOutlet iCarousel *adIC;
@property (weak, nonatomic) IBOutlet iCarousel *startIC;
@property (weak, nonatomic) IBOutlet UILabel *titleLB;
@property (weak, nonatomic) IBOutlet UIPageControl *pageC;

@property (nonatomic,assign) NSArray *colorArr;

-(void)pageCDotCount;

@end

NS_ASSUME_NONNULL_END

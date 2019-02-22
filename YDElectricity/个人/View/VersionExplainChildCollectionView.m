//
//  VersionExplainChildCollectionView.m
//  YDElectricity
//
//  Created by 元典 on 2019/2/22.
//  Copyright © 2019 yuandian. All rights reserved.
//

#import "VersionExplainChildCollectionView.h"
#import "VersionExplainChildCell.h"

#define kVersionExplainChildCell @"VersionExplainChildCell"

@interface VersionExplainChildCollectionView ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic,strong)NSArray *data;
@end

@implementation VersionExplainChildCollectionView


-(instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout data:(NSArray *)data{
    self = [super initWithFrame:frame collectionViewLayout:layout];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.delegate = self;
        self.dataSource = self;
        self.data = data;
       
        CGRect frame = CGRectMake(36 * kWidthScall, 88 * kWidthScall, 285 * kWidthScall, 17 * kWidthScall * self.data.count + 5 * (self.data.count -1) * kWidthScall);
        self.frame = frame;
        [self registerNib:[UINib nibWithNibName:kVersionExplainChildCell bundle:nil] forCellWithReuseIdentifier:kVersionExplainChildCell];
    }
    return self;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.data.count;
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    VersionExplainChildCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kVersionExplainChildCell forIndexPath:indexPath];
    return cell;
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

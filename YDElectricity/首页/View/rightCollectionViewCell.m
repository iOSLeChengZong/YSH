//
//  rightCollectionViewCell.m
//  YDElectricity
//
//  Created by 元典 on 2018/12/7.
//  Copyright © 2018 yuandian. All rights reserved.
//

#import "rightCollectionViewCell.h"
@interface rightCollectionViewCell()
@property(strong,nonatomic)UIImageView *roomImageView;
@property(strong,nonatomic)UILabel *roomLabel;
@end

static const CGFloat collectionCellHeight=80;
static const CGFloat labelHeight=20;

@implementation rightCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
}
//这边很关键 CollectionViewCell重用
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        if (self.roomImageView==nil) {
            self.roomImageView=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, ([UIScreen mainScreen].bounds.size.width-80-10*3)/3, collectionCellHeight-labelHeight)];
            self.roomImageView.contentMode=UIViewContentModeScaleAspectFill;
            self.roomImageView.clipsToBounds = YES;
            self.roomImageView.layer.masksToBounds = YES;
            self.roomImageView.layer.cornerRadius = 2.0;
            [self.contentView addSubview:self.roomImageView];
        }
        
        if (self.roomLabel==nil) {
            self.roomLabel=[[UILabel alloc]init];
            self.roomLabel.font=[UIFont systemFontOfSize:15];
            self.roomLabel.textAlignment=NSTextAlignmentCenter;
            [self.roomLabel sizeToFit];
            [self.contentView addSubview:self.roomLabel];
            [self.roomLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(self.roomImageView.mas_bottom).with.offset(2);
                make.centerX.mas_equalTo(self.roomImageView).with.offset(0);
                make.height.mas_equalTo(labelHeight);
            }];
        }
    }
    return self;
}

-(void)setCurNoHeadRightModel:(noHeadRightModel *)curNoHeadRightModel
{
    _curNoHeadRightModel=curNoHeadRightModel;
    self.roomImageView.image=[UIImage imageNamed:_curNoHeadRightModel.roomImageUrl];
    self.roomLabel.text=_curNoHeadRightModel.roomName;
}


+(CGSize)ccellSize
{
    return CGSizeMake(([UIScreen mainScreen].bounds.size.width-80-10*3)/3,collectionCellHeight);
}

@end

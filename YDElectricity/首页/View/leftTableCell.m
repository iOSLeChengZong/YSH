//
//  leftTableCell.m
//  YDElectricity
//
//  Created by 元典 on 2018/12/7.
//  Copyright © 2018 yuandian. All rights reserved.
//

#import "leftTableCell.h"

@interface leftTableCell()
@property(strong,nonatomic)UIView *leftColorView;
@property(strong,nonatomic)UILabel *nameLabel;
@end

//左边色彩条宽度
static const CGFloat leftColorViewWidth=3;
//文字字体大小
static const CGFloat textFontSize=15;

@implementation leftTableCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        //设置背影色
        self.backgroundColor=[UIColor grayColor];
        self.accessoryType = UITableViewCellAccessoryNone;
        
        if (self.leftColorView==nil) {
            self.leftColorView=[[UIView alloc]init];
            self.leftColorView.backgroundColor=[UIColor blueColor];
            self.leftColorView.hidden=YES;
            [self.contentView addSubview:self.leftColorView];
            [self.leftColorView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(self.contentView.mas_left).with.offset(0);
                make.top.mas_equalTo(self.contentView.mas_top).with.offset(0);
                make.bottom.mas_equalTo(self.contentView.mas_bottom).with.offset(0);
                make.width.mas_equalTo(leftColorViewWidth);
            }];
        }
        
        if (self.nameLabel==nil) {
            self.nameLabel=[[UILabel alloc]init];
            self.nameLabel.font=[UIFont systemFontOfSize:textFontSize];
            self.nameLabel.textAlignment=NSTextAlignmentCenter;
            [self.nameLabel sizeToFit];
            [self.contentView addSubview:self.nameLabel];
            [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.center.mas_equalTo(self.contentView);
                make.height.mas_equalTo(@20);
            }];
        }
    }
    return self;
}


- (void)awakeFromNib {
    // Initialization code
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

/**
 *  @author wujunyang, 15-10-10 14:10:52
 *
 *  @brief  设置选中跟没有选中的变化
 *
 *  @param hasBeenSelected 是否被选中
 *
 *  @since <#version number#>
 */
-(void)setHasBeenSelected:(BOOL)hasBeenSelected
{
    _hasBeenSelected=hasBeenSelected;
    if (_hasBeenSelected) {
        self.backgroundColor=[UIColor whiteColor];
        self.nameLabel.textColor=[UIColor greenColor];
        self.leftColorView.hidden=NO;
    }
    else
    {
        self.backgroundColor=[UIColor grayColor];
        self.nameLabel.textColor=[UIColor blackColor];
        self.leftColorView.hidden=YES;
    }
}

-(void)setCurLeftTagModel:(leftTagModel *)curLeftTagModel
{
    _curLeftTagModel=curLeftTagModel;
    self.nameLabel.text=_curLeftTagModel.tagName;
}

@end

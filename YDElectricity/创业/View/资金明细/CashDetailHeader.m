//
//  CashDetailHeader.m
//  YDElectricity
//
//  Created by 元典 on 2019/2/15.
//  Copyright © 2019 yuandian. All rights reserved.
//

#import "CashDetailHeader.h"
#import "YDCustomButton.h"
#import <BRPickerView.h>

@interface CashDetailHeader ()
@property (weak, nonatomic) IBOutlet UIView *parentView;
@property (nonatomic,strong) YDCustomButton *accountBtn;
@property (nonatomic,strong) YDCustomButton *dateBtn;
    


@end

@implementation CashDetailHeader

- (void)awakeFromNib {
    [super awakeFromNib];
    WK(weakSelf)
    CGRect frame = CGRectMake(40*kWidthScall, 0, (kScreenW * 0.5 - 130)*kWidthScall, self.parentView.size.height);
    _accountBtn = [[YDCustomButton alloc] initWithBtnFrame:frame btnType:ButtonImageRight titleAndImageSpace:14 imageSizeWidth:0 imageSizeHeight:0];
    [_accountBtn setImage:[UIImage imageNamed:@"y_b_down0"] forState:UIControlStateNormal];
    _accountBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [_accountBtn setTitleColor:KFontDefaultRGB forState:UIControlStateNormal];
    [_accountBtn setTitle:@"所有账户" forState:UIControlStateNormal];
    [_accountBtn bk_addEventHandler:^(id sender) {
        [BRStringPickerView showStringPickerWithTitle:@"账户" dataSource:@[@"支付宝", @"微信", @"中国很行",@"招商很行"] defaultSelValue:@"" isAutoSelect:NO themeColor:kFONTSlectRGB resultBlock:^(id selectValue) {
            [weakSelf.accountBtn setTitle:selectValue forState:UIControlStateNormal];
        }];
    } forControlEvents:UIControlEventTouchUpInside];
    [self.parentView addSubview:_accountBtn];
    
    frame = CGRectMake((CGRectGetMaxX(_accountBtn.frame) + 100) * kWidthScall, 0, _accountBtn.frame.size.width, _accountBtn.frame.size.height);
    _dateBtn = [[YDCustomButton alloc] initWithBtnFrame:frame btnType:ButtonImageRight titleAndImageSpace:14 imageSizeWidth:0 imageSizeHeight:0];
    [_dateBtn setImage:[UIImage imageNamed:@"y_b_down0"] forState:UIControlStateNormal];
    _dateBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [_dateBtn setTitleColor:KFontDefaultRGB forState:UIControlStateNormal];
    [_dateBtn setTitle:@"选择日期" forState:UIControlStateNormal];

    [_dateBtn bk_addEventHandler:^(id sender) {
        NSDate *currentDate = [NSDate date];
        NSCalendar* calendar = [NSCalendar currentCalendar];
        NSDateComponents* components = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth| NSCalendarUnitDay fromDate:currentDate]; // Get necessary date components
        
        NSDate *minDate = [NSDate br_setYear:[components year] month:[components month]-1 day:[components day]];
        NSDate *maxDate = [NSDate br_setYear:[components year] month:[components month] day:[components day]];//
        NSLog(@"maxDate:%@",maxDate);
        [BRDatePickerView showDatePickerWithTitle:@"日期" dateType:BRDatePickerModeYMD defaultSelValue:@"" minDate:minDate maxDate:maxDate isAutoSelect:YES themeColor:kFONTSlectRGB resultBlock:^(NSString *selectValue) {
            NSArray *arr = [selectValue componentsSeparatedByString:@"-"];
            NSString *str = [[arr[1] stringByAppendingString:@"/"] stringByAppendingString:arr[2]];
            [weakSelf.dateBtn setTitle:str forState:UIControlStateNormal];
            
        } cancelBlock:^{
            
        }];
    } forControlEvents:UIControlEventTouchUpInside];
    [self.parentView addSubview:_dateBtn];
    
    
    
}

@end

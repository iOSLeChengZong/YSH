//
//  YDAlertView.h
//  YDElectricity
//
//  Created by 元典 on 2018/12/3.
//  Copyright © 2018 yuandian. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef void (^OnCancleButtonClick)(void);
typedef void (^OnSureButtonClick)(void);

@interface YDAlertView : UIView
@property (nonatomic, copy) OnCancleButtonClick cancleBlock;
@property (nonatomic, copy) OnSureButtonClick sureBlock;

-(instancetype)initWithFrame:(CGRect)frame withTitle:(NSString *)title alertMessage:(NSString *)msg confrimBolck:(void (^)())confrimBlock cancelBlock:(void (^)())cancelBlock;
//弹出
-(void)show;

//隐藏
-(void)hide;
@end

NS_ASSUME_NONNULL_END

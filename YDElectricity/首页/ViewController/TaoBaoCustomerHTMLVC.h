//
//  TaoBaoCustomerHTMLVC.h
//  YDElectricity
//
//  Created by 元典 on 2019/1/23.
//  Copyright © 2019 yuandian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TaoBaoKeDetailViewModel.h"


NS_ASSUME_NONNULL_BEGIN
@protocol TaoBaoCustomerHTMLVCDelegate <NSObject>

-(void)GetModel:(TaoBaoKeDetailViewModel *)model;

@end

@interface TaoBaoCustomerHTMLVC : UIViewController


@property(nonatomic,strong)TaoBaoKeDetailViewModel *taoBaoVM;
@property(nonatomic,weak)id<TaoBaoCustomerHTMLVCDelegate> delegate;

@end

NS_ASSUME_NONNULL_END

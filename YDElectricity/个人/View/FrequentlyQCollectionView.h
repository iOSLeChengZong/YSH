//
//  QAGFoldableCollectionView.h
//  QAGFoldableCollectionView
//
//  Created by Changexie on 2016/11/9.
//  Copyright © 2016年 Changexie. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FrequentlyQGroupModel;

@interface FrequentlyQCollectionView : UIView

+ (instancetype)collectionView;

@property (nonatomic, strong) NSMutableArray<FrequentlyQGroupModel *> *groupModels;

@end

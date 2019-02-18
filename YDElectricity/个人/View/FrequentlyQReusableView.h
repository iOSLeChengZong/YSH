//

//

#import <UIKit/UIKit.h>

@class FrequentlyQReusableView, FrequentlyQGroupModel;

@protocol FrequentlyQReusableViewDelegate <NSObject>

- (void)headerViewClicked:(FrequentlyQReusableView *)headerView;

@end

@interface FrequentlyQReusableView : UICollectionReusableView

@property (nonatomic, strong) FrequentlyQGroupModel *groupModel;

@property (nonatomic, weak) id<FrequentlyQReusableViewDelegate> delegate;

@end

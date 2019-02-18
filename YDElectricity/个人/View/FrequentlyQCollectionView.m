//

//

#import "FrequentlyQCollectionView.h"

#import "FrequentlyQCollectionViewCell.h"
#import "FrequentlyQReusableView.h"

#import "FrequentlyQGroupModel.h"
#import "FrequentlyQChildModel.h"

static NSString *const kCellViewID   = @"FrequentlyQCollectionViewCell";
static NSString *const kHeaderViewID = @"FrequentlyQReusableView";


@interface FrequentlyQCollectionView () <UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, FrequentlyQReusableViewDelegate>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@end

@implementation FrequentlyQCollectionView

- (NSMutableArray<FrequentlyQGroupModel *> *)groupModels {
    if (!_groupModels) {
        _groupModels = [NSMutableArray array];
    }
    return _groupModels;
}

+ (instancetype)collectionView {
    FrequentlyQCollectionView *collectionView = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
    collectionView.backgroundColor = kViewBGColor;
    return collectionView;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self setupCollectionView];
}

- (void)setupCollectionView {
    [_collectionView registerNib:[UINib nibWithNibName:kCellViewID bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:kCellViewID];
    [_collectionView registerNib:[UINib nibWithNibName:kHeaderViewID bundle:[NSBundle mainBundle]] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:kHeaderViewID];
    
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return self.groupModels.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    
    if (self.groupModels[section].isOpen) {
        return self.groupModels[section].childModels.count;
    } else {
        return 0;
    }
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {

    FrequentlyQCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kCellViewID forIndexPath:indexPath];
    cell.childModel = self.groupModels[indexPath.section].childModels[indexPath.item];
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    if (![kind isEqualToString:UICollectionElementKindSectionHeader]) {
        return nil;
    }
    FrequentlyQReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:kHeaderViewID forIndexPath:indexPath];
    headerView.groupModel = self.groupModels[indexPath.section];
    headerView.delegate   = self;
    return headerView;
}

#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
//    if (indexPath.section == 0 && self.groupModels[indexPath.section].childModels[indexPath.item].originalGroupNumber != 0) {
//        [self backToOriginalGroup:indexPath];
//        return;
//    }
//    if (self.groupModels[indexPath.section].childModels[indexPath.item].originalGroupNumber == 0) {
//        return;
//    }
//    [self moveToTopGroup:indexPath];
}

//- (void)backToOriginalGroup:(NSIndexPath *)indexPath {
//    QAGGroupModel *topGroupModel = self.groupModels[0];
//    QAGChildModel *tmpChildModel = self.groupModels[0].childModels[indexPath.item];
//    [topGroupModel.childModels removeObject:tmpChildModel];
//    QAGGroupModel *originalGroupModel = self.groupModels[tmpChildModel.originalGroupNumber];
//    [originalGroupModel.childModels addObject:tmpChildModel];
//    [_collectionView reloadData];
//}
//
//- (void)moveToTopGroup:(NSIndexPath *)indexPath {
//    QAGGroupModel *tmpGroupModel = self.groupModels[indexPath.section];
//    QAGChildModel *tmpChildModel = self.groupModels[indexPath.section].childModels[indexPath.item];
//    [tmpGroupModel.childModels removeObject:tmpChildModel];
//    QAGGroupModel *topGroupModel = self.groupModels[0];
//    [topGroupModel.childModels addObject:tmpChildModel];
//    [_collectionView reloadData];
//}

#pragma mark - UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGSize size = kItemSize;
    return size;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    UIEdgeInsets inset = UIEdgeInsetsMake(0, (kScreenW - 357 * kWidthScall) * 0.5,3, (kScreenW - 357 * kWidthScall) * 0.5);
    return inset;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 3;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {

    return CGSizeMake(kScreenW, 53 * kWidthScall);;
}

#pragma mark - QAGFoldableCollectionReusableViewDelegate

- (void)headerViewClicked:(FrequentlyQReusableView *)headerView {
    [_collectionView reloadData];
}

@end

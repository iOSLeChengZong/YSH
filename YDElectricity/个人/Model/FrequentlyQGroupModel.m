

#import "FrequentlyQGroupModel.h"


@implementation FrequentlyQGroupModel

- (NSMutableArray<FrequentlyQChildModel *> *)childModels {
    if (!_childModels) {
        _childModels = [NSMutableArray array];
    }
    return _childModels;
}

- (BOOL)isFoldable {
    return _foldable;
}

- (BOOL)isOpen {
    return _open;
}

@end

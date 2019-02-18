//

//

#import "FrequentlyQCollectionViewCell.h"

#import "FrequentlyQChildModel.h"

@interface FrequentlyQCollectionViewCell ()

@property (weak, nonatomic) IBOutlet UITextView *textField;
@property (weak, nonatomic) IBOutlet UIView *view0;

@end

@implementation FrequentlyQCollectionViewCell

- (void)setChildModel:(FrequentlyQChildModel *)childModel {
    _childModel = childModel;
    
    _textField.text = childModel.name;
    _view0.backgroundColor = [UIColor whiteColor];
    
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
}

@end

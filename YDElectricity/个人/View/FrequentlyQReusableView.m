

#import "FrequentlyQReusableView.h"

#import "FrequentlyQGroupModel.h"

@interface FrequentlyQReusableView ()

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *arrowImageView;
@property (weak, nonatomic) IBOutlet UIView *cornerView;


@property (nonatomic, assign) CGAffineTransform originalTransform;

@end

@implementation FrequentlyQReusableView

- (void)awakeFromNib {
    [super awakeFromNib];
    [_cornerView viewcornerRadius:5 borderWith:0.01 clearColor:NO];
    _originalTransform = _arrowImageView.transform;
    _cornerView.backgroundColor = [UIColor whiteColor];
}

- (void)setGroupModel:(FrequentlyQGroupModel *)groupModel {
    _groupModel = groupModel;
    
    _nameLabel.text = groupModel.name;
    
    if (!groupModel.isFoldable) {
        _arrowImageView.hidden = YES;
    }
    
    _arrowImageView.transform = _originalTransform;
    if (groupModel.isOpen) {
        // 顺时针旋转90° (打开)
        _arrowImageView.transform = CGAffineTransformRotate(_arrowImageView.transform, M_PI_2);
        _cornerView.backgroundColor = kRGBA(257, 207, 218, 1);
    }else{
       _cornerView.backgroundColor = [UIColor whiteColor];
    }
}

- (IBAction)didHeaderViewTouchUpInside:(id)sender {
    if (!_groupModel.isFoldable) {
        return;
    }
    
    if (_groupModel.isOpen) {
        // 逆时针旋转90° (关闭)
        _arrowImageView.transform = CGAffineTransformRotate(_arrowImageView.transform, -M_PI_2);
        
   
    } else {
        // 顺时针旋转90° (打开)
        _arrowImageView.transform = CGAffineTransformRotate(_arrowImageView.transform, M_PI_2);
        
        
    }
    _groupModel.open = !_groupModel.isOpen;
    
    if (_delegate && [_delegate respondsToSelector:@selector(headerViewClicked:)]) {
        [_delegate headerViewClicked:self];
    }
}

@end

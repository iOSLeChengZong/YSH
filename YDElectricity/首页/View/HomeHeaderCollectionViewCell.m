//
//  HomeHeaderCollectionViewCell.m
//  YDElectricity
//
//  Created by 元典 on 2018/12/12.
//  Copyright © 2018 yuandian. All rights reserved.
//

#import "HomeHeaderCollectionViewCell.h"
#import "HomeViewModel.h"
#import "InHomeHeaderCell.h"

#define kMinimumLineSpacing  20

#define kMinimumInteritemSpacing 20
//每行显示的数量
#define kCellNumberPerLine  4
//cell的高度
#define kCellHigh 61


#define kInHomeHeaderCell @"InHomeHeaderCell"

@interface HomeHeaderCollectionViewCell()
@property(strong,nonatomic)NSArray *titleArray;
@property(strong,nonatomic)NSArray *imageNames;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *cycelScrollViewHeigitConstrait;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *collectionVHeightConstrait;

@end

@implementation HomeHeaderCollectionViewCell

-(void)setHomeVM:(HomeViewModel *)homeVM{
    _homeVM = homeVM;
    //设置轮播图
    self.imageURLs = [self.homeVM advertiseURLS];
    
//    for (int i = 0; i < self.imageURLs.count; ++i) {
//        NSLog(@"imageURL[%ld]:%@",i,self.imageURLs[i]);
//    }
    
//    if (self.imageURLs.count > 0) {
//        NSURL *url = [NSURL URLWithString: self.imageURLs[2]];// 获取的图片地址
//        UIImage *image = [UIImage imageWithData: [NSData dataWithContentsOfURL:url]]; // 根据地址取出图片
//        CGFloat w = image.size.width;
//        CGFloat h = image.size.height;
//        NSLog(@"wwww:%f,hhhh:%f",w,h);
//    }
    
    //设置秒杀商品
    //设置秒杀商品圆角
    [self.imageViewParentV viewcornerRadius:5 borderWith:0.01 clearColor:NO];
    
    [self.imageView sd_setImageWithURL:[self.homeVM secondSkillGoodURL] placeholderImage:[UIImage imageNamed:@"h1"]];
    
    [self.collectionV reloadData];
}

-(void)setImageURLs:(NSArray<NSString *> *)imageURLs{
    _imageURLs = imageURLs;
    [self setUpCycleScrollview];
}


- (void)awakeFromNib {
    [super awakeFromNib];
//    [self addChildViewToScrollV];
    self.imageNames = @[@"y_h_9.9元区icon",@"y_h_限时特卖",@"y_h_精选特品",@"y_h_加盟精品",@"y_h_金币商城"];
    self.collectionV.delegate = self;
    self.collectionV.dataSource = self;
    self.cycleScrollView.delegate = self;
    
    //为秒杀商品添加点击事件
    self.imageView.userInteractionEnabled = YES;
    UITapGestureRecognizer *recongnizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(SecondSkillImageTap:)];
    [self.imageView addGestureRecognizer:recongnizer];
    
    //对滚动视图和栏目视图屏幕适配
//    [self screenFit];
    
    
    

  
}

//// 如果要实现自定义cell的轮播图，必须先实现customCollectionViewCellClassForCycleScrollView:和setupCustomCell:forIndex:代理方法
//-(void)setupCustomCell:(UICollectionViewCell *)cell forIndex:(NSInteger)index cycleScrollView:(SDCycleScrollView *)view{
//
//}
//
//-(Class)customCollectionViewCellClassForCycleScrollView:(SDCycleScrollView *)view{
//    return nil;
//}

#pragma mark -- SDCycleScrollViewDelegate
/** 点击图片回调 */
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index{
   
    
}
/** 图片滚动回调 */
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didScrollToIndex:(NSInteger)index{
    
}


#pragma mark -- UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 1) {
        !_clickHandler ?: self.clickHandler([self.homeVM culomnGoodID:indexPath],[self.homeVM culomnCellTitleForItem:indexPath],HomeHeaderPushModelSeconSkill);
    }else{
        !_clickHandler ?: self.clickHandler([self.homeVM culomnGoodID:indexPath],[self.homeVM culomnCellTitleForItem:indexPath],HomeHeaderPushModelGoodList);
    }
    
    
}


#pragma mark -- UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.homeVM.culomnitemNum;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    InHomeHeaderCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kInHomeHeaderCell forIndexPath:indexPath];
    cell.culomnTitle.text = [self.homeVM culomnCellTitleForItem:indexPath];
    
    cell.culomnImage.image = [UIImage imageNamed:self.imageNames[indexPath.row]];
    
    return cell;
}

#pragma mark -- UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(kWidthScall*kCellHigh, kCellHigh * kWidthScall);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return ((self.bounds.size.width - (kWidthScall * kCellHigh * self.homeVM.culomnitemNum))/self.homeVM.culomnitemNum);
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 0;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
//    return UIEdgeInsetsMake(0, 0, 0, 0);
    CGFloat f = ((self.bounds.size.width - (kWidthScall * kCellHigh * self.homeVM.culomnitemNum))/self.homeVM.culomnitemNum) / 2;
    return UIEdgeInsetsMake(14*kWidthScall/*self.bounds.size.height/2*/, f/*((self.bounds.size.width - (kWidthScall * 42.0 * 5))/5)/2*/, 0/*self.bounds.size.height/2*/, f/*((self.bounds.size.width - (kWidthScall * 42.0 * 5))/5)/2*/);
}


#pragma mark -- 方法

//设置循环轮播图
-(void)setUpCycleScrollview{
    //设置代理

    //设置滚动方向
    self.cycleScrollView.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    ////     自定义分页控件小圆标颜色
    //    self.cycleScrollView.currentPageDotColor = [UIColor whiteColor];
    
    //自定义分布控件图片
//    self.cycleScrollView.currentPageDotImage = [UIImage imageNamed:@"pageControlCurrentDot"];
//    self.cycleScrollView.pageDotImage = [UIImage imageNamed:@"pageControlDot"];
    
    
   

    //设置要展示图片的网络地址
    self.cycleScrollView.imageURLStringsGroup = self.imageURLs;
    

}


//向轮播图中添加子视图
-(void)addChildViewToScrollV{
    
    CGFloat letEdge = ((kScreenW - (kWidthScall * 65.0 * 5))/5) / 2;
    NSLog(@"seeDDDD:%f",letEdge);
    
    for (int i = 0; i < self.titleArray.count; ++i) {
        // W / H = 75 / 85    @2x
        
        UIButton *button = [[UIButton alloc] init];
        [button setImage:[UIImage imageNamed:@"sns_icon_24.png"] forState:UIControlStateNormal];
//        [button setBackgroundImage:[UIImage imageNamed:@"test1"] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:@"sns_icon_23"] forState:UIControlStateHighlighted];
        [button setTitle:self.titleArray[i] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
        button.titleLabel.font = [UIFont systemFontOfSize:12];//[UIFont fontWithName:@"" size:15];//[UIFont systemFontOfSize:15];
        button.frame = CGRectMake(letEdge  + (kWidthScall * 65 + 2*letEdge) * i, 5, kWidthScall*65, 50);
        
        
        //设置按钮的尺寸为背景图尺寸 + 文字大小n尺寸
//        button.width = [title sizeWithFont:button.titleLabel.font maxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)].width;
//        button.height = button.currentImage.size.height+[title sizeWithFont:button.titleLabel.font maxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)].height;
        [button setContentVerticalAlignment:UIControlContentVerticalAlignmentBottom];
        //设置title在button上的位置(top left buttom right)
        button.titleEdgeInsets = UIEdgeInsetsMake(0, -kWidthScall*65, 0, 0);
        
        //监听按钮点击

    }
}

-(void)SecondSkillImageTap:(UITapGestureRecognizer *)skillTap
{
    !_clickHandler ?: self.clickHandler(@"秒杀栏目",@"秒杀",HomeHeaderPushModelTaoBaoKeDetail);
}

-(void)addChildView{
    [self setUpCycleScrollview];
    [self addChildViewToScrollV];
    
}

-(void)addClickHandler:(void (^)(NSString * _Nonnull, NSString * _Nonnull,HomeHeaderPushModel))hander{
    _clickHandler = hander;
}


-(void)screenFit{
    self.cycelScrollViewHeigitConstrait.constant *= kWidthScall;
    self.collectionVHeightConstrait.constant *= kWidthScall;
}

@end

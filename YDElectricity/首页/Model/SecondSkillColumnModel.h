#import <UIKit/UIKit.h>

@class SecondSkillColumnPageList;
@interface SecondSkillColumnModel : NSObject<YYModel>

@property (nonatomic, strong) NSArray<SecondSkillColumnPageList *> * pageList;
@property (nonatomic, assign) NSInteger pageNo;
@property (nonatomic, assign) NSInteger pageSize;
@property (nonatomic, assign) NSInteger totalCount;
@property (nonatomic, assign) NSInteger totalPages;

@end


@interface SecondSkillColumnPageList : NSObject<YYModel>

@property (nonatomic, strong) NSString * addTime;
@property (nonatomic, strong) NSString * categoryName;
/** 商品链接 */
@property (nonatomic, strong) NSString * clickUrl;
@property (nonatomic, strong) NSString * endTime;
@property (nonatomic, assign) NSInteger isTop;
@property (nonatomic, assign) NSInteger numIid;
/** 封面图片地址 */
@property (nonatomic, strong) NSObject * pageImgUrl;
/** 商品主图 */
@property (nonatomic, strong) NSString * picUrl;
/** reservePrice */
@property (nonatomic, assign) CGFloat reservePrice;
/** 已抢购数量 */
@property (nonatomic, assign) NSInteger soldNum;
@property (nonatomic, strong) NSString * startTime;
@property (nonatomic, assign) NSInteger state;
@property (nonatomic, strong) NSString * title;
@property (nonatomic, assign) NSInteger totalAmount;
@property (nonatomic, strong) NSObject * updateTime;
/** 淘抢购活动价 */
@property (nonatomic, assign) CGFloat zkFinalPrice;


@end

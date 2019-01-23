#import <UIKit/UIKit.h>

@class PageList;
@interface HomeGoodModel : NSObject<YYModel>

@property (nonatomic, strong) NSArray<PageList *> *pageList;
@property (nonatomic,assign) NSInteger totalPages;


@end



@interface PageList : NSObject<YYModel>

@property (nonatomic, strong) NSString * addTime;
@property (nonatomic, assign) NSInteger categoryClassId;

/** 奖励 */
@property (nonatomic, assign) CGFloat commission;
/** 优惠券结束时间 */
@property (nonatomic, strong) NSString * couponEndTime;
@property (nonatomic, assign) CGFloat commissionRate;
@property (nonatomic, strong) NSString * couponInfo;

/** 券 */
@property (nonatomic, assign) CGFloat couponPrice;
@property (nonatomic, assign) NSInteger couponReceiveCount;
@property (nonatomic, assign) NSInteger couponRemainCount;
/** 领券URL */
@property (nonatomic, strong) NSString * couponShareUrl;
/** 优惠券开始时间 */
@property (nonatomic, strong) NSString * couponStartTime;
@property (nonatomic, assign) NSInteger couponTotalCount;

@property (nonatomic, strong) NSObject * discountRate;
@property (nonatomic, strong) NSObject * endTime;
@property (nonatomic, strong) NSObject * goodsClickVolume;
@property (nonatomic, strong) NSObject * goodsDetails;
@property (nonatomic, strong) NSObject * goodsIntroduction;
@property (nonatomic, strong) NSObject * goodsLabel;
@property (nonatomic, assign) NSInteger goodsOwnClassId;
@property (nonatomic, strong) NSObject * goodsOwnClassId2;
@property (nonatomic, strong) NSString * goodsOwnClassName;
@property (nonatomic, strong) NSObject * goodsSource;
@property (nonatomic, assign) NSInteger goodsStatus;
@property (nonatomic, assign) BOOL includeCoupon;
@property (nonatomic, assign) BOOL includeDxjh;

/** 商品地址 */
@property (nonatomic, strong) NSString * itemUrl;
@property (nonatomic, assign) NSInteger numIid;

/** 主图 */
@property (nonatomic, strong) NSString * pictUrl;
@property (nonatomic, strong) NSObject * promotionType;
@property (nonatomic, strong) NSObject * publisher;
@property (nonatomic, strong) NSObject * publisherPhone;
@property (nonatomic, strong) NSObject * publisherQq;

/** 原价 */
@property (nonatomic, assign) CGFloat reservePrice;
@property (nonatomic, assign) NSInteger sellerId;
@property (nonatomic, assign) NSInteger sex;
@property (nonatomic, strong) NSString * shopTitle;
@property (nonatomic, strong) NSObject * shopkeeperWant;
@property (nonatomic, strong) NSString * shortTitle;
@property (nonatomic, strong) NSString * smallImages;
@property (nonatomic, strong) NSObject * startTime;
/** 商品title */
@property (nonatomic, strong) NSString * title;
@property (nonatomic, strong) NSString * tkTotalSales;
@property (nonatomic, strong) NSObject * updateTime;
@property (nonatomic, strong) NSString * url;
/** 销量 */
@property (nonatomic, assign) NSInteger volume;
@property (nonatomic, assign) NSInteger whetherRecommend;
@property (nonatomic, strong) NSObject * whetherShipping;
/** 折扣价 */
@property (nonatomic, assign) CGFloat zkFinalPrice;


@end

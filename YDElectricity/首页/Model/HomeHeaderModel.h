#import <UIKit/UIKit.h>
@class Row,AdvertisementList,CategoryClassList,GoodsSpikeList;
@interface HomeHeaderModel : NSObject<YYModel>

@property (nonatomic, strong) Row * rows;

@end


@interface Row : NSObject<YYModel>

@property (nonatomic, strong) NSArray<AdvertisementList *> *advertisementList;
@property (nonatomic, strong) NSArray<CategoryClassList *> *categoryClassList;
@property (nonatomic, strong) NSArray<GoodsSpikeList *> *goodsSpikeList;

@end


@interface AdvertisementList : NSObject<YYModel>

@property (nonatomic, strong) NSObject * addTime;
@property (nonatomic, strong) NSString * endTime;

//id -> ID
@property (nonatomic, strong) NSString *ID;
@property (nonatomic, strong) NSString * imgUrl;
@property (nonatomic, strong) NSString * jumpUrl;
@property (nonatomic, assign) NSInteger orderBy;
@property (nonatomic, strong) NSString * remark;
@property (nonatomic, strong) NSString * startTime;
@property (nonatomic, assign) NSInteger state;
@property (nonatomic, strong) NSString * title;
@property (nonatomic, strong) NSObject * updateTime;

@end


@interface CategoryClassList : NSObject<YYModel>
//add_time -> addTime
@property (nonatomic, strong) NSString * addTime;
//id -> ID
@property (nonatomic, strong) NSString *ID;
@property (nonatomic, strong) NSString * name;
//order_by -> orderBy
@property (nonatomic, assign) NSInteger orderBy;
//own_sector -> ownSector
@property (nonatomic, strong) NSString * ownSector;
@property (nonatomic, strong) NSString * remark;
@property (nonatomic, assign) NSInteger state;
@end


@interface GoodsSpikeList : NSObject<YYModel>

@property (nonatomic, strong) NSString * addTime;
@property (nonatomic, strong) NSString * categoryName;
@property (nonatomic, strong) NSString * clickUrl;
@property (nonatomic, strong) NSString * endTime;
@property (nonatomic, assign) NSInteger isTop;
@property (nonatomic, assign) NSInteger numIid;
@property (nonatomic, strong) NSString * pageImgUrl;
@property (nonatomic, strong) NSString * picUrl;
@property (nonatomic, assign) CGFloat reservePrice;
@property (nonatomic, assign) NSInteger soldNum;
@property (nonatomic, strong) NSString * startTime;
@property (nonatomic, assign) NSInteger state;
@property (nonatomic, strong) NSString * title;
@property (nonatomic, assign) NSInteger totalAmount;
@property (nonatomic, strong) NSString * updateTime;
@property (nonatomic, assign) CGFloat zkFinalPrice;

@end

//
//	RootClass.m
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport



#import "HomeHeaderModel.h"


@implementation HomeHeaderModel

+(NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass{
    return @{@"rows":[Row class]};
}


@end

@implementation Row
+(NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass{
    return @{@"advertisementList":[AdvertisementList class],
             @"categoryClassList":[CategoryClassList class],
             @"goodsSpikeList":[GoodsSpikeList class]
             };
}

@end

@implementation AdvertisementList

+(NSDictionary<NSString *,id> *)modelCustomPropertyMapper{
    return @{@"ID":@"id"};
}

@end


//NSString *const kCategoryClassListAddTime = @"add_time";
//NSString *const kCategoryClassListIdField = @"id";
//NSString *const kCategoryClassListName = @"name";
//NSString *const kCategoryClassListOrderBy = @"order_by";
//NSString *const kCategoryClassListOwnSector = @"own_sector";
//NSString *const kCategoryClassListRemark = @"remark";
//NSString *const kCategoryClassListState = @"state";
@implementation CategoryClassList


+(NSDictionary<NSString *,id> *)modelCustomPropertyMapper{
    return @{@"addTime":@"add_time",
             @"ID":@"id",
             @"orderBy":@"order_by",
             @"ownSector":@"own_sector"
             };
}



@end


@implementation GoodsSpikeList


@end

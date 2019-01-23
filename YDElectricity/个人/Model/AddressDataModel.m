//
//  AddressDataModel.m
//  YDElectricity
//
//  Created by 元典 on 2019/1/16.
//  Copyright © 2019 yuandian. All rights reserved.
//

#import "AddressDataModel.h"

@implementation AddressDataModel
- (void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:self.name forKey:@"name"];
    [aCoder encodeObject:self.telphone forKey:@"telphone"];
    [aCoder encodeObject:self.postCode forKey:@"postCode"];
    [aCoder encodeObject:self.areaStr forKey:@"areaStr"];
    [aCoder encodeObject:self.detailAddr forKey:@"detailAddr"];
    [aCoder encodeObject:self.defaultStr forKey:@"defaultStr"];
}

- (nullable instancetype)initWithCoder:(NSCoder *)aDecoder{
    self = [super init];
    if (self) {
        self.name = [aDecoder decodeObjectForKey:@"name"];
        self.telphone = [aDecoder decodeObjectForKey:@"telphone"];
        self.postCode = [aDecoder decodeObjectForKey:@"postCode"];
        self.areaStr = [aDecoder decodeObjectForKey:@"areaStr"];
        self.detailAddr = [aDecoder decodeObjectForKey:@"detailAddr"];
        self.defaultStr = [aDecoder decodeObjectForKey:@"defaultStr"];
    }
    return self;
}
@end

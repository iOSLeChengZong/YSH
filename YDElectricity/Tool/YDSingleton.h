//
//  YDSingleton.h
//  YDElectricity
//
//  Created by 元典 on 2018/12/30.
//  Copyright © 2018 yuandian. All rights reserved.
//

//条件编译
#if __has_feature(objc_arc)
//ARC


//.h头文件中的单例宏
#define YDSingletonH(name) + (instancetype)shared##name;

//.m文件中的单例宏
#define YDSingletonM(name) \
static id _instance;\
+ (instancetype)allocWithZone:(struct _NSZone *)zone{\
static dispatch_once_t onceToken;\
dispatch_once(&onceToken, ^{\
_instance = [super allocWithZone:zone];\
});\
return _instance;\
}\
+ (instancetype)shared##name{\
static dispatch_once_t onceToken;\
dispatch_once(&onceToken, ^{\
_instance = [[self alloc] init];\
});\
return _instance;\
}\
- (id)copyWithZone:(NSZone *)zone{\
return _instance;\
}



#else
//MRC


//.h头文件中的单例宏
#define YDSingleton(name) + (instancetype)shared##name;

//.m文件中的单例宏
#define YDSingletonM(name) \
static id _instance;\
+ (instancetype)allocWithZone:(struct _NSZone *)zone{\
static dispatch_once_t onceToken;\
dispatch_once(&onceToken, ^{\
_instance = [super allocWithZone:zone];\
});\
return _instance;\
}\
+ (instancetype)shared##name{\
static dispatch_once_t onceToken;\
dispatch_once(&onceToken, ^{\
_instance = [[self alloc] init];\
});\
return _instance;\
}\
- (id)copyWithZone:(NSZone *)zone{\
return _instance;\
}\
- (oneway void)release{\
}\
- (instancetype)retain{\
return self;\
}\
- (NSUInteger)retainCount{\
return 1;\
}\
- (instancetype)autorelease{\
return self;\
}



#endif


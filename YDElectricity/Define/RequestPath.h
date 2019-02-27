//
//  RequestPath.h
//  YDElectricity
//
//  Created by 元典 on 2018/11/26.
//  Copyright © 2018年 yuandian. All rights reserved.
//

//这个类是用来存储请求路径的
#ifndef RequestPath_h
#define RequestPath_h

//http://94.191.42.70:8090/index/selectGoodsList?goodsClassId=50&pageNo=1&pageSize=20

// http://192.168.101.31:8090 -> http://94.191.42.70
//http://192.168.101.31:8090/user/getRegisterCode?wxOpenId=fd56fd126d7eae0e41f74c895394155e

//基类URL
//#define kBaseURL1 @"http://192.168.101.122:8090"
#define kBaseURL1 @"https://www.yd-ishop.xyz"//  http://192.168.101.122:8090   http://94.191.42.70:8090 https://www.yd-ishop.xyz

#define kBaseURLTaoBao @"https://acs.m.taobao.com"

//第一次连调数据
#define kFirstTestURL @"/goods/selectGoodsList"


/** 首页 */
//首页头部数据
#define kHomeHederDataURL @"/index/getData"

//首页商品  参数: pageNo 请求的页数  pageSize 每页多少个   state=1 人气推荐   state=2 热销爆款
#define kHomeGoodListDataURL @"/index/selectGoodsList"//?pageNo=1&pageSize=20&state=1

//分类  //请求右边的列表使用参数 parentId
#define kCategoryModelURL @"/app/goods/selectGoodsClass"

//商品详情 参数 为 goodsClassId  对应模型字段为id
#define kCommodityDetailURL @"/index/selectGoodsList"


//验证用户注册
#define  kVerifyUserRegisterURL @"/user/verificationUserInfo"  //字段名 wxOpenId

//获取验证码
#define kVerifyCodeURL @"/user/getRegisterCode" //字段名为phone

//注册
#define kUserRegisterURL @"/user/register"

//登陆
#define kUserLoginURL @"/user/login"

//修改用户头像
#define kUpdateUserHeadURL @"/app/personal/updateUserHeadImg"

//修改用户信息
#define kUpdateUserInfoURL @"/app/personal/updateUserInfo"


//查询用户消息
#define kUserMessageURL @"/app/personal/selectMessageList"

//秒杀商品专栏
#define kSecondSkillGoodURL @"/index/selectGoodsSpikeList"

//记录用户进入app情况
#define kUserLogLog @"/app/personal/insertLoginLog"

//查询用户等级
#define kUserIdendity @"/app/personal/selectUserById"

//查询订单
#define kUserOrderURL @"/app/personal/selectOrderList"

//保存意见反馈
#define kIdearResponseURL @"/app/personal/insertUserComments"

//获取用户资金信息
#define kUserMoneyURL @"/app/business/getDataByUserId"


//团队成员
#define kUserTeamMemberURL @"/app/business/selectTeamMember"

//邀请记录
#define kUserInviteRecordURL @"/app/business/selectInviteDetailList"

#endif /* RequestPath_h */

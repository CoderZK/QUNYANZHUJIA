//
//  QYZJURLDefineTool.m
//  QYZJAPP
//
//  Created by zk on 2019/11/1.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import "QYZJURLDefineTool.h"



@implementation QYZJURLDefineTool


/** 登录 */
+ (NSString * )app_loginURL{
    return [NSString stringWithFormat:@"%@%@",URLOne,@"app_login_nocode.do"];
}
///** 退出登录 */
//+ (NSString * )getapp_loginURL;
/** 获取个人信息 */
+ (NSString * )user_centerInfoURL{
    return [NSString stringWithFormat:@"%@%@",URLOne,@"user_centerInfo.do"];
}
/** 我的提问列表*/
+ (NSString * )user_questionListURL{
    return [NSString stringWithFormat:@"%@%@",URLOne,@"user_questionList.do"];
}
/** 我的关注/粉丝 */
+ (NSString * )user_followListURL{
    return [NSString stringWithFormat:@"%@%@",URLOne,@"user_followList.do"];
}
/** 我的预约-装修需求 */
+ (NSString * )user_myApponitListURL{
    return [NSString stringWithFormat:@"%@%@",URLOne,@"user_myApponitList.do"];
}
/**我的邀请列表*/
+ (NSString * )user_invitationListURL{
    return [NSString stringWithFormat:@"%@%@",URLOne,@"user_invitationList.do"];
}
/**删除提问*/
+ (NSString * )user_delQuestionURL{
    return [NSString stringWithFormat:@"%@%@",URLOne,@"user_delQuestion.do"];
}
/** 用户的装修直播列表 */
+ (NSString * )user_ysListURL{
    return [NSString stringWithFormat:@"%@%@",URLOne,@"user_ysList.do"];
}
/** 我的钱包 */
+ (NSString * )user_myMoneyURL{
    return [NSString stringWithFormat:@"%@%@",URLOne,@"user_myMoney.do"];
}
/**提现 */
+ (NSString * )user_addCashURL{
    return [NSString stringWithFormat:@"%@%@",URLOne,@"user_addCash.do"];
}
/** 计算提现冻结金额 */
+ (NSString * )app_freezeMoneyURL{
    return [NSString stringWithFormat:@"%@%@",URLOne,@"app_freezeMoney.do"];
}
/** 历史提现冻结总金额 */
+ (NSString * )app_cashFreezeMoneyURL{
    return [NSString stringWithFormat:@"%@%@",URLOne,@"app_cashFreezeMoney.do"];
}
/** 银行列表 */
+ (NSString * )app_bankListURL{
    return [NSString stringWithFormat:@"%@%@",URLOne,@"app_bankList.do"];
}
/** 添加/编辑银行卡*/
+ (NSString * )user_bindBankURL{
    return [NSString stringWithFormat:@"%@%@",URLOne,@"user_bindBank.do"];
}
/** 金额明细记录 */
+ (NSString * )user_moneyListURL{
    return [NSString stringWithFormat:@"%@%@",URLOne,@"user_moneyList.do"];
}
/** 申请入驻检测 */
+ (NSString * )user_addApplicationCheckURL{
    return [NSString stringWithFormat:@"%@%@",URLOne,@"user_addApplicationCheck.do"];
}
/** 申请入驻时服务方身份证姓名检测 */
+ (NSString * )user_idCardCheckURL{
    return [NSString stringWithFormat:@"%@%@",URLOne,@"user_idCardCheck.do"];
}
/** 申请入驻*/
+ (NSString * )user_addApplicationURL{
    return [NSString stringWithFormat:@"%@%@",URLOne,@"user_addApplication.do"];
}
/** 取消服务方角色 */
+ (NSString * )user_cancelApplicationURL{
    return [NSString stringWithFormat:@"%@%@",URLOne,@"user_cancelApplication.do"];
}
/** 我的优惠券*/
+(NSString *)user_couponListURL{
    return [NSString stringWithFormat:@"%@%@",URLOne,@"user_couponList.do"];
}
/** 套餐列表 */
+(NSString *)app_vipPackageListURL{
    return [NSString stringWithFormat:@"%@%@",URLOne,@"app_vipPackageList.do"];
}
/** 充值套餐 */
+(NSString *)user_setVipURL{
    return [NSString stringWithFormat:@"%@%@",URLOne,@"user_setVip.do"];
}

/** 充值套餐支付*/
+ (NSString * )user_payVipURL{
    return [NSString stringWithFormat:@"%@%@",URLOne,@"user_payVip.do"];
}
/** 修改个人信息*/
+ (NSString * )user_editInfoURL{
    return [NSString stringWithFormat:@"%@%@",URLOne,@"user_editInfo.do"];
}
/** 检测用户的支付密码/设置支付密码(不需要检测验证码)*/
+ (NSString * )user_checkPayPassURL{
    return [NSString stringWithFormat:@"%@%@",URLOne,@"user_checkPayPass.do"];
}
/** 添加支付密码/忘记支付密码(需要检测验证码) */
+ (NSString * )user_setPayPassURL{
    return [NSString stringWithFormat:@"%@%@",URLOne,@"user_setPayPass.do"];
}
/** 换帮手机号*/
+ (NSString * )user_editPhoneURL{
    return [NSString stringWithFormat:@"%@%@",URLOne,@"user_editPhone.do"];
}
/** 修改密码 */
+ (NSString * )user_editPasswordURL{
    return [NSString stringWithFormat:@"%@%@",URLOne,@"user_editPassword.do"];
}
/** 我的预约裁判*/
+(NSString *)user_caipanListURL{
    return [NSString stringWithFormat:@"%@%@",URLOne,@"user_caipanList.do"];
}

/** 轮播图*/
+(NSString *)user_bannerListURL{
     return [NSString stringWithFormat:@"%@%@",URLOne,@"user_bannerList.do"];
}

#pragma mark ----- 消息部分 -------
/** 用户的通知消息*/
+(NSString *)user_newsURL{
    return [NSString stringWithFormat:@"%@%@",URLOne,@"user_news.do"];
}
/** 用户点赞消息-已读 */
+(NSString *)user_goodNewsReadURL{
    return [NSString stringWithFormat:@"%@%@",URLOne,@"user_goodNewsRead.do"];
}
/** 用户的最新点赞列表*/
+ (NSString * )user_goodNewsListURL{
    return [NSString stringWithFormat:@"%@%@",URLOne,@"user_goodNewsList.do"];
}
/** 用户的最新评论列表 */
+ (NSString * )user_commentNewsListURL{
    return [NSString stringWithFormat:@"%@%@",URLOne,@"user_commentNewsList.do"];
}
/** 用户评论消息-已读*/
+ (NSString * )user_commentNewsReadURL{
    return [NSString stringWithFormat:@"%@%@",URLOne,@"user_commentNewsRead.do"];
}
/** 用户的最新验收消息列表*/
+ (NSString * )user_turnoverStageNewListURL{
    return [NSString stringWithFormat:@"%@%@",URLOne,@"user_turnoverStageNewList.do"];
}
/**用户的最新报修消息列表*/
+ (NSString * )user_turnoverRepairNewListURL{
    return [NSString stringWithFormat:@"%@%@",URLOne,@"user_turnoverRepairNewList.do"];
}
/** 用户的最新系统消息列表*/
+ (NSString * )user_systemMessageNewListURL{
    return [NSString stringWithFormat:@"%@%@",URLOne,@"user_systemMessageNewList.do"];
}


#pragma mark ----- 我的小店 -------
/** 我的小店*/
+(NSString *)user_shopInfoURL{
    return [NSString stringWithFormat:@"%@%@",URLOne,@"user_shopInfo.do"];
}
/**  修改我的小店 */
+(NSString *)user_editShopURL{
    return [NSString stringWithFormat:@"%@%@",URLOne,@"user_editShop.do"];
}
/** 添加商品*/
+(NSString *)user_addGoodsURL{
    return [NSString stringWithFormat:@"%@%@",URLOne,@"user_addGoods.do"];
}
/** 修改商品*/
+(NSString *)user_editGoodsURL{
    return [NSString stringWithFormat:@"%@%@",URLOne,@"user_editGoods.do"];
}
/** 发布案例*/
+(NSString *)user_addCaseURL{
    return [NSString stringWithFormat:@"%@%@",URLOne,@"user_addCase.do"];
}
/** 修改案例*/
+(NSString *)user_updateCaseURL{
    return [NSString stringWithFormat:@"%@%@",URLOne,@"user_updateCase.do"];
}
/** 删除案例*/
+(NSString *)user_deleteCaseURL{
    return [NSString stringWithFormat:@"%@%@",URLOne,@"user_deleteCase.do"];
}

#pragma mark ----- 我的订单 -------

/** 我的订单列表*/
+(NSString *)user_orderListURL{
    return [NSString stringWithFormat:@"%@%@",URLOne,@"user_orderList.do"];
}
/** 确认收货*/
+(NSString *)user_sendGoodsURL{
    return [NSString stringWithFormat:@"%@%@",URLOne,@"user_sendGoods.do"];
}
/** 确认收货*/
+(NSString *)user_submitGoodsURL{
    return [NSString stringWithFormat:@"%@%@",URLOne,@"user_submitGoods.do"];
}
/** 提醒发货*/
+(NSString *)user_reminderURL{
    return [NSString stringWithFormat:@"%@%@",URLOne,@"user_reminder.do"];
}
/** 评价商品*/
+(NSString *)user_evaluateGoodsURL{
    return [NSString stringWithFormat:@"%@%@",URLOne,@"user_evaluateGoods.do"];
}
/**订单详情*/
+(NSString *)user_orderInfoURL{
    return [NSString stringWithFormat:@"%@%@",URLOne,@"user_orderInfo.do"];
}

#pragma mark ----- 交付 -------

/** 设置施工阶段的保修时间*/
+(NSString *)user_setStageRepairTimeURL{
    return [NSString stringWithFormat:@"%@%@",URLOne,@"user_setStageRepairTime.do"];
}

#pragma mark ----- 推荐答人-------
/** 答人主页*/
+(NSString *)app_getUserInfoURL{
    return [NSString stringWithFormat:@"%@%@",URLOne,@"app_getUserInfo.do"];
}
/** 答人列表*/
+(NSString *)app_searchURL{
    return [NSString stringWithFormat:@"%@%@",URLOne,@"app_search.do"];
}
/** 答人的案例列表*/
+(NSString *)user_caseListURL{
    return [NSString stringWithFormat:@"%@%@",URLOne,@"user_caseList.do"];
}
/** 答人的商品列表*/
+(NSString *)user_goodsListURL{
    return [NSString stringWithFormat:@"%@%@",URLOne,@"user_goodsList.do"];
}
/** 答人的回答语音列表*/
+(NSString *)user_mediaListURL{
    return [NSString stringWithFormat:@"%@%@",URLOne,@"user_mediaList.do"];
}
/** 答人关注/取消关注*/
+(NSString *)user_followURL{
    return [NSString stringWithFormat:@"%@%@",URLOne,@"user_follow.do"];
}
/** 答人的案例详情*/
+(NSString *)app_caseInfoURL{
    return [NSString stringWithFormat:@"%@%@",URLOne,@"app_caseInfo.do"];
}
/** 答人的小店主页*/
+(NSString *)app_shopInfoURL{
    return [NSString stringWithFormat:@"%@%@",URLOne,@"app_shopInfo.do"];
}
/**答人的商品详情*/
+(NSString *)app_goodsInfoURL{
    return [NSString stringWithFormat:@"%@%@",URLOne,@"app_goodsInfo.do"];
}
/**答人的回答详情*/
+(NSString *)app_questionInfoURL{
    return [NSString stringWithFormat:@"%@%@",URLOne,@"app_questionInfo.do"];
}
/**回复语音*/
+(NSString *)user_replyQuestionURL{
    return [NSString stringWithFormat:@"%@%@",URLOne,@"user_replyQuestion.do"];
}
/** 旁听语音*/
+(NSString *)user_sitAnswerURL{
    return [NSString stringWithFormat:@"%@%@",URLOne,@"user_sitAnswer.do"];
}
/** 旁听语音支付*/
+(NSString *)user_sitPayNewURL{
    return [NSString stringWithFormat:@"%@%@",URLOne,@"user_sitPayNew.do"];
}
/** 购买商品*/
+(NSString *)user_addGoodsOrderURL{
    return [NSString stringWithFormat:@"%@%@",URLOne,@"user_addGoodsOrder.do"];
}
/** 商品订单支付*/
+(NSString *)user_goodsPayNewURL{
    return [NSString stringWithFormat:@"%@%@",URLOne,@"user_goodsPayNew.do"];
}

#pragma mark ----- 需求单 -------
/** 推荐赚钱单子列表*/
+(NSString *)user_myDemandListURL{
    return [NSString stringWithFormat:@"%@%@",URLOne,@"user_myDemandList.do"];
}
/** 单子详情*/
+(NSString *)app_demandInfoURL{
    return [NSString stringWithFormat:@"%@%@",URLOne,@"app_demandInfo.do"];
}
/** 绑定虚拟手机号码*/
+(NSString *)app_bindVirtualPhoneURL{
    return [NSString stringWithFormat:@"%@%@",URLOne,@"app_bindVirtualPhone.do"];
}
/**推荐放单手机号码检验*/
+(NSString *)app_checkDemandURL{
    return [NSString stringWithFormat:@"%@%@",URLOne,@"app_checkDemand.do"];
}
/** 推荐赚钱放单*/
+(NSString *)user_addDemandURL{
    return [NSString stringWithFormat:@"%@%@",URLOne,@"user_addDemand.do"];
}
/** 单子列表 */
+(NSString *)user_demandListURL{
    return [NSString stringWithFormat:@"%@%@",URLOne,@"user_demandList.do"];
}
/**抢单*/
+(NSString *)user_grabDemandURL{
    return [NSString stringWithFormat:@"%@%@",URLOne,@"user_grabDemand.do"];
}
/** 抢单相关支付-正常支付*/
+(NSString *)user_payDemandURL{
    return [NSString stringWithFormat:@"%@%@",URLOne,@"user_payDemand.do"];
}
/**旁听单子客服语音*/
+(NSString *)user_sitDemandURL{
    return [NSString stringWithFormat:@"%@%@",URLOne,@"user_sitDemand.do"];
}
/** 单子操作*/
+(NSString *)user_operateDemandURL{
    return [NSString stringWithFormat:@"%@%@",URLOne,@"user_operateDemand.do"];
}
/** 填写资料*/
+(NSString *)user_addDetailURL{
    return [NSString stringWithFormat:@"%@%@",URLOne,@"user_addDetail.do"];
}
/** 根据签单额获取签单佣金*/
+(NSString *)app_getCommissonURL{
    return [NSString stringWithFormat:@"%@%@",URLOne,@"app_getCommisson.do"];
}
/** 提交申诉 */
+(NSString *)user_addAppealURL{
    return [NSString stringWithFormat:@"%@%@",URLOne,@"user_addAppeal.do"];
}
#pragma mark ----- 支付 -------
/**交付列表*/
+(NSString *)user_turnoverListURL{
    return [NSString stringWithFormat:@"%@%@",URLOne,@"user_turnoverList.do"];
}
/** 创建新单子的交付*/
+(NSString *)user_createNewTurnoverURL{
    return [NSString stringWithFormat:@"%@%@",URLOne,@"user_createNewTurnover.do"];
}



#pragma mark ---- 其它 --------- 
/** 获取城市列表*/
+(NSString *)app_addressURL{
    return [NSString stringWithFormat:@"%@%@",URLOne,@"app_address.do"];
}
/** 获取城市列表*/
+(NSString *)user_cityListURL{
    return [NSString stringWithFormat:@"%@%@",URLOne,@"user_cityList.do"];
}

/** 获取渠道列表*/
+(NSString *)app_labelListURL{
    return [NSString stringWithFormat:@"%@%@",URLOne,@"app_labelList.do"];
}
/** 获取需求类型列表*/
+(NSString *)app_demandTypeListURL{
    return [NSString stringWithFormat:@"%@%@",URLOne,@"app_demandTypeList.do"];
}

/** 删除城市列表*/
+(NSString *)user_delUserCityURL{
    return [NSString stringWithFormat:@"%@%@",URLOne,@"user_delUserCity.do"];
}
/** 用户添加城市*/
+(NSString *)user_localCityURL{
   return [NSString stringWithFormat:@"%@%@",URLOne,@"user_localCity.do"];
}

@end

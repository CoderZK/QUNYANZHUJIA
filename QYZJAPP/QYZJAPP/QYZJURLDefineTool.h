//
//  QYZJURLDefineTool.h
//  QYZJAPP
//
//  Created by zk on 2019/11/1.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN


////测试本地
#define URLOne @"http://mobile.qunyanzhujia.com:8098/qyzj/"
////图片地址
#define ImgURL @"http://47.100.198.68/upload"

////测试本地映射
//#define URL @"http://jgcbxt.natappfree.cc"
////图片映射
//#define ImgURL @"http://jgcbxt.natappfree.cc:80/upload"

@interface QYZJURLDefineTool : NSObject

/** 登录 */
+ (NSString * )app_loginURL;
///** 退出登录 */
//+ (NSString * )getapp_loginURL;
/** 获取个人信息 */
+ (NSString * )user_centerInfoURL;
/** 我的提问列表*/
+ (NSString * )user_questionListURL;
/** 我的关注/粉丝 */
+ (NSString * )user_followListURL;
/** 我的预约-装修需求 */
+ (NSString * )user_myApponitListURL;
/**我的邀请列表*/
+ (NSString * )user_invitationListURL;
/**删除提问*/
+ (NSString * )user_delQuestionURL;
/** 用户的装修直播列表 */
+ (NSString * )user_ysListURL;
/** 我的钱包 */
+ (NSString * )user_myMoneyURL;
/**提现 */
+ (NSString * )user_addCashURL;
/** 计算提现冻结金额 */
+ (NSString * )app_freezeMoneyURL;
/** 历史提现冻结总金额 */
+ (NSString * )app_cashFreezeMoneyURL;
/** 银行列表 */
+ (NSString * )app_bankListURL;
/** 添加/编辑银行卡*/
+ (NSString * )user_bindBankURL;
/** 金额明细记录 */
+ (NSString * )user_moneyListURL;
/** 申请入驻检测 */
+ (NSString * )user_addApplicationCheckURL;
/** 申请入驻时服务方身份证姓名检测 */
+ (NSString * )user_idCardCheckURL;
/** 申请入驻*/
+ (NSString * )user_addApplicationURL;
/** 取消服务方角色 */
+ (NSString * )user_cancelApplicationURL;
/** 我的优惠券*/
+(NSString *)user_couponListURL;
/** 套餐列表 */
+(NSString *)app_vipPackageListURL;
/** 充值套餐 */
+(NSString *)user_setVipURL;

/** 充值套餐支付*/
+ (NSString * )user_payVipURL;
/** 修改个人信息*/
+ (NSString * )user_editInfoURL;
/** 检测用户的支付密码/设置支付密码(不需要检测验证码)*/
+ (NSString * )user_checkPayPassURL;
/** 添加支付密码/忘记支付密码(需要检测验证码) */
+ (NSString * )user_setPayPassURL;
/** 换帮手机号*/
+ (NSString * )user_editPhoneURL;
/** 修改密码 */
+ (NSString * )user_editPasswordURL;
/** 我的预约裁判*/
+(NSString *)user_caipanListURL;


#pragma makr ----- 消息部分 -------
/** 用户的通知消息*/
+(NSString *)user_newsURL;
/** 用户点赞消息-已读 */
+(NSString *)user_goodNewsReadURL;
/** 用户的最新点赞列表*/
+ (NSString * )user_goodNewsListURL;
/** 用户的最新评论列表 */
+ (NSString * )user_commentNewsListURL;
/** 用户评论消息-已读*/
+ (NSString * )user_commentNewsReadURL;
/** 用户的最新验收消息列表*/
+ (NSString * )user_turnoverStageNewListURL;
/**用户的最新报修消息列表*/
+ (NSString * )user_turnoverRepairNewListURL;
/** 用户的最新系统消息列表*/
+ (NSString * )user_systemMessageNewListURL;


#pragma makr ----- 我的小店 -------
/** 我的小店*/
+(NSString *)user_shopInfoURL;
/**  修改我的小店 */
+(NSString *)user_editShopURL;
/** 添加商品*/
+(NSString *)user_addGoodsURL;
/** 修改商品*/
+(NSString *)user_editGoodsURL;
/** 发布案例*/
+(NSString *)user_addCaseURL;
/** 修改案例*/
+(NSString *)user_updateCaseURL;
/** 删除案例*/
+(NSString *)user_deleteCaseURL;

#pragma makr ----- 我的订单 -------

/** 我的订单列表*/
+(NSString *)user_orderListURL;
/** 确认收货*/
+(NSString *)user_sendGoodsURL;
/** 确认收货*/
+(NSString *)user_submitGoodsURL;
/** 提醒发货*/
+(NSString *)user_reminderURL;
/** 评价商品*/
+(NSString *)user_evaluateGoodsURL;
/**订单详情*/
+(NSString *)user_orderInfoURL;

#pragma makr ----- 交付 -------

/** 设置施工阶段的保修时间*/
+(NSString *)user_setStageRepairTimeURL;

#pragma makr ----- 推荐答人-------
/** 答人主页*/
+(NSString *)app_getUserInfoURL;
/** 答人列表*/
+(NSString *)app_searchURL;
/** 答人的案例列表*/
+(NSString *)user_caseListURL;
/** 答人的商品列表*/
+(NSString *)user_goodsListURL;
/** 答人的回答语音列表*/
+(NSString *)user_mediaListURL;
/** 答人关注/取消关注*/
+(NSString *)user_followURL;
/** 答人的案例详情*/
+(NSString *)app_caseInfoURL;
/** 答人的小店主页*/
+(NSString *)app_shopInfoURL;
/**答人的商品详情*/
+(NSString *)app_goodsInfoURL;
/**答人的回答详情*/
+(NSString *)app_questionInfoURL;
/**回复语音*/
+(NSString *)user_replyQuestionURL;
/** 旁听语音*/
+(NSString *)user_sitAnswerURL;
/** 旁听语音支付*/
+(NSString *)user_sitPayNewURL;
/** 购买商品*/
+(NSString *)user_addGoodsOrderURL;
/** 商品订单支付*/
+(NSString *)user_goodsPayNewURL;

#pragma makr ----- 需求单 -------
/** 推荐赚钱单子列表*/
+(NSString *)user_myDemandListURL;
/** 单子详情*/
+(NSString *)app_demandInfoURL;
/** 绑定虚拟手机号码*/
+(NSString *)app_bindVirtualPhoneURL;
/**推荐放单手机号码检验*/
+(NSString *)app_checkDemandURL;
/** 推荐赚钱放单*/
+(NSString *)user_addDemandURL;
/** 单子列表 */
+(NSString *)user_demandListURL;
/**抢单*/
+(NSString *)user_grabDemandURL;
/** 抢单相关支付-正常支付*/
+(NSString *)user_payDemandURL;
/**旁听单子客服语音*/
+(NSString *)user_sitDemandURL;
/** 单子操作*/
+(NSString *)user_operateDemandURL;
/** 填写资料*/
+(NSString *)user_addDetailURL;
/** 根据签单额获取签单佣金*/
+(NSString *)app_getCommissonURL;
/** 提交申诉 */
+(NSString *)user_addAppealURL;
#pragma makr ----- 支付 -------
/**交付列表*/
+(NSString *)user_turnoverListURL;
/** 创建新单子的交付*/
+(NSString *)user_createNewTurnoverURL;



/** 添加银行卡*/
+(NSString *)addMyBankCardURL;
/** 银行卡列表*/
+(NSString *)getMyBankCardListURL;
/** 删除银行卡*/
+(NSString *)deleteMyBankCardURL;
/** 取消点赞*/
+(NSString *)notlikeURL;



/** 删除回话*/
+(NSString *)deleteUserChatHoldURL;
/** 我的系统消息列表 */
+(NSString *)getMySysMsgListURL;
/** 获取客服*/
+(NSString *)contactKefURL;
/** 银行卡列表*/
+(NSString *)deletePostURL;
/** 帖子置顶套餐*/
+(NSString *)getPostTopPkgListURL;
/** 置顶提交*/
+(NSString *)postTopURL;

/** 绑定手机和第三方*/
+(NSString *)bindPhoneAndAppKeyURL;

/** 分享*/
+(NSString *)shareURL;
/** 更新*/
+(NSString *)getIosConfigURL;

+(NSString *)getImgURLWithStr:(NSString * )str;


@end

NS_ASSUME_NONNULL_END
//
//  QYZJURLDefineTool.h
//  QYZJAPP
//
//  Created by zk on 2019/11/1.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN


//正式
#define URLOne @"http://mobile.qunyanzhujia.com:8098/qyzj/"
//测试
//#define URLOne @"http://192.168.1.112:8086/qyzj/"


////图片地址
#define QiNiuImgURL @"http://web.qunyanzhujia.com/"
////视频地址地址
#define QiNiuVideoURL @"http://media.qunyanzhujia.com/"
//骑牛云的上传地址
#define QiNiuYunUploadURL @"http://upload.qiniup.com/"


////测试本地映射
//#define URL @"http://jgcbxt.natappfree.cc"
////图片映射
//#define ImgURL @"http://jgcbxt.natappfree.cc:80/upload"

@interface QYZJURLDefineTool : NSObject

/** 登录 */
+ (NSString * )app_loginURL;
/** 微信登录 */
+ (NSString * )app_appweixin_loginURL;
/** 绑定手机号 */
+ (NSString * )app_appBindPhoneURL;
/**  注册 */
+ (NSString * )app_regsiterURL;
/** 解除温馨绑定 */
+ (NSString * )user_bindOpenIdURL;
/**上传视频*/
+(NSString *)app_uploadAudioTokenURL;
///** 退出登录 */
+ (NSString * )user_app_logoutURL;
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
/**长传推送token*/
+(NSString *)app_bindPushTokenURL;

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
/** 轮播图*/
+(NSString *)user_bannerListURL;
/** 收藏列表*/
+(NSString *)app_collectListURL;
/** 头条取消和收藏*/
+(NSString *)app_headlinenewsCollectURL;
/** 头条取消和点赞*/
+(NSString *)app_headlinenewsGoodURL;
/** 广场取消和收藏*/
+(NSString *)app_articleCollectURL;
/** 广场取消和点赞*/
+(NSString *)app_articleGoodURL;
/**删除帖子*/
+(NSString *)app_articleCommentDelURL;
/**发送验证码*/
+(NSString *)app_sendmobileURL;
/**验证验证码*/
+(NSString *)app_checkSendCodeURL;
/**修改忘记密码*/
+(NSString *)app_findPasswordURL;
/**修改服务方资料*/
+(NSString *)user_editAppointAndQuestionURL;
/**报修详情*/
+(NSString *)user_repairBroadcastListURL;
/**添加播报*/
+(NSString *)user_createRepairBroadcastURL;
/**删除播报*/
+(NSString *)user_repairBoradcastDelURL;
/**回复播报*/
+(NSString *)user_repairBroadcastReplyURL;
/*用户地址*/
+(NSString *)user_addressListURL;
/*删除地址*/
+(NSString *)user_deleteAddressURL;
/*增加地址*/
+(NSString *)user_addAddressURL;
/*关注或者取消关注*/
+(NSString *)user_followURL;
/*回复帖子*/
+(NSString *)app_articleCommentURL;
/*头条评论更多*/
+(NSString *)app_headlinenewsDetailsCommentURL;
/*头条评论*/
+(NSString *)app_headlinenewsCommentURL;
/*旁听支付*/
+(NSString *)user_sitPayURL;

/*现有单子交付*/
+(NSString *)user_createTurnoverURL;

/*配置*/
+(NSString *)app_iosURL;


#pragma mark ----- 消息部分 -------
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
/** 头条详情*/
+ (NSString * )app_headlinenewsDetailsURL;
/** 帖子评论更多*/
+ (NSString * )app_articleDetailsCommentURL;


#pragma mark ----- 我的小店 -------
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

#pragma mark ----- 我的订单 -------

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

#pragma mark ----- 交付 -------

/** 设置施工阶段的报修时间*/
+(NSString *)user_setStageRepairTimeURL;

#pragma mark ----- 推荐答人-------
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

#pragma mark ----- 需求单 -------
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
#pragma mark ----- 支付 -------
/**交付列表*/
+(NSString *)user_turnoverListURL;
/** 创建新单子的交付*/
+(NSString *)user_createNewTurnoverURL;

/** 获取城市列表*/
+(NSString *)user_cityListURL;
/** 获取城市列表*/
+(NSString *)app_addressURL;
/** 用户添加城市*/
+(NSString *)user_localCityURL;
/** 删除城市列表*/
+(NSString *)user_delUserCityURL;
/** 获取渠道列表*/
+(NSString *)app_labelListURL;
/** 获取需求类型列表*/
+(NSString *)app_demandTypeListURL;

/** 获取发现广场列表*/
+(NSString *)app_articleListURL;
/** 获取发现广场详情*/
+(NSString *)app_articleDetailsURL;
/** 名家列表*/
+(NSString *)app_logiciansListURL;
/** 头条列表*/
+(NSString *)app_headlinenewsListURL;
/** 获取旁听列表*/
+(NSString *)app_questionSitListOpenURL;

/** 类型*/
+(NSString *)app_findLabelByTypeListURL;
/** 我的报修列表*/
+(NSString *)user_repairListURL;
/**邀请收入*/
+(NSString *)user_moneyListInvitationURL;
/**交付详情*/
+(NSString *)user_turnoverDetailsURL;
/**获取系统参数*/
+(NSString *)app_systemParamURL;
/**上传图片*/
+(NSString *)app_uploadImgTokenURL;

/**上传视频*/
+(NSString *)app_uploadVideoTokenURL;
/**发布动态*/
+(NSString *)app_insertArticleURL;
/**删除动态*/
+(NSString *)app_articleDelURL;
/**获取用户的角色*/
+(NSString *)user_basicInfoURL;
/**创建施工清单*/
+(NSString *)user_createStageURL;
/**创建变更清单*/
+(NSString *)user_createChangeStageURL;
/**变更阶段确认*/
+(NSString *)user_changeTurnoverCheckURL;
/**获取清单支付状态*/
+(NSString *)user_changeTurnoverChecksURL;
/**阶段验收通过*/
+(NSString *)user_turnoverStagePassURL;
/**阶段验收不通过*/
+(NSString *)user_turnoverStageNotPassURL;
/**创建实际施工阶段*/
+(NSString *)user_createConstructionURL;
/** 提交验收*/
+(NSString *)user_turnoverStageConfirmURL;
/**修改验收*/
+(NSString *)user_constructionEditURL;
/**删除实际阶段*/
+(NSString *)user_constructionDelURL;
/** 创建播报*/
+(NSString *)user_createBroadcastURL;
/**获取交付单击施工段信息*/
+(NSString *)user_turnoverStageNameURL;
/**支付尾款*/
+(NSString *)user_turnoverFinalPayURL;
/** 施工阶段播报内容回复*/
+(NSString *)user_broadcastReplyURL;

/**确认交付*/
+(NSString *)user_turnoverCheckURL;
/**交付清单详情*/
+(NSString *)user_turnoverListDetailsURL;
/**删除阶段播报*/
+(NSString *)user_boradcastDelURL;
/**创建保修*/
+(NSString *)user_createRepairURL;
/** 评价阶段内容回复*/
+(NSString *)user_turnoverStageEvalURL;
/** 确认保修*/
+(NSString *)user_sureRepairURL;
/** 交付播报列表*/
+(NSString *)user_broadcastListURL;


/**提交验收*/
+(NSString *)user_turnoverRepairConfirmURL;
/** 验收通过*/
+(NSString *)user_turnoverRepairPassURL;
/** 验收不通过*/
+(NSString *)user_turnoverRepairNotPassURL;
/** 保修单详情*/
+(NSString *)user_repairDetailsURL;
/** 可用优惠券列表 */
+(NSString *)user_payCouponListURL;


/**微信*/
+(NSString *)user_createWxOrderURL;
/** 支付宝*/
+(NSString *)user_createAlipayOrderURL;
/** 余额*/
+(NSString *)user_createBalanceOrderURL;
/** 优惠券*/
+(NSString *)user_createCouponOrderURL;
/** 余额加微信或者支付宝*/
+(NSString *)user_createPayNewURL;
/** 付款钱金额判断*/
+(NSString *)user_wechatPayURL;

/** 提问*/
+(NSString *)user_addQuestionURL;
/** 预约*/
+(NSString *)user_appointCaipanURL;
/** 预约表单*/
+(NSString *)user_appointDemandURL;
/**装修贷*/
+(NSString *)user_addZhuangxiuURL;
/**退保*/
+(NSString *)user_backBondURL;
/**获取城市是否开通*/
+(NSString *)app_getCityURL;
/**是否短息通知*/
+(NSString *)app_openCloseSmURL;

/** 更新*/
+(NSString *)getIosConfigURL;
+(NSString *)getImgURLWithStr:(NSString * )str;
+(NSString *)getVideoURLWithStr:(NSString * )str;



@end

NS_ASSUME_NONNULL_END

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
+ (NSString * )user_app_logoutURL{
    return [NSString stringWithFormat:@"%@%@",URLOne,@"user_app_logout.do"];
}
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

/** 收藏*/
+(NSString *)app_collectListURL{
   return [NSString stringWithFormat:@"%@%@",URLOne,@"app_collectList.do"];
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
/**获取用户的角色*/
+(NSString *)user_basicInfoURL{
   return [NSString stringWithFormat:@"%@%@",URLOne,@"user_basicInfo.do"];
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

/** 设置施工阶段的报修时间*/
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
/** 帖子评论更多*/
+ (NSString * )app_articleDetailsCommentURL {
     return [NSString stringWithFormat:@"%@%@",URLOne,@"app_articleDetailsComment.do"];
}

/*回复帖子*/
+(NSString *)app_articleCommentURL{
    return [NSString stringWithFormat:@"%@%@",URLOne,@"app_articleComment.do"];
}
/*头条评论更多*/
+(NSString *)app_headlinenewsDetailsCommentURL {
    return [NSString stringWithFormat:@"%@%@",URLOne,@"app_headlinenewsDetailsComment.do"];
}

/*头条评论*/
+(NSString *)app_headlinenewsCommentURL{
     return [NSString stringWithFormat:@"%@%@",URLOne,@"app_headlinenewsComment.do"];
}
/*旁听支付*/
+(NSString *)user_sitPayURL{
    return [NSString stringWithFormat:@"%@%@",URLOne,@"user_sitPay.do"];
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

/**修改服务方资料*/
+(NSString *)user_editAppointAndQuestionURL{
   return [NSString stringWithFormat:@"%@%@",URLOne,@"user_editAppointAndQuestion.do"];
}
/**报修详情*/
+(NSString *)user_repairBroadcastListURL{
     return [NSString stringWithFormat:@"%@%@",URLOne,@"user_repairBroadcastList.do"];
}
/**添加播报*/
+(NSString *)user_createRepairBroadcastURL{
     return [NSString stringWithFormat:@"%@%@",URLOne,@"user_createRepairBroadcast.do"];
}
/**删除播报*/
+(NSString *)user_repairBoradcastDelURL{
    return [NSString stringWithFormat:@"%@%@",URLOne,@"user_repairBoradcastDel.do"];
}
/**回复播报*/
+(NSString *)user_repairBroadcastReplyURL{
    return [NSString stringWithFormat:@"%@%@",URLOne,@"user_repairBroadcastReply.do"];
}
/*用户地址*/
+(NSString *)user_addressListURL{
   return [NSString stringWithFormat:@"%@%@",URLOne,@"user_addressList.do"];
}

/*删除地址*/
+(NSString *)user_deleteAddressURL{
    return [NSString stringWithFormat:@"%@%@",URLOne,@"user_deleteAddress.do"];
}
/*增加地址*/
+(NSString *)user_addAddressURL{
    return [NSString stringWithFormat:@"%@%@",URLOne,@"user_addAddress.do"];
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

/** 获取发现广场列表*/
+(NSString *)app_articleListURL{
   return [NSString stringWithFormat:@"%@%@",URLOne,@"app_articleList.do"];
}
/** 获取发现广场详情*/
+(NSString *)app_articleDetailsURL {
    return [NSString stringWithFormat:@"%@%@",URLOne,@"app_articleDetails.do"];
}
/** 名家列表*/
+(NSString *)app_logiciansListURL{
    return [NSString stringWithFormat:@"%@%@",URLOne,@"app_logiciansList.do"];
}
/** 头条列表*/
+(NSString *)app_headlinenewsListURL{
   return [NSString stringWithFormat:@"%@%@",URLOne,@"app_headlinenewsList.do"];
}
/** 获取旁听列表*/
+(NSString *)app_questionSitListOpenURL{
   return [NSString stringWithFormat:@"%@%@",URLOne,@"app_questionSitListOpen.do"];
}

/** 类型*/
+(NSString *)app_findLabelByTypeListURL {
   return [NSString stringWithFormat:@"%@%@",URLOne,@"app_findLabelByTypeList.do"];
}

/** 头条详情*/
+ (NSString * )app_headlinenewsDetailsURL{
     return [NSString stringWithFormat:@"%@%@",URLOne,@"app_headlinenewsDetails.do"];
}
/** 我的报修列表*/
+(NSString *)user_repairListURL{
    return [NSString stringWithFormat:@"%@%@",URLOne,@"user_repairList.do"];
}
/**邀请收入*/
+(NSString *)user_moneyListInvitationURL{
   return [NSString stringWithFormat:@"%@%@",URLOne,@"user_moneyListInvitation.do"];
}
/**交付详情*/
+(NSString *)user_turnoverDetailsURL{
    return [NSString stringWithFormat:@"%@%@",URLOne,@"user_turnoverDetails.do"];
}

/**获取系统参数*/
+(NSString *)app_systemParamURL {
    return [NSString stringWithFormat:@"%@%@",URLOne,@"app_systemParam.do"];
}

/**上传图片*/
+(NSString *)app_uploadImgTokenURL{
    return [NSString stringWithFormat:@"%@%@",URLOne,@"app_uploadImgToken.do"];
}

/**上传视频*/
+(NSString *)app_uploadVideoTokenURL{
   return [NSString stringWithFormat:@"%@%@",URLOne,@"app_uploadVideoToken.do"];
}
/**发布动态*/
+(NSString *)app_insertArticleURL{
    return [NSString stringWithFormat:@"%@%@",URLOne,@"app_insertArticle.do"];
}
/**删除动态*/
+(NSString *)app_articleDelURL{
    return [NSString stringWithFormat:@"%@%@",URLOne,@"app_articleDel.do"];
}

/** 取消和收藏*/
+(NSString *)app_headlinenewsCollectURL {
     return [NSString stringWithFormat:@"%@%@",URLOne,@"app_headlinenewsCollect.do"];
}
/** 头条取消和点赞*/
+(NSString *)app_headlinenewsGoodURL{
    return [NSString stringWithFormat:@"%@%@",URLOne,@"app_headlinenewsGood.do"];
}
/** 广场取消和收藏*/
+(NSString *)app_articleCollectURL{
    return [NSString stringWithFormat:@"%@%@",URLOne,@"app_articleCollect.do"];
}
/** 广场取消和点赞*/
+(NSString *)app_articleGoodURL{
   return [NSString stringWithFormat:@"%@%@",URLOne,@"app_articleGood.do"];
}
/**删除帖子*/
+(NSString *)app_articleCommentDelURL{
   return [NSString stringWithFormat:@"%@%@",URLOne,@"app_articleCommentDel.do"];
}
/**发送验证码*/
+(NSString *)app_sendmobileURL {
    return [NSString stringWithFormat:@"%@%@",URLOne,@"app_sendmobile.do"];
}
/**验证验证码*/
+(NSString *)app_checkSendCodeURL{
   return [NSString stringWithFormat:@"%@%@",URLOne,@"app_checkSendCode.do"];
}

/**修改忘记密码*/
+(NSString *)app_findPasswordURL {
    return [NSString stringWithFormat:@"%@%@",URLOne,@"app_findPassword.do"];
}

/**创建施工清单*/
+(NSString *)user_createStageURL{
    return [NSString stringWithFormat:@"%@%@",URLOne,@"user_createStage.do"];
}
/**创建变更清单*/
+(NSString *)user_createChangeStageURL{
     return [NSString stringWithFormat:@"%@%@",URLOne,@"user_createChangeStage.do"];
}
/**变更清单状态*/
+(NSString *)user_changeTurnoverCheckURL{
    return [NSString stringWithFormat:@"%@%@",URLOne,@"user_changeTurnoverCheck.do"];
}
/**获取清单支付状态*/
+(NSString *)user_changeTurnoverChecksURL{
   return [NSString stringWithFormat:@"%@%@",URLOne,@"user_changeTurnoverChecks.do"];
}


/**阶段验收通过*/
+(NSString *)user_turnoverStagePassURL{
    return [NSString stringWithFormat:@"%@%@",URLOne,@"user_turnoverStagePass.do"];
}
/**阶段验收不通过*/
+(NSString *)user_turnoverStageNotPassURL{
     return [NSString stringWithFormat:@"%@%@",URLOne,@"user_turnoverStageNotPass.do"];
}
/**创建实际施工阶段*/
+(NSString *)user_createConstructionURL{
     return [NSString stringWithFormat:@"%@%@",URLOne,@"user_createConstruction.do"];
}
/** 提交验收*/
+(NSString *)user_turnoverStageConfirmURL{
     return [NSString stringWithFormat:@"%@%@",URLOne,@"user_turnoverStageConfirm.do"];
}
/**修改验收*/
+(NSString *)user_constructionEditURL{
     return [NSString stringWithFormat:@"%@%@",URLOne,@"user_constructionEdit.do"];
}
/**删除实际阶段*/
+(NSString *)user_constructionDelURL{
    return [NSString stringWithFormat:@"%@%@",URLOne,@"user_constructionDel.do"];
}
/** 创建播报*/
+(NSString *)user_createBroadcastURL{
    return [NSString stringWithFormat:@"%@%@",URLOne,@"user_createBroadcast.do"];
}
/**获取交付单击施工段信息*/
+(NSString *)user_turnoverStageNameURL{
     return [NSString stringWithFormat:@"%@%@",URLOne,@"user_turnoverStageName.do"];
}
/**支付尾款*/
+(NSString *)user_turnoverFinalPayURL{
    return [NSString stringWithFormat:@"%@%@",URLOne,@"user_turnoverFinalPay.do"];
}
/** 施工阶段播报内容回复*/
+(NSString *)user_broadcastReplyURL{
     return [NSString stringWithFormat:@"%@%@",URLOne,@"user_broadcastReply.do"];
}
/**确认交付*/
+(NSString *)user_turnoverCheckURL{
     return [NSString stringWithFormat:@"%@%@",URLOne,@"user_turnoverCheck.do"];
}
/**交付清单详情*/
+(NSString *)user_turnoverListDetailsURL{
     return [NSString stringWithFormat:@"%@%@",URLOne,@"user_turnoverListDetails.do"];
}
/**删除阶段播报*/
+(NSString *)user_boradcastDelURL{
     return [NSString stringWithFormat:@"%@%@",URLOne,@"user_broadcastDel.do"];
}
/**创建保修*/
+(NSString *)user_createRepairURL{
     return [NSString stringWithFormat:@"%@%@",URLOne,@"user_createRepair.do"];
}
/** 每个阶段内容回复*/
+(NSString *)user_turnoverStageEvalURL{
     return [NSString stringWithFormat:@"%@%@",URLOne,@"user_turnoverStageEval.do"];
}
/** 确认保修*/
+(NSString *)user_sureRepairURL{
     return [NSString stringWithFormat:@"%@%@",URLOne,@"user_sureRepair.do"];
}
/** 交付播报列表*/
+(NSString *)user_broadcastListURL{
     return [NSString stringWithFormat:@"%@%@",URLOne,@"user_broadcastList.do"];
}

/**微信*/
+(NSString *)user_createWxOrderURL{
    return [NSString stringWithFormat:@"%@%@",URLOne,@"user_createWxOrder.do"];
}
/** 支付宝*/
+(NSString *)user_createAlipayOrderURL{
    return [NSString stringWithFormat:@"%@%@",URLOne,@"user_createAlipayOrder.do"];
}
/** 余额*/
+(NSString *)user_createBalanceOrderURL{
    return [NSString stringWithFormat:@"%@%@",URLOne,@"user_createBalanceOrder.do"];
}
/** 优惠券*/
+(NSString *)user_createCouponOrderURL{
    return [NSString stringWithFormat:@"%@%@",URLOne,@"user_createCouponOrder.do"];
}
/** 余额加微信或者支付宝*/
+(NSString *)user_createPayNewURL{
    return [NSString stringWithFormat:@"%@%@",URLOne,@"user_createPayNew.do"];
}






//图片地址
+(NSString *)getImgURLWithStr:(NSString * )str{
    
    NSString * picStr = @"";
    if (str) {
        if ([str hasPrefix:@"http:"] || [str hasPrefix:@"https:"]) {
            picStr = str;
        }else{
            picStr = [NSString stringWithFormat:@"%@%@",QiNiuImgURL,str];
        }
    }
    return picStr;

}

+(NSString *)getVideoURLWithStr:(NSString * )str {
    
   NSString * picStr = @"";
    if (str) {
        if ([str hasPrefix:@"http:"] || [str hasPrefix:@"https:"]) {
            picStr = str;
        }else{
            picStr = [NSString stringWithFormat:@"%@%@",QiNiuVideoURL,str];
        }
    }
    return picStr;
    
}


@end

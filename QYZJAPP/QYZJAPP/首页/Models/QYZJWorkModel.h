//
//  QYZJWorkModel.h
//  QYZJAPP
//
//  Created by zk on 2019/11/20.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface QYZJWorkModel : NSObject
@property(nonatomic,strong)NSString *ID;
@property(nonatomic,strong)NSString *days;
@property(nonatomic,strong)NSString *serviceName;
@property(nonatomic,strong)NSString *percent;
@property(nonatomic,strong)NSString *serviceUserId;
@property(nonatomic,strong)NSString *stageName;
@property(nonatomic,strong)NSString *status;//状态（1为待确认、2为待支付、3为已支付、4为否认）
@property(nonatomic,strong)NSString *time;
@property(nonatomic,strong)NSString *timeEnd;
@property(nonatomic,strong)NSString *timeEndStr;
@property(nonatomic,strong)NSString *timeStart;
@property(nonatomic,strong)NSString *timeStartStr;
@property(nonatomic,strong)NSString *turnoverListId;
@property(nonatomic,strong)NSString *type;//阶段类型（1为正常阶段，2为变更阶段） 支付类型（1为首款支付、2为尾款支付、3为变更阶段支付）
@property(nonatomic,strong)NSString *changeType;//阶段类型（1为正常阶段，2为变更阶段）
@property(nonatomic,strong)NSString *demandGrabSheetId;
@property(nonatomic,strong)NSString *evaluate;
@property(nonatomic,strong)NSString *userId;
@property(nonatomic,strong)NSString *addTime;
@property(nonatomic,strong)NSString *moneyOverTime;
@property(nonatomic,strong)NSString *no;
@property(nonatomic,strong)NSString *openId;
@property(nonatomic,strong)NSString *payType;
@property(nonatomic,strong)NSString *wechatCharging;
@property(nonatomic,strong)NSString *invitationCode;
@property(nonatomic,strong)NSString *nickName;
@property(nonatomic,strong)NSString *password;
@property(nonatomic,strong)NSString *pay_pass;
@property(nonatomic,strong)NSString *questionNum;
@property(nonatomic,strong)NSString *role;
@property(nonatomic,strong)NSString *roleId;
@property(nonatomic,strong)NSString *shop_id;
@property(nonatomic,strong)NSString *roleName;
@property(nonatomic,strong)NSString *salt;
@property(nonatomic,strong)NSString *telphone;
@property(nonatomic,strong)NSString *des;
@property(nonatomic,strong)NSString *evaluateCon;
@property(nonatomic,strong)NSString *commitTime;
@property(nonatomic,strong)NSString *community_name;
@property(nonatomic,strong)NSString *title;
@property(nonatomic,strong)NSString *content;
/** 服务方：待发起交付1、待客户确认2、待客户支付3、施工中4、待阶段验收5、待客户支付尾款6、待评价7、交付完成8；
客户：待服务方发起交付1、待确认2、待支付3、施工中4、待阶段验收5、待支付尾款6、待评价7、交付完成8 */
@property(nonatomic,strong)NSString *user_status;

@property(nonatomic,strong)NSString *turnoverStageName;
@property(nonatomic,strong)NSString *turnoverTitle;
@property(nonatomic,strong)NSString *con;
@property(nonatomic,strong)NSString *constructionStageId;

@property(nonatomic,strong)NSString *drawing_url; // 图纸
@property(nonatomic,strong)NSString *budget_url; //预算图纸
@property(nonatomic,strong)NSString *contract_url; //合同
@property(nonatomic,strong)NSString *change_table_url;//变更相册
@property(nonatomic,strong)NSString *b_recomend_address;
@property(nonatomic,strong)NSString *type_name;
@property(nonatomic,strong)NSString *b_recomend_name;
@property(nonatomic,strong)NSString *mediaUrl;
@property(nonatomic,strong)NSString *demandId;
@property(nonatomic,strong)NSString *area;
@property(nonatomic,strong)NSString *demand_context;
@property(nonatomic,strong)NSString * demand_voice;
@property(nonatomic,strong)NSString *real_tel;
@property(nonatomic,strong)NSString *reason;
@property(nonatomic,strong)NSString *feedback_reply;
@property(nonatomic,strong)NSString *appeal_reason;
@property(nonatomic,strong)NSString *allDays;
@property(nonatomic,strong)NSString *appeal_plateReason;
@property(nonatomic,strong)NSString *picUrl;
@property(nonatomic,strong)NSString *videoUrl;
@property(nonatomic,strong)NSString *year;


@property(nonatomic,strong)NSMutableArray<QYZJWorkModel *> *changeTurnoverLists;
@property(nonatomic,strong)NSMutableArray<QYZJWorkModel *> *turnoverLists;
@property(nonatomic,strong)NSMutableArray<QYZJWorkModel *> *changeConstructionStage;
@property(nonatomic,strong)NSMutableArray<QYZJWorkModel *> *selfStage;
@property(nonatomic,strong)NSMutableArray<QYZJWorkModel *> *media_url;
@property(nonatomic,strong)NSMutableArray<QYZJWorkModel *> *other;
@property(nonatomic,strong)NSMutableArray<QYZJWorkModel *> *constructionStage;
@property(nonatomic,strong)NSMutableArray<QYZJWorkModel *> *repairSelf;

@property(nonatomic,strong)QYZJWorkModel *turnover;
@property(nonatomic,strong)QYZJWorkModel *turnoverListOrderFirst;
@property(nonatomic,strong)QYZJWorkModel *demandUser;
@property(nonatomic,strong)QYZJWorkModel *turnoverListOrderFinal;

@property(nonatomic,strong)QYZJWorkModel *turnoverList;
@property(nonatomic,strong)QYZJWorkModel *demand;

@property(nonatomic,strong)NSArray *pics;
@property(nonatomic,strong)NSArray *change_table_urls;
@property(nonatomic,strong)NSArray *videos;

@property(nonatomic,assign)BOOL isDelete;
@property(nonatomic,assign)BOOL isAppoint;
@property(nonatomic,assign)BOOL isAuth;
@property(nonatomic,assign)BOOL isBond;
@property(nonatomic,assign)BOOL isCoach;
@property(nonatomic,assign)BOOL isFamous;
@property(nonatomic,assign)BOOL isQuestion;
@property(nonatomic,assign)BOOL isReferee;
@property(nonatomic,assign)BOOL isVip;
@property(nonatomic,assign)BOOL is_self;//是不是自己的单子
@property(nonatomic,assign)BOOL is_service;//(0：不是客户；1：是客户)
@property(nonatomic,assign)BOOL   isRepair;
@property(nonatomic,assign)BOOL isOverRepairTime;
@property(nonatomic,assign)BOOL isService;

@property(nonatomic,assign)CGFloat price;
@property(nonatomic,assign)CGFloat moneyCharging;
@property(nonatomic,assign)CGFloat payMoney;
@property(nonatomic,assign)CGFloat payMoneyCharging;
@property(nonatomic,assign)CGFloat money;
@property(nonatomic,assign)CGFloat questionPrice;
@property(nonatomic,assign)CGFloat allPrice;
@property(nonatomic,assign)CGFloat score;
@property(nonatomic,assign)CGFloat sitPrice;
@property(nonatomic,assign)CGFloat budget;
@property(nonatomic,assign)CGFloat commission_price;
@property(nonatomic,assign)CGFloat sign_money;


@property(nonatomic,assign)CGFloat cellHeight;

@property(nonatomic,assign)NSInteger audit_status; //单子审核状态 0：未审核 1：审核成功 2：审核失败
@property(nonatomic,assign)NSInteger appeal_status;
@property(nonatomic,assign)NSInteger manner; //风格
@property(nonatomic,assign)NSInteger house_model;//户型
@property(nonatomic,assign)NSInteger renovation_time;//装修时间
@property(nonatomic,assign)NSInteger evaluateLevel;
//@property(nonatomic,assign)NSInteger appeal_status;
//@property(nonatomic,assign)NSInteger appeal_status;
@end

NS_ASSUME_NONNULL_END

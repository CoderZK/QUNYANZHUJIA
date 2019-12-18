//
//  QYZJFindModel.h
//  QYZJAPP
//
//  Created by zk on 2019/11/7.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface QYZJFindModel : NSObject

@property(nonatomic,strong)NSString *ID;
@property(nonatomic,strong)NSString *userId;
@property(nonatomic,strong)NSString *turnoverListId;
@property(nonatomic,strong)NSString *shopName;
@property(nonatomic,strong)NSString *cityId;
@property(nonatomic,strong)NSString *pro_id;
@property(nonatomic,strong)NSString *area_id;
@property(nonatomic,strong)NSString *city_id;
@property(nonatomic,strong)NSString *proStr;
@property(nonatomic,strong)NSString *areaStr;
@property(nonatomic,strong)NSString *cityStr;
@property(nonatomic,strong)NSString *pic;
@property(nonatomic,strong)NSString *des;
@property(nonatomic,strong)NSString *evaluateCon;
@property(nonatomic,strong)NSString *picUrl;
@property(nonatomic,strong)NSString *video;
@property(nonatomic,strong)NSString *videoUrl;
@property(nonatomic,strong)NSString *type;
@property(nonatomic,strong)NSString *content;
@property(nonatomic,strong)NSString *goodsIds;
@property(nonatomic,strong)NSString *headImg;
@property(nonatomic,strong)NSString *a_head_img;
@property(nonatomic,strong)NSString *head_img;
@property(nonatomic,strong)NSString *nickName;
@property(nonatomic,strong)NSString *timeNow;
@property(nonatomic,strong)NSString *picture;
@property(nonatomic,strong)NSString *refShopId;
@property(nonatomic,strong)NSString *articleId;
@property(nonatomic,strong)NSString *commentContent;
@property(nonatomic,strong)NSString *toUserId;
@property(nonatomic,strong)NSString *articleType;
@property(nonatomic,strong)NSString *articleContent;
@property(nonatomic,strong)NSString *articleVideo;
@property(nonatomic,strong)NSString *articlePicture;
@property(nonatomic,strong)NSString *name;
@property(nonatomic,strong)NSString *toNickName;
@property(nonatomic,strong)NSString *context;
@property(nonatomic,strong)NSString *shopId;
@property(nonatomic,strong)NSString *commentId;//关联ID
@property(nonatomic,strong)NSString *headerPic;
@property(nonatomic,strong)NSString *title;
@property(nonatomic,strong)NSString *time;
@property(nonatomic,strong)NSString *showContent;
@property(nonatomic,strong)NSString *label;
@property(nonatomic,strong)NSString *score;
@property(nonatomic,strong)NSString *role_name;
@property(nonatomic,strong)NSString *a_role_name;
@property(nonatomic,strong)NSString *a_role;
@property(nonatomic,strong)NSString *roleName;
@property(nonatomic,strong)NSString *nick_name;
@property(nonatomic,strong)NSString *a_nick_name;
@property(nonatomic,strong)NSString *contents;
@property(nonatomic,strong)NSString *turnoverStageName;
@property(nonatomic,strong)NSString *con;
@property(nonatomic,strong)NSString *constructionStageId;
@property(nonatomic,strong)NSString *addTime;
@property(nonatomic,strong)NSString *add_time;
@property(nonatomic,strong)NSString *q_head_img;
@property(nonatomic,strong)NSString *q_nick_name;
@property(nonatomic,strong)NSString *b_recomend_name;
@property(nonatomic,strong)NSString *demand_grab_sheet_id;
@property(nonatomic,strong)NSString *type_name;
@property(nonatomic,strong)NSString *area;
@property(nonatomic,strong)NSString *commission_type;
@property(nonatomic,strong)NSString *b_recomend_address;
@property(nonatomic,strong)NSString *address_pca;
@property(nonatomic,strong)NSString *role_ids;
@property(nonatomic,strong)NSString *role_strs;
@property(nonatomic,strong)NSString *stage_name;
@property(nonatomic,strong)NSString *time_start;
@property(nonatomic,strong)NSString *time_end;
@property(nonatomic,strong)NSString *demand_context;
@property(nonatomic,strong)NSString *telphone;
@property(nonatomic,strong)NSString *community_name;
@property(nonatomic,strong)NSString *telphonebudget;
@property(nonatomic,strong)NSString *turnoverTitle;
@property(nonatomic,strong)NSString *replyContent;

/** 服务方：待发起交付1、待客户确认2、待客户支付3、施工中4、待阶段验收5、待客户支付尾款6、待评价7、交付完成8；
 客户：待服务方发起交付1、待确认2、待支付3、施工中4、待阶段验收5、待支付尾款6、待评价7、交付完成8 */
@property(nonatomic,strong)NSString *user_status;



@property(nonatomic,strong)NSString *custom_telphone;
@property(nonatomic,strong)NSString *status;
@property(nonatomic,strong)NSString *custom_nick_name;

@property(nonatomic,strong)NSString *goods_pic;
@property(nonatomic,strong)NSString *osn;
@property(nonatomic,strong)NSString *goods_name;
@property(nonatomic,strong)NSString *goods_price;
@property(nonatomic,strong)NSString *media_url;
@property(nonatomic,strong)NSString *mediaUrl;
@property(nonatomic,strong)NSString *video_url;
@property(nonatomic,strong)NSString *pic_url;


@property(nonatomic,strong)QYZJFindModel *article;
@property(nonatomic,strong)QYZJFindModel *headlinenews;


@property(nonatomic,strong)NSMutableArray<QYZJFindModel *> *commentList;
@property(nonatomic,strong)NSMutableArray<QYZJFindModel *> *goodsList; //商品列表
@property(nonatomic,strong)NSMutableArray<QYZJFindModel *> *goodList; //点赞列表
@property(nonatomic,strong)NSMutableArray<QYZJFindModel *> *mediaList;
@property(nonatomic,strong)NSMutableArray<QYZJFindModel *> *answer_list;
@property(nonatomic,strong)NSMutableArray<QYZJFindModel *> *answerList;
@property(nonatomic,strong)NSMutableArray<QYZJFindModel *> *broadcastReply;
@property(nonatomic,strong)NSMutableArray<QYZJFindModel *> *apponitUsers;
@property(nonatomic,strong)NSMutableArray<QYZJFindModel *> *repairSelf;
@property(nonatomic,strong)NSMutableArray *videos;
@property(nonatomic,strong)NSMutableArray *pictures;
@property(nonatomic,strong)NSMutableArray *change_table_urls;
@property(nonatomic,strong)NSArray *pics;

@property(nonatomic,assign)BOOL isReturn;
@property(nonatomic,assign)BOOL isMy;
@property(nonatomic,assign)BOOL isGood;
@property(nonatomic,assign)BOOL isDelete;
//@property(nonatomic,assign)BOOL isConllect;
@property(nonatomic,assign)BOOL isCollect;
@property(nonatomic,assign)BOOL isRead;
@property(nonatomic,assign)BOOL isOpen;
@property(nonatomic,assign)BOOL is_open;
@property(nonatomic,assign)BOOL isAuth;
@property(nonatomic,assign)BOOL is_question;
@property(nonatomic,assign)BOOL is_vip;
@property(nonatomic,assign)BOOL is_appoint;
@property(nonatomic,assign)BOOL is_coach;
@property(nonatomic,assign)BOOL is_bond; //是否保证金
@property(nonatomic,assign)BOOL is_referee;
@property(nonatomic,assign)BOOL isService;
@property(nonatomic,assign)BOOL  is_service;//是否五服务方
@property(nonatomic,assign)BOOL  isSale;
@property(nonatomic,assign)BOOL  isSelect;
@property(nonatomic,assign)BOOL  isPlaying;
@property(nonatomic,assign)BOOL  is_pay;
@property(nonatomic,assign)BOOL is_realname;
@property(nonatomic,assign)BOOL is_notice;
@property(nonatomic,assign)BOOL   isRepair;
@property(nonatomic,assign)BOOL isOverRepairTime;

@property(nonatomic,assign)NSInteger goodsNum;
@property(nonatomic,assign)NSInteger commentNum;
@property(nonatomic,assign)NSInteger fans_num;
@property(nonatomic,assign)NSInteger appoint_num;
@property(nonatomic,assign)NSInteger answer_num;
@property(nonatomic,assign)NSInteger sitOnNum;
@property(nonatomic,assign)NSInteger goodNum;//点赞人数
@property(nonatomic,assign)NSInteger sit_on_num;
@property(nonatomic,assign)NSInteger collectNum;
@property(nonatomic,assign)NSInteger sign_num;
@property(nonatomic,assign)NSInteger ok_num;
@property(nonatomic,assign)NSInteger demand_num;
@property(nonatomic,assign)NSInteger audit_status;// 0 未审核,1审核 2审核失败
@property(nonatomic,assign)NSInteger type_id;
@property(nonatomic,assign)NSInteger manner_id;
@property(nonatomic,assign)NSInteger house_model_id;
@property(nonatomic,assign)NSInteger renovation_time_id;
@property(nonatomic,assign)NSInteger year;
@property(nonatomic,assign)NSInteger evaluateLevel;


@property(nonatomic,assign)CGFloat all_days;
@property(nonatomic,assign)CGFloat days;
@property(nonatomic,assign)CGFloat price;
@property(nonatomic,assign)CGFloat sitPrice;
@property(nonatomic,assign)CGFloat appoint_price;
@property(nonatomic,assign)CGFloat question_price;
@property(nonatomic,assign)CGFloat allPrice;
@property(nonatomic,assign)CGFloat sit_price;
@property(nonatomic,assign)CGFloat budget;
@property(nonatomic,assign)CGFloat percent;


@property(nonatomic,assign)CGFloat cellHeight;





@end

NS_ASSUME_NONNULL_END

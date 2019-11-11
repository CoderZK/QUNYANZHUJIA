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
@property(nonatomic,strong)NSString *shopName;
@property(nonatomic,strong)NSString *cityId;
@property(nonatomic,strong)NSString *pic;
@property(nonatomic,strong)NSString *video;
@property(nonatomic,strong)NSString *type;
@property(nonatomic,strong)NSString *content;
@property(nonatomic,strong)NSString *goodsIds;
@property(nonatomic,strong)NSString *goodsNum;
@property(nonatomic,strong)NSString *headImg;
@property(nonatomic,strong)NSString *nickName;
@property(nonatomic,strong)NSString *timeNow;
@property(nonatomic,strong)NSString *picture;
@property(nonatomic,strong)NSString *commentNum;
@property(nonatomic,strong)NSString *refShopId;
@property(nonatomic,strong)NSString *articleId;
@property(nonatomic,strong)NSString *commentContent;
@property(nonatomic,strong)NSString *goodNum;//点赞人数
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
@property(nonatomic,strong)QYZJFindModel *article;


@property(nonatomic,strong)NSMutableArray<QYZJFindModel *> *commentList;
@property(nonatomic,strong)NSMutableArray<QYZJFindModel *> *goodsList; //商品列表
@property(nonatomic,strong)NSMutableArray<QYZJFindModel *> *goodList; //点赞列表
@property(nonatomic,strong)NSMutableArray *videos;
@property(nonatomic,strong)NSMutableArray *pictures;



@property(nonatomic,assign)BOOL isReturn;
@property(nonatomic,assign)BOOL isMy;
@property(nonatomic,assign)BOOL isGood;
@property(nonatomic,assign)BOOL isDelete;
@property(nonatomic,assign)BOOL isConllect;
@property(nonatomic,assign)BOOL isRead;
@property(nonatomic,assign)BOOL isOpen;
@property(nonatomic,assign)BOOL isAuth;




@property(nonatomic,assign)CGFloat price;

@property(nonatomic,assign)CGFloat cellHeight;





@end

NS_ASSUME_NONNULL_END

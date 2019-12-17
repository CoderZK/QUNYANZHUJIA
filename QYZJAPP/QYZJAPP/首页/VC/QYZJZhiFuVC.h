//
//  QYZJZhiFuVC.h
//  QYZJAPP
//
//  Created by zk on 2019/11/21.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface QYZJZhiFuVC : BaseViewController


//@property(nonatomic,strong)NSString *osn;
//@property(nonatomic,assign)CGFloat money;
@property(nonatomic,strong)NSString *ID;
//@property(nonatomic,assign)BOOL is_needWeChat;

@property(nonatomic,strong)QYZJTongYongModel *model;

//支付类型（1:抢单、2:签单、3:旁听客服语音、4:旁听订单、5:预约订单、6:提问订单、7:交付 首款订单、8:交付尾款订单、9:交付变更阶段订单、10:购买小店商品订单
@property(nonatomic,assign)NSInteger type;


@end

NS_ASSUME_NONNULL_END

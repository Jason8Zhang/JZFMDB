//
//  JZBookModel.h
//  JZFMDB_Example
//
//  Created by apple-new on 2019/6/13.
//  Copyright © 2019 jason8zhang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JZBookModel : NSObject
@property (nonatomic, strong) NSString    *selected;
@property (nonatomic, strong) NSString    *novelId; //novelId
@property (nonatomic, strong) NSString    *bookId; //globalId
@property (nonatomic, strong) NSString    *bookImageUrl; //封面图
@property (nonatomic, strong) NSString    *bookTitle;
@property (nonatomic, strong) NSString    *footTips;
@property (nonatomic, strong) NSString    *bookInfo; //简介
@property (nonatomic, strong) NSString    *status; //状态文字
@property (nonatomic, strong) NSNumber    *statusNum; //状态数字  30连载中 40暂停更新  10审核中 45完结审核中  20未通过审核  -1锁定/屏蔽
@property (nonatomic, strong) NSString    *lastChaperId;//最新更新ID
@property (nonatomic, strong) NSString    *lastChatperName;
@property (nonatomic, strong) NSNumber      *vipFlag;//是否Vip
@property (nonatomic, strong) NSString    *signTypeName;//发布类型
@property (nonatomic, strong) NSNumber    *signType;   //发布类型 id

@property (nonatomic, strong) NSString    *categoryId;//作品类型一级分类
@property (nonatomic, strong) NSString    *subcategoryId;//作品类型二级分类

@property (nonatomic, strong) NSString    *category;
@property (nonatomic, strong) NSString    *categoryParentId;

@property (nonatomic, strong) NSString    *categoryName;//小说分类文字

@property (nonatomic, strong) NSNumber    *salePurpose;    //销售意向 id
@property (nonatomic, strong) NSString    *salePurposeName;//销售意向 只有云起有
@property (nonatomic, strong) NSString    *msg;//征文截止信息
@property (nonatomic, strong) NSString    *articleName;//征文名称
@property (nonatomic, strong) NSString    *essayId;//征文ID

@property (nonatomic, strong) NSNumber    *valId;//红包平台选项
@property (nonatomic, strong) NSString    *tgName;//红包平台名称
@property (nonatomic, strong) NSString    *target;
@property (nonatomic, strong) NSArray    *tarChoose;

@property (nonatomic, strong) NSNumber    *site;//发布站点代号 id
@property (nonatomic, strong) NSString    *siteName;//发布站点名称

@property (nonatomic, strong) NSNumber *isCanEditNovel;  //

@property (nonatomic, strong) NSData *cacheImageData;
@property (nonatomic, strong) NSString * createTime;
@property (nonatomic, strong) NSString * lastUpdateTime;

@property (nonatomic, strong) NSNumber *isPublishBook;

@property (nonatomic, strong) NSString *isInArtcleString; //是否参加征文
@property (nonatomic, strong) NSString *isfinelayout;//是否精排
@property (nonatomic, strong) NSString *messageFromTitlePage; //扉页寄语
@property (nonatomic, strong) NSString *canDesignCover;//是否可以设计书封
@property (nonatomic, strong) NSString *isCanDeleteNovel;
@end

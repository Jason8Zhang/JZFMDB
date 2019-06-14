

#import "BookModel.h"

@implementation AuthornovelsClass
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{ @"novelid" : @"novelId", @"cbid" : @"CBID", @"signtypename" : @"signTypeName", @"lastupdatetime" : @"lastUpdateTime", @"iscandeletenovel" : @"isCanDeleteNovel", @"categoryparentid" : @"categoryParentId", @"statusnew" : @"statusNew", @"statustextnew" : @"statusTextNew", @"sentencelimit" : @"sentenceLimit", @"signtype" : @"signType", @"issignonline" : @"isSignOnline", @"candesigncover" : @"canDesignCover", @"categoryname" : @"categoryName", @"lastchapterid" : @"lastChapterId", @"coverurl" : @"coverUrl", @"sitename" : @"siteName", @"createtime" : @"createTime", @"signonlineurl" : @"signOnlineUrl", @"iscaneditnovel" : @"isCanEditNovel", @"isinartcle" : @"isInArtcle", @"salepurpose" : @"salePurpose", @"statustext" : @"statusText", @"salepurposename" : @"salePurposeName", @"vipflag" : @"vipFlag",};
}
@end

@implementation ResultClass
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{ @"authornovels" : @"authorNovels",};
}
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{ @"authornovels" : [AuthornovelsClass class],};
}
@end

@implementation BookModel
@end

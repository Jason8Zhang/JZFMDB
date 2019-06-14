


#import <Foundation/Foundation.h>

@interface AuthornovelsClass : NSObject
@property (nonatomic,copy  ) NSString *novelid;
@property (nonatomic,copy  ) NSString *cbid;
@property (nonatomic,strong) id signtypename;
@property (nonatomic,copy  ) NSString *category;
@property (nonatomic,copy  ) NSString *authorid;
@property (nonatomic,copy  ) NSString *authorname;
@property (nonatomic,copy  ) NSString *lastupdatetime;
@property (nonatomic,assign) NSInteger iscandeletenovel;
@property (nonatomic,copy  ) NSString *categoryparentid;
@property (nonatomic,assign) NSInteger statusnew;
@property (nonatomic,copy  ) NSString *statustextnew;
@property (nonatomic,assign) NSInteger sentencelimit;
@property (nonatomic,assign) NSInteger signtype;
@property (nonatomic,strong) id intro;
@property (nonatomic,assign) BOOL issignonline;
@property (nonatomic,assign) NSInteger site;
@property (nonatomic,assign) NSInteger candesigncover;
@property (nonatomic,strong) id categoryname;
@property (nonatomic,copy  ) NSString *pagemess;
@property (nonatomic,copy  ) NSString *isfinelayout;
@property (nonatomic,assign) NSInteger status;
@property (nonatomic,strong) id lastchapterid;
@property (nonatomic,strong) id coverurl;
@property (nonatomic,assign) NSInteger auditstatus;
@property (nonatomic,copy  ) NSString *sitename;
@property (nonatomic,copy  ) NSString *createtime;
@property (nonatomic,copy  ) NSString *freetype;
@property (nonatomic,strong) id signonlineurl;
@property (nonatomic,assign) NSInteger iscaneditnovel;
@property (nonatomic,assign) NSInteger isinartcle;
@property (nonatomic,assign) NSInteger salepurpose;
@property (nonatomic,copy  ) NSString *statustext;
@property (nonatomic,strong) id title;
@property (nonatomic,copy  ) NSString *salepurposename;
@property (nonatomic,assign) NSInteger vipflag;
@end

@interface ResultClass : NSObject
@property (nonatomic,strong) NSArray<AuthornovelsClass *> *authornovels;
@end

@interface BookModel : NSObject
@property (nonatomic,strong) ResultClass *result;
@property (nonatomic,copy  ) NSString *info;
@property (nonatomic,copy  ) NSString *code;
@end

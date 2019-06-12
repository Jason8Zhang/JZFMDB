//
//  JZFMDBHelper.m
//  BGFMDB
//
//  Created by apple-new on 2019/6/4.
//

#import "JZFMDBTools.h"
#import "BGFMDB.h"
#import "BGDB.h"
#import "BGTool.h"

//static NSString *
@interface JZFMDBTools()
//@property(nonatomic,strong) BGDB *db;
//
@end
@implementation JZFMDBTools

+(void)setDebugEnable:(BOOL)enable{
    bg_setDebug(enable);//打开调试模式,打印输出调试信息.
}

+(BOOL)existTableName:(NSString *)nameStr {
    return [JZFMDBTools bg_isExistForTableName:nameStr];
}

+ (BOOL)existTableName:(NSString *)nameStr key:(NSString *)keyStr {
    return NO;
}

- (instancetype)initWithTableName:(NSString *)tableName {
    if (self = [super init]) {
        self.bg_tableName = tableName;
    }
    return self;
}

+ (instancetype)getInstanceByTableName:(NSString *)tableName{
    return [[self alloc] initWithTableName:tableName];
}

+(BOOL)syncSaveModel:(id)model inTable:(NSString *)tableName {
    NSObject *targetData = model;
    targetData.bg_tableName = tableName;
    return [targetData bg_save];
}

+(void)asyncSaveModel:(id)model inTable:(NSString *)tableName withSuccBlock:(void(^)(BOOL isSuccess))succBlock{
    NSObject *targetData = model;
    targetData.bg_tableName = tableName;
    return [targetData bg_saveAsync:succBlock];
}

+ (BOOL)syncSaveArray:(NSArray *)array {
   JZFMDBTools *instance = [self getInstanceByTableName:@"book"];
//   [instance bg_sa]
   [self bg_saveOrUpdateArray:array];
   return YES;
}

+(BOOL)syncInsertModel:(id)model inTable:(NSString *)tableName {
    NSObject *targetData = model;
    targetData.bg_tableName = tableName;
    return [targetData bg_save];
}


+ (BOOL)syncUpdateTable:(NSString *)tableName byId:(NSString *)identifyStr value:(nonnull id)value {
    JZFMDBTools *instance = [self getInstanceByTableName:tableName];
    NSString* where = [NSString stringWithFormat:@"where %@=%@",bg_sqlKey(identifyStr),value];
    return [instance bg_updateWhere:where];
}

+ (void)asyncUpdateTable:(NSString *)tableName byId:(NSString *)identifyStr value:(id)value withSuccBlock:(void(^)(BOOL isSuccess))succBlock {
    
}

+ (id)syncQueryItemFromTable:(NSString *)tableName byId:(NSString *)identifyStr value:(NSString *)value{
    NSObject *obj = [NSObject new];
    NSString* where = [NSString stringWithFormat:@"where %@=%@",bg_sqlKey(identifyStr),bg_sqlValue(value)];
    NSArray* arr = [NSObject bg_find:tableName where:where];
//    JZFMDBTools *instance = [self getInstanceByTableName:tableName];
//    NSArray* arr = [instance bg_find:tableName where:where];
//    return [instance b:where];
//    return nil;
    return arr;
}

//+ (BOOL)syncUpdateTable:(NSString *)tableName byId:(NSString *)identifyStr value:(id)value {
////    NSObject *targetData = model;
//    targetData.bg_tableName = tableName;
//    NSString* where = [NSString stringWithFormat:@"where %@=%@",bg_sqlKey(identifyStr),value];
//    return [p bg_updateWhere:where];
//}
#pragma -mark 改

+(BOOL)asyncUpdateTable:(NSString* _Nullable)tablename class:(Class)cls where:(NSString* _Nonnull)where {
    NSAssert(where && where.length,@"条件不能为空!");
    if(tablename == nil) {
        tablename = NSStringFromClass([self class]);
    }
    __block BOOL result;
    id object = [[self class] new];
    [object setBg_tableName:tablename];
    [[BGDB shareManager] updateWithObject:object valueDict:nil conditions:where complete:^(BOOL isSuccess) {
        result = isSuccess;
    }];
    //关闭数据库
    [[BGDB shareManager] closeDB];
    return result;
}

+(BOOL)asyncUpdateTable:(NSString* _Nullable)tablename class:(Class)cls oldKeyValue:(NSDictionary *)oldKeyValue newKeyValue:(NSDictionary *)newKeyValue{
    
    NSString *where = @"SET";
//    oldKeyValue.k
//    va_list args;
//    va_start(args, keyValues);
//    NSString *where = [[NSString alloc] initWithFormat:keyValues arguments:args];
//    id arg;
//    while ((arg = va_arg(argsList, id)))
//    {
//        [array addObject:arg];
////    }
//    BOOL isKey = YES;
//    NSString
//
//    NSMutableArray *array = [NSMutableArray array];
//    if (keyValues)
//    {
//        va_list argsList;
//        [array addObject:keyValues];
//        va_start(argsList, keyValues);
//        id arg;
//        while ((arg = va_arg(argsList, NSString *)))
//        {
//            [array addObject:arg];
//        }
//        va_end(argsList);
//    }
//

    
    

//    NSMutableString *sql = [NSMutableString stringWithCapacity:[format length]];
//    NSMutableArray *arguments = [NSMutableArray array];
//    [self extractSQL:format argumentsList:args intoString:sql arguments:arguments];
    
//    va_end(args);
//    [self addObj:@"hellow", @"thank you", nil];
    return YES;
}


+ (void)addObj:(NSString *)firstObj,...
{
    NSMutableArray *array = [NSMutableArray array];
    if (firstObj)
    {
        va_list argsList;
        [array addObject:firstObj];
        va_start(argsList, firstObj);
        id arg;
        while ((arg = va_arg(argsList, NSString *)))
        {
            [array addObject:arg];
        }
        va_end(argsList);
    }
    NSLog(@"sssss %@", array);
    
}


#pragma -mark 查询
+(NSInteger)countInTable:(NSString *)tableName {
    return [JZFMDBTools bg_count:tableName where:nil];
}

/**
 同步查询所有结果.
 @tablename 当此参数为nil时,查询以此类名为表名的数据，非nil时，查询以此参数为表名的数据.
 @orderBy 要排序的key.
 @limit 每次查询限制的条数,0则无限制.
 @desc YES:降序，NO:升序.
 */
+(NSArray* _Nullable)syncQueryTable:(NSString* _Nullable)tablename class:(Class)cls limit:(NSInteger)limit orderBy:(NSString* _Nullable)orderBy desc:(BOOL)desc{
    if(tablename == nil) {
        tablename = NSStringFromClass([cls class]);
    }
    NSMutableString* where = [NSMutableString string];
    orderBy?[where appendFormat:@"order by %@%@ ",@"BG_",orderBy]:[where appendFormat:@"order by %@ ",@"rowid"];
    desc?[where appendFormat:@"desc"]:[where appendFormat:@"asc"];
    !limit?:[where appendFormat:@" limit %@",@(limit)];
    __block NSArray* results;
    [[BGDB shareManager] queryObjectWithTableName:tablename class:[cls class] where:where complete:^(NSArray * _Nullable array) {
        results = array;
    }];
    //关闭数据库
    [[BGDB shareManager] closeDB];
    return results;
}

/**
 同步查询所有结果.
 @tablename 当此参数为nil时,查询以此类名为表名的数据，非nil时，查询以此参数为表名的数据.
 温馨提示: 当数据量巨大时,请用范围接口进行分页查询,避免查询出来的数据量过大导致程序崩溃.
 */
+(NSArray* _Nullable)syncQueryAllInTable:(NSString* _Nullable)tablename class:(Class)cls{
    if (tablename == nil) {
        tablename = NSStringFromClass([self class]);
    }
    __block NSArray* results;
    [[BGDB shareManager] queryObjectWithTableName:tablename class:[cls class] where:nil complete:^(NSArray * _Nullable array) {
        results = array;
    }];
    //关闭数据库
    [[BGDB shareManager] closeDB];
    return results;
}

/**
 同步查询所有结果.
 @tablename 当此参数为nil时,查询以此类名为表名的数据，非nil时，查询以此参数为表名的数据.
 @orderBy 要排序的key.
 @range 查询的范围(从location开始的后面length条，localtion要大于0).
 @desc YES:降序，NO:升序.
 */
+(NSArray* _Nullable)syncQueryTable:(NSString* _Nullable)tablename class:(Class)cls range:(NSRange)range orderBy:(NSString* _Nullable)orderBy desc:(BOOL)desc{
    if(tablename == nil) {
        tablename = NSStringFromClass([cls class]);
    }
    NSMutableString* where = [NSMutableString string];
    orderBy?[where appendFormat:@"order by %@%@ ",@"BG_",orderBy]:[where appendFormat:@"order by %@ ",@"rowid"];
    desc?[where appendFormat:@"desc"]:[where appendFormat:@"asc"];
    NSAssert((range.location>0)&&(range.length>0),@"range参数错误,location应该大于零,length应该大于零");
    [where appendFormat:@" limit %@,%@",@(range.location-1),@(range.length)];
    __block NSArray* results;
    [[BGDB shareManager] queryObjectWithTableName:tablename class:[self class] where:where complete:^(NSArray * _Nullable array) {
        results = array;
    }];
    //关闭数据库
    [[BGDB shareManager] closeDB];
    return results;
}

+(NSArray* _Nullable)syncQueryTable:(NSString* _Nullable)tablename class:(Class)cls where:(NSString* _Nullable)where {
    if(tablename == nil) {
        tablename = NSStringFromClass([self class]);
    }
    __block NSArray* results;
    [[BGDB shareManager] queryWithTableName:tablename conditions:where complete:^(NSArray * _Nullable array) {
        results = [BGTool tansformDataFromSqlDataWithTableName:tablename class:[cls class] array:array];
    }];
    //关闭数据库
    [[BGDB shareManager] closeDB];
    return results;
}

+(NSArray* _Nullable)syncQueryTable:(NSString* _Nullable)tablename class:(Class)cls byKey:(NSString *)key value:(NSString *)value {
    NSString *where = [NSString stringWithFormat:@"%@=%@",bg_sqlKey(key),bg_sqlValue(value)];
    return [self syncQueryTable:tablename class:cls where:where];
}
@end

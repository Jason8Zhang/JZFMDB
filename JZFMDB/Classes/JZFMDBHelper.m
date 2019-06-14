//
//  JZFMDB.m
//  BGFMDB
//
//  Created by apple-new on 2019/6/4.
//

#import "JZFMDBHelper.h"
#import "BGFMDB.h"
#import "BGDB.h"
#import "BGTool.h"

#define SpendTimeLog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#define StartTime CFAbsoluteTime start = CFAbsoluteTimeGetCurrent();
#define GetIntervalTime  CFAbsoluteTime end = CFAbsoluteTimeGetCurrent(); \
                        \
                        if([BGDB shareManager].debug) { \
                            SpendTimeLog(@"耗时%f 秒",end - start); \
                        }

@interface JZFMDBHelper()

@end
@implementation JZFMDBHelper

#pragma - mark 日志开关
+ (void)setDebugEnable:(BOOL)enable{
    bg_setDebug(enable);//打开调试模式,打印输出调试信息.
}

#pragma - mark 是否存在
+ (BOOL)existTableName:(NSString *)nameStr {
    StartTime
    BOOL succ = [JZFMDBHelper bg_isExistForTableName:nameStr];
    GetIntervalTime
    return succ;
}

#pragma - mark 存储
+(BOOL)syncSaveModel:(id)model inTable:(NSString *)tableName {
    StartTime
    NSObject *targetData = model;
    targetData.bg_tableName = tableName;
    GetIntervalTime
    return [targetData bg_save];
}

+ (void)asyncSaveModel:(id)model inTable:(NSString *)tableName withSuccBlock:(void(^)(BOOL isSuccess))succBlock{
    StartTime
    [[BGDB shareManager] addToThreadPool:^{
        BOOL succ = [self syncSaveModel:model inTable:tableName];
        succBlock(succ);
        GetIntervalTime
    }];
}

+ (BOOL)syncSaveDic:(NSDictionary *)dic inTable:(NSString *)tableName {
    StartTime
    GetIntervalTime
    return [dic bg_saveDictionary];
}

+ (void)asyncSaveDic:(NSDictionary *)dic inTable:(NSString *)tableName withSuccBlock:(void(^)(BOOL isSuccess))succBlock {
    StartTime
    [[BGDB shareManager] addToThreadPool:^{
        BOOL succ = [self syncSaveDic:dic inTable:tableName];
        succBlock(succ);
        GetIntervalTime
    }];
}

+ (BOOL)syncSaveArray:(NSArray *)array {
    StartTime
    BOOL succ = [self bg_saveOrUpdateArray:array];
    GetIntervalTime
    return succ;
}

+ (void)asyncSaveArray:(NSArray *)array withSuccBlock:(void(^)(BOOL isSuccess))succBlock {
    StartTime
    [[BGDB shareManager] addToThreadPool:^{
        BOOL succ = [self syncSaveArray:array];
        succBlock(succ);
        GetIntervalTime
    }];
}

+ (BOOL)syncInsertModel:(id)model inTable:(NSString *)tableName {
    StartTime
    NSObject *targetData = model;
    targetData.bg_tableName = tableName;
    BOOL succ = [targetData bg_save];
    GetIntervalTime
    return succ;
}


+ (void)asyncInsertModel:(id)model inTable:(NSString *)tableName withSuccBlock:(void(^)(BOOL isSuccess))succBlock {
    StartTime
    [[BGDB shareManager] addToThreadPool:^{
        BOOL succ = [self syncInsertModel:tableName inTable:tableName];
        succBlock(succ);
        GetIntervalTime
    }];
}

+ (BOOL)syncCoverModel:(id)model inTable:(NSString *)tableName {
    StartTime
    [self deleteTable:tableName];
    BOOL succ = [self syncSaveModel:model inTable:tableName];
    GetIntervalTime
    return succ;
}


#pragma - mark 删除

+ (BOOL)syncDeleteItemInTable:(NSString *)tableName where:(NSString *)where{
    StartTime
    BOOL succ = [NSObject bg_delete:tableName where:where];
    GetIntervalTime
    return succ;
}

+ (void)syncDeleteItemInTable:(NSString *)tableName where:(NSString *)where withSuccBlock:(void(^)(BOOL isSuccess))succBlock {
    StartTime
    [[BGDB shareManager] addToThreadPool:^{
        BOOL succ = [self syncDeleteItemInTable:tableName where:where];
        succBlock(succ);
        GetIntervalTime
    }];
}

+ (BOOL)syncDeleteItemInTable:(NSString *)tableName byKey:(NSString *)keyString value:(NSString *)valueString {
    StartTime
    NSString *where = [NSString stringWithFormat:@"where %@=%@",bg_sqlKey(keyString),valueString];
    BOOL succ = [self syncDeleteItemInTable:tableName where:where];
    GetIntervalTime
    return succ;
}

+ (void)syncDeleteItemInTable:(NSString *)tableName byKey:(NSString *)keyString value:(NSString *)valueString withSuccBlock:(void(^)(BOOL isSuccess))succBlock {
    StartTime
    [[BGDB shareManager] addToThreadPool:^{
        BOOL succ = [self syncDeleteItemInTable:tableName byKey:keyString value:valueString];
        succBlock(succ);
        GetIntervalTime
    }];
}

+ (BOOL)syncDeleteItemInTable:(NSString *)tableName keyValues:(NSString *)keyValues,... {
    StartTime
    NSString *keyString = keyValues;
    va_list argsList;
    va_start(argsList, keyValues);
    NSString *valueString = va_arg(argsList, NSString *);
    va_end(argsList);
    BOOL succ = [self syncDeleteItemInTable:tableName byKey:keyString value:valueString];
    GetIntervalTime
    return succ;
}

+ (void)syncDeleteItemInTable:(NSString *)tableName withSuccBlock:(void(^)(BOOL isSuccess))succBlock keyValues:(NSString *)keyValues,... {
    StartTime
    [[BGDB shareManager] addToThreadPool:^{
        BOOL succ = [self syncDeleteItemInTable:tableName keyValues:keyValues];
        succBlock(succ);
        GetIntervalTime
    }];
}

+ (BOOL)deleteTable:(NSString *)tableName {
    StartTime
    BOOL succ = [NSObject bg_clear:tableName];
    GetIntervalTime
    return succ;
}

+ (void)deleteTable:(NSString *)tableName withSuccBlock:(void(^)(BOOL isSuccess))succBlock {
    StartTime
    [[BGDB shareManager] addToThreadPool:^{
        BOOL succ = [self deleteTable:tableName];
        succBlock(succ);
        GetIntervalTime
    }];
}
#pragma -mark 改

+ (BOOL)syncUpdateTable:(NSString *)tableName model:(id)model byIndentify:(NSString *)indentifyStr value:(NSString *)value {
    StartTime
    NSString *where = [NSString stringWithFormat:@"where %@=%@",bg_sqlKey(indentifyStr),value];
    BOOL succ = [self syncUpdateTable:tableName model:model where:where];
    GetIntervalTime
    return succ;
}


+ (void)asyncUpdateTable:(NSString *)tableName model:(id)model byIndentify:(NSString *)indentifyStr value:(NSString *)value withSuccBlock:(void (^)(BOOL))succBlock {
    StartTime
    [[BGDB shareManager] addToThreadPool:^{
        BOOL succ = [self syncUpdateTable:tableName model:model byIndentify:indentifyStr value:value];
        succBlock(succ);
        GetIntervalTime
    }];
}

+ (BOOL)syncUpdateTable:(NSString *)tableName model:(id)model where:(NSString *)where {
    StartTime
    NSObject *obj = model;
    obj.bg_tableName = tableName;
    BOOL succ = [obj bg_updateWhere:where];
    GetIntervalTime
    return succ;
}

+ (void)asyncUpdateTable:(NSString *)tableName model:(id)model where:(NSString *)where withSuccBlock:(void (^)(BOOL isSuccess))succBlock {
    StartTime
    [[BGDB shareManager] addToThreadPool:^{
        BOOL succ = [self syncUpdateTable:tableName model:model where:where];
        succBlock(succ);
        GetIntervalTime
    }];
}

+(BOOL)syncUpdateTable:(NSString* _Nullable)tablename model:(id)model keyvalues:(NSString *)keyValues, ... {
    StartTime
    NSString *keyString = keyValues;
    va_list argsList;
    va_start(argsList, keyValues);
    NSString *valueString = va_arg(argsList, NSString *);
    va_end(argsList);
    BOOL succ = [self syncUpdateTable:tablename model:model byIndentify:keyString value:valueString];
    GetIntervalTime
    return succ;
}

+ (void)asyncUpdateTable:(NSString* _Nullable)tablename model:(id)model succBlock:(void(^)(BOOL isSuccess))succBlock keyvalues:(NSString *)keyValues, ... {
    StartTime
    [[BGDB shareManager] addToThreadPool:^{
        BOOL succ = [self syncUpdateTable:tablename model:model keyvalues:keyValues];
        succBlock(succ);
        GetIntervalTime
    }];
}

#pragma -mark 查询

+(NSInteger)countInTable:(NSString *)tableName {
    StartTime
    BOOL succ = [JZFMDBHelper bg_count:tableName where:nil];
    GetIntervalTime
    return succ;
}


/**
 同步查询所有结果.
 @tablename 当此参数为nil时,查询以此类名为表名的数据，非nil时，查询以此参数为表名的数据.
 @orderBy 要排序的key.
 @range 查询的范围(从location开始的后面length条，localtion要大于0).
 @desc YES:降序，NO:升序.
 */
+(NSArray* _Nullable)syncQueryTable:(NSString* _Nullable)tablename class:(Class)cls range:(NSRange)range orderBy:(NSString* _Nullable)orderBy desc:(BOOL)desc{
    StartTime
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
    GetIntervalTime
    return results;
}

+ (void)asyncQueryTable:(NSString*)tablename class:(Class)cls range:(NSRange)range orderBy:(NSString*)orderBy desc:(BOOL)desc withSuccBlock:(void(^)(NSArray* modelArray))succBlock {
    StartTime
    [[BGDB shareManager] addToThreadPool:^{
       NSArray *array = [self syncQueryTable:tablename class:cls range:range orderBy:orderBy desc:desc];
       succBlock(array);
        GetIntervalTime
    }];
}

/**
 同步查询所有结果.
 @tablename 当此参数为nil时,查询以此类名为表名的数据，非nil时，查询以此参数为表名的数据.
 @orderBy 要排序的key.
 @limit 每次查询限制的条数,0则无限制.
 @desc YES:降序，NO:升序.
 */
+(NSArray* _Nullable)syncQueryTable:(NSString* _Nullable)tablename class:(Class)cls limit:(NSInteger)limit orderBy:(NSString*)orderBy desc:(BOOL)desc{
    StartTime
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
    GetIntervalTime
    return results;
}

+ (void)asyncQueryTable:(NSString*)tablename class:(Class)cls limit:(NSInteger)limit orderBy:(NSString* _Nullable)orderBy desc:(BOOL)desc withSuccBlock:(void(^)(NSArray* modelArray))succBlock {
    StartTime
    [[BGDB shareManager] addToThreadPool:^{
        NSArray *array = [self syncQueryTable:tablename class:cls limit:limit orderBy:orderBy desc:desc];
        succBlock(array);
        GetIntervalTime
    }];
}

/**
 同步查询所有结果.
 @tablename 当此参数为nil时,查询以此类名为表名的数据，非nil时，查询以此参数为表名的数据.
 温馨提示: 当数据量巨大时,请用范围接口进行分页查询,避免查询出来的数据量过大导致程序崩溃.
 */
+(NSArray* _Nullable)syncQueryAllInTable:(NSString* _Nullable)tablename class:(Class)cls{
    StartTime
    if (tablename == nil) {
        tablename = NSStringFromClass([self class]);
    }
    __block NSArray* results;
    [[BGDB shareManager] queryObjectWithTableName:tablename class:[cls class] where:nil complete:^(NSArray * _Nullable array) {
        results = array;
    }];
    //关闭数据库
    [[BGDB shareManager] closeDB];
    GetIntervalTime
    return results;
}

+ (void)asyncQueryAllInTable:(NSString*)tablename class:(Class)cls withSuccBlock:(void(^)(NSArray* modelArray))succBlock {
    StartTime
    [[BGDB shareManager] addToThreadPool:^{
        NSArray *array = [self syncQueryAllInTable:tablename class:cls];
        succBlock(array);
        GetIntervalTime
    }];
}

+ (NSArray* _Nullable)syncQueryTable:(NSString* _Nullable)tablename class:(Class)cls where:(NSString* _Nullable)where {
    StartTime
    if(tablename == nil) {
        tablename = NSStringFromClass([self class]);
    }
    __block NSArray* results;
    [[BGDB shareManager] queryWithTableName:tablename conditions:where complete:^(NSArray * _Nullable array) {
        results = [BGTool tansformDataFromSqlDataWithTableName:tablename class:[cls class] array:array];
    }];
    //关闭数据库
    [[BGDB shareManager] closeDB];
    GetIntervalTime
    return results;
}

+ (void)asyncQueryTable:(NSString* )tablename class:(Class)cls where:(NSString* )where withSuccBlock:(void(^)(NSArray* modelArray))succBlock {
    [[BGDB shareManager] addToThreadPool:^{
        StartTime
        NSArray *array = [self syncQueryTable:tablename class:cls where:where];
        succBlock(array);
        GetIntervalTime
    }];
}

+ (NSArray* _Nullable)syncQueryTable:(NSString* _Nullable)tablename class:(Class)cls byKey:(NSString *)key value:(NSString *)value {
    StartTime
    NSString *where = [NSString stringWithFormat:@"where %@=%@",bg_sqlKey(key),bg_sqlValue(value)];
    NSArray *array =  [self syncQueryTable:tablename class:cls where:where];
    GetIntervalTime
    return array;
}

+ (void)asyncQueryTable:(NSString* )tablename class:(Class)cls byKey:(NSString *)key value:(NSString *)value withSuccBlock:(void(^)(NSArray* modelArray))succBlock {
    StartTime
    [[BGDB shareManager] addToThreadPool:^{
        NSArray *array = [self syncQueryTable:tablename class:cls byKey:key value:value];
        succBlock(array);
        GetIntervalTime
    }];
}

+ (NSArray*)syncQueryTable:(NSString *)tablename class:(Class)cls keyvalues:(NSString *)keyValues,... {
    StartTime
    NSString *keyString = keyValues;
    va_list argsList;
    va_start(argsList, keyValues);
    NSString *valueString = va_arg(argsList, NSString *);
    va_end(argsList);
    NSArray *array = [self syncQueryTable:tablename class:cls byKey:keyString value:valueString];
    GetIntervalTime
    return array;
}

+ (void)asyncQueryTable:(NSString *)tablename class:(Class)cls withSuccBlock:(void(^)(NSArray* modelArray))succBlock keyvalues:(NSString *)keyValues,... {
    StartTime
    [[BGDB shareManager] addToThreadPool:^{
        NSArray *array = [self syncQueryTable:tablename class:cls keyvalues:keyValues];
        succBlock(array);
        GetIntervalTime
    }];
}

@end

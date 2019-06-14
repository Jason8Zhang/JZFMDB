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

@interface JZFMDBHelper()

@end
@implementation JZFMDBHelper

#pragma - mark 日志开关
+ (void)setDebugEnable:(BOOL)enable{
    bg_setDebug(enable);//打开调试模式,打印输出调试信息.
}

#pragma - mark 是否存在
+ (BOOL)existTableName:(NSString *)nameStr {
    return [JZFMDBHelper bg_isExistForTableName:nameStr];
}

#pragma - mark 存储
+(BOOL)syncSaveModel:(id)model inTable:(NSString *)tableName {
    NSObject *targetData = model;
    targetData.bg_tableName = tableName;
    return [targetData bg_save];
}

+ (void)asyncSaveModel:(id)model inTable:(NSString *)tableName withSuccBlock:(void(^)(BOOL isSuccess))succBlock{
    NSObject *targetData = model;
    targetData.bg_tableName = tableName;
    return [targetData bg_saveAsync:succBlock];
}

+ (BOOL)syncSaveDic:(NSDictionary *)dic inTable:(NSString *)tableName {
    return [dic bg_saveDictionary];
}

/**
 异步存入字典类型
 */
+ (void)asyncSaveDic:(NSDictionary *)dic inTable:(NSString *)tableName withSuccBlock:(void(^)(BOOL isSuccess))succBlock {
    
}


+ (BOOL)syncSaveArray:(NSArray *)array {
    return [self bg_saveOrUpdateArray:array];
}

+ (void)asyncSaveArray:(NSArray *)array withSuccBlock:(void(^)(BOOL isSuccess))succBlock {
    [[BGDB shareManager] addToThreadPool:^{
        BOOL succ = [self syncSaveArray:array];
        succBlock(succ);
    }];
}


+ (BOOL)syncInsertModel:(id)model inTable:(NSString *)tableName {
    NSObject *targetData = model;
    targetData.bg_tableName = tableName;
    return [targetData bg_save];
}


+ (void)asyncInsertModel:(id)model inTable:(NSString *)tableName withSuccBlock:(void(^)(BOOL isSuccess))succBlock {
    [[BGDB shareManager] addToThreadPool:^{
        BOOL succ = [self syncInsertModel:tableName inTable:tableName];
        succBlock(succ);
    }];
}

+ (BOOL)syncCoverModel:(id)model inTable:(NSString *)tableName {
    [self deleteTable:tableName];
    return [self syncSaveModel:model inTable:tableName];
}


#pragma - mark 删除

+ (BOOL)syncDeleteItemInTable:(NSString *)tableName where:(NSString *)where{
    return [NSObject bg_delete:tableName where:where];
}

+ (BOOL)syncDeleteItemInTable:(NSString *)tableName byKey:(NSString *)keyString value:(NSString *)valueString {
    NSString *where = [NSString stringWithFormat:@"where %@=%@",bg_sqlKey(keyString),valueString];
    return [self syncDeleteItemInTable:tableName where:where];
}

+ (BOOL)syncDeleteItemInTable:(NSString *)tableName keyValues:(NSString *)keyValues,... {
    NSString *keyString = keyValues;
    va_list argsList;
    va_start(argsList, keyValues);
    NSString *valueString = va_arg(argsList, NSString *);
    va_end(argsList);
    return [self syncDeleteItemInTable:tableName byKey:keyString value:valueString];
}
+ (void)asynDeleteItemFromTable:(NSString *)tableName byId:(NSString *)identifyStr {
    
}

+ (void)deleteTable:(NSString *)tableName {
    //    [BGDB deleteSqlite:tableName];
    //    +(BOOL)bg_clear:(NSString* _Nullable)tablename;
    [NSObject bg_clear:tableName];
}

+ (void)deleteAllTable {
    
}
#pragma -mark 改

+ (BOOL)syncUpdateTable:(NSString *)tableName model:(id)model byIndentify:(NSString *)indentifyStr value:(NSString *)value {
    NSString *where = [NSString stringWithFormat:@"where %@=%@",bg_sqlKey(indentifyStr),value];
    return [self syncUpdateTable:tableName model:model where:where];
}


+ (void)asyncUpdateTable:(NSString *)tableName model:(id)model byIndentify:(NSString *)indentifyStr value:(NSString *)value withSuccBlock:(void (^)(BOOL))succBlock {
    [[BGDB shareManager] addToThreadPool:^{
        BOOL succ = [self syncUpdateTable:tableName model:model byIndentify:indentifyStr value:value];
        succBlock(succ);
    }];
}



+ (BOOL)syncUpdateTable:(NSString *)tableName model:(id)model where:(NSString *)where {
    NSObject *obj = model;
    obj.bg_tableName = tableName;
    return  [obj bg_updateWhere:where];
}

+ (void)asyncUpdateTable:(NSString *)tableName model:(id)model where:(NSString *)where withSuccBlock:(void (^)(BOOL isSuccess))succBlock {
    [[BGDB shareManager] addToThreadPool:^{
        BOOL succ = [self syncUpdateTable:tableName model:model where:where];
        succBlock(succ);
    }];
}

+(BOOL)syncUpdateTable:(NSString* _Nullable)tablename model:(id)model keyvalues:(NSString *)keyValues, ... {
    NSString *keyString = keyValues;
    va_list argsList;
    va_start(argsList, keyValues);
    NSString *valueString = va_arg(argsList, NSString *);
    va_end(argsList);
    return [self syncUpdateTable:tablename model:model byIndentify:keyString value:valueString];
}

+ (void)asyncUpdateTable:(NSString* _Nullable)tablename model:(id)model succBlock:(void(^)(BOOL isSuccess))succBlock keyvalues:(NSString *)keyValues, ... {
    [[BGDB shareManager] addToThreadPool:^{
        BOOL succ = [self syncUpdateTable:tablename model:model keyvalues:keyValues];
        succBlock(succ);
    }];
}

#pragma -mark 查询

+(NSInteger)countInTable:(NSString *)tableName {
    return [JZFMDBHelper bg_count:tableName where:nil];
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

+ (NSArray* _Nullable)syncQueryTable:(NSString* _Nullable)tablename class:(Class)cls where:(NSString* _Nullable)where {
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

+ (NSArray* _Nullable)syncQueryTable:(NSString* _Nullable)tablename class:(Class)cls byKey:(NSString *)key value:(NSString *)value {
    NSString *where = [NSString stringWithFormat:@"where %@=%@",bg_sqlKey(key),bg_sqlValue(value)];
    return [self syncQueryTable:tablename class:cls where:where];
}

+ (NSArray*)syncQueryTable:(NSString *)tablename class:(Class)cls keyvalues:(NSString *)keyValues,... {
    NSString *keyString = keyValues;
    va_list argsList;
    va_start(argsList, keyValues);
    NSString *valueString = va_arg(argsList, NSString *);
    va_end(argsList);
    return [self syncQueryTable:tablename class:cls byKey:keyString value:valueString];
}

+ (id)syncQueryItemFromTable:(NSString *)tableName byId:(NSString *)identifyStr value:(NSString *)value{
//    NSObject *obj = [NSObject new];
    NSString* where = [NSString stringWithFormat:@"where %@=%@",bg_sqlKey(identifyStr),bg_sqlValue(value)];
    NSArray* arr = [NSObject bg_find:tableName where:where];

    return arr;
}

+ (double)modelWithSpendTime:(void(^)(void))block {
    CFAbsoluteTime start = CFAbsoluteTimeGetCurrent();
    
    block();
    CFAbsoluteTime end = CFAbsoluteTimeGetCurrent();
    return end-start;
}

@end

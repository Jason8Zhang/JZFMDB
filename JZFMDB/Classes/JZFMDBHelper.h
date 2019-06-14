//
//  JZFMDB.h
//  BGFMDB
//
//  Created by apple-new on 2019/6/4.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface JZFMDBHelper : NSObject

/**
 debug日志开关
 */
+ (void)setDebugEnable:(BOOL)enable;

/**
 是否存在该表
 */
+ (BOOL)existTableName:(NSString *)nameStr;

// 增

/**
 同步存入model类型
 @return 成功与否
 */
+ (BOOL)syncSaveModel:(id)model inTable:(NSString *)tableName;

/**
 异步存入model类型
 */
+ (void)asyncSaveModel:(id)model inTable:(NSString *)tableName withSuccBlock:(void(^)(BOOL isSuccess))succBlock;

/**
 同步存入字典类型
 @return 成功与否
 */
+ (BOOL)syncSaveDic:(NSDictionary *)dic inTable:(NSString *)tableName;

/**
 异步存入字典类型
 */
+ (void)asyncSaveDic:(NSDictionary *)dic inTable:(NSString *)tableName withSuccBlock:(void(^)(BOOL isSuccess))succBlock;

/**
 同步存入数组类型
 @return 成功与否
 */
+ (BOOL)syncSaveArray:(NSArray *)array;

/**
 异步存入数组类型
 */
+ (void)asyncSaveArray:(NSArray *)array withSuccBlock:(void(^)(BOOL isSuccess))succBlock;

/**
 同步插入数组类型
 @return 成功与否
 */
+ (BOOL)syncInsertModel:(id)model inTable:(NSString *)tableName;

/**
 异步插入数组类型
 */
+ (void)asyncInsertModel:(id)model inTable:(NSString *)tableName withSuccBlock:(void(^)(BOOL isSuccess))succBlock;

/**
 覆盖保存

 @param model 数据模型
 @param tableName 表名
 @return 成功与否
 */
+ (BOOL)syncCoverModel:(id)model inTable:(NSString *)tableName;

// 删

+ (BOOL)syncDeleteItemInTable:(NSString *)tableName where:(NSString *)where;
+ (BOOL)syncDeleteItemInTable:(NSString *)tableName byKey:(NSString *)keyString value:(NSString *)valueString;
+ (BOOL)syncDeleteItemInTable:(NSString *)tableName keyValues:(NSString *)keyValues,...;
+ (void)asynDeleteItemFromTable:(NSString *)tableName byId:(NSString *)identifyStr;

+ (void)deleteTable:(NSString *)tableName;

+ (void)deleteAllTable;
// 改

/**
 同步存入数组类型
 @return 成功与否
 */
+ (BOOL)syncUpdateTable:(NSString *)tableName model:(id)model byIndentify:(NSString *)indentifyStr value:(NSString *)value;

/**
 异步存入数组类型
 */
+ (void)asyncUpdateTable:(NSString *)tableName model:(id)model byIndentify:(NSString *)indentifyStr value:(NSString *)value withSuccBlock:(void(^)(BOOL isSuccess))succBlock;

/**
 同步存入数组类型
 @return 成功与否
 */
+ (BOOL)syncUpdateTable:(NSString *)tableName model:(id)model where:(NSString *)where;

/**
 异步存入数组类型
 */
+ (void)asyncUpdateTable:(NSString *)tableName model:(id)model where:(NSString *)where withSuccBlock:(void(^)(BOOL isSuccess))succBlock;

/**
 同步存入数组类型

 @param tablename 表名
 @param model 存入的数据item
 @param keyValues 满足条件的key value，此处只处理两个传入数据，后续数据回舍弃
 @return 返回成功与否
 */
+ (BOOL)syncUpdateTable:(NSString* _Nullable)tablename model:(id)model keyvalues:(NSString *)keyValues, ...;

/**
 异步存入数组类型

 @param tablename 表名
 @param model 存入的数据item
 @param succBlock 成功回调
 @param keyValues 满足条件的key value，此处只处理两个传入数据，后续数据回舍弃
 */
+ (void)asyncUpdateTable:(NSString* _Nullable)tablename model:(id)model succBlock:(void(^)(BOOL isSuccess))succBlock keyvalues:(NSString *)keyValues, ...;

// 查

/**
 表中数据条数
 @param tableName 表名
 @return 返回条数
 */
+ (NSInteger)countInTable:(NSString *)tableName;
//


/**
 同步查询，按照range查

 @param tablename 表名
 @param cls 返回数据的model类
 @param range range
 @param orderBy 按照某个key排序
 @param desc 正序
 @return 返回查找到的model数组
 */
+ (NSArray* _Nullable)syncQueryTable:(NSString* _Nullable)tablename class:(Class)cls range:(NSRange)range orderBy:(NSString* _Nullable)orderBy desc:(BOOL)desc;

/**
 同步查询，按照limit查询

 @param tablename 表名
 @param cls 返回数据的model类
 @param limit limit
 @param orderBy 按照某个key排序
 @param desc 正序
 @return 返回查找到的model数组
 */
+ (NSArray* _Nullable)syncQueryTable:(NSString* _Nullable)tablename class:(Class)cls limit:(NSInteger)limit orderBy:(NSString* _Nullable)orderBy desc:(BOOL)desc;

/**
 同步查询，查所有的数据

 @param tablename 表名
 @param cls 返回数据的model类
 @return 返回查找到的model数组
 */
+ (NSArray* _Nullable)syncQueryAllInTable:(NSString* _Nullable)tablename class:(Class)cls;

/**
 同步查询，条件查询

 @param tablename 表名
 @param cls 返回数据的model类
 @param where 条件
 @return 返回查找到的model数组
 */
+ (NSArray* _Nullable)syncQueryTable:(NSString* _Nullable)tablename class:(Class)cls where:(NSString* _Nullable)where;

/**
 同步查询，用一组key value

 @param tablename 表名
 @param cls 返回数据的model类
 @param key key
 @param value value
 @return 返回查找到的model数组
 */
+ (NSArray* _Nullable)syncQueryTable:(NSString* _Nullable)tablename class:(Class)cls byKey:(NSString *)key value:(NSString *)value;

/**
 同步查询，用一组key value

 @param tablename 表名
 @param cls 返回数据的model类
 @param keyValues 满足条件的key value，此处只处理两个传入数据，后续数据回舍弃
 @return 返回查找到的model数组
 */
+ (NSArray*)syncQueryTable:(NSString *)tablename class:(Class)cls keyvalues:(NSString *)keyValues,...;

@end

NS_ASSUME_NONNULL_END

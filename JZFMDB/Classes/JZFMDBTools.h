//
//  JZFMDBHelper.h
//  BGFMDB
//
//  Created by apple-new on 2019/6/4.
//

#import <Foundation/Foundation.h>
typedef void(^AsySaveSuccBlock)(BOOL isSucc);
typedef void(^AsyQuerySuccBlock)(id item);

NS_ASSUME_NONNULL_BEGIN

@interface JZFMDBTools : NSObject
//- (id)initWithName:(NSString *)name;
- (instancetype)initWithTableName:(NSString *)tableName;

- (instancetype)initWithTableName:(NSString *)tableName modelClass:(Class)cls;
/**
 debug日志开关

 @param enable <#enable description#>
 */
+(void)setDebugEnable:(BOOL)enable;

/**
 <#Description#>

 @param nameStr <#nameStr description#>
 @return <#return value description#>
 */
+(BOOL)existTableName:(NSString *)nameStr;

/**
 <#Description#>

 @param nameStr <#nameStr description#>
 @param keyStr <#keyStr description#>
 @return <#return value description#>
 */
+ (BOOL)existTableName:(NSString *)nameStr key:(NSString *)keyStr;



// 增

+(BOOL)syncSaveModel:(id)model inTable:(NSString *)tableName;
+(void)asyncSaveModel:(id)model inTable:(NSString *)tableName withSuccBlock:(void(^)(BOOL isSuccess))succBlock;
+(BOOL)syncInsertModel:(id)model inTable:(NSString *)tableName;

+ (void)asyncSaveDic:(NSDictionary *)dic withSuccBlock:(AsySaveSuccBlock)succBlock;
+ (BOOL)saveDic:(NSDictionary *)dic;

+ (void)asyncSaveArray:(NSArray *)array withSuccBlock:(AsySaveSuccBlock)succBlock;
+ (BOOL)syncSaveArray:(NSArray *)array;
// 删

+ (void)deleteItemFromTable:(NSString *)tableName byId:(NSString *)identifyStr;

+ (void)deleteTable:(NSString *)tableName;

+ (void)deleteAllTable;
// 改

+(BOOL)asyncUpdateTable:(NSString* _Nullable)tablename class:(Class)cls where:(NSString* _Nonnull)where;

+(BOOL)asyncUpdateTable:(NSString* _Nullable)tablename class:(Class)cls keyvalues:(NSString *)keyValues, ...;

+ (void)asyncUpdateTable:(NSString *)tableName byId:(NSString *)identifyStr value:(id)value withSuccBlock:(void(^)(BOOL isSuccess))succBlock;
+ (BOOL)syncUpdateTable:(NSString *)tableName byId:(NSString *)identifyStr value:(id)value;

// 查
// 表中数据条数
+(NSInteger)countInTable:(NSString *)tableName;
// 按照range查询
+(NSArray* _Nullable)syncQueryTable:(NSString* _Nullable)tablename class:(Class)cls range:(NSRange)range orderBy:(NSString* _Nullable)orderBy desc:(BOOL)desc;
// 按照limit查询
+(NSArray* _Nullable)syncQueryTable:(NSString* _Nullable)tablename class:(Class)cls limit:(NSInteger)limit orderBy:(NSString* _Nullable)orderBy desc:(BOOL)desc;
// 查所有的数据
+(NSArray* _Nullable)syncQueryAllInTable:(NSString* _Nullable)tablename class:(Class)cls;

+(NSArray* _Nullable)syncQueryTable:(NSString* _Nullable)tablename class:(Class)cls where:(NSString* _Nullable)where;

+(NSArray* _Nullable)syncQueryTable:(NSString* _Nullable)tablename class:(Class)cls byKey:(NSString *)key value:(NSString *)value;



+ (void)asyncQueryItemFromTable:(NSString *)tableName byId:(NSString *)identifyStr withSuccBlock:(void(^)(id model))succBlock;
+ (id)syncQueryItemFromTable:(NSString *)tableName byId:(NSString *)identifyStr;

+ (void)asyncQueryItemsFromTable:(NSString *)tableName byPageNo:(NSInteger)pageNo pageSize:(NSInteger)pageSize withSuccBlock:(AsyQuerySuccBlock)succBlock;

+ (id)syncQueryItemFromTable:(NSString *)tableName byId:(NSString *)identifyStr value:(NSString *)value;
@end

NS_ASSUME_NONNULL_END

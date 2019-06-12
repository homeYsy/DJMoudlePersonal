//
//  WCDBManager.h
//  DJBase
//  wcdb数据库操作
//  Created by CSS on 2019/5/22.
//  Copyright © 2019年 djkj. All rights reserved.
//

#import <Foundation/Foundation.h>

@class WCTDatabase;
@protocol WCTTableCoding;
@interface WCDBOperation : NSObject

@property (nonatomic, strong, readonly) WCTDatabase *dbDatabase;

- (instancetype )initDBWithName:(NSString *)dbName;

- (instancetype )initWithDBWithPath:(NSString *)dbPath;

- (BOOL)isTableExists:(NSString *)tableName;

#pragma mark create table

- (BOOL)createTableAndIndexesOfName:(NSString *)tableName withClass:(Class)cls;

#pragma mark insert


/**
 数据库插入模型
 
 @param object 插入的模型
 @param tableName 表名
 */
- (BOOL)insertObject:(NSObject<WCTTableCoding> *)object
                into:(NSString *)tableName;

/*
 replace
 **/

- (BOOL)insertOrReplaceObject:(NSObject<WCTTableCoding> *)object
                         into:(NSString *)tableName;

#pragma mark - Get Object
/**
 从数据库查找model
 
 @param cls class
 @param tableName 表名
 @param keyName model id 对应绑定数据库的名称
 @param key 实参，id类型只接受NSString和NSNumber类型，其他会报错
 */
- (id)getOneObjectOfClass:(Class)cls fromTable:(NSString *)tableName primaryKeyName:(NSString *)keyName primaryKey:(id)key;


#pragma mark Update With Object

/**
 根据传入id参数更新数据库
 
 @param tableName 表名
 @param object 更新的model
 @param keyName 绑定的数据库参数
 @param key id类型只接受NSString和NSNumber类型，其他会报错
 */
- (BOOL)updateObjectInTable:(NSString *)tableName withObject:(NSObject<WCTTableCoding> *)object primaryKeyName:(NSString *)keyName primaryKey:(id)key;

#pragma mark delete object

/**
 从数据库删除模型
 
 @param tableName 表名
 @param keyName 绑定id对应数据库字段名
 @param key id类型只接受NSString和NSNumber类型，其他会报错
 */
- (BOOL)deleteObjectFromTable:(NSString *)tableName primaryKeyName:(NSString *)keyName primaryKey:(id)key;


@end

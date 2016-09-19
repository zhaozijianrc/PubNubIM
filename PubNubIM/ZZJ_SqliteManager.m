//
//  ZZJ_SqliteManager.m
//  PubNubIM
//
//  Created by rc on 16/8/29.
//  Copyright © 2016年 rc. All rights reserved.
//

#import "ZZJ_SqliteManager.h"

@interface ZZJ_SqliteManager ()
@property (nonatomic, strong) FMDatabase *db;

@end

@implementation ZZJ_SqliteManager
#define DATABASEPATH [[(NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES)) lastObject]stringByAppendingPathComponent:dataBaseName]
#define dataBaseName @"UseHeart.db"

static ZZJ_SqliteManager *sqliteManager = nil;

+ (ZZJ_SqliteManager *)shareManager{
    
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        sqliteManager = [[ZZJ_SqliteManager alloc]init];
        sqliteManager.db = [FMDatabase databaseWithPath:DATABASEPATH];
        //        CLog(@"DATABASEPATH:%@",DATABASEPATH);
    });
    return sqliteManager;
}

-(void)createTableWithTableName:(NSString *)tableName
{
    //    tableName = @"aa";
    if ([_db open]) {
        //        @property (nonatomic, readonly) NSDictionary* headers;
        if (![_db tableExists:tableName]) {
            NSString *strExecute = [NSString stringWithFormat:@"CREATE TABLE %@ (localId INTEGER PRIMARY KEY AUTOINCREMENT,text text,messageType INTEGER,messageId INTEGER)",tableName];
            if ([_db executeUpdate:strExecute]) {
                NSLog(@"create table %@ success",tableName);
            }else{
                NSLog(@"fail to create table %@",tableName);
            }
        }else {
        }
        [_db close];
    }else{
        NSLog(@"fail to open");
    }
}




- (BOOL)addMessage:(chatMessage*)message{
    
    NSString *tableName = @"ChatMsg";
    
    [self createTableWithTableName:tableName];
    if([_db open])
    {
        BOOL isExit = NO;
        NSString * sql = [NSString stringWithFormat:@"select * from %@ where messageId = '%zd'",tableName,@1];
        FMResultSet * rs = [_db executeQuery:sql];
        while ([rs next]) {
            isExit = YES;
        }
        BOOL success;
        if (isExit) {
            //            messageId text,recipientId text,senderId text,text text,timestamp date,timeInterval text,messageType INTEGER
            NSString *updateSql = [[NSString alloc] initWithFormat:@"UPDATE %@ SET  text = '%zd',messageType = %d where messageId = '%@'",tableName,message.megText,message.direction,@1];
            success = [_db executeUpdate:updateSql];
        }
        else
        {
            NSString *updateSql = [[NSString alloc] initWithFormat:@"insert into %@ (messageId ,text ,messageType) values('%@','%@','%zd')",tableName,@1,message.megText,message.direction];
            
            success = [_db executeUpdate:updateSql];
        }
        
        [_db close];
        return success;
    }
    return NO;
    
}

-(NSMutableArray *)getAllChatMsgWithTargetUserId:(NSString *)targetUserId
{
  
    NSString *tableName = [NSString stringWithFormat:@"ChatMsg"];
    
    [self createTableWithTableName:tableName];
    
    if ([_db open]) {
        NSMutableArray *arr = [[NSMutableArray alloc]init];
        NSString * sql = [NSString stringWithFormat:@"SELECT * FROM %@ order by localId",tableName];
        //        NSString * sql = [NSString stringWithFormat:@"SELECT * FROM %@ order by timeInterval desc",tableName];
        //        NSString * sql = [NSString stringWithFormat:@"SELECT * FROM %@",tableName];
        FMResultSet * rs = [_db executeQuery:sql];
        while ([rs next]) {
            chatMessage *message = [[chatMessage alloc]init];
            
            message.megText = [NSString stringWithFormat:@"%@",[rs stringForColumn:@"text"]];
            

            
            message.direction = [rs intForColumn:@"messageType"];
             
             
//
            [arr addObject:message];
        }
        [_db close];
        return arr;
    }
    return nil;
}



@end

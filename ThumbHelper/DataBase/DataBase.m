//
//  DataBase.m
//  ThumbHelper
//
//  Created by LiuLei on 12-4-24.
//  Copyright (c) 2012年 LiuLei. All rights reserved.
//

#import "DataBase.h"
static sqlite3 *dataBaseEntry;

#define kDBPath @"ThumbHelper.sqlite"

@implementation DataBase

+ (BOOL) updateDateBase 
{
	NSString *directoryPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
	NSFileManager *fileManager = [NSFileManager defaultManager];
	NSString *fullPath = [directoryPath stringByAppendingPathComponent:kDBPath];
	NSString *sourcePath = [[NSBundle mainBundle] pathForResource:@"ThumbHelper" ofType:@"sqlite"];
	if(![fileManager fileExistsAtPath:fullPath]){
		NSError *error;
		if(![fileManager copyItemAtPath:sourcePath toPath:fullPath error:&error])
			NSLog(@"Create up database : %@",[error localizedDescription]);
		
		return NO;
	}else {
		return YES;
	}

}

+ (sqlite3 *)openDataBase{
	if(dataBaseEntry){
	
		return dataBaseEntry;
	}
	NSString *directoryPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
	NSFileManager *fileManager = [NSFileManager defaultManager];
	NSString *fullPath = [directoryPath stringByAppendingPathComponent:kDBPath];
	NSString *sourcePath = [[NSBundle mainBundle] pathForResource:@"ThumbHelper" ofType:@"sqlite"];
	if(![fileManager fileExistsAtPath:fullPath]){
		NSError *error;
		if(![fileManager copyItemAtPath:sourcePath toPath:fullPath error:&error])
			NSLog(@"Create up database : %@",[error localizedDescription]);
		
	}


	
	int result = sqlite3_open([fullPath UTF8String], &dataBaseEntry);
	if(result == SQLITE_OK){
		NSLog(@"Create database at path \"%@\" with status %d",fullPath,result);
		return dataBaseEntry;
		
	}else {
		return nil;
	}
}

+ (void)closeDataBase{
	if(dataBaseEntry){
		int result = sqlite3_close(dataBaseEntry);
		if(result == SQLITE_OK){
		dataBaseEntry = nil;
		NSLog(@"Close database with status %d",result);
		}		
	}	
}

@end

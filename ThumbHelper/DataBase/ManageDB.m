//
//  DataBase.h
//  ThumbHelper
//
//  Created by LiuLei on 12-4-24.
//  Copyright (c) 2012年 LiuLei. All rights reserved.
//

#import "DataBase.h"
#import "ManageDB.h"

@implementation ManageDB


+ (BOOL) shouldUpDate:(NSString *) tablename
{
	sqlite3 *db = [DataBase openDataBase];
	sqlite3_stmt *stmt;
	int result = sqlite3_prepare_v2(db,"select count(*) from sqlite_master where tbl_name = ?", -1, &stmt, NULL);
	sqlite3_bind_text(stmt, 1, [tablename UTF8String],-1,NULL);
	if (result == SQLITE_OK) {
		sqlite3_step(stmt);
		int ID = sqlite3_column_int(stmt,0);
		sqlite3_finalize(stmt);
		if (ID==0) {
			return YES;
		}else {
			return NO;
		}
	}
	sqlite3_finalize(stmt);
	return NO;

}
+ (BOOL) createTablediary
{
	sqlite3 *db = [DataBase openDataBase];
	sqlite3_stmt *stmt;
	int result = sqlite3_prepare_v2(db,"create table tmpdiary (id INTEGER PRIMARY KEY NOT NULL,type INTEGER DEFAULT 1,mdtype INTEGER DEFAULT 1,weather INTEGER DEFAULT 1,font VARCHAR,background INTEGER DEFAULT 3,content VARCHAR)", -1, &stmt, NULL);
	if (result == SQLITE_OK) {
		NSLog(@"create table tmpdiary succeed");
		sqlite3_step(stmt);
		sqlite3_finalize(stmt);
		return YES;
	}
	sqlite3_finalize(stmt);
	return NO;
	
	
	
//CREATE TABLE "diary" ("id" INTEGER PRIMARY KEY  NOT NULL , "type" INTEGER, "mdtype" INTEGER, "weather" INTEGER, "font" VARCHAR, "image" BLOB, "content" VARCHAR)
}

+ (BOOL) updateTablediary
{
	sqlite3 *db = [DataBase openDataBase];
	sqlite3_stmt *stmt;

	int result= sqlite3_prepare_v2(db,"insert into tmpdiary(id,content) select data ,content from diary", -1, &stmt, NULL);
	if (result == SQLITE_OK) {
		NSLog(@"update table temdiary succeed");
		sqlite3_step(stmt);
		sqlite3_finalize(stmt);
		return YES;
	}
	
	sqlite3_finalize(stmt);
//insert into tmpdiary(id,content) select data ,content from diary
	return NO;
}


+ (BOOL) updateAnotherData
{
	sqlite3 *db = [DataBase openDataBase];
	sqlite3_stmt *stmt;
	int result = sqlite3_prepare_v2(db,"select data,fontstyle,fontsize,colorred,colorgreen,colorblue from diary", -1, &stmt, NULL);
	if (result == SQLITE_OK) {
		
		while (SQLITE_ROW == sqlite3_step(stmt)) {
			sqlite3_stmt *sstmt;
			int ID = sqlite3_column_int(stmt,0);
			const unsigned char *fontstyle = sqlite3_column_text(stmt, 1);
			int fontsize = sqlite3_column_int(stmt,2);
			float red = sqlite3_column_double(stmt,3);
			float green = sqlite3_column_double(stmt,4);
			float blue = sqlite3_column_double(stmt,5);
			
			NSString *fstyle=[NSString stringWithUTF8String:(const char *) fontstyle];
			NSString *string=[NSString stringWithFormat:@"%02d ",fontsize];
			int color=9*red*2+3*green*2+blue*2;
			string=[string stringByAppendingFormat:@"%02d ",color];
			string=[string stringByAppendingString:fstyle];
			
			
			int ok = sqlite3_prepare_v2(db,"update tmpdiary set font=? where ID=?", -1, &sstmt, NULL);
			if (ok == SQLITE_OK) {
				
				sqlite3_bind_text(sstmt, 1, [string UTF8String],-1,NULL);
				sqlite3_bind_int(sstmt, 2, ID);
				sqlite3_step(sstmt);
			}
			
			sqlite3_finalize(sstmt);
		}
		
		NSLog(@"update anotherdata successfully");
		
		
		
	}
	
	sqlite3_finalize(stmt);
	return YES;
	
}



+ (BOOL) deleteTablediary
{
	sqlite3 *db = [DataBase openDataBase];
	sqlite3_stmt *stmt;
	int result = sqlite3_prepare_v2(db,"drop table diary", -1, &stmt, NULL);
	if (result == SQLITE_OK) {
		NSLog(@"delete table succeed");
		sqlite3_step(stmt);
		sqlite3_finalize(stmt);
		return YES;
	}
	sqlite3_finalize(stmt);
	return NO;
}
+ (BOOL) renameTablediary
{
	sqlite3 *db = [DataBase openDataBase];
	sqlite3_stmt *stmt;
	int result = sqlite3_prepare_v2(db,"alter table tmpdiary rename to diary", -1, &stmt, NULL);
	if (result == SQLITE_OK) {
		NSLog(@"change table name succeed");
		sqlite3_step(stmt);
		sqlite3_finalize(stmt);
		return YES;
	}
	
	return NO;

}

+ (BOOL) renameTablectimage
{
	sqlite3 *db = [DataBase openDataBase];
	sqlite3_stmt *stmt;
	int result = sqlite3_prepare_v2(db,"alter table image rename to ctimage", -1, &stmt, NULL);
	if (result == SQLITE_OK) {
		NSLog(@"change table name succeed");
		sqlite3_step(stmt);
		sqlite3_finalize(stmt);
		return YES;
	}
	sqlite3_finalize(stmt);
	return NO;
}

+ (BOOL) createTablediyimage
{
	sqlite3 *db = [DataBase openDataBase];
	sqlite3_stmt *stmt;
	int result = sqlite3_prepare_v2(db,"create table tmpimage (id INTEGER ,date INTEGER,image BLOB)", -1, &stmt, NULL);
	if (result == SQLITE_OK) {
		NSLog(@"create diyimage table succeed");
		sqlite3_step(stmt);
		sqlite3_finalize(stmt);
		return YES;
	}
	sqlite3_finalize(stmt);
	return NO;
	

}

+ (BOOL) updateTablediyimage
{
	sqlite3 *db = [DataBase openDataBase];
	sqlite3_stmt *stmt;
	int result= sqlite3_prepare_v2(db,"select date from diy", -1, &stmt, NULL);	
	
	if (result == SQLITE_OK) {
		while (SQLITE_ROW == sqlite3_step(stmt)) {
		sqlite3_stmt *sstmt;
		int ID = sqlite3_column_int(stmt,0);
		int date = ID;
		int result= sqlite3_prepare_v2(db,"insert into tmpimage(id ,date ,image) values (1,?,(select firstimage from diy where date= ?))", -1, &sstmt, NULL);
		sqlite3_bind_int(sstmt, 1, ID);
		sqlite3_bind_int(sstmt, 2, date);
		if (result == SQLITE_OK) {
			NSLog(@"update firstimage ok");
			sqlite3_step(sstmt);
			
		}else {
			NSLog(@"we have some trouble");
		}
		
		result= sqlite3_prepare_v2(db,"insert into tmpimage(id ,date ,image) values (2,?,(select secondimage from diy where date= ?))", -1, &sstmt, NULL);
		sqlite3_bind_int(sstmt, 1, ID);
		sqlite3_bind_int(sstmt, 2, date);
		if (result == SQLITE_OK) {
			sqlite3_step(sstmt);
			
		}
		result= sqlite3_prepare_v2(db,"insert into tmpimage(id ,date ,image) values (3,?,(select thirdimage from diy where date= ?))", -1, &sstmt, NULL);
		sqlite3_bind_int(sstmt, 1, ID);
		sqlite3_bind_int(sstmt, 2, date);
		if (result == SQLITE_OK) {
			
			sqlite3_step(sstmt);
			
			NSLog(@"We have change all the diyimage");
		}
			
		sqlite3_finalize(sstmt);
		}
	
	}
	
	sqlite3_finalize(stmt);
	//insert into tmpdiary(id,content) select data ,content from diary
	return YES;
	
}

+ (BOOL) deleteTablediyimage
{
	sqlite3 *db = [DataBase openDataBase];
	sqlite3_stmt *stmt;
	int result = sqlite3_prepare_v2(db,"drop table diy", -1, &stmt, NULL);
	if (result == SQLITE_OK) {
		NSLog(@"delete table diy succeed");
		sqlite3_step(stmt);
		sqlite3_finalize(stmt);
		return YES;
	}
	sqlite3_finalize(stmt);
	return NO;
	
}
+ (BOOL) renameTablediyimage
{
	sqlite3 *db = [DataBase openDataBase];
	sqlite3_stmt *stmt;
	int result = sqlite3_prepare_v2(db,"alter table tmpimage rename to diyimage", -1, &stmt, NULL);
	if (result == SQLITE_OK) {
		NSLog(@"rename table tmpimage succeed");
		sqlite3_step(stmt);
		sqlite3_finalize(stmt);
		return YES;
	}
	sqlite3_finalize(stmt);
	return NO;
	
}


+ (BOOL) createTablesound
{
	sqlite3 *db = [DataBase openDataBase];
	sqlite3_stmt *stmt;
	int result = sqlite3_prepare_v2(db,"create table sound (id INTEGER PRIMARY KEY NOT NULL,date INTEGER,name VARCHAR)", -1, &stmt, NULL);
	if (result == SQLITE_OK) {
		NSLog(@"create soundtable succeed");
		sqlite3_step(stmt);
		sqlite3_finalize(stmt);
		return YES;
	}
	sqlite3_finalize(stmt);
	return NO;
}

+ (BOOL) updateTablesound
{
	sqlite3 *db = [DataBase openDataBase];
	sqlite3_stmt *stmt;
	
	int result= sqlite3_prepare_v2(db,"select data ,sound from diary", -1, &stmt, NULL);
	if (result == SQLITE_OK) {
		while (SQLITE_ROW == sqlite3_step(stmt)) {
			int date = sqlite3_column_int(stmt,0);
			int sound = sqlite3_column_int(stmt,1);
			if (sound==1) {
				sqlite3_stmt *sstmt;
				NSString *string=[NSString stringWithFormat:@"%d.caf",date];
				int ok=sqlite3_prepare_v2(db,"insert into sound(date,name) values(?,?)", -1, &sstmt, NULL);
				if (ok==SQLITE_OK) {
					sqlite3_bind_int(sstmt, 1, date);
					sqlite3_bind_text(sstmt, 2, [string UTF8String],-1,NULL);
					sqlite3_step(sstmt);
					
					NSLog(@"sound update successfully");
				}
				sqlite3_finalize(sstmt);
			}
		}
		
	}
	sqlite3_finalize(stmt);
	//insert into tmpdiary(id,content) select data ,content from diary
	return NO;
	
}





+ (BOOL) addTable
{
	sqlite3 *db = [DataBase openDataBase];
	sqlite3_stmt *stmt;
	int result = sqlite3_prepare_v2(db,"create table mydiary (id INTEGER,data INTEGER,name VARCHAR)", -1, &stmt, NULL);
	if (result == SQLITE_OK) {
		NSLog(@"aaa");
		sqlite3_step(stmt);
		sqlite3_finalize(stmt);
		return YES;
	}

	return NO;
}
+ (BOOL) deleteTable
{
	sqlite3 *db = [DataBase openDataBase];
	sqlite3_stmt *stmt;
	int result = sqlite3_prepare_v2(db,"drop table mydiary", -1, &stmt, NULL);
	if (result == SQLITE_OK) {
		NSLog(@"aaa");
		sqlite3_step(stmt);
		sqlite3_finalize(stmt);
		return YES;
	}
	
	return NO;

}

+ (BOOL) alertTable
{
	sqlite3 *db = [DataBase openDataBase];
	sqlite3_stmt *stmt;
	int result = sqlite3_prepare_v2(db,"alter table mydiary add column type INTEGER", -1, &stmt, NULL);
	if (result == SQLITE_OK) {
		NSLog(@"aaa");
		sqlite3_step(stmt);
		sqlite3_finalize(stmt);
		return YES;
	}
	
	return NO;
}

+ (BOOL) renameColumn
{
	sqlite3 *db = [DataBase openDataBase];
	sqlite3_stmt *stmt;
	int result = sqlite3_prepare_v2(db,"alter table hello rename to mydiary", -1, &stmt, NULL);
	if (result == SQLITE_OK) {
		NSLog(@"aaa");
		sqlite3_step(stmt);
		sqlite3_finalize(stmt);
		return YES;
	}
	
	return NO;

}


+ (NSMutableArray *) getAllNotes {


	sqlite3 *db = [DataBase openDataBase];
	sqlite3_stmt *stmt;
	int result = sqlite3_prepare_v2(db,"select * from diary order by id asc", -1, &stmt, NULL);
	if (result == SQLITE_OK) {
		
        NSMutableArray *arrAllNotes = [[NSMutableArray alloc] init];
		while (SQLITE_ROW == sqlite3_step(stmt)) {
			int id_db = sqlite3_column_int(stmt,0);
            const unsigned char *title_db = sqlite3_column_text(stmt, 1);
            const unsigned char *time_db = sqlite3_column_text(stmt, 2);
            const unsigned char *content_db = sqlite3_column_text(stmt, 3);

			Notes *curNotes = [[Notes alloc] init];
            
            curNotes.id_notes = id_db;
            curNotes.title_notes = [NSString stringWithUTF8String:(const char *)title_db];
            curNotes.time_notes = [NSString stringWithUTF8String:(const char *)time_db];
            curNotes.content_notes = [NSString stringWithUTF8String:(const char *)content_db];

			[arrAllNotes addObject:curNotes];
		}
		sqlite3_finalize(stmt);
		return arrAllNotes;
	}
	else {
		NSLog(@"get EventTypeList failed with code:%d",result);
	}
	sqlite3_finalize(stmt);
	return [NSMutableArray array];
}

+ (NSInteger) getFirstDiaryDate
{
	sqlite3 *db = [DataBase openDataBase];
	sqlite3_stmt *stmt;
	int ID;
	int result = sqlite3_prepare_v2(db,"select id from diary order by id asc limit 1", -1, &stmt, NULL);
	if (result == SQLITE_OK) {
		if (SQLITE_ROW == sqlite3_step(stmt)) {
			ID= sqlite3_column_int(stmt,0);
			}
		sqlite3_finalize(stmt);
		return ID;
	}

	sqlite3_finalize(stmt);
	return ID;
	
}
+ (NSInteger) getLastDiaryDate
{
	sqlite3 *db = [DataBase openDataBase];
	sqlite3_stmt *stmt;
	int ID;
	int result = sqlite3_prepare_v2(db,"select id from diary order by id desc limit 1", -1, &stmt, NULL);
	if (result == SQLITE_OK) {
		if (SQLITE_ROW == sqlite3_step(stmt)) {
			ID= sqlite3_column_int(stmt,0);
		}
		sqlite3_finalize(stmt);
		return ID;
	}
	
	sqlite3_finalize(stmt);
	return ID;
	
}

+ (Notes *) getNotes:(NSInteger ) ID
{
	
	sqlite3 *db = [DataBase openDataBase];
	sqlite3_stmt *stmt;
	int result = sqlite3_prepare_v2(db,"select * from diary where id= ?", -1, &stmt, NULL);
	sqlite3_bind_int(stmt, 1, ID);
	if (result == SQLITE_OK) {
		Notes *curNotes = [[Notes alloc] init];
		if (SQLITE_ROW == sqlite3_step(stmt)) {
			int id_db = sqlite3_column_int(stmt,0);
            const unsigned char *title_db = sqlite3_column_text(stmt, 1);
            const unsigned char *time_db = sqlite3_column_text(stmt, 2);
            const unsigned char *content_db = sqlite3_column_text(stmt, 3);
            
			Notes *curNotes = [[Notes alloc] init];
            curNotes.id_notes = id_db;
            curNotes.title_notes = [NSString stringWithUTF8String:(const char *)title_db];
            curNotes.time_notes = [NSString stringWithUTF8String:(const char *)time_db];
            curNotes.content_notes = [NSString stringWithUTF8String:(const char *)content_db];
			
		}
		sqlite3_finalize(stmt);
		return curNotes;
	}
	else {
		NSLog(@"get EventTypeList failed with code:%d",result);
	}
	sqlite3_finalize(stmt);
	return nil;
	
}


+ (BOOL) deleteDiary:(NSInteger) ID
{
	sqlite3 *db = [DataBase openDataBase];
	sqlite3_stmt *stmt;
	sqlite3_prepare_v2(db,"delete from diary where id = ?", -1, &stmt, NULL);
	sqlite3_bind_int(stmt, 1, ID);
	int result = sqlite3_step(stmt);
	sqlite3_finalize(stmt);
	return result;
}

+ (NSMutableArray *) getDiarysfrom:(NSInteger) startDate to: (NSInteger) endDate
{
	sqlite3 *db = [DataBase openDataBase];
	sqlite3_stmt *stmt;
	int result = sqlite3_prepare_v2(db,"select * from diary where id >= ? and id < ? order by id asc", -1, &stmt, NULL);
	sqlite3_bind_int(stmt, 1, startDate);
	sqlite3_bind_int(stmt, 2, endDate);
	
	if (result == SQLITE_OK) {
		NSMutableArray *arrAllNotes = [[NSMutableArray alloc] init];
        
		while (SQLITE_ROW == sqlite3_step(stmt)) {
			int id_db = sqlite3_column_int(stmt,0);
            const unsigned char *title_db = sqlite3_column_text(stmt, 1);
            const unsigned char *time_db = sqlite3_column_text(stmt, 2);
            const unsigned char *content_db = sqlite3_column_text(stmt, 3);
            
			Notes *curNotes = [[Notes alloc] init];
            
            curNotes.id_notes = id_db;
            curNotes.title_notes = [NSString stringWithUTF8String:(const char *)title_db];
            curNotes.time_notes = [NSString stringWithUTF8String:(const char *)time_db];
            curNotes.content_notes = [NSString stringWithUTF8String:(const char *)content_db];
			[arrAllNotes addObject:curNotes];
		}
		sqlite3_finalize(stmt);
		return arrAllNotes;
	}
	else {
		NSLog(@"get EventTypeList failed with code:%d",result);
	}
	sqlite3_finalize(stmt);
	return [NSMutableArray array];
}

+ (BOOL) deleteDiarysfrom:(NSInteger) startDate to: (NSInteger) endDate
{
	
	sqlite3 *db = [DataBase openDataBase];
	sqlite3_stmt *stmt;
	sqlite3_prepare_v2(db,"delete from diary where id >= ? and id < ?", -1, &stmt, NULL);
	sqlite3_bind_int(stmt, 1, startDate);
	sqlite3_bind_int(stmt, 2, endDate);
	int result = sqlite3_step(stmt);
	sqlite3_finalize(stmt);
	return result;
	
	
}

+ (NSInteger) getDiaryCountfrom:(NSInteger) startDate to: (NSInteger) endDate
{
	sqlite3 *db = [DataBase openDataBase];
	sqlite3_stmt *stmt;
	int result = sqlite3_prepare_v2(db,"select count(id) from diary where id >= ? and id <= ?", -1, &stmt, NULL);
	sqlite3_bind_int(stmt, 1, startDate);
	sqlite3_bind_int(stmt, 2, endDate);
	if (result == SQLITE_OK) {
		if(SQLITE_ROW == sqlite3_step(stmt))
		{
			int number = sqlite3_column_int(stmt,0);
			sqlite3_finalize(stmt);
			return number;
		}else
		{
			sqlite3_finalize(stmt);
			return 0;
		}
		
		
	}
	sqlite3_finalize(stmt);
	return 0;
}



+ (BOOL) insertIntoDiarywithID:(NSInteger ) ID withType:(NSInteger ) type withMdType:(NSInteger ) mdtype withWeather:(NSInteger) weather 
					  withFont:(NSString *) font withBG:(NSInteger)bgID withContent:(NSString *) content
{
	sqlite3 *db = [DataBase openDataBase];
	sqlite3_stmt *stmt;
	int result = sqlite3_prepare_v2(db,"insert into diary(id,type,mdtype,weather,font,background,content) values(?,?,?,?,?,?,?)", -1, &stmt, NULL);
	sqlite3_bind_int(stmt, 1, ID);
	sqlite3_bind_int(stmt, 2, type);
	sqlite3_bind_int(stmt, 3, mdtype);
	sqlite3_bind_int(stmt, 4, weather);
	sqlite3_bind_text(stmt, 5, [font UTF8String],-1,NULL);
	sqlite3_bind_int(stmt, 6, bgID);
	sqlite3_bind_text(stmt, 7, [content UTF8String],-1,NULL);
	if (result == SQLITE_OK) {
	sqlite3_step(stmt);	
	
	}

	
	sqlite3_finalize(stmt);
	return result;
	
}

+ (BOOL) updateDiaryWithID:(NSInteger)ID withID:(NSInteger)newID
{
	sqlite3 *db = [DataBase openDataBase];
	sqlite3_stmt *stmt;
	sqlite3_prepare_v2(db,"update diary set ID=? where ID=?", -1, &stmt, NULL);
	sqlite3_bind_int(stmt, 1, newID);
	sqlite3_bind_int(stmt, 2, ID);
	
	int result = sqlite3_step(stmt);
	sqlite3_finalize(stmt);
	return result;
}

+ (BOOL) updateDiaryWithID:(NSInteger ) ID withType:(NSInteger) type
{
	sqlite3 *db = [DataBase openDataBase];
	sqlite3_stmt *stmt;
	sqlite3_prepare_v2(db,"update diary set type=? where ID=?", -1, &stmt, NULL);
	sqlite3_bind_int(stmt, 1, type);
	sqlite3_bind_int(stmt, 2, ID);

	int result = sqlite3_step(stmt);
	sqlite3_finalize(stmt);
	return result;
	
}

+ (BOOL) updateDiaryWithID:(NSInteger ) ID withMdType:(NSInteger) mdtype
{
	sqlite3 *db = [DataBase openDataBase];
	sqlite3_stmt *stmt;
	sqlite3_prepare_v2(db,"update diary set mdtype=? where ID=?", -1, &stmt, NULL);
	sqlite3_bind_int(stmt, 1, mdtype);
	sqlite3_bind_int(stmt, 2, ID);
	
	int result = sqlite3_step(stmt);
	sqlite3_finalize(stmt);
	return result;
	
}

+ (BOOL) updateDiaryWithID:(NSInteger ) ID withWeather:(NSInteger) weather
{
	sqlite3 *db = [DataBase openDataBase];
	sqlite3_stmt *stmt;
	sqlite3_prepare_v2(db,"update diary set weather=? where ID=?", -1, &stmt, NULL);
	sqlite3_bind_int(stmt, 1, weather);
	sqlite3_bind_int(stmt, 2, ID);
	
	int result = sqlite3_step(stmt);
	sqlite3_finalize(stmt);
	return result;
	
}

+ (BOOL) updateDiaryWithID:(NSInteger ) ID withFont:(NSString *) font
{
	sqlite3 *db = [DataBase openDataBase];
	sqlite3_stmt *stmt;
	sqlite3_prepare_v2(db,"update diary set font=? where ID=?", -1, &stmt, NULL);
	sqlite3_bind_text(stmt, 1, [font UTF8String],-1,NULL);
	sqlite3_bind_int(stmt, 2, ID);
	
	int result = sqlite3_step(stmt);
	sqlite3_finalize(stmt);
	return result;
	
}

+ (BOOL) updateDiaryWithID:(NSInteger ) ID withBG:(NSInteger) bgID
{
	sqlite3 *db = [DataBase openDataBase];
	sqlite3_stmt *stmt;
	sqlite3_prepare_v2(db,"update diary set background=? where ID=?", -1, &stmt, NULL);
	sqlite3_bind_int(stmt, 1, bgID);
	sqlite3_bind_int(stmt, 2, ID);
	
	int result = sqlite3_step(stmt);
	sqlite3_finalize(stmt);
	return result;
	
}


+ (BOOL) updateDiaryWithID:(NSInteger ) ID withContent:(NSString *) content
{
	sqlite3 *db = [DataBase openDataBase];
	sqlite3_stmt *stmt;
	sqlite3_prepare_v2(db,"update diary set content=? where ID=?", -1, &stmt, NULL);
	sqlite3_bind_text(stmt, 1, [content UTF8String],-1,NULL);
	sqlite3_bind_int(stmt, 2, ID);
	
	int result = sqlite3_step(stmt);
	sqlite3_finalize(stmt);
	return result;
	
}



@end

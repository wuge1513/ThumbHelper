//
//  AddClockViewCell.m
//  GeiniableClock
//
//  Created by yuan jun on 11-8-5.
//  Copyright 2011 the9. All rights reserved.
//

#import "AddClockViewCell.h"
#import "AlarmViewController.h"


@implementation AddClockViewCell

@synthesize alarmViewController;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code.
    }
    return self;
}

- (void)setEditing:(BOOL)editing animated:(BOOL)animated {
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state.
}
- (IBAction)addClockBtn:(UIButton *)sender
{
	[self setSelected:YES animated:YES];
	[self.alarmViewController showAddClockView:nil];
}



@end

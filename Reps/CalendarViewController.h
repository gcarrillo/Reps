//
//  CalendarViewController.h
//  Reps
//
//  Created by Gabriel Carrillo on 12/29/15.
//  Copyright © 2015 Gabriel Carrillo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RSDFDatePickerView.h"

@interface CalendarViewController : UIViewController <RSDFDatePickerViewDelegate, RSDFDatePickerViewDataSource>

//@property (strong, nonatomic) IBOutlet UIView *calendarView;
@property (strong, nonatomic) IBOutlet RSDFDatePickerView *datePickerView;

@end

//
//  CalendarViewController.m
//  Reps
//
//  Created by Gabriel Carrillo on 12/29/15.
//  Copyright © 2015 Gabriel Carrillo. All rights reserved.
//

#import "CalendarViewController.h"
#import "RSDFDatePickerView.h"

@interface CalendarViewController ()

@end

@implementation CalendarViewController

- (IBAction)todayButtonTapped:(id)sender {
    [self.datePickerView scrollToToday:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.datePickerView.delegate = self;
    self.datePickerView.dataSource = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - RSDFDatePickerViewDelegate

// Returns YES if the date should be highlighted or NO if it should not.
- (BOOL)datePickerView:(RSDFDatePickerView *)view shouldHighlightDate:(NSDate *)date
{
    return YES;
}

// Returns YES if the date should be selected or NO if it should not.
- (BOOL)datePickerView:(RSDFDatePickerView *)view shouldSelectDate:(NSDate *)date
{
    return YES;
}

// Prints out the selected date.
- (void)datePickerView:(RSDFDatePickerView *)view didSelectDate:(NSDate *)date
{
    NSLog(@"%@", [date description]);
}

#pragma mark - RSDFDatePickerViewDataSource

// Returns YES if the date should be marked or NO if it should not.
- (BOOL)datePickerView:(RSDFDatePickerView *)view shouldMarkDate:(NSDate *)date
{
    //NSLog(@"In datePickerView:shouldMarkDate");
    
    if (arc4random() % 2 == 0) {
        return YES;
    } else {
        return NO;
    }
}

// Returns the color of the default mark image for the specified date.
- (UIColor *)datePickerView:(RSDFDatePickerView *)view markImageColorForDate:(NSDate *)date
{
    NSLog(@"In datePickerView:markImageColorForDate");
    if (arc4random() % 2 == 0) {
        return [UIColor grayColor];
    } else {
        return [UIColor greenColor];
    }
}

// Returns the mark image for the specified date.
//- (UIImage *)datePickerView:(RSDFDatePickerView *)view markImageForDate:(NSDate *)date
//{
//    if (arc4random() % 2 == 0) {
//        return [UIImage imageNamed:@"img_gray_mark"];
//    } else {
//        return [UIImage imageNamed:@"img_green_mark"];
//    }
//}

@end

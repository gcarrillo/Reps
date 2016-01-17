//
//  AddSetViewController.h
//  Reps
//
//  Created by Gabriel Carrillo on 1/16/16.
//  Copyright © 2016 Gabriel Carrillo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ExerciseTableViewController.h"

@class Exercise;

@interface AddSetViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, UIPickerViewDelegate, UIPickerViewDataSource, ExerciseTableViewControllerProtocol>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIPickerView *pickerView;
@property (weak, nonatomic) IBOutlet UIDatePicker *datePickerView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *pickerViewConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *datePickerViewConstraint;

@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (strong, nonatomic) NSArray *exercises;
@property (strong, nonatomic) Exercise *selectedExercise;
@property (nonatomic, retain) NSNumber *selectedReps;
@property (nonatomic, retain) NSNumber *selectedWeight;
@property (nonatomic, retain) NSDate *selectedDate;

- (IBAction)datePickerDidSelectDate:(id)sender;
- (IBAction)saveButtonTapped:(id)sender;

@end

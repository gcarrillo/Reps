//
//  CalendarViewController.h
//  Reps
//
//  Created by Gabriel Carrillo on 12/29/15.
//  Copyright © 2015 Gabriel Carrillo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/Coredata.h>
#import "RSDFDatePickerView.h"

@interface CalendarViewController : UIViewController <RSDFDatePickerViewDelegate, RSDFDatePickerViewDataSource, UITableViewDataSource, UITableViewDelegate, NSFetchedResultsControllerDelegate>

@property (strong, nonatomic) IBOutlet RSDFDatePickerView *datePickerView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;

@end

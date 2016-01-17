//
//  ExerciseTableViewController.h
//  Reps
//
//  Created by Gabriel Carrillo on 12/20/15.
//  Copyright © 2015 Gabriel Carrillo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/Coredata.h>

@class ExerciseTableViewController;
@class Exercise;

@protocol ExerciseTableViewControllerProtocol <NSObject>

- (void)exerciseTableViewController:(ExerciseTableViewController *)vc didChooseExercise:(Exercise *)exercise;
- (void)exerciseTableViewControllerDidCancel:(ExerciseTableViewController *)vc;

@end

@interface ExerciseTableViewController : UITableViewController <NSFetchedResultsControllerDelegate>

@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (weak, nonatomic) id <ExerciseTableViewControllerProtocol> delegate;

- (IBAction)cancelButtonTapped:(id)sender;

@end


//
//  Set+CoreDataProperties.h
//  Reps
//
//  Created by Gabriel Carrillo on 12/20/15.
//  Copyright © 2015 Gabriel Carrillo. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Set.h"

NS_ASSUME_NONNULL_BEGIN

@interface Set (CoreDataProperties)

@property (nullable, nonatomic, retain) NSDate *date;
@property (nullable, nonatomic, retain) NSNumber *reps;
@property (nullable, nonatomic, retain) NSNumber *weight;
@property (nullable, nonatomic, retain) Exercise *exercise;

@end

NS_ASSUME_NONNULL_END

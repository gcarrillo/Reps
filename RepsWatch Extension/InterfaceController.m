//
//  InterfaceController.m
//  RepsWatch Extension
//
//  Created by Gabriel Carrillo on 12/25/15.
//  Copyright © 2015 Gabriel Carrillo. All rights reserved.
//

#import "InterfaceController.h"

@interface InterfaceController()

@end


@implementation InterfaceController {
    BOOL dateLabelIsHidden;
}

- (void)awakeWithContext:(id)context {
    [super awakeWithContext:context];

    // Configure interface objects here.
}

- (void)willActivate {
    // This method is called when watch view controller is about to be visible to user
    [super willActivate];
    
    if ([WCSession isSupported]) {
        WCSession *session = [WCSession defaultSession];
        session.delegate = self;
        [session activateSession];
    }
}

- (void)didDeactivate {
    // This method is called when watch view controller is no longer visible
    [super didDeactivate];
}

@end




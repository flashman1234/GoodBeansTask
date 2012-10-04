//
//  SelectedPersonViewController.h
//  GoodBeansTask
//
//  Created by Michal Thompson on 10/4/12.
//  Copyright (c) 2012 Michal Thompson. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Person.h"

@interface SelectedPersonViewController : UIViewController
{
    IBOutlet UILabel *nameLabel;
    IBOutlet UILabel *beanTypeLabel;
}

@property ( nonatomic , retain ) Person *thePerson;
@property (nonatomic, strong) NSManagedObjectContext* managedObjectContext;

-(IBAction)closeViewController;
-(id)initWithManagedObjectContext:(NSManagedObjectContext *)moc;

@end

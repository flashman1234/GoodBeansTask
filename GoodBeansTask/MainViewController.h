//
//  MainViewController.h
//  GoodBeansTask
//
//  Created by Michal Thompson on 10/4/12.
//  Copyright (c) 2012 Michal Thompson. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainViewController : UIViewController<UITextFieldDelegate>
{
    IBOutlet UILabel *saveLabel;
    UITextField *editingField;
}

@property ( nonatomic , retain ) IBOutlet UITextField *nameTextField;
@property ( nonatomic , retain ) IBOutlet UITextField *beanTypeTextField;
@property (nonatomic, strong) NSManagedObjectContext* managedObjectContext;


-(IBAction)showInfo;
-(IBAction)showPersonlist;
-(IBAction)savePerson;

@end

//
//  PersonListViewController.h
//  GoodBeansTask
//
//  Created by Michal Thompson on 10/4/12.
//  Copyright (c) 2012 Michal Thompson. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PersonListViewController : UIViewController<UITableViewDelegate, UITableViewDataSource>{
    
    IBOutlet UITableView *personTableView;
}

@property (nonatomic, strong) NSManagedObjectContext* managedObjectContext;
@property (nonatomic, retain) NSArray *personArray;
@property (nonatomic, retain) UITableView *personTableView;

@property (nonatomic, retain) NSString *existingPerson;

-(id)initWithManagedObjectContext:(NSManagedObjectContext *)moc;




@end

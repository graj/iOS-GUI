//
//  ADVApartmentListViewController.h
//  apartmentshare
//
//  Created by Tope Abayomi on 22/01/2013.
//  Copyright (c) 2013 App Design Vault. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface ADVApartmentListViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>


@property (nonatomic, weak) IBOutlet UITableView *apartmentTableView;

-(IBAction)uploadPressed:(id)sender;
-(IBAction)loginLogoutPressed:(id)sender;

@end

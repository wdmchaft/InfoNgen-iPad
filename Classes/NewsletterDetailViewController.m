    //
//  NewsletterDetailViewController.m
//  Untitled
//
//  Created by Robert Stewart on 2/22/10.
//  Copyright 2010 InfoNgen. All rights reserved.
//

#import "NewsletterDetailViewController.h"
#import "EditableTableCell.h"
#import "Page.h"
#import "SegmentedTableCell.h"

@implementation NewsletterDetailViewController
@synthesize settingsTable,page;

// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
	return YES;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
	return 3;
}

- (void) switched
{
	UIAlertView * a=[[UIAlertView alloc] initWithTitle:@"Switched" message:@"Yep" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
	
	[a show];
	
	[a release];
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
	self.page.name=textField.text;
}

- (void) publishTypeChanged:(id)sender{
	UISegmentedControl *segmentedControl = (UISegmentedControl *)sender;
	
	self.page.publishType=[segmentedControl titleForSegmentAtIndex:[segmentedControl selectedSegmentIndex]];
}

- (void) emailFormatChanged:(id)sender{
	UISegmentedControl *segmentedControl = (UISegmentedControl *)sender;
	
	self.page.emailFormat=[segmentedControl titleForSegmentAtIndex:[segmentedControl selectedSegmentIndex]];
}

- (void) rssEnabledChanged:(id)sender
{
	UISwitch * s=(UISwitch*)sender;
	
	self.page.rssEnabled=s.isOn;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	UITableViewCell *cell;
    
	switch (indexPath.section) {
		
		case kTitleSection:
			{
				switch (indexPath.row) {
					case kTitleRow:
					{
						EditableTableCell * textFormCell=[[[EditableTableCell alloc] initWithStyle:UITableViewCellStyleDefault  reuseIdentifier:nil] autorelease];
						
						textFormCell.textField.text=self.page.name;
						textFormCell.textField.delegate=self;
						cell=textFormCell;
					}
					break;
				}
			}
			break;
		
		case kLogoImageSection:
			{
				switch (indexPath.row) {
				 
					case kLogoImageRow:
					{
						cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault  reuseIdentifier:nil] autorelease];
						cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
						cell.textLabel.text = @"Logo Image";
					}
					
				}
			}
			break;
			
		case kPublishingSection:
			{
				switch (indexPath.row) {
					 
					case kRssEnabledRow:
						{
							cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil] autorelease];
							UISwitch *mySwitch = [[UISwitch alloc] initWithFrame:CGRectZero];
							
							[mySwitch setOn:self.page.rssEnabled animated:NO];
							
							[cell addSubview:mySwitch];
							cell.accessoryView = mySwitch;
							
							[(UISwitch *)cell.accessoryView addTarget:self action:@selector(rssEnabledChanged:)
													 forControlEvents:UIControlEventValueChanged];
							
							
							[mySwitch release];
							cell.textLabel.text = @"RSS Output";
						}
						break;
						
					case kEmailFormatRow:
						{
							SegmentedTableCell * segmentedCell=[[SegmentedTableCell alloc] initWithStyle:UITableViewCellStyleDefault
																						 reuseIdentifier:nil buttonNames:[NSArray arrayWithObjects:@"HTML", @"PDF", nil]];
							
							if([self.page.emailFormat isEqualToString:@"PDF"])
							{
								segmentedCell.segmentedControl.selectedSegmentIndex=1;
							}
							else
							{
								segmentedCell.segmentedControl.selectedSegmentIndex=0;
							}
							
							[segmentedCell.segmentedControl addTarget:self action:@selector(emailFormatChanged:) forControlEvents:UIControlEventValueChanged];
							
							cell=segmentedCell;
							cell.textLabel.text=@"Email Format";
						}
						break;
					
					case kScheduleTypeRow:
						{
							SegmentedTableCell * segmentedCell=[[SegmentedTableCell alloc] initWithStyle:UITableViewCellStyleDefault
																						 reuseIdentifier:nil buttonNames:[NSArray arrayWithObjects:@"Preview", @"Publish", nil]];
							
							if([self.page.publishType isEqualToString:@"Publish"])
							{
								segmentedCell.segmentedControl.selectedSegmentIndex=1;
							}
							else
							{
								segmentedCell.segmentedControl.selectedSegmentIndex=0;
							}
							
							[segmentedCell.segmentedControl addTarget:self action:@selector(publishTypeChanged:) forControlEvents:UIControlEventValueChanged];
							
							cell=segmentedCell;
							cell.textLabel.text=@"Publish Type";
						}
						break;
						
					case kScheduleRow:
						{
							cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault  reuseIdentifier:nil] autorelease];
							cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;	
							cell.textLabel.text = @"Schedule";
						}
						break;
					
					case kSubscribersRow:
						{
							cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault  reuseIdentifier:nil] autorelease];
							cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;	
							cell.textLabel.text = @"Subscribers";
						}
						break;
				
				}
			}
	}
	
	return cell;
	
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	switch (section) {
		case kTitleSection:
			return 1;
		case kLogoImageSection:
			return 1;
		case kPublishingSection:
			return 5;
	}
	return 0;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
	switch (section) 
	{
		case kTitleSection:
			return @"Title";
		case kLogoImageSection:
			return @"Logo Image";
		case kPublishingSection:
			return @"Publishing Settings";
	}
	return nil;
}

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
	[settingsTable release];
	[page release];
    [super dealloc];
}


@end
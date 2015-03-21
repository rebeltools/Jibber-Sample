//
//  ViewController.m
//  Jibber Sample
//
//  Created by Matthew Cheok on 22/3/15.
//  Copyright (c) 2015 Team Rebel. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (nonatomic, strong) NSArray *items;

@end

@implementation ViewController

- (IBAction)loadItems:(id)sender {
	NSURLSessionDataTask *task = [[NSURLSession sharedSession] dataTaskWithURL:[NSURL URLWithString:@"https://www.nsscreencast.com/api/episodes.json"] completionHandler: ^(NSData *data, NSURLResponse *response, NSError *error) {
	    NSArray *items = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
	    self.items = items;

	    dispatch_async(dispatch_get_main_queue(), ^{
			[self.tableView reloadData];
		});
	}];
	[task resume];
}

- (void)viewDidLoad {
	[super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.

	[self loadItems:self];
}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return self.items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	NSDictionary *item = self.items[indexPath.row];

	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
	cell.textLabel.text = item[@"episode"][@"title"];
	cell.detailTextLabel.text = item[@"episode"][@"description"];
	return cell;
}

@end

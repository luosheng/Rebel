//
//  NSWindow+RBLKeyWindowAdditions.h
//  Rebel
//
//  Created by Luo Sheng on 12-10-24.
//  Copyright (c) 2012 GitHub. All rights reserved.
//

#import <Cocoa/Cocoa.h>

// Since we allow the `RBLPopover`'s backing window become key to work around
// mouseMoved events, the main window will resign its key state when the popover
// is presented. We need to do some tricks to make the main window consider
// itself to be key when it has a popover attached in the active application,
// regardless of what its actual key state is.
@interface NSWindow (RBLKeyWindowAdditions)

@end

#import "Cocoa/Cocoa.h"
#import "CoreObject/CoreObject.h"
#import "CoreObject/COUndoTrack.h"
#import "CoreObject/COAttributedStringWrapper.h"

@interface SDEditor : NSWindowController <NSTextViewDelegate>
@property (strong, readonly) COEditingContext *context;

- (instancetype)initWithPath:(NSString *)path;
- (COBranch *)branch;
@end


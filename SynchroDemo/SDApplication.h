#import "Cocoa/Cocoa.h"
#import "CoreObject/COSynchronizerJSONClient.h"  // Won't compile unless these two headers are imported.  That needs to be fixed.
#import "CoreObject/COSynchronizerJSONServer.h"
#import "CoreObject/COSynchronizerClient.h"
#import "CoreObject/COSynchronizerServer.h"

#import "SDEditor.h"

@interface SDApplication : NSObject <NSApplicationDelegate, COSynchronizerServerDelegate, COSynchronizerClientDelegate>
@end

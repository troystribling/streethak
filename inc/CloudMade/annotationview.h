#import "RMMarker+CMAnnotationView.h"

- (void) tapOnMarker: (RMMarker*) marker 
{
 NSString* poiName = poi.name?poi.name:poi.synthesizedName;
 [marker addAnnotationViewWithTitle:poiName];
}
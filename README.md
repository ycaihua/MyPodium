# MyPodium
iOS Application for creating tournaments, leagues and other events with custom stat tracking.

This is a re-creation of the MyPodium Application. The previous attempt had a completed login and registration system and implemented a few things after login, but it was remade for a few reasons:
- To implement UI completely programmatically (more control, cleaner split between view/controller for MVC)
- To make sure the .gitignore ignored sensitive information just as much as it needed to
- To organize files via xCode groups, not physical directories for consistency (files were a mess because some were in the correct physical directories while others were not, even though the xCode structure was in place)

MyPodium is an iPhone application created to help people organize all sorts of competitive events: it is intended to give anybody with common interests, be it video games, sports or other games, a way to host their events and observe a wealth of statistical information. It is also intended to be a source of practice, and therefore, I will attempt to implement everything I can in a clean, scalable way. I intend for this to be the last time I remake this project (a couple of which were due to amassing too much tech debt or messing up git somehow), so I will commit frequently. More information will be available as the project continues.

##Detailed description of recent changes
- (May 29, 2015) Changing structure of existing views as done in Spectrum app. Each view has a `makeControls` and a `makeControlConstraints` method. `makeControls` creates and stylizes each control with whitespace in between and adds each one to the view, and `makeControlConstraints` adds a large NSArray of NSLayoutConstraints to properly structure the view. This approach, instead of adding each control with its constraints one by one, has slightly less clutter, and, more importantly, is less prone to the error of adding constraints for items not yet added to the view. Naming needs to be different for MPMenuView in particular (`makeMenu` and `makeMenuConstraints`) so its subclass views don't override the same method.
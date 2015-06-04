# MyPodium
iOS Application for creating tournaments, leagues and other events with custom stat tracking.

##About the App
There exist several web and mobile apps out there that help the user create tournaments or leagues, with varying levels of flexibility. This is a service that can definitely be expanded on. MyPodium does so, first, by allowing the user to create "events," a term used to describe created tournaments, leagues, [ladders](http://en.wikipedia.org/wiki/Ladder_tournament) or individual matches. Second, all of those events are compatible with single-player competitors, or teams of players. Third, with the exception of tournaments, events can allow for more than two opponents in a free-for-all style, and, if that is the case, allow for more than one winner. Finally, and most importantly, once the user is done with the specification of the event, MyPodium uses game modes to allow the event to track statistics of the user's choice, and present a wealth of statistical information and charts about the event. This means the user can see in-depth information about their own poker league, tennis ladder, or video game tournament all in the same way.

##Terminology
- **Participant**: a competitor in an event. Can be either an individual player or a team of players.

- **Event**: a match, tournament, league or ladder.

- **Match**: a single competition with one or more winning participants and one or more losing participants.

- **Tournament**: a type of event where participants are paired in head-to-head matches, eliminating the loser from contention until an overall winner is declared.

- **League**: a type of event where participants are organized into matches over multiple rounds without elimination. The overall winner is declared based on final record.

- **Ladder**: a type of event where participants can organize their own matches according to their own schedule. Winners gain points on a ladder according to a formula. The event can be ended by the creator at any time, or at a fixed date, at which point the winner is the highest scorer. *The formula is a variant of the [elo system](http://en.wikipedia.org/wiki/Elo_rating_system), which in effect gives more points for a lower ranked participant beating a higher ranked one, and the converse.*

- **Mode**: a specification of what the event is for - possibly a sport, card, board, video game or something else entirely. Modes have an optional time limit per match, and an optional list of statistic names (all statistics are integers). 

##About the Development
This is a re-creation of the MyPodium Application. The previous attempt had a completed login and registration system and implemented a few things after login, but it was remade for a few reasons:
- To implement UI completely programmatically (more control, cleaner split between view/controller for MVC)
- To make sure the .gitignore ignored sensitive information just as much as it needed to
- To organize files via xCode groups, not physical directories for consistency (files were a mess because some were in the correct physical directories while others were not, even though the xCode structure was in place)

MyPodium is an iPhone application created to help people organize all sorts of competitive events: it is intended to give anybody with common interests, be it video games, sports or other games, a way to host their events and observe a wealth of statistical information. It is also intended to be a source of practice, and therefore, I will attempt to implement everything I can in a clean, scalable way. I intend for this to be the last time I remake this project (a couple of which were due to amassing too much tech debt or messing up git somehow), so I will commit frequently. More information will be available as the project continues.

##Detailed description of important changes/bugs
- (June 3, 2015) "Leak-through bug" resurfaced - initial solution causes a blank view to overlay on top of logged-out controller (so, the hacky solution didn't work). Found SO post on issue: http://stackoverflow.com/questions/26763020/leaking-views-when-changing-rootviewcontroller-inside-transitionwithview

- (June 2, 2015) Model classes: first class under "Model" group added today; `MPFriendsModel`. The structure of these classes will be entirely class (~static) methods for interacting with Parse DBs (methods will mostly be simple Parse predicate queries). Because most of these methods will return a value based on the query, they will be conducted synchronously, which means the caller (usually in a controller) will use grand central dispatch for asynchronous data retrieval. Each model class will have a `testMethods` function that is used to print useful information about the queries in NSLog (it may be useful later to move these into a proper assertion-based testing model, but that's for down the line).

- (May 31, 2015) "Leak-through bug": if the user had presented at least one view controller by clicking on a sidebar link, then logged out, the top portion of the menu (including the white-on-black status bar and SOME of the title text) would persist on top of the logo of the `MPLogInViewController` when logging out (and consequently using `delegate.window setRootViewController:`). Not related to the change adding an animation to changing root controller (occurs with and without animation). Fixed (hacky, but works), by presenting a blank `UIViewController` before setting the root controller.

- (May 31, 2015) About the issue of presenting and dismissing menuized view controllers: presenting and dismissing the controllers becomes more complicated when they're both contained within an `MMDrawerController`, as is the case when logged in (or, when the menu is present). The most lightweight solution is getting the container and calling `container setCenterViewController:`, but that will not produce any usable controller stack, which means losing the functionality of some sort of "back button" (way to go to previous controller). Instead, the approach taken was to construct a new `MMDrawerController` with a different center controller (using a class method `AppDelegate makeDrawerWithCenterController:`), and presenting/dismissing them in the traditional way. If these drawers take up too much overhead, this approach may need to be changed.

- (May 29, 2015) Changing structure of existing views as done in Spectrum app. Each view has a `makeControls` and a `makeControlConstraints` method. `makeControls` creates and stylizes each control with whitespace in between and adds each one to the view, and `makeControlConstraints` adds a large NSArray of NSLayoutConstraints to properly structure the view. This approach, instead of adding each control with its constraints one by one, has slightly less clutter, and, more importantly, is less prone to the error of adding constraints for items not yet added to the view. Naming needs to be different for MPMenuView in particular (`makeMenu` and `makeMenuConstraints`) so its subclass views don't override the same method.

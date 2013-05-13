WUSTAC - WebStac iPhone Application for Washington Universithy In St. Lous

Still in early alpha, and it's without graphics but they'll eventually get added in along with a classes interface.

If you want to contribute, just fork the application. I'm gonna keep this open source.

4 tab application:

1st deals with balances (campus card, food)
2nd deals with housing (campus box, res college, mailbox combo)
3rd deals with classes (campus map, classes during current semester)
4th is credits, and includes a refresh button

These viewcontrollers (of type DCViewController) are subscribed to a dispatcherSingleton (following the singleton and scubscriber patterns). In general:

View controller loads, sets up methods for a NSNotificationCenter to call when the dispatcherSingleton recieves data from the website. 
The View Controller then calls a method on the dispatcherDispatcher to fetch the data that it needs to render the view. 
DispatcerSingleton sends out an asyncronous http request. 
DispatcherSingleton recieves a response and notifies the view controller via a NSNotificationCenter
NSNotificationCenter calls the appropriate method when the data is revieved.
The method invokes parser static methods which takes in a regex (defined in the class), a label (connected to the storyboad), adjustment values, and the data revieved to set the label.
Text gets set in the view from the output of the parser. 
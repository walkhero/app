import Foundation

enum Copy {
    static let notifications = """
We use notifications to display important messages and provide feedback to your actions, and only when you are actively using the app.

We will never send you Push Notifications.

Your privacy is respected at all times.
"""
    
    static let deactivate = """
Notifications are activated
"""
    
    static let location = """
This app will never access your location, but may ask you to grant access if a website is requesting it, useful when using maps, otherwise is not really necessary.

You can always change this permission on Settings.
"""
    
    static let policy = """
This app is **not** tracking you in anyway, nor sharing any information from you with no one, we are also not storing any data concerning you.

We make use of Apple's *iCloud* to synchronise your data across your own devices, but no one other than you, not us nor even Apple can access your data.

If you allow **notifications** these are going to be displayed only for giving feedback on actions you take while using the app, we **don't** want to contact you in anyway and specifically we **don't** want to send you **Push Notifications**.

Whatever you do with this app is up to you and we **don't** want to know about it.
"""
    
    static let noPurchases = """
No In-App Purchases available at the moment, try again later.
"""
    
    static let froob = """
By purchasing _Privacy +_ you support research and development at _Privacy Inc_ and for *Privacy Browser*.

_Privacy +_ is an In-App Purchase, it is non-consumable, meaning it is a **1 time only** purchase and you can use it both on iOS and macOS.
"""
}

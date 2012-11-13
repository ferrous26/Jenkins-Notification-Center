#
#  AppDelegate.rb
#  Jenkins Notifier
#
#  Created by Mark Rada on 2012-11-13.
#  Copyright 2012 ferrous26. All rights reserved.
#

class AppDelegate
    def applicationDidFinishLaunching(a_notification)
        @listener = NotificationServer.new
        @listener.listen
    end
    
    def applicationWillTerminate aNotification
        @listener.cleanup
        end
end


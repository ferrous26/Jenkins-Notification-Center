#
#  NotificationCenter.rb
#  Jenkins Notifier
#
#  Created by Mark Rada on 2012-11-13.
#  Copyright 2012 ferrous26. All rights reserved.
#

require 'socket'
require 'json'

class NotificationServer
    
    def initialize
        @socket = TCPServer.new 9191
        
        @center = NSUserNotificationCenter.defaultUserNotificationCenter
        @center.delegate = self
        
        @notif_q = Dispatch::Queue.new 'com.ferrous26.notif_q'
        @notifs  = []
    end
    
    ##
    # Listen for an incoming connection. When the connection in received it will be
    # handled (formatted and sent to the notification center).
    #
    # Only a single connection will be handled, you must call this over again to
    # handle another connection.
    def listen
        @notif_q.async do
            client = @socket.accept
            record = JSON.parse client.read
            client.close
            
            notif = format_notification_with record
            
            @center.deliverNotification notif
            @notif_q.async do listen end
        end
    end
    
    
    private
    
    def format_notification_with record
        
        notif = NSUserNotification.alloc.init
        notif.title             = 'Jenkins'
        notif.subtitle          = "Build #{record['build']['number']} #{record['build']['phase']}"
        notif.informativeText   = record['build']['status'] if record['build'].has_key? 'status'
        
        # @todo this seems to have no effect. why?
        notif.hasActionButton   = true
        notif.actionButtonTitle = 'Details'
   
        notif
end
    
    ##
    # Remove notifications that are more than 20 messages old. That is,
    # oldness is defined by how many messages are in the notification
    # center and not how long they have been there. This is up for debate
    # and can change in the future.
    def remove_old_notifications
        @notifs[20..-1].to_a.each do |notif|
            @center.removeDeliveredNotification notif
        end
    end
    
    def cleanup
        @center.removeAllDeliveredNotifications
    end
    
    
    # @group NSUserNotificationCenterDelegate methods
    
    def userNotificationCenter center, didDeliverNotification: notif
        @notifs << notif
        remove_old_notifications
    end
    
    def userNotificationCenter center, didActivateNotification: notif
        NSLog("pretend we just switched to a results view")
        # @todo switch to results detail view and display test results
    end
    
    def userNotificationCenter center, shouldPresentNotification: notif
        true # always try to show results...
    end
    
end

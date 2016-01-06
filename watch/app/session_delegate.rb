class SimpleSessionManager < NSObject

  attr_accessor :currentSession

  def initialize

    if WCSession.isSupported
      self.currentSession = WCSession.defaultSession
      self.currentSession.delegate = self
      self.currentSession.activateSession
      NSLog("Default WCSession initialized %@", self.currentSession);
    else
      NSLog("WCSession not supported");
    end

  end

  def sessionWatchStateDidChange(session)
    NSLog("WCSession changed #{session}")
  end

  def session(session, didReceiveApplicationContext: applicationContext)
    NSLog("WCSession received application context %@", applicationContext)
  end

  def session(session, didReceiveMessage: message, replyHandler: replyHandler)
    NSLog("WCSession received a message  w/handler %@", message)
  end

  def session(session, didReceiveMessage: message)
    NSLog("WCSession received a message %@", message)
  end

  def session(session, didReceiveMessageData: data)
    NSLog("WCSession received data %@", data)
  end

  def session(session, didReceiveMessageData: data, replyHandler: replyHandler)
    NSLog("WCSession received data w/reply %@", data)
  end

  def valid
    #TODO: Why doesn't self.currentSession.paired exist?
    # 2016-01-05 16:23:28.572 watch-connectivity WatchKit Extension[57243:4406588]
    # *** Terminating app due to uncaught exception 'NoMethodError', reason:
    # 'in `valid': undefined method `paired' for #<WCSession:0xcb13ae0> (NoMethodError)
    #if self.currentSession.paired && self.currentSession.watchAppInstalled
    #  true
    #else
    #  false
    #end
    true
  end

  def reachable
    if valid && self.currentSession.reachable
      true
    else
      false
    end
  end

end
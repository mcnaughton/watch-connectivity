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

  # Only call on application not watch
  def valid
    if self.currentSession.paired && self.currentSession.watchAppInstalled
      true
    else
      false
    end
    true
  end

  # Only call on application not watch
  def reachable
    if valid && self.currentSession.reachable
      true
    else
      false
    end
  end

end
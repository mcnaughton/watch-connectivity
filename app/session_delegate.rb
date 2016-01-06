class ApplicationSessionManager < NSObject

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

  def updateApplicationContext(obj, error: err)
    self.currentSession.updateApplicationContext(obj, error: err)
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
    if self.currentSession.isPaired && self.currentSession.isWatchAppInstalled
      true
    else
      false
    end
    true
  end

  def reachable
    if valid() && self.currentSession.isReachable
      true
    else
      false
    end
  end

end
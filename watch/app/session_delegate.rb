class WatchSessionManager < NSObject

  attr_accessor :currentSession, :callbacks

  def initialize

    self.currentSession = WCSession.defaultSession
    self.currentSession.delegate = self
    self.currentSession.activateSession

    self.callbacks = []

  end

  def listen(callback)
    self.callbacks << callback
  end

  def data(data, reply: replyHandler, error: errorHandler)
    NSLog("DATA %@", data)
    begin
      self.currentSession.sendMessageData(data, replyHandler: replyHandler, errorHandler: errorHandler)
    rescue
      NSLog("Bad data")
    end

  end

  def message(msg, reply: replyHandler, error: errorHandler)
    NSLog("MSG %@", msg)
    begin
      self.currentSession.sendMessage(msg, replyHandler: replyHandler, errorHandler: errorHandler)
    rescue
      NSLog("Bad msg")
    end
  end

  def sessionWatchStateDidChange(session)
    NSLog("WCSession changed #{session}")
  end

  def session(session, didReceiveApplicationContext: applicationContext)
    NSLog("WCSession received application context %@", applicationContext)
    self.callbacks.each {
      |cb|
        if cb.respond_to? 'call'
          cb.call(applicationContext)
        end
    }
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

end
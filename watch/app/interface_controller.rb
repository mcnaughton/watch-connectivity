class InterfaceController < WKInterfaceController

  extend IB

  attr_accessor :rowData, :session

  outlet :watchTable, WKInterfaceTable

  def awakeWithContext(context)
    super

    # Initialize variables here.
    # Configure interface objects here.
    NSLog("%@ awakeWithContext", self)

    self.session = WCSession.defaultSession
    self.session.activateSession

    self.rowData = [
        {
            "title" => "Google",
            "url" => "http://www.google.com"
        }
    ]
    len = self.rowData.count
    self.watchTable.setNumberOfRows(len, withRowType: "dummy")

    self.rowData.each_index { |index|
      data = self.rowData[index]
      row = self.watchTable.rowControllerAtIndex(index)
      if nil != row
        row.headline.text = data['title']
      end
    }

    self
  end

  def willActivate
    # This method is called when watch view controller is about to be visible to user
    NSLog("%@ will activate", self)
    super
  end

  def didDeactivate
    # This method is called when watch view controller is no longer visible
    NSLog("%@ did deactivate", self)
    super
  end

  def table(table, didSelectRowAtIndex: rowIndex)

    if nil != self.session && nil != self.session.receivedApplicationContext
      NSLog("Received application context #{self.session.receivedApplicationContext.inspect}")
    else
      NSLog("No application context #{self.session.receivedApplicationContext.inspect}")
    end

    msg = {"goUrl" => self.rowData[rowIndex]["url"]}
    NSLog("Sending msg %@", msg)
    begin
      replyHandler = Proc.new { |reply|
        NSLog("WatchConnectivity reply %@", reply)
      }
      errorHandler = Proc.new { |err|
        NSLog("WatchConnectivity err %@", err.localizedDescription)
      }
      self.session.sendMessageData(msg, replyHandler: replyHandler, errorHandler: errorHandler)
    rescue
      NSLog("WatchConnectivity caught err")
    end
    return true
  end

end

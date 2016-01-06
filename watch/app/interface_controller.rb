class InterfaceController < WKInterfaceController

  extend IB

  attr_accessor :rowData, :sharedSessionManager

  outlet :watchTable, WKInterfaceTable

  def awakeWithContext(context)
    super

    # Initialize variables here.
    # Configure interface objects here.
    NSLog("%@ awakeWithContext", self)

    self.sharedSessionManager = SimpleSessionManager.new

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

    if self.sharedSessionManager.reachable
      NSLog("No reachable watch device found")
    else

      msg = {"goUrl" => self.rowData[rowIndex]["url"]}
      NSLog("Sending msg %@", msg)

      begin
        replyHandler = Proc.new { |reply|
          NSLog("WatchConnectivity reply %@", reply)
        }
        errorHandler = Proc.new { |err|
          NSLog("WatchConnectivity err %@", err.localizedDescription)
        }
        self.sharedSessionManager.sendMessageData(msg, replyHandler: replyHandler, errorHandler: errorHandler)
      rescue
        NSLog("WatchConnectivity rescued")
      end

      true
    end

  end

end

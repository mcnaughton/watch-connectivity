class AppDelegate

  attr_accessor :currentSession

  def application(application, didFinishLaunchingWithOptions:launchOptions)
    rootViewController = UIViewController.alloc.init
    rootViewController.title = 'watch-connectivity'
    rootViewController.view.backgroundColor = UIColor.whiteColor

    navigationController = UINavigationController.alloc.initWithRootViewController(rootViewController)

    @window = UIWindow.alloc.initWithFrame(UIScreen.mainScreen.bounds)
    @window.rootViewController = navigationController
    @window.makeKeyAndVisible

    WCSession.defaultSession.delegate = self
    self.currentSession = WCSession.defaultSession
    self.currentSession.activateSession

    err = nil
    if self.currentSession.valid
      self.currentSession.updateApplicationContext([ {
          'url' => 'http://www.bing.com',
          'title' => 'Bing'
        } ], error: err)

      if nil != err
        NSLog("Could not update application context #{err.inspect}")
      end
    else
      NSLog("No valid WCSession found")
      if self.currentSession.reachable
        NSLog("Watch app not installed")
      else
        NSLog("Not reachable")
      end
    end

    true
  end
end

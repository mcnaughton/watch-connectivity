class AppDelegate

  attr_accessor :session

  def application(application, didFinishLaunchingWithOptions:launchOptions)
    rootViewController = UIViewController.alloc.init
    rootViewController.title = 'watch-connectivity'
    rootViewController.view.backgroundColor = UIColor.whiteColor

    navigationController = UINavigationController.alloc.initWithRootViewController(rootViewController)

    @window = UIWindow.alloc.initWithFrame(UIScreen.mainScreen.bounds)
    @window.rootViewController = navigationController
    @window.makeKeyAndVisible

    self.session = WCSession.defaultSession
    self.session.delegate = self
    self.session.activateSession

    err = nil
    self.session.updateApplicationContext([ {
        'url' => 'http://www.bing.com',
        'title' => 'Bing'
      } ], error: err)
    true
  end
end

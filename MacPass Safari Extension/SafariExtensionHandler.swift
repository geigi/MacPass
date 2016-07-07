//
//  SafariExtensionHandler.swift
//  MacPass Safari Extension
//
//  Created by Julian Geywitz on 07/07/16.
//  Copyright © 2016 HicknHack Software GmbH. All rights reserved.
//

import SafariServices

class SafariExtensionHandler: SFSafariExtensionHandler {
    
  override func messageReceived(withName messageName: String, from page: SFSafariPage, userInfo: [NSObject : AnyObject]!) {
    // This method will be called when a content script provided by your extension calls safari.extension.dispatchMessage("message").
    page.getPropertiesWithCompletionHandler { properties in
      NSLog("The extension received a message (\(messageName)) from a script injected into (\(properties?.url)) with userInfo (\(userInfo))")
    }
  }
    
  override func toolbarItemClicked(in window: SFSafariWindow) {
    // This method will be called when your toolbar item is clicked.
    NSLog("The extension's toolbar item was clicked")
  }
    
  override func validateToolbarItem(in window: SFSafariWindow, validationHandler: ((Bool, String) -> Void)) {
    // This is called when Safari's state changed in some way that would require the extension's toolbar item to be validated again.
    validationHandler(true, "")
  }
    
  override func popoverViewController() -> SFSafariExtensionViewController {
    return SafariExtensionViewController.shared
  }

  override func contextMenuItemSelected(withCommand command: String,
                                        in page: SFSafariPage, userInfo: [NSObject : AnyObject]? = [:]) {
    print("ContextMenu clicked")
    
    switch command {
      case "RequestCredentials":
        getCredentials(page: page, userInfo: userInfo)
      
      default:
        NSLog("False request \(command)")
    }
  }
  
  func getCredentials(page: SFSafariPage, userInfo: [NSObject : AnyObject]? = [:]) {
    NSLog("User asked for credentials")
    
    // Not working, but it should see: https://developer.apple.com/library/prerelease/content/documentation/NetworkingInternetWeb/Conceptual/SafariAppExtension_PG/AddingScriptContent.html
//    page.getPropertiesWithCompletionHandler { properties in
//      NSLog("\(properties?.url)")
//    }
    
    //Workaround using DOM and JS
    
    if userInfo == nil {
      NSLog("Safari Extension js did not send a userInfo")
      return
    }
    
    if let url = userInfo!["url"] {
      NSLog(url as! String)
    }
    else {
      NSLog("userInfo did not contain a url information")
    }
    
    
  }
}

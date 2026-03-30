//
//  NIFileHandling.swift
//  Komplete Kontrol Speed Up
//
//  Created by Noah Peña on 9/27/24.
//

import Foundation

let DEFAULT_KOMPLETE_KONTROL_2_SCAN_APP_DIRECTORY: String = "/Library/Application Support/Native Instruments/Komplete Kontrol/"
let DEFAULT_KOMPLETE_KONTROL_3_SCAN_APP_DIRECTORY: String = "/Library/Application Support/Native Instruments/Komplete Kontrol 3/"
let DEFAULT_MASCHINE_2_SCAN_APP_DIRECTORY: String = "/Library/Application Support/Native Instruments/Maschine 2/"
let DEFAULT_MASCHINE_3_SCAN_APP_DIRECTORY: String = "/Library/Application Support/Native Instruments/Maschine 3/"
let SCAN_APP3_NAME: String = "ScanApp3.app"
let CHANGED_SCAN_APP3_NAME: String = "ScanApp3.app.old"
let SCAN_APP_NAME: String = "ScanApp.app"
let CHANGED_SCAN_APP_NAME: String = "ScanApp.app.old"
let NI_PLUGIN_INFO_NAME: String = "ni-plugin-info.app"
let CHANGED_NI_PLUGIN_INFO_NAME: String = "ni-plugin-info.app.old"

var MASCHINE_2_SCAN_APP_NAME: String = SCAN_APP_NAME
var MASCHINE_3_SCAN_APP_NAME: String = NI_PLUGIN_INFO_NAME
var KOMPLETE_KONTROL_2_SCAN_APP_NAME: String = SCAN_APP3_NAME
var KOMPLETE_KONTROL_3_SCAN_APP_NAME: String = SCAN_APP3_NAME

func getScanAppDirectory(type: SupportedApplications) -> String
{
    switch type
    {
        case SupportedApplications.KompleteKontrol2:
            return DEFAULT_KOMPLETE_KONTROL_2_SCAN_APP_DIRECTORY
            
        case SupportedApplications.Maschine2:
            return DEFAULT_MASCHINE_2_SCAN_APP_DIRECTORY
        
        case SupportedApplications.KompleteKontrol3:
            return DEFAULT_KOMPLETE_KONTROL_3_SCAN_APP_DIRECTORY
        
        case SupportedApplications.Maschine3:
            return DEFAULT_MASCHINE_3_SCAN_APP_DIRECTORY
    }
}

func getScanAppFileName(type: SupportedApplications) -> String
{
    switch type
    {
        case SupportedApplications.KompleteKontrol2:
            return KOMPLETE_KONTROL_2_SCAN_APP_NAME
            
        case SupportedApplications.Maschine2:
            return MASCHINE_2_SCAN_APP_NAME
        
        case SupportedApplications.KompleteKontrol3:
            return KOMPLETE_KONTROL_3_SCAN_APP_NAME
            
        case SupportedApplications.Maschine3:
            return MASCHINE_3_SCAN_APP_NAME
    }
}

func getChangedScanAppFileName(name: String) -> String
{
//    print(name)
    switch name {
        
        case SCAN_APP3_NAME:
            return CHANGED_SCAN_APP3_NAME
        
        case SCAN_APP_NAME:
            return CHANGED_SCAN_APP_NAME
        
        case NI_PLUGIN_INFO_NAME:
            return CHANGED_NI_PLUGIN_INFO_NAME
        
        default:
            return name
    }
    
//    if name == SCAN_APP3_NAME
//    {
//        return CHANGED_SCAN_APP3_NAME
//    }
//    else if name == SCAN_APP_NAME
//    {
//        return CHANGED_SCAN_APP_NAME
//    }
//    else
//    {
//        return CHANGED_NI_PLUGIN_INFO_NAME
//    }
}


func isScanAppEnabled(type: SupportedApplications) -> Bool
{
    
    let scanAppDirectory: String = getScanAppDirectory(type: type)
    let scanAppName: String = getScanAppFileName(type: type)
    let changedScanAppName: String = getChangedScanAppFileName(name: scanAppName)
    
    // We know that the Application exists, so we can safely look for the ScanApp Files
    // The possible outcomes are as followed:
    //
    // ScanApp file exists but ScanApp.old does not = Currently Enabled
    // ScanApp file does not exist and ScanApp.old exists = Currently Disabled
    // ScanApp file exists and ScanApp.old exists = Application has been Recently Updated = Currently Enabled
    
    print(type.rawValue + ": " + scanAppDirectory + "(" + scanAppName + " | " + changedScanAppName + ")" )
    
    let scanAppState = FileManager.default.fileExists(atPath: scanAppDirectory + scanAppName)
    let changedScanAppState = FileManager.default.fileExists(atPath: scanAppDirectory + changedScanAppName)
    
    if (scanAppState && changedScanAppState)
    {
        // New Version was recently installed so we'll remove the old scan app and return false
//        try! FileManager.default.removeItem(at: URL(fileURLWithPath: String(scanAppDirectory + changedScanAppName)))
        return true
    }
    
    if (scanAppState && !changedScanAppState)
    {
        // Just the ScanApp exists so we'll return true
        return true
    }
    
    return false
    
}

func setScanAppName(type: SupportedApplications, name: String)
{
    switch type
    {
        case SupportedApplications.KompleteKontrol2:
            KOMPLETE_KONTROL_2_SCAN_APP_NAME = name
            break
            
        case SupportedApplications.Maschine2:
            MASCHINE_2_SCAN_APP_NAME = name
            break
        
        case SupportedApplications.KompleteKontrol3:
            KOMPLETE_KONTROL_3_SCAN_APP_NAME = name
            break
            
        case SupportedApplications.Maschine3:
            MASCHINE_3_SCAN_APP_NAME = name
            break
    }
}

func isApplicationInstalled(type: SupportedApplications) -> Bool
{
    
    let scanAppDirectory: String = getScanAppDirectory(type: type)
    let scanAppFileName: String = getScanAppFileName(type: type)
    let changedScanAppFileName: String = getChangedScanAppFileName(name: scanAppFileName)
    var result: Bool = true
    
//    print(scanAppDirectory + scanAppFileName)
//    print(scanAppDirectory + changedScanAppFileName)
    
    // Old Versions of Komplete Kontrol and Maschine use the regular ScanApp
    // while newer versions use ScanApp3, so we'll check for which one we have
    
    if FileManager.default.fileExists(atPath: String(scanAppDirectory + scanAppFileName))
    {
        result = true
//        setScanAppName(type: type, name: scanAppFileName)
    }
    else if FileManager.default.fileExists(atPath: String(scanAppDirectory + changedScanAppFileName))
    {
        result = true
//        setScanAppName(type: type, name: changedScanAppFileName)
    }
    else
    {
        // Couldn't find it
//        print("Couldn't find " + scanAppDirectory + scanAppFileName)
        result = false
    }
    
    return result
}

func processScanApp(type: SupportedApplications, enableScanApp: Bool)
{
    let scanAppDirectory: String = getScanAppDirectory(type: type)
    let scanAppName: String = getScanAppFileName(type: type)
    let changedScanAppName: String = getChangedScanAppFileName(name: scanAppName)
    let scanAppURL: URL = URL(fileURLWithPath: String(scanAppDirectory + scanAppName))
    let changedScanAppURL: URL = URL(fileURLWithPath: String(scanAppDirectory + changedScanAppName))
    
    if enableScanApp
    {
        // Re-Enabled Scan App
        // So we need to move the ScanApp3.app.old to being ScanApp3.app
        try! FileManager.default.moveItem(at: changedScanAppURL, to: scanAppURL)
    }
    else
    {
        // Disable Scan App
        // So we need to move the ScanApp3.app to being ScanApp3.app.old
        do
        {
            try FileManager.default.moveItem(at: scanAppURL, to: changedScanAppURL)
            
        } catch {
            print(error)
        }
    }
}


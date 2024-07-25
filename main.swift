import Foundation
import Cocoa
import Darwin

func clearTerminal() {
    print("\u{1B}[H\u{1B}[2J", terminator: "")
}

func title() {
    print("|TASKMANAGER|")
}

func viepids() {
    let runningApplications = NSWorkspace.shared.runningApplications
    for app in runningApplications {
        let bundleID = app.bundleIdentifier ?? "unknown"
        let simpleb = bundleID.components(separatedBy: ".").last ?? bundleID
        let pid = app.processIdentifier
        print("Process: \(simpleb) - PID: \(pid)")
    }
}

func menu() {
    clearTerminal()
    title()
    print("\nWould you like to view PIDs or end PIDs? 1/2")
    
    if let input = readLine() {
        switch input {
        case "1":
            clearTerminal()
            title()
            print("Viewing PIDs:")
            viepids()
            print("\nPress any key to return to the menu...")
            _ = readLine()
            menu()
            
        case "2":
            clearTerminal()
            title()
            print("\nEnding PIDs")
            viepids()
            print("\n\n\n")
            print("Choose PID TO END")
            if let result = readLine(), let pid = Int32(result) {
                _ = kill(pid, SIGTERM)
                print("Terminating PID \(pid)...")
            } else {
                print("Invalid PID.")
            }
            print("\nPress any key to return to the menu...")
            _ = readLine()
            menu()
            
        default:
            print("Invalid Input")
            print("\nPress any key to return to the menu...")
            _ = readLine()
            menu()
        }
    }
}

menu()

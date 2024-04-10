import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
    
    var statusItem: NSStatusItem!
    var counter: Int = UserDefaults.standard.integer(forKey: "counter") {
        didSet {
            UserDefaults.standard.set(counter, forKey: "counter") // сохранить значение после закрытия
            updateStatusItemTitle()
        }
    }
    
    var interval: Int = UserDefaults.standard.integer(forKey: "interval") {
        didSet {
            UserDefaults.standard.set(interval, forKey: "interval")
        }
    }
    
    
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        self.statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)
        if let button = self.statusItem.button {
            button.title = "\(counter)"
        }
        constructMenu()
        
        NSApplication.shared.setActivationPolicy(.accessory) // скрыть приложение в dock
       
       
    }
    
    func applicationWillTerminate(_ aNotification: Notification) {
        // Необязательно, так как значение счетчика обновляется в UserDefaults при каждом изменении
    }
    
    @objc func incrementCounter() {
        counter += interval
    }

    @objc func decrementCounter() {
        counter -= interval
    }
    
    @objc func zeroCounter() {
        counter = 0
    }
    
    @objc func setUserCounterValue() {
        guard let window = NSApplication.shared.windows.first else { return }

        // Делаем окно прозрачным
        window.alphaValue = 0.0

        let alert = NSAlert()
        alert.messageText = "The Count"
        alert.informativeText = "Set Value:"
        alert.addButton(withTitle: "ОК")
        alert.addButton(withTitle: "Cancel")
        let inputTextField = NSTextField(frame: NSRect(x: 0, y: 0, width: 200, height: 24))
        inputTextField.stringValue = "\(counter)" // Убедитесь, что переменная `counter` существует и имеет правильное значение
        alert.accessoryView = inputTextField
        alert.beginSheetModal(for: window) { (modalResponse) in
        
            window.close()
            
            if modalResponse == .alertFirstButtonReturn {
                if let inputValue = Int(inputTextField.stringValue) {
                    self.counter = inputValue // Убедитесь, что `counter` обновляется корректно в контексте этого метода
                }
            }
        }
    }
    
    @objc func setInterval() {
        guard let window = NSApplication.shared.windows.first else { return }
        
        // Делаем окно прозрачным
        window.alphaValue = 0.0

        let alert = NSAlert()
        alert.messageText = "Set Interval"
        alert.informativeText = "Interval:"
        alert.addButton(withTitle: "OK")
        alert.addButton(withTitle: "None")
        let inputTextField = NSTextField(frame: NSRect(x: 0, y: 0, width: 200, height: 24))
        inputTextField.stringValue = "\(interval)"
        alert.accessoryView = inputTextField
        alert.beginSheetModal(for: window) { (modalResponse) in
            
            window.close()
            
            if modalResponse == .alertFirstButtonReturn {
                if let inputValue = Int(inputTextField.stringValue) {
                    self.interval = inputValue
                }
            }
        }
    }
    
    func updateStatusItemTitle() {
        if let button = self.statusItem.button {
            button.title = "\(counter)"
        }
    }
    
    func constructMenu() {
        let menu = NSMenu()
        
        menu.addItem(NSMenuItem(title: "⊕", action: #selector(AppDelegate.incrementCounter), keyEquivalent: ""))
        menu.addItem(NSMenuItem(title: "⊖", action: #selector(AppDelegate.decrementCounter), keyEquivalent: ""))
        menu.addItem(NSMenuItem.separator())
        menu.addItem(NSMenuItem(title: "Set Value", action: #selector(AppDelegate.setUserCounterValue), keyEquivalent: ""))
        menu.addItem(NSMenuItem(title: "Set Interval", action: #selector(AppDelegate.setInterval), keyEquivalent: ""))
        menu.addItem(NSMenuItem.separator())
        menu.addItem(NSMenuItem(title: "Reset", action: #selector(AppDelegate.zeroCounter), keyEquivalent: ""))
        menu.addItem(NSMenuItem(title: "Exit", action: #selector(NSApplication.terminate(_:)), keyEquivalent: ""))
        
        statusItem.menu = menu
    }
    
}

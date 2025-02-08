//
//  MachoOutlineView.swift
//  MachOExplorer
//
//  Created by bangcle on 2025/1/20.
//  Copyright © 2025 DeVaukz. All rights reserved.
//

import Cocoa
import MachOKit

class MachOOutlineView: NSOutlineView {
    override func menu(for event: NSEvent) -> NSMenu? {
        let point = event.locationInWindow
        let viewPoint = self.convert(point, from: event.window?.contentView)
        let row = self.row(at: viewPoint)
        if (row == -1) {
            return nil
        }
        
        guard let item = self.item(atRow: row) as? NSTreeNode else {
            return nil
        }
        
        guard let macho = item.representedObject as? MKExtractable else {
            return nil
        }
        
        if (!macho.extractable()) {
            return nil
        }
        
        let menu = NSMenu()
        let extractItem = ImageMenuItem(title: "extract", action:#selector(extract), keyEquivalent: "")
        extractItem.macho = macho
        menu.addItem(extractItem)
        
        return menu
    }
    
    @objc func extract(_ sender: ImageMenuItem) {
        guard let macho = sender.macho else {
            return
        }
        
        let openPanel = NSOpenPanel()
        openPanel.canChooseDirectories = true
        openPanel.canChooseFiles = false
        openPanel.allowsMultipleSelection = false
        openPanel.begin { (result) in
            if result != .OK {
                return
            }
            if let dir = openPanel.url?.path() {
                macho.extract(to: dir)
            }
        }
    }
    
//    deinit {
//        Swift.print("\(self.className) deinit")
//    }
}

class ImageMenuItem: NSMenuItem {
    var macho: MKExtractable?
}

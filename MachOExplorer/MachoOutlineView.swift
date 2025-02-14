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
        
        guard let extractable = item.representedObject as? MKExtractable else {
            return nil
        }
        
        if (!extractable.extractable()) {
            return nil
        }
        
        let menu = NSMenu()
        let isDSC = extractable.isKind(of: MKSharedCache.self)
        var title: String
        if isDSC {
            title = "extract all images"
        } else {
            title = "extract"
        }
        let extractItem = ImageMenuItem(title: title, action:#selector(extract), keyEquivalent: "")
        extractItem.extractable = extractable
        menu.addItem(extractItem)
        
        if isDSC {
            let subMenu = NSMenu()
            
            let dsc = extractable as! MKSharedCache
            var items = [NSMenuItem]()
            for image in dsc.sortedImages() {
                let imageItem = ImageMenuItem(title: image.description, action:#selector(extract), keyEquivalent: "")
                imageItem.extractable = image
                items.append(imageItem)
            }
            subMenu.items = items
            
            let extractItem = ImageMenuItem(title: "extract image", action:#selector(extract), keyEquivalent: "")
            menu.addItem(extractItem)
            menu.setSubmenu(subMenu, for: extractItem)
        }
        
        return menu
    }
    
    @objc func extract(_ sender: ImageMenuItem) {
        guard let extractable = sender.extractable else {
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
                extractable.extract(to: dir)
            }
        }
    }
    
//    deinit {
//        Swift.print("\(self.className) deinit")
//    }
}

class ImageMenuItem: NSMenuItem {
    var extractable: MKExtractable?
}

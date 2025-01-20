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
        
        guard let dscImage = item.representedObject as? MKDSCImage else {
            return nil
        }
        
        return nil
        // segment中offset的参照对象并不相同，目前还不清楚具体关系，暂不启用extract功能
        let menu = NSMenu()
        let extractItem = ImageMenuItem(title: "extract", action:#selector(extract), keyEquivalent: "")
        extractItem.dscImage = dscImage
        menu.addItem(extractItem)
        
        return menu
    }
    
    @objc func extract(_ sender: ImageMenuItem) {
        guard let dscIamge = sender.dscImage else {
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
                dscIamge.extract(to: dir)
            }
        }
    }
}

class ImageMenuItem: NSMenuItem {
    var dscImage: MKDSCImage?
}

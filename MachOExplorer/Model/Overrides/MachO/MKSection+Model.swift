//----------------------------------------------------------------------------//
//|
//|             MachOExplorer - A Graphical Mach-O Viewer
//! @file       MKSection+Model.swift
//!
//! @author     D.V.
//! @copyright  Copyright (c) 2018 D.V. All rights reserved.
//|
//| Permission is hereby granted, free of charge, to any person obtaining a
//| copy of this software and associated documentation files (the "Software"),
//| to deal in the Software without restriction, including without limitation
//| the rights to use, copy, modify, merge, publish, distribute, sublicense,
//| and/or sell copies of the Software, and to permit persons to whom the
//| Software is furnished to do so, subject to the following conditions:
//|
//| The above copyright notice and this permission notice shall be included
//| in all copies or substantial portions of the Software.
//|
//| THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
//| OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
//| MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
//| IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
//| CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
//| TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
//| SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
//----------------------------------------------------------------------------//

import MachOKit

extension MKSection
{
    override func adapter(forField field: MKNodeField) -> FieldAdapter? {
        // 不过滤字段，以便S_ZEROFILL的section可以显示信息，如遇到以下这些字段不需要显示，但是显示出来的情况，在相应的layout方法中去掉即可
//        if field.name == "name" ||
//           field.name == "alignment" ||
//           field.name == "fileOffset" ||
//           field.name == "vmAddress" ||
//           field.name == "size" ||
//           field.name == "type" ||
//           field.name == "userAttributes" ||
//           field.name == "systemAttributes" {
//            return nil
//        }
        
        return super.adapter(forField: field)
    }
}

extension MKSection /* OutlineNodeModel */
{
    override var outline_title: String {
        return "Section (" + self.description + ")"
    }
}

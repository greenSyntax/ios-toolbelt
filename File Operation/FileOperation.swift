/*
 The MIT License (MIT)
 Copyright (c) 2018 Abhishek Kumar Ravi
 Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
 The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 */

import Foundation

enum Acknowledgement {
    case success(String)
    case failure(String)
}

protocol FileReadable {
    var fileName: String { get set }
    var fileExtension: String { get }
    var atomicProperty: Bool { get }
    var encodingType: String.Encoding { get }
}

extension FileReadable {

    var fileExtension: String {
        return "txt"
    }

    var atomicProperty: Bool {
        return true
    }

    var encodingType: String.Encoding {
        return String.Encoding.utf8
    }
}

struct FileOpeartion {

    private var delegate:FileReadable!

    init(delegate: FileReadable) {
        self.delegate = delegate
    }

    private func getFilePath() -> URL? {

        if let documentPath = try? FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0] {

            let filePath = documentPath.appendingPathComponent(delegate.fileName).appendingPathExtension(delegate.fileExtension)
            print("File: \(filePath)")
            return filePath
        }

        return nil
    }

    public func read() -> Acknowledgement {

        if let path = getFilePath() {
            if let data = try? String(contentsOf: path) {
                return Acknowledgement.success(data)
            }
            else {
                return Acknowledgement.failure("Error while reading data")
            }
        }

        return Acknowledgement.failure("Error in getting File path")
    }

    public func write(data: String) -> Acknowledgement {

        if let path = getFilePath() {
            if let status = try? data.write(to: path, atomically: delegate.atomicProperty, encoding: delegate.encodingType) {
                return Acknowledgement.success("Succesfully written")
            }
            else {
                return Acknowledgement.failure("Error while writing in file.")
            }
        }
        else {
            return Acknowledgement.failure("Error: Can't get the file path")
        }

    }
}

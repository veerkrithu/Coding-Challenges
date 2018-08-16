//
//  FileStatistics.swift
//  
//
//  Created by Ganesan, Veeramani - Contractor {BIS} on 8/15/18.
//

import Foundation

struct FileInfo {
    var name: String
    var size: Double
    var exten: String
}

func solution(_ S : inout String) -> String {
    // write your code in Swift 3.0 (Linux)
    
    var files = [FileInfo]()
    
    let filesInfoArray = S.components(separatedBy: "\n")
    for fileInfo in filesInfoArray {
        
        let fileInfoStruct = parseFilesInfo(fileInfo)
        files.append(fileInfoStruct)
    }
    
    var result = String(format:"music %.0f\n", totalSizeForFileTypes(["mp3", "flac"], files))
    result += String(format:"images %.0f\n", totalSizeForFileTypes(["jpeg", "jpg", "png"], files))
    result += String(format:"movies %.0f\n", totalSizeForFileTypes(["mkv", "mp4"], files))
    result += String(format:"others %.0f", totalSizeForFileTypes(["txt", "exe"], files))
    
    return result
}


func totalSizeForFileTypes(_ types: [String], _ files: [FileInfo])->Double {
    
    var totalSize = 0.0
    for type in types {
        
        let matchedFiles = files.filter { $0.exten == type }
        
        for matchedFile in matchedFiles {
            totalSize =  totalSize + matchedFile.size
        }
    }
    
    return totalSize
}


func parseFilesInfo(_ fileInfo: String)->FileInfo {
    
    let fileInfoArray = fileInfo.components(separatedBy: " ")
    
    if fileInfoArray.count > 0 {
        
        let fileNameExtendion = fileInfoArray.first?.components(separatedBy: ".")
        
        let name = fileNameExtendion?.first
        let exten = fileNameExtendion?.last
        
        let val = (fileInfoArray.last?.trimmingCharacters(in: ["b"]))
        
        return FileInfo(name: name!, size: Double(val!)!, exten: exten!)
    }
    
    return FileInfo(name: "", size: 0, exten: "")
}


var S = "my.$%song.mp3 11b\ngreatSong.flac 1000b\nnot3.txt 5b\nvideo.mp4 200b\ngame.exe 100b\nmov!e.mkv 10000b"

solution(&S)


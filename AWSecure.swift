//
//  File.swift
//  core
//
//  Created by Apple on 08/09/2021.
//  Copyright © 2021 Haider Tamsil. All rights reserved.
//

import Foundation

//import CryptoSwift

//func getUrlRequest(url:String,params:String) -> URLRequest{
//
//    var headers = [String :String]()
//    var signedHeaders = [String:String]()
//
////    var bodyDigest = sha256("")
//
//    var urlForSigning = url
//    if urlForSigning.last == "/" {
//        urlForSigning = String(url.dropLast())
//    }
//
//    var request = URLRequest(url: URL(string: url)!)
//    request.httpMethod = "POST"
//    
//    
//    
//    let body = try? JSONSerialization.data(withJSONObject: params, options: [])
//    let bodyString = NSString(data: body!, encoding: String.Encoding.utf8.rawValue)! as String
////    if (bodyString.trim().count > 0){
////        bodyDigest = sha256(bodyString)
////        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
////        request.httpBody = bodyString.data(using: String.Encoding.utf8)
////    }
//
////    signedHeaders = signedHeaders(url: URL(string: urlForSigning)!,
////                                         bodyDigest: bodyDigest, httpMethod: "POST")
//
//    
//    
//    
////    headers["Authorization"] = signedHeaders["Authorization"]
////    headers["x-amz-date"] = signedHeaders["x-amz-date"]
////    headers["Host"] = signedHeaders["Host"]
////    headers["expiration"] = signedHeaders["expiration"]
////    headers["x-amz-security-token"] = signedHeaders["x-amz-security-token"]
////    headers["Content-Type"] = signedHeaders["Content-Type"]
////
////    for (k, v) in headers {
////        request.setValue(v, forHTTPHeaderField: k)
////    }
////
////    return request
////}
////
////func signedHeaders(url: URL, bodyDigest: String,
////                   httpMethod: String, date: Date = Date()) -> [String: String] {
////
////    let accessKey = "AKIA6KJHO2RDTIUJA4MC"
////    let secretKey = "EDxmaft4Nfe0G24NWq0rdHiTWVog5qShgJ3zXy+"
////    let datetime = timestamp(date)
////    let expirationTime = timestamp(date)
////    let port = ((url as NSURL).port != nil) ? ":" + String(describing: (url as NSURL).port!) : ""
////    var headers = ["x-amz-date": datetime, "Host": url.host! + port,  "expiration": expirationTime, "x-amz-security-token" : "aa9bb579-6ca7-4455-83e7-857735d68769", "Content-Type": "application/json"]
////    headers["Authorization"] = authorization(accessKey, secretKey: secretKey, url: url, headers: headers,
////                                             datetime: datetime, httpMethod: httpMethod, bodyDigest: bodyDigest)
////
////    return headers
////}
//// MARK: Utilities
//
////fileprivate func pathForURL(_ url: URL) -> String {
////    var path = url.path
////    if path.isEmpty {
////        path = "/"
////    } else {
////        // do this to preserve encoded path fragments, like those containing encoded '/' (%2F)
////        // NSURL.path  decodes them and they are lost
////        var encodedPartsArray = [String]()
////        // get rid of 'http(s)://'
////        let fullURL = String(url.absoluteString[url.absoluteString.index(url.absoluteString.startIndex, offsetBy: 8)...])
////        var rawPath = String(fullURL[fullURL.range(of: "/")!.lowerBound...])
////        if rawPath.contains("?") {
////            rawPath = String(rawPath[..<rawPath.range(of: "?")!.lowerBound])
////        }
////        for part in rawPath.components(separatedBy: "/") {
////            if !part.isEmpty {
////                 let secretKey = "EDxmaft4Nfe0G24NWq0rdHiTWVog5qShgJ3zXy+"
//////                encodedPartsArray.append(URLSigner.sign(key: part,  secret: secretKey))
////
////            }
////        }
////        path = "/" + encodedPartsArray.joined(separator: "/")
////    }
////    return path
////}
//
////func sha256(_ str: String) -> String {
////    let data = str.data(using: String.Encoding.utf8)!
////    return data.base64EncodedString()
////}
////
////fileprivate func hmac(_ string: NSString, key: Data) -> Data {
////    let msg = string.data(using: String.Encoding.utf8.rawValue)!
////
////    let hmac = try! HMAC(key: key.bytes, variant: .sha256).authenticate(msg.bytes)
////    return Data(bytes: hmac)
////}
////
////fileprivate func timestamp(_ date: Date) -> String {
////    let formatter = DateFormatter()
////    formatter.dateFormat = "yyyyMMdd'T'HHmmss'Z'"
////    formatter.timeZone = TimeZone(identifier: "UTC")
////    formatter.locale = Locale(identifier: "en_US_POSIX")
////    return formatter.string(from: date)
////}
////
////// MARK: Methods Ported from AWS SDK
////
////fileprivate func authorization(_ accessKey: String, secretKey: String, url: URL, headers: Dictionary<String, String>,
////                               datetime: String, httpMethod: String, bodyDigest: String) -> String {
////    let cred = credential(accessKey, datetime: datetime)
////    let shead = signedHeaders(headers)
////    let sig = signature(secretKey, url: url, headers: headers, datetime: datetime,
////                        httpMethod: httpMethod, bodyDigest: bodyDigest)
////
////    return [
////        "AWS4-HMAC-SHA256 Credential=\(cred)",
////        "SignedHeaders=\(shead)",
////        "Signature=\(sig)",
////        ].joined(separator: ", ")
////}
////
////fileprivate func credential(_ accessKey: String, datetime: String) -> String {
////    return "\(accessKey)/\(credentialScope(datetime))"
////}
////
////fileprivate func signedHeaders(_ headers: [String:String]) -> String {
////    var list = Array(headers.keys).map { $0.lowercased() }.sorted()
////    if let itemIndex = list.index(of: "authorization") {
////        list.remove(at: itemIndex)
////    }
////    return list.joined(separator: ";")
////}
////
////fileprivate func canonicalHeaders(_ headers: [String: String]) -> String {
////    var list = [String]()
////    let keys = Array(headers.keys).sorted {$0.localizedCompare($1) == ComparisonResult.orderedAscending}
////
////    for key in keys {
////        if key.caseInsensitiveCompare("authorization") != ComparisonResult.orderedSame {
////            // Note: This does not strip whitespace, but the spec says it should
////            list.append("\(key.lowercased()):\(headers[key]!)")
////        }
////    }
////    return list.joined(separator: "\n")
////}
////
////fileprivate func signature(_ secretKey: String, url: URL, headers: [String: String],
////                           datetime: String, httpMethod: String, bodyDigest: String) -> String {
////    let secret = NSString(format: "AWS4%@", secretKey).data(using: String.Encoding.utf8.rawValue)!
////    let date = hmac(String(datetime[..<datetime.index(datetime.startIndex, offsetBy: 8)]) as NSString, key: secret)
////    let region = hmac("us-east-2" as NSString, key: date)
////    let service = hmac("execute-api" as NSString, key: region)
////    let credentials = hmac("aws4_request", key: service)
////    let string = stringToSign(datetime, url: url, headers: headers, httpMethod: httpMethod, bodyDigest: bodyDigest)
////    return hmac(string as NSString, key: credentials).base64EncodedString()
////}
////
////fileprivate func credentialScope(_ datetime: String) -> String {
////    return [
////        String(datetime[..<datetime.index(datetime.startIndex, offsetBy: 8)]),
////        "us-east-2",
////        "execute-api",
////        "aws4_request"
////        ].joined(separator: "/")
////}
////
////fileprivate func stringToSign(_ datetime: String, url: URL, headers: [String: String],
////                              httpMethod: String, bodyDigest: String) -> String {
////    return [
////        "AWS4-HMAC-SHA256",
////        datetime,
////        credentialScope(datetime),
////        sha256(canonicalRequest(url, headers: headers, httpMethod: httpMethod, bodyDigest: bodyDigest)),
////        ].joined(separator: "\n")
////}
////
////fileprivate func canonicalRequest(_ url: URL, headers: [String: String],
////                                  httpMethod: String, bodyDigest: String) -> String {
////    return [
////        httpMethod,                       // HTTP Method
////        pathForURL(url),                  // Resource Path
////        url.query ?? "",                  // Canonicalized Query String
////        "\(canonicalHeaders(headers))\n", // Canonicalized Header String (Plus a newline for some reason)
////        signedHeaders(headers),           // Signed Headers String
////        bodyDigest,                       // Sha265 of Body
////        ].joined(separator: "\n")
////}
////
////public func encodeURIComponent(_ s: String) -> String {
////    let allowed = NSMutableCharacterSet.alphanumeric()
////    allowed.addCharacters(in: "-_.~")
////    //allowed.addCharactersInString("-_.!~*'()")
////    return s.addingPercentEncoding(withAllowedCharacters: allowed as CharacterSet) ?? ""
////}
////
////
////class URLSigner: NSObject {
////    static func sign(key: String, secret: String) -> URL?{
////        let path = "/path/something"
////        var secret_key = secret
////        secret_key = secret_key.replacingOccurrences(of: "-", with: "+")
////        secret_key = secret_key.replacingOccurrences(of: "_", with: "/")
////            if let decodedData = Data(base64Encoded: secret_key)?.bytes, let hmac = try? HMAC(key: decodedData, variant: .sha1).authenticate(Array(path.utf8)){
////                var signature = hmac.toBase64()
////                signature = signature.replacingOccurrences(of: "+", with: "-").replacingOccurrences(of: "/", with: "_")
////                return URL(string: "URL" + path + "&signature=" + signature)
////            }
////        return URL(string: "URL" + path)
////    }
////}
//    
//    
//}

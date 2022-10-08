//
//  String+Extension.swift
//  GitHub Resume
//
//  Created by Shahbaz Khan on 24/11/2019.


import UIKit
 extension String {
    
     func validateEmail() -> Bool {
        return true
        let predicate = NSPredicate(format:"SELF MATCHES[c] %@", "^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$")
        return predicate.evaluate(with: self)
    }
    
    func ConvertBase64StringToImage () -> UIImage! {
        let imageData = Data.init(base64Encoded: self, options: .init(rawValue: 0))
        let image = UIImage(data: imageData!)
        return image
    }
    
    func toDate(_ formate : String ,_ locale : String = "en_US") -> Date! {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = formate
        dateFormatter.timeZone = .current
        dateFormatter.locale = Locale.init(identifier: locale)
        return dateFormatter.date(from: self)
        
    }
    var containsValidCharacterForPassword: Bool {
      guard self != "" else { return true }
      let hexSet = CharacterSet(charactersIn: "1234567890abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLKMNOPQRSTUVWXYZ@$")
      let newSet = CharacterSet(charactersIn: self)
      return hexSet.isSuperset(of: newSet)
    }
    
    
   
    static func isStringValid(_ string: String?) -> Bool {
        if  string == nil{
            return false
        }
        
        var flage:Bool = false
        if !(string ?? "").isEmpty {
            flage = true
        }
        
        return flage
    }
    
    var urlEncodeString: String {
        let characterSetTobeAllowed = (CharacterSet(charactersIn: "!@#$%&*()+'\";:=,/?[] ").inverted)
        return self.addingPercentEncoding(withAllowedCharacters: characterSetTobeAllowed)!
    }
    
    
    func contains(_ find: String) -> Bool{
        return self.range(of: find) != nil
    }
    
    func containsIgnoringCase(_ find: String) -> Bool{
        return self.range(of: find, options: .caseInsensitive) != nil
    }

    func paymentFormatted() -> String {
        var selfString = self
        selfString = selfString.replacingOccurrences(of: ",", with: "")
        let numberFormatter = NumberFormatter()
        let number = numberFormatter.number(from: selfString)
        let paymentFloatValue = number!.floatValue
          numberFormatter.numberStyle = NumberFormatter.Style.decimal
        let formattedNumber =  numberFormatter.string(from: NSNumber(value:paymentFloatValue))
        if self == "0" {
            return "AED 0.00"
        }
        if (formattedNumber?.contains("."))! {
            return "AED \(formattedNumber ?? "")"

        } else {
            return "AED \(formattedNumber ?? "").00"

        }
    }
}

public extension String {
    
    /**
     Localize string
     */
    func localizedStringWithVariables(_ value: String, vars: CVarArg...) -> String {
        return String(format: NSLocalizedString(self, tableName: nil, bundle: Bundle.main, value: value, comment: ""), arguments: vars)
    }
    
    /// Return the float value
    var floatValue: Float {
        return (self as NSString).floatValue
    }
    
    /**
     lenght of the string
     */
    var length: Int {
        return self.count
    }
    
    /**
     It's like substringFromIndex(index: String.Index), but it requires an Int as index
     */
    func substringFromIndex(_ index: Int) -> String {
        let indexStartOfText = self.index(self.startIndex, offsetBy: index)
        return String(self[indexStartOfText...])
    }
    
    /**
     It's like substringToIndex(index: String.Index), but it requires an Int as index
     */
    func substringToIndex(_ index: Int) -> String {
        let indexStartOfText = self.index(self.startIndex, offsetBy: index)
        return String(self[..<indexStartOfText])
    }
    
    /**
     Creates a substring with a given range
     */
    func substringWithRange(_ range: Range<Int>) -> String {
        let start = self.index(self.startIndex, offsetBy: range.lowerBound)
        let end = self.index(self.startIndex, offsetBy: range.upperBound)
        return String(self[start..<end])
    }
    
    /**
     Returns the index of the given character
     */
    func indexOfCharacter(_ character: Character) -> Int {
        if let index = self.firstIndex(of: character) {
            return self.distance(from: self.startIndex, to: index)
        }
        return -1
    }
    
    /**
     Search in a given string a substring from the start char to the end char (excluded form final string).
     Example: "This is a test" with start char 'h' and end char 't' will return "is is a "
     */
    
    /**
     Check if self has the given substring in case-sensitive
     */
    func hasString(_ string: String, caseSensitive: Bool = true) -> Bool {
        if caseSensitive {
            return self.range(of: string) != nil
        } else {
            return self.lowercased().range(of: string.lowercased()) != nil
        }
    }
    
    /**
     Check if self is an email
     */
    func isEmail() -> Bool {
        return String.isEmail(self)
    }
    
    func isEmptyString() -> Bool {
        return String.isValid(self)
    }
    
    /**
     Encode the given string to Base64
     */
    func encodeToBase64() -> String {
        return String.encodeToBase64(self)
    }
    
    /**
     Decode the given Base64 to string
     */
    func decodeBase64() -> String {
        return String.decodeBase64(self)
    }
    
    /**
     Convert self to a NSData
     */
    func convertToNSData() -> Data {
        return self.data(using: String.Encoding.utf8)!
    }
    
    /**
     Conver self to a capitalized string.
     Example: "This is a Test" will return "This is a test" and "this is a test" will return "This is a test"
     */
    func sentenceCapitalizedString() -> String {
        if self.length == 0 {
            return ""
        }
        let uppercase: String = self.substringToIndex(1).uppercased()
        let lowercase: String = self.substringFromIndex(1).lowercased()
        
        return uppercase + lowercase
    }
    
    /**
     Returns a human legible string from a timestamp
     */
    func dateFromTimestamp() -> String {
        let year: String = self.substringToIndex(4)
        var month: String = self.substringFromIndex(5)
        month = month.substringToIndex(4)
        var day: String = self.substringFromIndex(8)
        day = day.substringToIndex(2)
        var hours: String = self.substringFromIndex(11)
        hours = hours.substringToIndex(2)
        var minutes: String = self.substringFromIndex(14)
        minutes = minutes.substringToIndex(2)
        
        return "\(day)/\(month)/\(year) \(hours):\(minutes)"
    }
    
    /**
     Returns a new string containing matching regular expressions replaced with the template string
     */
    func stringByReplacingWithRegex(_ regexString: NSString, withString replacement: NSString) throws -> NSString {
        let regex: NSRegularExpression = try NSRegularExpression(pattern: regexString as String, options: .caseInsensitive)
        return regex.stringByReplacingMatches(in: self, options: NSRegularExpression.MatchingOptions(rawValue: 0), range:NSMakeRange(0, self.length), withTemplate: "") as NSString
    }
    
    /**
     Encode self to an encoded url string
     */
    func URLEncode() -> String {
        return self.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlHostAllowed)!
    }
    
    /// Returns the last path component
    var lastPathComponent: String {
        get {
            return (self as NSString).lastPathComponent
        }
    }
    
    /// Returns the path extension
    var pathExtension: String {
        get {
            return (self as NSString).pathExtension
        }
    }
    
    /// Delete the last path component
    var stringByDeletingLastPathComponent: String {
        get {
            return (self as NSString).deletingLastPathComponent
        }
    }
    
    /// Delete the path extension
    var stringByDeletingPathExtension: String {
        get {
            return (self as NSString).deletingPathExtension
        }
    }
    
    /// Returns an array of path components
    var pathComponents: [String] {
        get {
            return (self as NSString).pathComponents
        }
    }
    
    /**
     Appends a path component to the string
     */
    func stringByAppendingPathComponent(_ path: String) -> String {
        let string = self as NSString
        
        return string.appendingPathComponent(path)
    }
    
    /**
     Appends a path extension to the string
     */
    func stringByAppendingPathExtension(_ ext: String) -> String? {
        let nsSt = self as NSString
        
        return nsSt.appendingPathExtension(ext)
    }
    
    /// Converts self to a NSString
    var NS: NSString {
        return (self as NSString)
    }
    
    /**
     Returns if self is a valid UUID or not
     */
    func isUUID() -> Bool {
        do {
            let regex: NSRegularExpression = try NSRegularExpression(pattern: "^[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}$", options: .caseInsensitive)
            let matches: Int = regex.numberOfMatches(in: self as String, options: .reportCompletion, range: NSMakeRange(0, self.length))
            return matches == 1
        } catch {
            return false
        }
    }
    /**
     Returns if self is a numbers or not
     */
    func isNumber() -> Bool {
        let numberCharacters = CharacterSet.decimalDigits.inverted
        return !self.isEmpty && self.rangeOfCharacter(from: numberCharacters) == nil
    }
    
    /**
     Returns if self is a valid UUID for APNS (Apple Push Notification System) or not
     */
    func isUUIDForAPNS() -> Bool {
        do {
            let regex: NSRegularExpression = try NSRegularExpression(pattern: "^[0-9a-f]{32}$", options: .caseInsensitive)
            let matches: Int = regex.numberOfMatches(in: self as String, options: .reportCompletion, range: NSMakeRange(0, self.length))
            return matches == 1
        } catch {
            return false
        }
    }
    
    /**
     Converts self to an UUID APNS valid (No "<>" or "-" or spaces)
     */
    func convertToAPNSUUID() -> NSString {
        return self.trimmingCharacters(in: CharacterSet(charactersIn: "<>")).replacingOccurrences(of: " ", with: "").replacingOccurrences(of: "-", with: "") as NSString
    }
    
    /**
     Used to calculate text height for max width and font
     */
    func heightForWidth(_ width: CGFloat, font: UIFont) -> CGFloat {
        var size: CGSize = CGSize.zero
        if self.length > 0 {
            let frame: CGRect = self.boundingRect(with: CGSize(width: width, height: 999999), options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font : font], context: nil)
            size = CGSize(width: frame.size.width, height: frame.size.height + 1)
        }
        return size.height
    }
    
    // MARK: - Subscript functions -

    
    /**
     Returns the string from a given range
     */
    subscript(range: Range<Int>) -> String {
        return substringWithRange(range)
    }
    
    // MARK: - Class functions -
    
    /**
     Check if the given string is an email
     */
    static func isEmail(_ email: String) -> Bool {
        
        let emailRegEx: String = "^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$"
        
        let regExPredicate: NSPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        return regExPredicate.evaluate(with: email.lowercased())
    }
    
    /**
     Convert a string to UTF8
     
     - parameter string: String to be converted
     
     - returns: Returns the converted string
     */
    static func convertToUTF8Entities(_ string: String) -> String {
        return string
            .replacingOccurrences(of: "%27", with: "'")
            .replacingOccurrences(of: "%e2%80%99".capitalized, with: "’")
            .replacingOccurrences(of: "%2d".capitalized, with: "-")
            .replacingOccurrences(of: "%c2%ab".capitalized, with: "«")
            .replacingOccurrences(of: "%c2%bb".capitalized, with: "»")
            .replacingOccurrences(of: "%c3%80".capitalized, with: "À")
            .replacingOccurrences(of: "%c3%82".capitalized, with: "Â")
            .replacingOccurrences(of: "%c3%84".capitalized, with: "Ä")
            .replacingOccurrences(of: "%c3%86".capitalized, with: "Æ")
            .replacingOccurrences(of: "%c3%87".capitalized, with: "Ç")
            .replacingOccurrences(of: "%c3%88".capitalized, with: "È")
            .replacingOccurrences(of: "%c3%89".capitalized, with: "É")
            .replacingOccurrences(of: "%c3%8a".capitalized, with: "Ê")
            .replacingOccurrences(of: "%c3%8b".capitalized, with: "Ë")
            .replacingOccurrences(of: "%c3%8f".capitalized, with: "Ï")
            .replacingOccurrences(of: "%c3%91".capitalized, with: "Ñ")
            .replacingOccurrences(of: "%c3%94".capitalized, with: "Ô")
            .replacingOccurrences(of: "%c3%96".capitalized, with: "Ö")
            .replacingOccurrences(of: "%c3%9b".capitalized, with: "Û")
            .replacingOccurrences(of: "%c3%9c".capitalized, with: "Ü")
            .replacingOccurrences(of: "%c3%a0".capitalized, with: "à")
            .replacingOccurrences(of: "%c3%a2".capitalized, with: "â")
            .replacingOccurrences(of: "%c3%a4".capitalized, with: "ä")
            .replacingOccurrences(of: "%c3%a6".capitalized, with: "æ")
            .replacingOccurrences(of: "%c3%a7".capitalized, with: "ç")
            .replacingOccurrences(of: "%c3%a8".capitalized, with: "è")
            .replacingOccurrences(of: "%c3%a9".capitalized, with: "é")
            .replacingOccurrences(of: "%c3%af".capitalized, with: "ï")
            .replacingOccurrences(of: "%c3%b4".capitalized, with: "ô")
            .replacingOccurrences(of: "%c3%b6".capitalized, with: "ö")
            .replacingOccurrences(of: "%c3%bb".capitalized, with: "û")
            .replacingOccurrences(of: "%c3%bc".capitalized, with: "ü")
            .replacingOccurrences(of: "%c3%bf".capitalized, with: "ÿ")
            .replacingOccurrences(of: "%20", with: " ")
    }
    
    /**
     Encode the given string to Base64
     
     - parameter string: String to encode
     
     - returns: Returns the encoded string
     */
    static func encodeToBase64(_ string: String) -> String {
        let data: Data = string.data(using: String.Encoding.utf8)!
        return data.base64EncodedString(options: NSData.Base64EncodingOptions(rawValue: 0))
    }
    
    /**
     Decode the given Base64 to string
     
     - parameter string: String to decode
     
     - returns: Returns the decoded string
     */
    static func decodeBase64(_ string: String) -> String {
        let data: Data = Data(base64Encoded: string as String, options: NSData.Base64DecodingOptions(rawValue: 0))!
        return NSString(data: data, encoding: String.Encoding.utf8.rawValue)! as String
    }
    
    
    static func isValid (_ string: String) -> Bool {
        return ((string.removeWhiteSpacesFromString() == "") || string.length == 0 || (string == "(null)") || (string.isEmpty)) ? false : true
    }
    
    func removeWhiteSpacesFromString() -> String {
        let trimmedString: String = self.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        return trimmedString
    }
    
    /**
     Remove double or more duplicated spaces
     
     - returns: String without additional spaces
     */
    var removeExcessiveSpaces: String {
        let components = self.components(separatedBy: CharacterSet.whitespaces)
        let filtered = components.filter({!$0.isEmpty})
        return filtered.joined(separator: " ")
    }
    
    /**
     Used to create an UUID as String
     
     - returns: Returns the created UUID string
     */
    static func generateUUID() -> String {
        let theUUID: CFUUID? = CFUUIDCreate(kCFAllocatorDefault)
        let string: CFString? = CFUUIDCreateString(kCFAllocatorDefault, theUUID)
        return string! as String
    }
    
    var parseJSONString: Any? {
        
        let data = self.data(using: String.Encoding.utf8, allowLossyConversion: false)
        
        if let jsonData = data {
            // Will return an object or nil if JSON decoding fails
            do {
                let message = try JSONSerialization.jsonObject(with: jsonData, options:.mutableContainers)
                if let jsonResult = message as? NSMutableArray {
                    return jsonResult //Will return the json array output
                } else {
                    return nil
                }
            }
            catch let error as NSError {
                print("An error occurred: \(error)")
                return nil
            }
        } else {
            // Lossless conversion of the string was not possible
            return nil
        }
    }
    
    var isBlank: Bool {
        get {
            let trimmed = trimmingCharacters(in: CharacterSet.whitespaces)
            return trimmed.isEmpty
        }
    }
    var isBackspace: Bool {
      let char = self.cString(using: String.Encoding.utf8)!
      return strcmp(char, "\\b") == -92
    }
    
    func isGIF() -> Bool {
        let imageFormats = ["gif"]
        if URL(string: self) != nil  {
            let extensi = (self as NSString).pathExtension
            return imageFormats.contains(extensi)
        }
        return false
    }
}

extension String {
    func fromBase64() -> String? {
        guard let data = Data(base64Encoded: self) else {
            return nil
        }
        return String(data: data, encoding: .utf8)
    }
    
    func toBase64() -> String {
        return Data(self.utf8).base64EncodedString()
    }
    func reverse() -> String  { return self.reduce("") { "\($1)" + $0 } }
}

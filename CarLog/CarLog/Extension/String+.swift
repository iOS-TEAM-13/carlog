import UIKit

extension String {
    // 대소문자, 특수문자, 숫자 8자 이상일 때 -> true
    func isValidPassword() -> Bool {
        let regularExpression = "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?=.*[$@$!%*?&])[A-Za-z\\d$@$!%*?&]{8,}"
        let passwordValidation = NSPredicate(format: "SELF MATCHES %@", regularExpression)
        return passwordValidation.evaluate(with: self)
    }

    // @와2글자 이상 확인 1@naver.com
    func isValidEmail() -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.(com|co\\.kr|net)"
        let emailTest = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: self)
    }

    func width(of font: UIFont) -> CGFloat {
        return (self as NSString).size(withAttributes: [.font: font]).width
    }

    func toDate() -> Date? { // "yyyy-MM-dd HH:mm:ss"
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy.MM.dd HH:mm:ss"
        dateFormatter.locale = Locale(identifier: "ko_KR")
        if let date = dateFormatter.date(from: self) {
            return date
        } else {
            return nil
        }
    }

    func toSaveDate() -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy.MM.dd"
        dateFormatter.timeZone = TimeZone(identifier: "UTC")
        if let date = dateFormatter.date(from: self) {
            return date
        } else {
            return nil
        }
    }

    func intervalToDate() -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        dateFormatter.timeZone = TimeZone(identifier: "UTC")
        if let date = dateFormatter.date(from: self) {
            return date
        } else {
            return nil
        }
    }

    func isValidateCarNumber(_ carNumber: String) -> Bool {
        // 최소 7자리 길이 검사
        if carNumber.count < 7 {
            print("7자리 이상")
            return false
        }

        return true
//        // 마지막 5번째 문자가 한글인 경우에만 유효
//        let index = cleanedCarNumber.index(cleanedCarNumber.endIndex, offsetBy: -4)
//        let lastFiveCharacters = cleanedCarNumber.suffix(4)
//        let lastCharacter = lastFiveCharacters[lastFiveCharacters.index(before: lastFiveCharacters.endIndex)]
//
//        if isValidKoreanString(String(lastCharacter)) {
//            print("성공")
//            return true
//        } else {
//            print("뭔가가 잘못됨")
//            return false
//        }
    }

    func isValidKoreanString(_ input: String) -> Bool {
        let koreanPattern = "^[가-힣]*$" // 정규표현식 패턴: 가부터 힣까지의 문자로만 이루어져야 함
        let regex = try! NSRegularExpression(pattern: koreanPattern)
        let range = NSRange(location: 0, length: input.utf16.count)

        if regex.firstMatch(in: input, options: [], range: range) != nil {
            return true // 유효한 한글 문자열
        } else {
            return false // 유효하지 않은 문자열
        }
    }
}

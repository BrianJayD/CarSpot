import Foundation

extension Int64
{
    // add option to convert to phone number String
    func toPhoneString() -> String
    {
        let phone = String(self)
        var format: String = ""
        
        if(phone.count > 10)
        {
        format = "X (XXX) XXX-XXXX"
        }
        else
        {
            format = "(XXX) XXX-XXXX"
        }

        let numbers = phone.replacingOccurrences(of: "[^0-9]", with: "", options: .regularExpression)
        var result = ""
        var index = numbers.startIndex

        for ch in format where index < numbers.endIndex
        {
            if ch == "X"
            {
                result.append(numbers[index])
                index = numbers.index(after: index)
            }
            else
            {
                result.append(ch)
            }
        }
        return result
    }
}

import Foundation
import Darwin

public func GetBSDProcessList() -> ([kinfo_proc]?)  {

    let name = [CTL_KERN, KERN_PROC, KERN_PROC_ALL, 0];
    let namePointer = name.withUnsafeBufferPointer { UnsafeMutablePointer<Int32>($0.baseAddress) }
    var length: Int = 0
    var done = false
    var result: [kinfo_proc]?
    var err: Int32

    repeat {
        err = sysctl(namePointer, u_int(name.count), nil, &length, nil, 0)
        if err == -1 {
            err = errno
        }
    
        if err == 0 {
            let count = length / strideof(kinfo_proc)
            result = [kinfo_proc](count: count, repeatedValue: kinfo_proc())
            err = result!.withUnsafeMutableBufferPointer({ (inout p: UnsafeMutableBufferPointer<kinfo_proc>) -> Int32 in
                return sysctl(namePointer, u_int(name.count), p.baseAddress, &length, nil, 0)
            })
            switch err {
            case 0:
                done = true
            case -1:
                err = errno
            case ENOMEM:
                err = 0
            default:
                fatalError()
            }
        }
    } while err == 0 && !done

    return result
}
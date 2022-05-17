//
//  filter.swift
//  core
//
//  Created by Apple on 19/09/2021.
//  Copyright © 2021 Haider Tamsil. All rights reserved.
//Filter for heartbeat

import Foundation;
class Filterr
{
    static let shareInstance = Filterr()
    
    var TAG: String = "Filter";
    func Filter(_ x: [Double])->[Double]
    {
        
        print("function started")
        let b: [Double] = [2.99292505132609e-05, 0.000119717002049047, 0.000179575503090668, 0.000119717002043274, 2.99292505160365e-05];
        let a: [Double] = [1, -3.59431388607942, 4.86321619744762, -2.93449288775772, 0.666069444397730];
//        var length: Int = x.count
        var result: [Double] = Array(repeating: 0.0, count: x.count);
        result[0] = b[0] * x[0];
        
        var i: Int = 0;
        print(x.count)
            while (i < x.count)
            {
                print(i)
                result[i] = 0.0;
                var j: Int = 0;
                if ((i < b.count) && (j < x.count))
                {
                    
                    result[i] += (b[i] * x[j]);
                }
                
                j = j + 1
                while (j <= i)
                {
                    
                    let k: Int = i - j;
                    if ((k < b.count) && (j < x.count))
                    {
                        result[i] += b[k] * x[j];
                    }
                    if ((k < x.count) && (j < a.count))
                    {
                        result[i] -= a[j] * result[k];
//                        print(result)
                    }
                    
                    j = j + 1
                }
                i = i + 1;
            }
    
        
            var k = 0;
            while (k < result.count)
            {
                result[k] *= 2.5;
                k += 1;
            }
        
        
        print("Function ended")
        return result
    }
}

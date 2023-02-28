/*
 MIT License

 Copyright (c) 2022 Calogero Sanfilippo

 Permission is hereby granted, free of charge, to any person obtaining a copy
 of this software and associated documentation files (the "Software"), to deal
 in the Software without restriction, including without limitation the rights
 to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 copies of the Software, and to permit persons to whom the Software is
 furnished to do so, subject to the following conditions:

 The above copyright notice and this permission notice shall be included in all
 copies or substantial portions of the Software.

 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 SOFTWARE.
 */

import SGPKitOBJC
import CoreLocation

private extension TLE {
	var asTLEWrapper: TLEWrapper {
		TLEWrapper(title: title, firstLine: firstLine, secondLine: secondLine)
	}
}

private extension SGPKitOBJC.SatelliteData {
	var asSatelliteData: SatelliteData {
		SatelliteData(latitude: latitude, longitude: longitude, speed: speed, altitude: altitude)
	}
}

private extension SGPKitOBJC.LookAngles {
    var asLookAngles: LookAngles {
        LookAngles(azimuth: azimuth, elevation: elevation, range: range, rangeRate: rangeRate)
    }
}

/// A class that calculates the satellite position, speed and altitude from a TLE set
public final class TLEInterpreter {

	public init() {}

	/// Returns a SatelliteData instance calculated from a TLE set
	///
	/// - parameter tle: The TLE set
	/// - parameter date: Date for which we want to obtain information about the satellite
	/// - returns: A `SatelliteData` describing the satellite
	public func satelliteData(from tle: TLE, date: Date) -> SatelliteData {
		let wrapper = SGP4Wrapper()
		let result: SGPKitOBJC.SatelliteData = wrapper.getSatelliteData(from: tle.asTLEWrapper, date: date)
		return result.asSatelliteData
	}
    
    /// Returns a LookAngles instance calculated from a TLE set and ground station coordinates and altitude
    ///
    /// - parameter tle: The TLE set
    /// - parameter date: Date for which we want to obtain information about the looking angles
    /// - returns: A LookAngles describing azimuth and elevation of satellite
    public func lookAngles(from tle: TLE, date: Date, coordinate: CLLocationCoordinate2D, altitude: Double) -> LookAngles {
        let wrapper = SGP4Wrapper()
        let result: SGPKitOBJC.LookAngles = wrapper.getLookFrom(tle.asTLEWrapper, date: date, coordinate: coordinate, altitude: altitude)
        return result.asLookAngles
    }
}

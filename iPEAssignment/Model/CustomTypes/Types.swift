import Foundation


enum DataType {
    case temperature, feelsLike, max, min, sunrise, sunset, rain, windSpeed, humidity, pressure, clouds, visibility, dewPoint, UIIndex
}

enum Temperature {
    case actual, morning, day, evening, night, max, min, feelsLike, feelsLikeMorning, feelsLikeDay, feelsLikeEvening, feelsLikeNight
}

enum SunTime {
    case sunrise, sunset
}

enum Wind {
    case speed, degrees
}

enum Coordinate {
    case lat, long
}


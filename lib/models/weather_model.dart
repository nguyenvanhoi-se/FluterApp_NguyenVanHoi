class WeatherModel {
  final String cityName;
  final double temperature;
  final double feelsLike;
  final double minTemperature;
  final double maxTemperature;
  final int humidity;
  final double windSpeed;
  final String description;
  final String iconCode;

  const WeatherModel({
    required this.cityName,
    required this.temperature,
    required this.feelsLike,
    required this.minTemperature,
    required this.maxTemperature,
    required this.humidity,
    required this.windSpeed,
    required this.description,
    required this.iconCode,
  });

  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    final List<dynamic> weatherList =
        json['weather'] as List<dynamic>;

    final Map<String, dynamic> weather =
        weatherList.first as Map<String, dynamic>;

    final Map<String, dynamic> main =
        json['main'] as Map<String, dynamic>;

    final Map<String, dynamic> wind =
        (json['wind'] as Map<String, dynamic>?) ?? {};

    return WeatherModel(
      cityName: json['name'] as String? ?? 'Unknown',
      temperature: (main['temp'] as num?)?.toDouble() ?? 0,
      feelsLike: (main['feels_like'] as num?)?.toDouble() ?? 0,
      minTemperature: (main['temp_min'] as num?)?.toDouble() ?? 0,
      maxTemperature: (main['temp_max'] as num?)?.toDouble() ?? 0,
      humidity: (main['humidity'] as num?)?.toInt() ?? 0,
      windSpeed: (wind['speed'] as num?)?.toDouble() ?? 0,
      description:
          weather['description'] as String? ?? 'Unknown',
      iconCode: weather['icon'] as String? ?? '01d',
    );
  }

  String get temperatureText =>
      '${temperature.round()}°';

  String get feelsLikeText =>
      '${feelsLike.round()}°';

  String get minTemperatureText =>
      '${minTemperature.round()}°';

  String get maxTemperatureText =>
      '${maxTemperature.round()}°';

  String get descriptionText {
    if (description.isEmpty) {
      return '';
    }

    return description[0].toUpperCase() +
        description.substring(1);
  }

  String get windSpeedText =>
      '${windSpeed.toStringAsFixed(1)} m/s';

  String get iconUrl =>
      'https://openweathermap.org/img/wn/$iconCode@4x.png';
}
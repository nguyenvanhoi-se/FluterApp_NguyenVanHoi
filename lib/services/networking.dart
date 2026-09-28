import 'dart:convert';

import 'package:http/http.dart' as http;

import '../constants/constants.dart';
import '../models/weather_model.dart';

class NetworkingService {
  // ===================================================
  // LẤY THỜI TIẾT THEO TỌA ĐỘ
  // ===================================================

  Future<WeatherModel> getWeatherByCoordinates({
    required double latitude,
    required double longitude,
  }) async {
    final Uri url = Uri.parse(
      openWeatherBaseUrl,
    ).replace(
      queryParameters: {
        'lat': latitude.toString(),
        'lon': longitude.toString(),
        'appid': openWeatherApiKey,
        'units': 'metric',
        'lang': 'en',
      },
    );

    final http.Response response = await http.get(url);

    if (response.statusCode != 200) {
      throw Exception(
        'Weather request failed: ${response.statusCode}',
      );
    }

    final Map<String, dynamic> data =
        jsonDecode(response.body) as Map<String, dynamic>;

    return WeatherModel.fromJson(data);
  }

  // ===================================================
  // TÌM TỌA ĐỘ THEO TÊN THÀNH PHỐ
  // ===================================================

  Future<WeatherModel> getWeatherByCity(
    String city,
  ) async {
    final String cityName = city.trim();

    if (cityName.isEmpty) {
      throw Exception(
        'Please enter a city name.',
      );
    }

    // -------------------------------------------------
    // Bước 1: tìm latitude + longitude của thành phố
    // -------------------------------------------------

    final Uri geocodingUrl = Uri.parse(
      openWeatherGeocodingUrl,
    ).replace(
      queryParameters: {
        'q': cityName,
        'limit': '1',
        'appid': openWeatherApiKey,
      },
    );

    final http.Response geoResponse =
        await http.get(geocodingUrl);

    if (geoResponse.statusCode != 200) {
      throw Exception(
        'City search failed: ${geoResponse.statusCode}',
      );
    }

    final List<dynamic> locations =
        jsonDecode(geoResponse.body) as List<dynamic>;

    if (locations.isEmpty) {
      throw Exception(
        'City not found.',
      );
    }

    final Map<String, dynamic> location =
        locations.first as Map<String, dynamic>;

    final double latitude =
        (location['lat'] as num).toDouble();

    final double longitude =
        (location['lon'] as num).toDouble();

    // -------------------------------------------------
    // Bước 2: lấy thời tiết theo tọa độ
    // -------------------------------------------------

    return getWeatherByCoordinates(
      latitude: latitude,
      longitude: longitude,
    );
  }
}
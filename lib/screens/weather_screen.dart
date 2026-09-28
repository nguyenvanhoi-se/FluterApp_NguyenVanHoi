import 'package:flutter/material.dart';

import '../components/weather_info.dart';
import '../models/weather_model.dart';
import '../services/location.dart';
import '../services/networking.dart';
import 'city_screen.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() =>
      _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  final LocationService _locationService =
      LocationService();

  final NetworkingService _networkingService =
      NetworkingService();

  WeatherModel? _weather;

  bool _loading = true;

  String? _errorMessage;

  @override
  void initState() {
    super.initState();

    _loadCurrentLocationWeather();
  }

  // =====================================================
  // CURRENT LOCATION
  // =====================================================

  Future<void> _loadCurrentLocationWeather() async {
    setState(() {
      _loading = true;
      _errorMessage = null;
    });

    try {
      final position =
          await _locationService.getCurrentLocation();

      final weather =
          await _networkingService
              .getWeatherByCoordinates(
        latitude: position.latitude,
        longitude: position.longitude,
      );

      if (!mounted) {
        return;
      }

      setState(() {
        _weather = weather;
        _loading = false;
      });
    } catch (e) {
      if (!mounted) {
        return;
      }

      setState(() {
        _loading = false;
        _errorMessage =
            e.toString().replaceFirst(
                  'Exception: ',
                  '',
                );
      });
    }
  }

  // =====================================================
  // SEARCH CITY
  // =====================================================

  Future<void> _searchCity(String city) async {
    try {
      final weather =
          await _networkingService.getWeatherByCity(
        city,
      );

      if (!mounted) {
        return;
      }

      setState(() {
        _weather = weather;
        _errorMessage = null;
      });
    } catch (e) {
      rethrow;
    }
  }

  // =====================================================
  // OPEN SEARCH SCREEN
  // =====================================================

  Future<void> _openSearchScreen() async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CityScreen(
          onSearch: _searchCity,
        ),
      ),
    );
  }

  // =====================================================
  // BUILD
  // =====================================================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF4A90E2),
              Color(0xFF5B8DEF),
              Color(0xFF6F7BF7),
              Color(0xFF7667D9),
            ],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(
              20,
              12,
              20,
              10,
            ),
            child: Column(
              children: [
                // =========================================
                // TOP BAR
                // =========================================

                Row(
                  children: [
                    Container(
                      width: 45,
                      height: 45,
                      decoration: BoxDecoration(
                        color:
                            Colors.white.withValues(alpha: 0.14),
                        borderRadius:
                            BorderRadius.circular(14),
                      ),
                      child: IconButton(
                        tooltip: 'Current location',
                        onPressed: _loading
                            ? null
                            : _loadCurrentLocationWeather,
                        icon: const Icon(
                          Icons.my_location_rounded,
                          color: Colors.white,
                          size: 21,
                        ),
                      ),
                    ),

                    const Expanded(
                      child: Text(
                        'CLIMA',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 4,
                        ),
                      ),
                    ),

                    Container(
                      width: 45,
                      height: 45,
                      decoration: BoxDecoration(
                        color:
                            Colors.white.withValues(alpha: 0.14),
                        borderRadius:
                            BorderRadius.circular(14),
                      ),
                      child: IconButton(
                        tooltip: 'Search city',
                        onPressed:
                            _loading ? null : _openSearchScreen,
                        icon: const Icon(
                          Icons.search_rounded,
                          color: Colors.white,
                          size: 24,
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 15),

                // =========================================
                // SEARCH BAR
                // =========================================

                GestureDetector(
                  onTap:
                      _loading ? null : _openSearchScreen,
                  child: Container(
                    height: 53,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius:
                          BorderRadius.circular(17),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black
                              .withValues(alpha: 0.10),
                          blurRadius: 18,
                          offset: const Offset(0, 7),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.search_rounded,
                          color: Colors.black54,
                        ),

                        const SizedBox(width: 10),

                        const Expanded(
                          child: Text(
                            'Search for a city...',
                            style: TextStyle(
                              color: Colors.black45,
                              fontSize: 15,
                            ),
                          ),
                        ),

                        Container(
                          padding:
                              const EdgeInsets.symmetric(
                            horizontal: 14,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xFF4D8FE8),
                            borderRadius:
                                BorderRadius.circular(11),
                          ),
                          child: const Text(
                            'Search',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 18),

                // =========================================
                // WEATHER
                // =========================================

                Expanded(
                  child: _buildContent(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // =====================================================
  // CONTENT
  // =====================================================

  Widget _buildContent() {
    if (_loading) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 38,
              height: 38,
              child: CircularProgressIndicator(
                strokeWidth: 3,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 18),
            Text(
              'Loading weather...',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
            ),
          ],
        ),
      );
    }

    if (_errorMessage != null) {
      return Center(
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.13),
            borderRadius: BorderRadius.circular(24),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.cloud_off_rounded,
                color: Colors.white,
                size: 60,
              ),

              const SizedBox(height: 16),

              const Text(
                'Unable to load weather',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 10),

              Text(
                _errorMessage!,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color:
                      Colors.white.withValues(alpha: 0.75),
                  fontSize: 14,
                ),
              ),

              const SizedBox(height: 20),

              ElevatedButton.icon(
                onPressed: _loadCurrentLocationWeather,
                icon: const Icon(
                  Icons.refresh_rounded,
                ),
                label: const Text(
                  'TRY AGAIN',
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor:
                      const Color(0xFF4A78DB),
                  padding:
                      const EdgeInsets.symmetric(
                    horizontal: 22,
                    vertical: 13,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(14),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }

    if (_weather == null) {
      return const Center(
        child: Text(
          'No weather data',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
          ),
        ),
      );
    }

    return WeatherInfo(
      weather: _weather!,
    );
  }
}
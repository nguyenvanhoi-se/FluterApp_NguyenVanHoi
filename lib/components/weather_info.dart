import 'package:flutter/material.dart';

import '../models/weather_model.dart';

class WeatherInfo extends StatelessWidget {
  final WeatherModel weather;

  const WeatherInfo({
    super.key,
    required this.weather,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        children: [
          // =================================================
          // CITY
          // =================================================

          Text(
            weather.cityName,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 34,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.5,
            ),
          ),

          const SizedBox(height: 5),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.location_on_rounded,
                color: Colors.white70,
                size: 17,
              ),
              const SizedBox(width: 4),
              Text(
                'Current location',
                style: TextStyle(
                  color: Colors.white.withValues(alpha: 0.7),
                  fontSize: 14,
                ),
              ),
            ],
          ),

          const SizedBox(height: 20),

          // =================================================
          // MAIN WEATHER CARD
          // =================================================

          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(
              horizontal: 24,
              vertical: 25,
            ),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.14),
              borderRadius: BorderRadius.circular(28),
              border: Border.all(
                color: Colors.white.withValues(alpha: 0.15),
              ),
            ),
            child: Column(
              children: [
                // WEATHER ICON
                Container(
                  width: 150,
                  height: 150,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white.withValues(alpha: 0.10),
                  ),
                  child: Image.network(
                    weather.iconUrl,
                    fit: BoxFit.contain,
                    errorBuilder: (
                      context,
                      error,
                      stackTrace,
                    ) {
                      return const Icon(
                        Icons.cloud_rounded,
                        size: 90,
                        color: Colors.white,
                      );
                    },
                  ),
                ),

                const SizedBox(height: 12),

                // TEMPERATURE
                Text(
                  weather.temperatureText,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 78,
                    height: 0.95,
                    fontWeight: FontWeight.w300,
                  ),
                ),

                const SizedBox(height: 12),

                // DESCRIPTION
                Text(
                  weather.descriptionText,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 21,
                    fontWeight: FontWeight.w600,
                  ),
                ),

                const SizedBox(height: 8),

                Text(
                  'Feels like ${weather.feelsLikeText}',
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.68),
                    fontSize: 15,
                  ),
                ),

                const SizedBox(height: 20),

                // MIN / MAX
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _TemperatureItem(
                      icon: Icons.arrow_downward_rounded,
                      title: 'Min',
                      value: weather.minTemperatureText,
                    ),
                    const SizedBox(width: 35),
                    _TemperatureItem(
                      icon: Icons.arrow_upward_rounded,
                      title: 'Max',
                      value: weather.maxTemperatureText,
                    ),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(height: 18),

          // =================================================
          // INFORMATION TITLE
          // =================================================

          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Weather details',
              style: TextStyle(
                color: Colors.white.withValues(alpha: 0.9),
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),

          const SizedBox(height: 12),

          // =================================================
          // STATS
          // =================================================

          Row(
            children: [
              Expanded(
                child: _WeatherDetailCard(
                  icon: Icons.water_drop_rounded,
                  title: 'Humidity',
                  value: '${weather.humidity}%',
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _WeatherDetailCard(
                  icon: Icons.air_rounded,
                  title: 'Wind speed',
                  value: weather.windSpeedText,
                ),
              ),
            ],
          ),

          const SizedBox(height: 12),

          Row(
            children: [
              Expanded(
                child: _WeatherDetailCard(
                  icon: Icons.thermostat_rounded,
                  title: 'Min temp',
                  value: weather.minTemperatureText,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _WeatherDetailCard(
                  icon: Icons.wb_sunny_rounded,
                  title: 'Max temp',
                  value: weather.maxTemperatureText,
                ),
              ),
            ],
          ),

          const SizedBox(height: 20),
        ],
      ),
    );
  }
}

// =======================================================
// TEMPERATURE ITEM
// =======================================================

class _TemperatureItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;

  const _TemperatureItem({
    required this.icon,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          color: Colors.white70,
          size: 18,
        ),
        const SizedBox(width: 4),
        Text(
          '$title ',
          style: TextStyle(
            color: Colors.white.withValues(alpha: 0.65),
            fontSize: 14,
          ),
        ),
        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 15,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}

// =======================================================
// WEATHER DETAIL CARD
// =======================================================

class _WeatherDetailCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;

  const _WeatherDetailCard({
    required this.icon,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 14,
        vertical: 16,
      ),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.10),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.10),
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              icon,
              color: Colors.white,
              size: 20,
            ),
          ),

          const SizedBox(width: 10),

          Expanded(
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.60),
                    fontSize: 12,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  value,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
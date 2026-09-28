import 'package:flutter/material.dart';

class CityScreen extends StatefulWidget {
  final Future<void> Function(String city) onSearch;

  const CityScreen({
    super.key,
    required this.onSearch,
  });

  @override
  State<CityScreen> createState() =>
      _CityScreenState();
}

class _CityScreenState extends State<CityScreen> {
  final TextEditingController _controller =
      TextEditingController();

  bool _loading = false;

  Future<void> _search() async {
    final city = _controller.text.trim();

    if (city.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter a city name.'),
        ),
      );
      return;
    }

    setState(() {
      _loading = true;
    });

    try {
      await widget.onSearch(city);

      if (!mounted) {
        return;
      }

      Navigator.pop(context);
    } catch (e) {
      if (!mounted) {
        return;
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.red.shade700,
          content: Text(
            e.toString().replaceFirst(
                  'Exception: ',
                  '',
                ),
          ),
        ),
      );
    } finally {
      if (mounted) {
        setState(() {
          _loading = false;
        });
      }
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

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
              Color(0xFF6F7BF7),
              Color(0xFF7667D9),
            ],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                // TOP BAR
                Row(
                  children: [
                    Container(
                      width: 45,
                      height: 45,
                      decoration: BoxDecoration(
                        color: Colors.white
                            .withValues(alpha: 0.14),
                        borderRadius:
                            BorderRadius.circular(14),
                      ),
                      child: IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(
                          Icons.arrow_back_rounded,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    const Expanded(
                      child: Text(
                        'SEARCH CITY',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 2,
                        ),
                      ),
                    ),
                    const SizedBox(width: 45),
                  ],
                ),

                const SizedBox(height: 45),

                // TITLE
                const Text(
                  'Find your city',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 8),

                Text(
                  'Search for current weather anywhere',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color:
                        Colors.white.withValues(alpha: 0.72),
                    fontSize: 15,
                  ),
                ),

                const SizedBox(height: 30),

                // SEARCH FIELD
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius:
                        BorderRadius.circular(18),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black
                            .withValues(alpha: 0.10),
                        blurRadius: 20,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                  child: TextField(
                    controller: _controller,
                    autofocus: true,
                    textInputAction:
                        TextInputAction.search,
                    onSubmitted: (_) {
                      _search();
                    },
                    style: const TextStyle(
                      fontSize: 17,
                    ),
                    decoration: const InputDecoration(
                      hintText: 'Enter city name...',
                      prefixIcon: Icon(
                        Icons.location_city_rounded,
                      ),
                      border: InputBorder.none,
                      contentPadding:
                          EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 17,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 18),

                // BUTTON
                SizedBox(
                  width: double.infinity,
                  height: 55,
                  child: ElevatedButton(
                    onPressed: _loading ? null : _search,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor:
                          const Color(0xFF4A78DB),
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(17),
                      ),
                      elevation: 0,
                    ),
                    child: _loading
                        ? const SizedBox(
                            width: 24,
                            height: 24,
                            child:
                                CircularProgressIndicator(
                              strokeWidth: 2.5,
                            ),
                          )
                        : const Row(
                            mainAxisAlignment:
                                MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.search_rounded,
                              ),
                              SizedBox(width: 8),
                              Text(
                                'SEARCH WEATHER',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                  ),
                ),

                const Spacer(),

                Icon(
                  Icons.cloud_rounded,
                  size: 80,
                  color: Colors.white
                      .withValues(alpha: 0.15),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
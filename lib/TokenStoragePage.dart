import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http show get, post;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

// =========================================================================
// I. MODELS
// =========================================================================

class LoginResponse {
  final String accessToken;
  final String refreshToken;
  final int id;
  final String username;

  LoginResponse({
    required this.accessToken,
    required this.refreshToken,
    required this.id,
    required this.username,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      accessToken: json['token'] as String? ?? json['accessToken'] as String,
      refreshToken: json['refreshToken'] as String? ?? '',
      id: json['id'] as int,
      username: json['username'] as String,
    );
  }
}

class User {
  final int id;
  final String firstName;
  final String lastName;
  final String email;
  final String phone;
  final String image;
  final Address address;

  User({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phone,
    required this.image,
    required this.address,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] as int,
      firstName: json['firstName'] as String,
      lastName: json['lastName'] as String,
      email: json['email'] as String,
      phone: json['phone'] as String,
      image: json['image'] as String,
      address: Address.fromJson(json['address']),
    );
  }
}

class Address {
  final String address;
  final String city;
  final String country;

  Address({
    required this.address,
    required this.city,
    required this.country,
  });

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      address: json['address'] as String,
      city: json['city'] as String,
      country: json['country'] as String,
    );
  }
}

// =========================================================================
// II. SERVICES
// =========================================================================

class TokenStorage {
  final _storage = const FlutterSecureStorage();
  static const _accessTokenKey = 'accessToken';

  Future<void> saveAccessToken(String token) async {
    await _storage.write(key: _accessTokenKey, value: token);
  }

  Future<String?> getAccessToken() async {
    return await _storage.read(key: _accessTokenKey);
  }

  Future<void> deleteAccessToken() async {
    await _storage.delete(key: _accessTokenKey);
  }
}

class AuthService {
  static const String _baseUrl = "https://dummyjson.com";
  final TokenStorage _tokenStorage = TokenStorage();

  Future<LoginResponse> login(String username, String password) async {
    final response = await http.post(
      Uri.parse('$_baseUrl/auth/login'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'username': username, 'password': password}),
    );

    if (response.statusCode == 200) {
      final jsonMap = jsonDecode(response.body);
      final loginResponse = LoginResponse.fromJson(jsonMap);
      await _tokenStorage.saveAccessToken(loginResponse.accessToken);
      return loginResponse;
    } else {
      throw Exception('Đăng nhập thất bại (${response.statusCode})');
    }
  }

  Future<User> fetchUserProfile(int userId) async {
    final token = await _tokenStorage.getAccessToken();
    if (token == null) throw Exception('Token không tồn tại!');

    final response = await http.get(
      Uri.parse('$_baseUrl/users/$userId'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      },
    );

    if (response.statusCode == 200) {
      return User.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Token hết hạn hoặc không hợp lệ');
    }
  }

  Future<void> logout() async => await _tokenStorage.deleteAccessToken();
}

// =========================================================================
// III. TOKEN STORAGE PAGE (Dùng cho MainNavigator)
// =========================================================================

class TokenStoragePage extends StatefulWidget {
  const TokenStoragePage({super.key});

  @override
  State<TokenStoragePage> createState() => _TokenStoragePageState();
}

class _TokenStoragePageState extends State<TokenStoragePage> {
  final TokenStorage _tokenStorage = TokenStorage();
  bool _isAuthenticated = false;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _checkAuth();
  }

  Future<void> _checkAuth() async {
    final token = await _tokenStorage.getAccessToken();
    if (mounted) {
      setState(() {
        _isAuthenticated = token != null;
        _isLoading = false;
      });
    }
  }

  void _setAuth(bool value) {
    setState(() => _isAuthenticated = value);
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    return _isAuthenticated
        ? ProfileScreen(onLogout: () => _setAuth(false))
        : LoginScreen(onLoginSuccess: () => _setAuth(true));
  }
}

// =========================================================================
// IV. UI SCREENS
// =========================================================================

class LoginScreen extends StatelessWidget {
  final VoidCallback onLoginSuccess;
  LoginScreen({super.key, required this.onLoginSuccess});

  final _usernameController = TextEditingController(text: "emilys");
  final _passwordController = TextEditingController(text: "emilyspass");
  final AuthService _authService = AuthService();

  void _handleLogin(BuildContext context) async {
    try {
      await _authService.login(
        _usernameController.text,
        _passwordController.text,
      );
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Đăng nhập thành công!")),
        );
        onLoginSuccess();
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Lỗi: $e")),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF6A11CB), Color(0xFF2575FC)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Center(
        child: SingleChildScrollView(
          child: Card(
            elevation: 12,
            margin: const EdgeInsets.all(24),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
            child: Padding(
              padding: const EdgeInsets.all(26),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text("Đăng Nhập", style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 20),
                  TextField(
                    controller: _usernameController,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.person),
                      labelText: "Username",
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
                    ),
                  ),
                  const SizedBox(height: 15),
                  TextField(
                    controller: _passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.lock),
                      labelText: "Password",
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
                    ),
                  ),
                  const SizedBox(height: 25),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () => _handleLogin(context),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blueAccent,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                      ),
                      child: const Text("Đăng nhập", style: TextStyle(fontSize: 18, color: Colors.white)),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class ProfileScreen extends StatefulWidget {
  final VoidCallback onLogout;
  const ProfileScreen({super.key, required this.onLogout});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late Future<User> _futureUser;
  final AuthService _auth = AuthService();
  final int _userId = 1;

  @override
  void initState() {
    super.initState();
    _futureUser = _auth.fetchUserProfile(_userId);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<User>(
      future: _futureUser,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return Center(child: Text("Lỗi: ${snapshot.error}"));
        }

        final user = snapshot.data!;
        return SingleChildScrollView(
          child: Column(
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 30),
                decoration: const BoxDecoration(
                  gradient: LinearGradient(colors: [Color(0xFF2575FC), Color(0xFF6A11CB)]),
                ),
                child: Column(
                  children: [
                    CircleAvatar(radius: 55, backgroundImage: NetworkImage(user.image)),
                    const SizedBox(height: 12),
                    Text("${user.firstName} ${user.lastName}",
                        style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: Colors.white)),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    _infoCard("Thông tin cá nhân", [
                      _infoTile(Icons.badge, "ID:", user.id.toString()),
                      _infoTile(Icons.email, "Email:", user.email),
                      _infoTile(Icons.phone, "Điện thoại:", user.phone),
                    ]),
                    const SizedBox(height: 20),
                    _infoCard("Địa chỉ", [
                      _infoTile(Icons.home, "Địa chỉ:", user.address.address),
                      _infoTile(Icons.location_city, "Thành phố:", user.address.city),
                      _infoTile(Icons.flag, "Quốc gia:", user.address.country),
                    ]),
                    const SizedBox(height: 30),
                    ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.red, minimumSize: const Size.fromHeight(50)),
                      onPressed: () async {
                        await _auth.logout();
                        widget.onLogout();
                      },
                      icon: const Icon(Icons.logout, color: Colors.white),
                      label: const Text("Đăng xuất", style: TextStyle(color: Colors.white)),
                    )
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _infoCard(String title, List<Widget> children) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(title, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          const Divider(),
          ...children,
        ]),
      ),
    );
  }

  Widget _infoTile(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(children: [
        Icon(icon, color: Colors.blueAccent),
        const SizedBox(width: 10),
        Text(label, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16)),
        const SizedBox(width: 10),
        Expanded(child: Text(value, style: const TextStyle(fontSize: 16, color: Colors.black87))),
      ]),
    );
  }
}
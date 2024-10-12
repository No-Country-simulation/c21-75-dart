enum UserRole {
  student, // 0
  instructor, // 1
  admin // 2
}

// Función para convertir el enum a String o int
String roleToString(UserRole role) {
  return role.toString().split('.').last; // 'student', 'instructor', 'admin'
}

int roleToInt(UserRole role) {
  return role.index; // 0, 1, 2
}

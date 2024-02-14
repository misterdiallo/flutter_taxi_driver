import 'dart:math';
import 'dart:math';

String generateChinesePlateNumber(String cityCode) {
  // Define the possible characters and numbers for Chinese license plates
  List<String> characters = [
    '京',
    '津',
    '沪',
    '渝',
    '冀',
    '豫',
    '云',
    '辽',
    '黑',
    '湘',
    '皖',
    '鲁',
    '新',
    '苏',
    '浙',
    '赣',
    '鄂',
    '桂',
    '甘',
    '晋',
    '蒙',
    '陕',
    '吉',
    '闽',
    '贵',
    '粤',
    '青',
    '藏',
    '川',
    '宁',
    '琼'
  ];
  List<String> numbers = [
    'A',
    'B',
    'C',
    'D',
    'E',
    'F',
    'G',
    'H',
    'J',
    'K',
    'L',
    'M',
    'N',
    'P',
    'Q',
    'R',
    'S',
    'T',
    'U',
    'V',
    'W',
    'X',
    'Y',
    'Z'
  ];
  List<int> codes = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9];

  // Add the city code as the prefix
  String plateNumber = cityCode;

  // Randomly select one character and five numbers
  plateNumber += characters[Random().nextInt(characters.length)];
  for (int i = 0; i < 5; i++) {
    plateNumber += numbers[Random().nextInt(numbers.length)];
  }

  // Add a random region code (e.g., 0-9)
  plateNumber += codes[Random().nextInt(codes.length)].toString();

  return plateNumber;
}

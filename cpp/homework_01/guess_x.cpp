// Oleh Ortynskyi
#include <iostream>

int GetRandomNumber(int min_num, int max_num);

int main(){

   srand(time(NULL));

  int min = 0;
  int max = 100;
  int n, x;

  while (true)
  {
    x = GetRandomNumber(min, max);

    std::cout << "Random number is: " << x << std::endl;
    std::cout << "Enter the integer in range from " << min << " to " << max << ":" << std::endl;
    std::cin >> n;

    if (n == x)
    {
      std::cout << "You win, integer: " << n << std::endl;
      break;
    }

    if (n < min || n > max)
    {
      std::cout << "Wrong range! Try again" << std::endl;
      continue;
    }

    std::cout << "Upss... :(" << std::endl;
    if (n > x)
    {
      max = n;
      min = x;
    }
    else
    {
      max = x;
      min = n;
    }
  }
    return 0;
}

int GetRandomNumber(int min_num, int max_num)
{
  int num = min_num + rand() % (max_num - min_num + 1);
  return num;
}
/**
 * @file main.c
 * @author Frantisek Spunda
 * @date 2023-07-10
 * @brief Description of this project
 *
 * @copyright Copyright (c) 2023
 *
 */

#include <stdio.h>
#include <stdlib.h>
#include "main.h"
#include "lib.h"

// include library for math functions

int *makeArray(int size);
int *makeArray(int size);
void writeFile();
int getBiggestDevider(int a, int b);
void printBackwards(int *arr, int size);
int getAverage(int *arr, int size);
int getMax(int *arr, int size);

int main(void)
{

  int test = bobek();
  printf("%i", test);

  // int userInput[5];

  // printf("Select 5 numbers: ");
  // for (int i = 0; i < 5; i++)
  // {
  //   scanf("%d", &userInput[i]);
  // }

  // int value = getBiggestDevider(userInput[0], userInput[1]);
  // printBackwards(userInput, 5);
  // int average = getAverage(userInput, 5);
  // int max = getMax(userInput, 5);

  // printf("\nBiggest devider: %i\n", value);
  // printf("Average: %i\n", average);
  // printf("Max: %i\n", max);

  // writeFile();

  // ! MEMORY OPERATIONS
  // int *b = intiger();
  // int size = 5;
  // char string[] = "Test";

  // string[0] = string[0] + ('a' - 'A');

  // printf("%s\n", string);

  // int *myArray = makeArray(size);
  // myArray[2] = -1;
  // *(myArray + 1) = 5;

  // for (int i = 0; i < size; ++i)
  // {
  //   printf("%i ", *(myArray + i));
  // }

  // free(myArray);

  return 0;
}

int getMax(int *arr, int size)
{
  int max = arr[0];
  for (int i = 1; i < size; i++)
  {
    if (arr[i] > max)
      max = arr[i];
  }

  return max;
}

int getAverage(int *arr, int size)
{
  int sum = 0;
  for (int i = 0; i < size; ++i)
  {
    sum += arr[i];
  }

  return sum / size;
}

void printBackwards(int *arr, int size)
{
  for (int i = size - 1; i >= 0; --i)
  {
    printf("%i ", arr[i]);
  }
}

int getBiggestDevider(int a, int b)
{

  int biggest = a > b ? a : b;

  for (int i = biggest; i > 0; --i)
  {
    if (a % i == 0 && b % i == 0)
    {
      return i;
    }
  }

  return 1;
}

int *makeInt()
{
  int *a = malloc(sizeof(int));
  *a = 4;

  return a;
}

int *makeArray(int size)
{
  int *arr = (int *)malloc(sizeof(int) * size);
  if (arr == NULL)
  {
    fprintf(stderr, "Chyba při alokaci paměti pro pole.\n");
    exit(1);
  }

  for (int i = 0; i < size; ++i)
  {
    arr[i] = i;
  }

  return arr;
}

void writeFile()
{
  FILE *file;
  file = fopen("test.txt", "w");
  // repeat 100 times
  for (int i = 0; i < 100; ++i)
  {
    fprintf(file, "Number %i\n", i);
  }
  fclose(file);

  file = fopen("test.txt", "r");
  char content[255];
  while (fgets(content, 100, file))
  {
    printf("%s", content);
  };
  fclose(file);
}

/**
 * @brief Calculate factorial
 *
 * @param number
 * @return int
 */
int factorial(int number)
{
  int factorial = 1;

  for (int i = number; i > 0; --i)
  {
    factorial *= i;
  }

  return factorial;
}
#include <stdio.h>

int main() {
    int num1, num2, num3, sum;

    // Prompt the user for three numbers
    printf("Enter the first number: ");
    scanf("%d", &num1);
    printf("Enter the second number: ");
    scanf("%d", &num2);
    printf("Enter the third number: ");
    scanf("%d", &num3);

    // Calculate the sum
    sum = num1 + num2 + num3;

    // Print the result
    printf("The sum of %d, %d, and %d is: %d\n", num1, num2, num3, sum);

    return 0;
}

import 'dart:io';

import 'package:four_functions_probs/four_functions_probs.dart' as four_functions_probs;

void main(List<String> arguments) {
 
//  Write a program to tally up total change from user’s pockets. The method GetTotal() will have
// number of pennies, nickels, dimes, quarters, loonies and twoonies passed into it and will return the
// total amount. All values entered must be integers and positive. Validation is required to ensure a
// negative value is not allowed.

print('Enter number of pennies ');

int pennies = validateInput();
print('Enter number of nickles ');

int nickels = validateInput();
print('Enter number of dimes ');

int dimes = validateInput();
print('Enter number of quarters ');

int quarters = validateInput();
print('Enter number of loonies ');

int loonies = validateInput();
print('Enter number of twoonies ');

int twoonies = validateInput();

double total = getTotal(pennies,nickels,dimes,quarters,loonies,twoonies);

print('total value is $total');
}

double getTotal(int pennies, int nickles, int dimes, int quarters,int loonies,int twoonies ){
  const double penny = 0.01;
  const double nickle = 0.05;
  const double dime = 0.10;
  const double quarter = 0.25;
  const double loonie = 1.0;
  const double twoonie = 2.0;

  double totalValue = (pennies*penny)+(nickles*nickle)+(dimes*dime)+(quarters*quarter)+(loonies*loonie)+(twoonies*twoonie);

  return totalValue;
}

int validateInput(){
  int? value;
  while(true){
    String? input = stdin.readLineSync();
    value = int.tryParse(input!);

    if(value != null && value >= 0){
      return value;
    } else{
      print('Please enter a valid positive integer');
    }
  }
}
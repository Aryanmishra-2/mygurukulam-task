package com.company.utils

class AnsibleRoleCD implements Serializable {
  
def add(a, b) {
    return CalculatorUtils.add(a as double, b as double)
}

def subtract(a, b) {
    return CalculatorUtils.subtract(a as double, b as double)
}

def multiply(a, b) {
    return CalculatorUtils.multiply(a as double, b as double)
}

def divide(a, b) {
    return CalculatorUtils.divide(a as double, b as double)
}

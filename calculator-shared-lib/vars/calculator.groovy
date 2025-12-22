import com.company.utils.Email
import com.company.utils.CalculatorUtils

def add(a, b) {
    CalculatorUtils.add(a as double, b as double)
}

def subtract(a, b) {
    CalculatorUtils.subtract(a as double, b as double)
}

def multiply(a, b) {
    CalculatorUtils.multiply(a as double, b as double)
}

def divide(a, b) {
    CalculatorUtils.divide(a as double, b as double)
}

def notify(Boolean success, String recipient, String reportUrl = null) {
    new Email(this).send(success, recipient, reportUrl)
}

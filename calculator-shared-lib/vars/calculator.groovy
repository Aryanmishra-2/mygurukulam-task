import com.company.utils.CalculatorUtils
import com.company.utils.Email

def call(String operation, a, b) {

    switch (operation) {

        case 'add':
            return CalculatorUtils.add(a as double, b as double)

        case 'sub':
            return CalculatorUtils.subtract(a as double, b as double)

        case 'mul':
            return CalculatorUtils.multiply(a as double, b as double)

        case 'div':
            return CalculatorUtils.divide(a as double, b as double)

        default:
            error "Invalid operation: ${operation}"
    }
}

def notify(Boolean success, String recipient) {
    new Email(this).send(success, recipient)
}

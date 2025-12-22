import com.company.utils.*

def call(Map config) {

    try {

        stage('Clean Workspace') {
            new CleanWorkspace(this).run()
        }

        stage('Calculator Utils') {
            new CalculatorUtils(this).run()
        }

        stage('Publish Success Report') {
            new PublishReport(this).send(
                'SUCCESS',
                config.email
            )
        }

    } catch (err) {

        stage('Publish Failure Report') {
            new PublishReport(this).send(
                'FAILURE',
                config.email
            )
        }

        throw err

    } finally {

        echo "CD Pipeline execution completed."

    }
}

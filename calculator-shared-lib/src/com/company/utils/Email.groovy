package com.company.utils.Email

class Email implements Serializable {
    def script
    Email(script) { this.script = script }

    def mail(Boolean success, String recipient) {
        def buildUrl = script.env.BUILD_URL
        def coverageUrl = "${buildUrl}artifact/htmlcov/index.html"
        def status = success ? "SUCCESS" : "FAILURE"
        def message = """Build #${script.env.BUILD_NUMBER} - ${status}
Job: ${script.env.JOB_NAME}
Job URL: ${buildUrl}
Coverage Report: ${coverageUrl}"""
        
        script.echo message
        script.mail to: recipient,
                    subject: "${status}: ${script.env.JOB_NAME} #${script.env.BUILD_NUMBER}",
                    body: message
    }
}

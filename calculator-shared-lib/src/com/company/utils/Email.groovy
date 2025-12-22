package com.company.utils

class Email implements Serializable {

    def script

    Email(script) {
        this.script = script
    }

    def send(Boolean success, String recipient, String reportUrl = null) {

        def buildUrl = script.env.BUILD_URL ?: "N/A"
        def status = success ? "SUCCESS" : "FAILURE"
        def finalReportUrl = reportUrl ?: "${buildUrl}artifact/htmlcov/index.html"

        def message = """
Build Status : ${status}
Job Name     : ${script.env.JOB_NAME}
Build Number : ${script.env.BUILD_NUMBER}
Build URL    : ${buildUrl}
Report URL   : ${finalReportUrl}
"""

        script.echo message

        script.mail(
            to: recipient,
            subject: "${status}: ${script.env.JOB_NAME} #${script.env.BUILD_NUMBER}",
            body: message
        )
    }
}

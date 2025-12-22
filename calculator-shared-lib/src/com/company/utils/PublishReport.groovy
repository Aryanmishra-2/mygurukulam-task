package org.cloud_ops_crew.redis_role_cd

class PublishReport implements Serializable {
    def script
    PublishReport(script) { this.script = script }

    def send(String status, String emailRecipient) {
        Boolean isSuccess = (status == 'SUCCESS')
        new Email(script).mail(isSuccess, emailRecipient)
    }
}

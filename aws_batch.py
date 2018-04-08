def batch_client():
    """Create AWS Batch Client
    {"message": "Create AWS Batch Connection"}
    {"message": "Found credentials in shared credentials file: ~/.aws/credentials"}
    """

    log.info(f"Create AWS Batch Connection")
    client = boto3.client("batch")
    return client

def submit_job(job_name="1", job_queue="first-run-job-queue",
                job_definition="Rekognition", 
                command="uname -a"):
    """Submit AWS Batch Job"""

    client = batch_client()
    extra_data = {"jobName":job_name, 
                "jobQueue":job_queue, 
                "jobDefinition":job_definition,
                "command":command}
    log.info("Submitting AWS Batch Job", extra=extra_data)
    submit_job_response = client.submit_job(
        jobName=job_name,
        jobQueue=job_queue,
        jobDefinition=job_definition,
        containerOverrides={'command': command}
    )
    log.info(f"Job Response: {submit_job_response}", extra=extra_data)
    return submit_job_response

# Cloud Run Setup for cvmaker

Description of setup steps to get [cvmaker](https://github.com/mixomat/cvmaker) deployed on [Google Cloud Run](https://cloud.google.com/run) serverless platform.

## Requirements

- JDK 15
- Gradle 7 (optional)
- Google Cloud SDK (for cloud setup)

## Setup Google Cloud Infrastructure
1. Install and initialize the [Cloud SDK](https://cloud.google.com/sdk/docs/).
2. Create a Google Cloud project.
3. Define some environment variables:
```shell
# PROJECT_ID holds the gcp project id.
PROJECT_ID=$(gcloud config get-value project)

# SERVICE_NAME the name of the source node service
SERVICE_NAME="cvmaker"

# REGION holds the GCS bucket region
REGION=us-east1
```
4. Enable Google Cloud Platform services:
```shell
gcloud services enable --async \
run.googleapis.com \
containerregistry.googleapis.com
```
5. Build and push an initial docker image to GCR:
```shell
docker build -t gcr.io/${PROJECT_ID}/${SERVICE_NAME} .
docker push gcr.io/${PROJECT_ID}/${SERVICE_NAME}
```
6. Run service in Google Cloud Run:
```shell
gcloud run deploy ${SERVICE_NAME} \
--image gcr.io/${PROJECT_ID}/${SERVICE_NAME} \
--platform=managed --region=${REGION} --allow-unauthenticated
```

## Native GraalVM Dockerfile

tbd...


## Additional Resources
* [Micronaut Gradle Plugin](https://github.com/micronaut-projects/micronaut-gradle-plugin)
* [Micronaut GraalVM Guide](https://guides.micronaut.io/latest/micronaut-creating-first-graal-app-gradle-kotlin.html)

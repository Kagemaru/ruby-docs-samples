FROM ruby:3.2.3-slim

RUN adduser app --home /app --shell /bin/bash --gecos app \
 && cd /app

RUN apt-get update -y \
 && apt-get install -y curl gnupg \
 && echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] https://packages.cloud.google.com/apt cloud-sdk main" \
  | tee -a /etc/apt/sources.list.d/google-cloud-sdk.list \
 && curl https://packages.cloud.google.com/apt/doc/apt-key.gpg \
  | gpg --dearmor -o /usr/share/keyrings/cloud.google.gpg \
 && apt-get update -y \
 && apt-get install -y \
            apt-transport-https \
            bash \
            build-essential make \
            ca-certificates \
            google-cloud-cli-gke-gcloud-auth-plugin \
            google-cloud-sdk \
            kubectl

SHELL ["/bin/bash", "-c"]

WORKDIR /app

COPY Gemfile Gemfile.lock ./

RUN bundle config set without 'development test'
RUN bundle install --deployment --binstubs --jobs=8 --retry=3

COPY . .

USER app

RUN gcloud version
RUN gcloud auth \
           activate-service-account \
	   test-all-permissions@api-project-1016687514786.iam.gserviceaccount.com \
           --key-file=./service-account-key.json


EXPOSE 8080/tcp

ENV APP_ENV=production \
    GOOGLE_APPLICATION_CREDENTIALS=./service-account-key.json \
    KUBECONFIG=./kubeconfig.yaml

ENTRYPOINT ["bundle", "exec", "ruby", "app.rb"]

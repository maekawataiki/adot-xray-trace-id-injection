FROM python:3.9

WORKDIR /app

COPY . .

RUN pip install --no-cache-dir -r requirements.txt

RUN opentelemetry-bootstrap --action=install

ENV HOME=/

ENV OTEL_RESOURCE_ATTRIBUTES='service.name=aws-sample-auto-app'

CMD OTEL_PROPAGATORS=xray \
OTEL_PYTHON_ID_GENERATOR=xray \
OTEL_PYTHON_DISABLED_INSTRUMENTATIONS=logging \
opentelemetry-instrument python3 application.py

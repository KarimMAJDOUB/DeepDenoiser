FROM tensorflow/tensorflow:2.3.1

# Create the environment:
# COPY env.yml /app
# RUN conda env create --name cs329s --file=env.yml
# Make RUN commands use the new environment:
# SHELL ["conda", "run", "-n", "cs329s", "/bin/bash", "-c"]

RUN pip install tqdm obspy pandas minio
RUN pip install uvicorn fastapi kafka-python

WORKDIR /opt

# Copy files
COPY deepdenoiser /opt/deepdenoiser
COPY model /opt/model

# Expose API port
EXPOSE 8002

ENV PYTHONUNBUFFERED=1

# Start API server
#ENTRYPOINT ["conda", "run", "--no-capture-output", "-n", "cs329s", "uvicorn", "--app-dir", "phasenet", "app:app", "--reload", "--port", "8000", "--host", "0.0.0.0"]
ENTRYPOINT ["uvicorn", "--app-dir", "deepdenoiser", "app:app", "--reload", "--port", "8002", "--host", "0.0.0.0"]

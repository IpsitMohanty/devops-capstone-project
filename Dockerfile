# Use Python 3.9 slim as base image
FROM python:3.9-slim

# Set working directory inside the container
WORKDIR /app

# Copy requirements.txt and install dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy the application source code
COPY service/ ./service/

# Switch to a non-root user
RUN useradd --uid 1000 theia && chown -R theia /app
USER theia

# Expose port 8080
EXPOSE 8080

# Run the service with Gunicorn
CMD ["gunicorn", "--bind=0.0.0.0:8080", "--log-level=info", "service:app"]

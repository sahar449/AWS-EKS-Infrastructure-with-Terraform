# Use a specific Python image as the base image
FROM python:3.9-slim

# Create a non-root user and group
RUN addgroup --system appgroup && adduser --system --ingroup appgroup appuser

# Set working directory
WORKDIR /app

# Copy the application code and set ownership
COPY app.py /app/

# Set minimal permissions: readable and executable only by the owner
RUN chown appuser:appgroup /app/app.py && \
    chmod 500 /app/app.py

# Install dependencies (Flask and stress)
RUN apt-get update && \
    pip install flask && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Switch to the non-root user
USER appuser

# Run the application
CMD ["python", "app.py"]

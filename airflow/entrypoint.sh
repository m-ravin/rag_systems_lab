#!/bin/bash
set -e


# Clean up any existing PID files and processes
echo "Cleaning up any existing Airflow processes..."
command -v pkill >/dev/null && pkill -f "airflow webserver" || true
command -v pkill >/dev/null && pkill -f "airflow scheduler" || true

rm -f /opt/airflow/airflow-webserver.pid
rm -f /opt/airflow/airflow-scheduler.pid

# Wait a moment for processes to fully terminate
sleep 2

# Initialize Airflow database
echo "Initializing Airflow database..."
airflow db migrate 

# NOTE: The 'airflow users create' command is deprecated in newer versions.


# Start webserver and scheduler
#echo "Starting Airflow webserver and scheduler..."
#airflow webserver --port 8080 --daemon &
#airflow scheduler


# Start Airflow in standalone mode (includes scheduler + API server)
echo "Starting Airflow in standalone mode..."
airflow standalone

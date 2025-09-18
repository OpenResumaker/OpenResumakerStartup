#!/bin/bash

echo "================================"
echo " OpenResumaker One-Click Startup Tool"
echo "================================"
echo ""
echo "Starting local server..."
echo ""

# Check if mongoose_linux exists and is executable
if [ ! -f "./mongoose_linux" ]; then
    echo "Error: mongoose_linux not found in current directory"
    echo "Please make sure you're running this script from the OpenResumaker directory"
    exit 1
fi

if [ ! -x "./mongoose_linux" ]; then
    echo "Making mongoose_linux executable..."
    chmod +x ./mongoose_linux
fi

# Start Mongoose server in background
echo "Starting server on http://localhost:8000..."
./mongoose_linux -d dist -l http://0.0.0.0:8000 &
SERVER_PID=$!

# Wait for server to start
sleep 3

# Try to open browser (works on most Linux distributions)
if command -v xdg-open > /dev/null; then
    xdg-open http://localhost:8000
elif command -v gnome-open > /dev/null; then
    gnome-open http://localhost:8000
elif command -v kde-open > /dev/null; then
    kde-open http://localhost:8000
else
    echo "Please open your browser and navigate to: http://localhost:8000"
fi

echo ""
echo "Server started successfully!"
echo "Server PID: $SERVER_PID"
echo "To stop the server, press Ctrl+C or run: kill $SERVER_PID"
echo ""

# Keep script running and handle Ctrl+C
trap "echo ''; echo 'Stopping server...'; kill $SERVER_PID 2>/dev/null; echo 'Server stopped.'; exit 0" INT

echo "Press Ctrl+C to stop the server..."
wait $SERVER_PID

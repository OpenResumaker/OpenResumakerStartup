#!/bin/bash

echo "================================"
echo " OpenResumaker One-Click Startup Tool"
echo "================================"
echo ""
echo "Starting local server..."
echo ""

# Check if mongoose_macos exists and is executable
if [ ! -f "./mongoose_macos" ]; then
    echo "Error: mongoose_macos not found in current directory"
    echo "Please make sure you're running this script from the OpenResumaker directory"
    exit 1
fi

if [ ! -x "./mongoose_macos" ]; then
    echo "Making mongoose_macos executable..."
    chmod +x ./mongoose_macos
fi

# Start Mongoose server in background
echo "Starting server on http://localhost:8000..."
./mongoose_macos -d dist -l http://0.0.0.0:8000 &
SERVER_PID=$!

# Wait for server to start
sleep 3

# Open browser on macOS
if command -v open > /dev/null; then
    open http://localhost:8000
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

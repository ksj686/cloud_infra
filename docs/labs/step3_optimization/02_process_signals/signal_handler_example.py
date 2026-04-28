import signal
import time
import os

def signal_handler(signum, frame):
    """Graceful shutdown logic."""
    print(f"\nReceived signal: {signum} (SIGTERM)")
    print("Performing cleanup operations...")
    time.sleep(2)
    print("Cleanup complete. Exiting gracefully.")
    exit(0)

# Register the signal handler for SIGTERM
signal.signal(signal.SIGTERM, signal_handler)

print(f"Process started with PID: {os.getpid()}")
print("Try running: kill -15 <PID> to see graceful shutdown.")
print("Waiting for signal... (Ctrl+C to interrupt with SIGINT)")

try:
    while True:
        time.sleep(1)
except KeyboardInterrupt:
    print("\nSIGINT received. Exiting.")

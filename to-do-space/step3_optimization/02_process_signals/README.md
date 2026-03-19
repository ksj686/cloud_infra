# Process Management and Signals

## Understanding Linux Signals
Linux uses signals to communicate with running processes.

### Key Signals
1. **SIGTERM (15)**: The default signal sent by `kill`. It requests the process to terminate gracefully, allowing it to clean up resources, close files, etc.
   - Command: `kill 1234` or `kill -15 1234`
2. **SIGKILL (9)**: Forces the process to terminate immediately. The process cannot catch this signal or perform any cleanup. This can leave "stale" lock files or temporary data.
   - Command: `kill -9 1234`
3. **SIGHUP (1)**: Often used to tell a daemon to reload its configuration.

### Best Practices
- **Try SIGTERM first**: Always attempt to stop a process gracefully.
- **Use SIGKILL only as a last resort**: Only if the process is unresponsive and SIGTERM fails.

## Handling Zombie Processes
A zombie process (`Z` state in `ps`) is a process that has finished execution but remains in the process table.
- They don't use memory or CPU, but they do consume a process ID (PID).
- Usually, they disappear once their parent process "reaps" them.
- If they persist, you may need to kill the parent process.

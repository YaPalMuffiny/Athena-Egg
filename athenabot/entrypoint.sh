#!/bin/bash
# --- A more vibrant color palette ---
clear
CYAN='\033[1;36m'
MAGENTA='\033[1;35m'
YELLOW='\033[1;33m'
GREEN='\033[1;32m'
RESET='\033[0m' # No Color

# Switch to the container's working directory
cd /home/container || exit 1

# Wait for the container to fully initialize
sleep 1

# Default the TZ environment variable to UTC.
TZ=${TZ:-UTC}
export TZ

# Set environment variable that holds the Internal Docker IP
INTERNAL_IP=$(ip route get 1 | awk '{print $(NF-2);exit}')
export INTERNAL_IP

# --- System Information ---
echo -e "${CYAN}---------------------------------------------------------------------${RESET}"
echo -e "${MAGENTA} Athena Bot Egg by YaPalMuffiny ${RESET}"
echo -e "${CYAN}---------------------------------------------------------------------${RESET}"
echo -e "${YELLOW}Running on: ${GREEN} $(. /etc/os-release ; echo $NAME $VERSION)${RESET}"
echo -e "${YELLOW}Current timezone: ${GREEN} $(cat /etc/timezone)${RESET}"
echo -e "${CYAN}---------------------------------------------------------------------${RESET}"
echo -e "${YELLOW}NodeJS Version: ${GREEN} $(node -v) ${RESET}"
echo -e "${YELLOW}npm Version: ${GREEN} $(npm -v) ${RESET}"
echo -e "${CYAN}---------------------------------------------------------------------${RESET}"

# Replace Startup Variables
MODIFIED_STARTUP=$(echo -e $(echo -e ${STARTUP} | sed -e 's/{{/${/g' -e 's/}}/}/g'))
echo -e "${YELLOW}Startup Command: ${GREEN}${MODIFIED_STARTUP}${RESET}"

# --- Run the Server ---
echo -e "${CYAN}---------------------------------------------------------------------${RESET}"
echo -e "${MAGENTA} Starting Bot...${RESET}"
echo -e "${CYAN}---------------------------------------------------------------------${RESET}"
eval ${MODIFIED_STARTUP}
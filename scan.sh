#!/bin/bash
# Display devices IP address
function get_ip() {
	echo "ip :"
  ip addr | grep -oP 'inet \K[\d.]+'
  echo ""
}

# Display devices MAC address and vendor
function get_mac() {
  echo "mac and vendor:"
  ifconfig | grep -o -E '([0-9a-fA-F]:?){12}'
  ip addr | grep link/ether | cut -d ' ' -f 6
  echo ""
}

# Display router IP addresses
function get_router_ip() {
  # External
  echo "external:"
  curl ifconfig.me
  echo ""
  # Internal
  echo "internal :"
  ip route show | grep -i 'default via' | awk '{print $3 }'
}

# Display device name
function get_name() {
  echo ""
  echo "name:"
  hostname
}

# Display DNS information
function get_dns() {
  # DNS
  echo ""
  echo "dns:"
  cat /etc/resolv.conf | grep nameserver
  echo ""

  # DHCP
  echo "dhcp:"
  ifconfig | awk '/inet / {print $2}' | head -n 1
}

# Display ISP information
function get_isp() {
  echo ""
  # Whois ISP
  whois $(curl -s ifconfig.me) | grep -i role:
}

# Display if the device is connected via Ethernet or Wireless
function get_connected() {
  nmcli device show | grep -i GENERAL.DEVICE:
}

# Call functions
get_ip
get_mac
get_router_ip
get_name
get_dns
get_isp
get_connected

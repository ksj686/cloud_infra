# Kernel Configuration Tutorial

This tutorial provides best practices for configuring a custom Linux kernel using `make menuconfig`.

## Prerequisites
- Linux kernel source code downloaded.
- Build tools installed (`build-essential`, `libncurses-dev`, `bison`, `flex`, `libssl-dev`, `libelf-dev`).

## Best Practices for `make menuconfig`

### 1. Copy Existing Config
Always start with your current system's configuration to ensure baseline stability:
```bash
cp /boot/config-$(uname -r) .config
make menuconfig
```

### 2. Core Areas for Customization
Focus on these categories for server environments:

#### Networking Support -> Networking Options
- **Enable specific protocols:** If you are running complex networks (e.g., SCTP, BGP), enable them here.
- **Firewalling:** Ensure `Network packet filtering framework (Netfilter)` is enabled for `ufw` or `iptables` to work correctly.

#### Device Drivers
- **Storage Controllers:** If you use RAID controllers (like PERC, LSI), ensure their specific drivers are enabled.
- **Network Interface Cards (NICs):** Enable specific drivers for high-performance server NICs (e.g., Intel `igb`, `ixgbe`).
- **USB Support:** If you don't need USB on a production server, you can disable it to reduce attack surface and kernel size.

#### File Systems
- Ensure the file systems you use (e.g., `ext4`, `xfs`, `btrfs`) are built-in (not as modules) for the boot partition.

### 3. Critical Fixes for Modern Kernels
In recent kernels (like 6.x), certain options must be disabled if you do not have the proper security certificates:
- **`CONFIG_SYSTEM_TRUSTED_KEYS=""`**
- **`CONFIG_SYSTEM_REVOCATION_KEYS=""`**

To automate this, use:
```bash
scripts/config --disable SYSTEM_TRUSTED_KEYS
scripts/config --disable SYSTEM_REVOCATION_KEYS
```

---
*Note: A smaller kernel is generally faster and more secure, but removing too much can lead to hardware incompatibility.*

#!/bin/bash
# Instalador de herramientas pentesting (CPTS/OSCP) - Kali + Hyprland
set -u
echo "[*] apt update..."; sudo apt update

APT_TOOLS=(
  seclists feroxbuster ffuf gobuster wfuzz nikto nuclei whatweb
  netexec impacket-scripts responder evil-winrm enum4linux-ng smbmap
  onesixtyone hydra hashcat john sqlmap
  chisel proxychains4 socat masscan
  metasploit-framework exploitdb neo4j bloodhound
  jq golang-go python3-pip pipx git dnsutils
  cargo rustc clang libclang-dev libkrb5-dev gcc pkg-config
)
echo "[*] Paquetes apt..."
for p in "${APT_TOOLS[@]}"; do
  sudo apt install -y "$p" >/dev/null 2>&1 && echo "  [+] $p" || echo "  [!] $p saltado"
done

echo "[*] pipx..."
pipx ensurepath >/dev/null 2>&1
for t in certipy-ad mitm6 coercer bloodyAD ldapdomaindump; do
  pipx install "$t" >/dev/null 2>&1 && echo "  [+] $t" || echo "  [!] $t fallo/ya instalado"
done

echo "[*] Binarios en ~/tools..."
mkdir -p ~/tools
wget -q https://github.com/ropnop/kerbrute/releases/latest/download/kerbrute_linux_amd64 -O ~/tools/kerbrute && chmod +x ~/tools/kerbrute && sudo ln -sf ~/tools/kerbrute /usr/local/bin/kerbrute
wget -q https://github.com/DominicBreuker/pspy/releases/latest/download/pspy64 -O ~/tools/pspy64 && chmod +x ~/tools/pspy64
wget -q https://github.com/peass-ng/PEASS-ng/releases/latest/download/linpeas.sh -O ~/tools/linpeas.sh && chmod +x ~/tools/linpeas.sh
wget -q https://github.com/peass-ng/PEASS-ng/releases/latest/download/winPEASx64.exe -O ~/tools/winPEASx64.exe
for comp in proxy agent; do
  URL=$(curl -s https://api.github.com/repos/nicocha30/ligolo-ng/releases/latest | grep browser_download_url | grep -E "${comp}.*linux_amd64.tar.gz" | cut -d '"' -f4)
  wget -q "$URL" -O /tmp/ligolo-$comp.tar.gz && tar -xzf /tmp/ligolo-$comp.tar.gz -C ~/tools "$comp" 2>/dev/null
done

echo "[*] Herramientas Rust (compilan, tardan)..."
cargo install rustscan >/dev/null 2>&1 && echo "  [+] rustscan" || echo "  [!] rustscan"
cargo install rusthound-ce >/dev/null 2>&1 && echo "  [+] rusthound-ce" || echo "  [!] rusthound-ce"

echo "[*] Wordlists..."
[ -f /usr/share/wordlists/rockyou.txt.gz ] && sudo gunzip -k /usr/share/wordlists/rockyou.txt.gz && echo "  [+] rockyou"

echo "[*] PATH..."
grep -q 'HOME/tools' ~/.zshrc || echo 'export PATH="$HOME/tools:$PATH"' >> ~/.zshrc
grep -q 'cargo/bin'  ~/.zshrc || echo 'export PATH="$HOME/.cargo/bin:$PATH"' >> ~/.zshrc

echo "[*] Hecho."

$vpnName = "WMarine VPN";
$vpn = Get-VpnConnection -Name $vpnName;

if($vpn.ConnectionStatus -eq "Connected"){
  rasdial $vpnName /DISCONNECT;
}
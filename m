Return-Path: <hexiled@nixbits.net>
Message-ID: <4F8DD568.3040102@nixbits.net>
Date: Tue, 17 Apr 2012 16:41:12 -0400
From: HeXiLeD <hexiled@nixbits.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: [B.A.T.M.A.N.] Batman configuration and MTU
Reply-To: HeXileD@nixbits.net,
	The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: b.a.t.m.a.n@lists.open-mesh.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

I have being doing some testing with several types of configurations
with custom openwrt build and batman in oder to try to come with a basic
default "plug & play" ready to deploy firmware evolving the least
changes possible other than the router's ip and not much more.
I have tried several configurations, more than one subnet and have being
trying to see a way to make some nice HOW-Tos regarding this matter for
several types of configurations.

So far and from what i seen all working and half working examples do not
work for everyone or at least no one or very few post complete
configurations of all files in /etc/config/  that actually fully work.

Then there is the question if bridging. Some say bridge this, others say
do not bridge that. None supply a fully working example that can be
replicated. (i am glad i access the routers over serial cable which i
recommend to everyone if they are working on builds and configurations.

I have now collected quite a few pdfs regarding all openwrt, batman and
mesh netwroks and only a couple worth to use for configurations as they
seem to work.

The best one i found so far can be obtained here:
http://wiki.villagetelco.org/images/0/07/SECN_UserGuideV1d4_compressed.pdf

Mesh Potato: Small Enterprise Campus Network (user guide)
SECN_UserGuideV1d4_compressed.pdf

It shows basic fast working examples either using Luci and command
line.It's not a perfect guide as it needs a few retouches but by far the
best i have found until now.

This guide leads me to quite a few questions as for example i was told
not to bridge the lan:
https://forum.openwrt.org/viewtopic.php?id=35517

This led me to more complex configurations that included 2 different
subnets and more but still not 100% working.

And following the guide i only got it working doing a bridge.
It still find this bridge strange and something confuses me but seems to
work.

However there is still a problem that remains which is the MTU.
I have tried several ways to enable and they all seem to fail.

Bellow are my current configurations that match the described situation:


- -----

# cat firewall

config 'defaults'
        option 'syn_flood' '1'
        option 'input' 'ACCEPT'
        option 'output' 'ACCEPT'
        option 'forward' 'REJECT'
        option 'disable_ipv6' '1'

config 'zone'
        option 'name' 'lan'
        option 'network' 'lan'
        option 'input' 'ACCEPT'
        option 'output' 'ACCEPT'
        option 'forward' 'REJECT'

config 'zone'
        option 'name' 'wifi'
        option 'network' 'wifi'
        option 'input' 'ACCEPT'
        option 'output' 'ACCEPT'
        option 'forward' 'REJECT'

config 'zone'
        option 'name' 'wan'
        option 'network' 'wan'
        option 'input' 'REJECT'
        option 'output' 'ACCEPT'
        option 'forward' 'REJECT'
        option 'masq' '1'

config 'forwarding'
        option 'src' 'lan'
        option 'dest' 'wan'


config 'rule'
        option 'name' 'Allow-DHCP-Renew'
        option 'src' 'wan'
        option 'proto' 'udp'
        option 'dest_port' '68'
        option 'target' 'ACCEPT'
        option 'family' 'ipv4'

config 'rule'
        option 'name' 'Allow-Ping'
        option 'src' 'wan'
        option 'proto' 'icmp'
        option 'icmp_type' 'echo-request'
        option 'family' 'ipv4'
        option 'target' 'ACCEPT'

config 'include'
        option 'path' '/etc/firewall.user'

- -----
# cat dhcp

config 'dnsmasq'
        option 'domainneeded' '1'
        option 'boguspriv' '1'
        option 'filterwin2k' '0'
        option 'localise_queries' '1'
        option 'rebind_protection' '1'
        option 'rebind_localhost' '1'
        option 'local' '/lan/'
        option 'domain' 'wireless.domain.com'
        option 'expandhosts' '1'
        option 'nonegcache' '0'
        option 'authoritative' '1'
        option 'readethers' '1'
        option 'leasefile' '/tmp/dhcp.leases'
        option 'resolvfile' '/tmp/resolv.conf.auto'

        config 'dhcp' 'lan'
        option 'interface' 'lan'
        option 'start' '51'
        option 'limit' '254'
        option 'leasetime' '24h'

config 'dhcp' 'wan'
        option 'interface' 'wan'
        option 'ignore' '1'
        option 'domain' 'wireless.domain.com'

- -----

g# cat network

config 'switch' 'eth0'
        option 'enable' '1'

config 'switch_vlan' 'eth0_0'
        option 'device' 'eth0'
        option 'vlan' '0'
        option 'ports' '1 2 3 4 5'

config 'switch_vlan' 'eth0_1'
        option 'device' 'eth0'
        option 'vlan' '1'
        option 'ports' '0 5'

config 'interface' 'loopback'
        option 'ifname' 'lo'
        option 'proto' 'static'
        option 'ipaddr' '127.0.0.1'
        option 'netmask' '255.0.0.0'

config 'interface' 'lan'
        option 'type' 'bridge'
        option 'proto' 'static'
        option 'ipaddr' '192.168.1.1'
        option 'netmask' '255.255.255.0'
        option 'broadcast' '192.168.1.255'
        option 'ifname' 'eth0.0 bat0 wlan0'
        option 'mtu' '1528'

#config 'interface' 'wifi'
#        option 'proto' 'none'
#        option 'ifname' 'wlan0'
#        option 'mtu' '1528'

#config 'interface' 'lan'
#       option 'proto' 'none'
#       option 'ifname' 'lan'
#       option 'mtu' '1528'

config 'interface' 'wan'
        option 'ifname' 'eth0.1'
        option 'proto' 'dhcp'


- -----
# cat wireless
config 'wifi-device' 'radio0'
        option 'type' 'mac80211'
        option 'channel' '11'
        option 'phy' 'phy0'
        option 'hwmode' '11g'
        option 'country' 'ca'
        option 'txpower' '20'
        option 'diversity' '1'
        option 'disabled' '0'
        option 'txantenna' '1'
        option 'rxantenna' '1'

config 'wifi-iface'
        option 'device' 'radio0'
        option 'hidden' '0'
        option 'mode' 'adhoc'
        option 'ssid' 'wireless'
        option 'bssid' '02:16:b8:6b:0a:1a'
        option 'encryption' 'none'
	#option 'network' 'lan' #is optional or must match bridge name
        option 'mtu' '1528' #mtu seems to be ignored - needs fix


- -----
# cat batman-adv
config 'mesh' 'bat0'
        option 'ap_isolation' '0'
        option 'bonding' '0'
        option 'aggregation' '1'
        option 'fragmentation' '1'
        option 'gw_bandwidth' '3mbit/384kbit'
        option 'gw_mode' 'client'
        option 'gw_sel_class' '5'
        option 'orig_interval' '1000'
        option 'vis_mode' 'client'
        option 'interfaces' 'wlan0 eth0.0'


# batctl if
eth0.0: active
wlan0: active

# batctl o
[B.A.T.M.A.N. adv 2012.0.0, MainIF/MAC: eth0.0/00:12:17:be:f9:46 (bat0)]
  Originator      last-seen (#/255)           Nexthop [outgoingIF]:
Potential nexthops ...

- -----
The mesh potato guide does not show configurations for batman-adv .
I also noticed that replacing bat0 interfaces by "lan" seems to be
working as the lan interface already bridges everything.
Correct me if i am wrong.

The last problem i now face (assuming that this configuration is valid)
is the MTU settings which seem to be ignored no matter where i add them;
including creating the following for the other interfaces:

config 'interface' 'wifi'
        option 'proto' 'none'
        option 'ifname' 'wlan0'
        option 'mtu' '1528'

I have lost quite a lot of sleep over these problems and it is natural
that i might be missing something very simple.

batman_adv: bat0: The MTU of interface eth0.0 is too small (1500) to
handle the transport of batman-adv packets. Packets going over this
interface will be fragmented on layer2 which could impact the
performance. Setting the MTU to 1528 would solve the problem.

batman_adv: bat0: The MTU of interface wlan0 is too small (1500) to
handle the transport of batman-adv packets. Packets going over this
interface will be fragmented on layer2 which could impact the
performance. Setting the MTU to 1528 would solve the problem.

Right now i am just trying the setup with 1 router and testing with a
netbook. I am able to connect, obtain ip from the router in either wired
or wireless. I am also able to connect to the wan but while doing so
wirelessly the performance is lower and slower which i believe to be
caused by the lack of proper MTU adjustment.


Extra details:
wrt54g v2.2
backfire 10.03.2
b43 drivers version 508.1084
batman 2012 v14 + batman-adv_load-module-when-needed.patch

Loaded modules:

nf_nat_tftp              432  0
nf_conntrack_tftp       2400  1 nf_nat_tftp
nf_nat_irc               864  0
nf_conntrack_irc        2592  1 nf_nat_irc
nf_nat_ftp              1360  0
nf_conntrack_ftp        4896  1 nf_nat_ftp
ipt_MASQUERADE           992  1
iptable_nat             2304  1
nf_nat                 11824  5
nf_nat_tftp,nf_nat_irc,nf_nat_ftp,ipt_MASQUERADE,iptable_nat
xt_NOTRACK               672  0
iptable_raw              656  1
xt_state                 800  3
nf_conntrack_ipv4       7808  6 iptable_nat,nf_nat
nf_defrag_ipv4           608  1 nf_conntrack_ipv4
nf_conntrack           42560 12
nf_nat_tftp,nf_conntrack_tftp,nf_nat_irc,nf_conntrack_irc,nf_nat_ftp,nf_conntrack_ftp,ipt_MASQUERADE,iptable_nat,nf_nat,xt_NOTRACK,xt_state,nf_conntrack_ipv4
ipt_REJECT              1984  2
xt_TCPMSS               1952  0
ipt_LOG                 4640  0
xt_comment               464  0
xt_multiport            1904  0
xt_mac                   576  0
xt_limit                1152  1
iptable_mangle           992  0
iptable_filter           768  1
ip_tables               8864  4
iptable_nat,iptable_raw,iptable_mangle,iptable_filter
xt_tcpudp               1856  4
x_tables                9840 13
ipt_MASQUERADE,iptable_nat,xt_NOTRACK,xt_state,ipt_REJECT,xt_TCPMSS,ipt_LOG,xt_comment,xt_multiport,xt_mac,xt_limit,ip_tables,xt_tcpudp
b43                   151056  0
mac80211              260560  1 b43
cfg80211              149136  2 b43,mac80211
compat                 13312  3 b43,mac80211,cfg80211
arc4                     816  2
aes_generic            31056  0
deflate                 1328  0
ecb                     1328  0
cbc                     2016  0
batman_adv            105408  0
crc16                    976  1 batman_adv
diag			7504  0	
switch_robo		4208  0
swicth_core		5216  1 switch_robo

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.17 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iQIcBAEBAgAGBQJPjdVoAAoJEA1GFAMAMJs71XgP/jbQ4O2+OuddmP7zfKwvTJXz
db2YoxmiXx3it0F2R/fV5689B5l0yrxPFtebjN27IDeq2zwJaSvkBuWg6LCFDO2/
W4YKX7P7AzqXIDlkuGO5qH72YKc6Bfw9u74dTusGY4OmmcoLdboN8ID3Qax2wSkY
npFukKtqZJFlO4ehH/hneuXxEDmAlpAcDa6dD3+Zkttm61S9ktwslZdtC/tEqoYO
g/dqW2r8GXekcd2E/AajG1J4BLSdU1+xQJGVjyWufhO9IAFTNdkkUHAKM6fo96Ea
7SBFvVdLMo6D64gImAUNi5IREgrTihOY41iC1/JnAXTGAfSrxRi8YBbu1aRkUIc3
oTQ8OOTrIE0MmqE0+z0y88Ie23QtADtwHgLUFBHaliqXnkyHB2HxykeyU1WJHSrK
3qsI04Ag4x9GEoMjvThdIhdyIiRFhkSmNg9dfDjaPfhXKOdlklcOOMHyGm1VYO8t
acq3vF9TO2d1dsbLKi78QO9jP8pmaWCTLoHf0HE896S8ju1HfMuhSsacjQ+y1W/v
XQyP1f3DT/XAIqIhdQ36ZHBSUv081UqdskhtUhPp3V3HEzP7YFYH9wV08P3vQgAM
OLZhLrn8JEm1r1urWFzYhuZStdpgAxgNdr7WnC1aYkrx1rvT7WAmZKLx204Pqkjz
tdg/kdoEBo6fo8wM3Kvd
=TnUr
-----END PGP SIGNATURE-----

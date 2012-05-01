Return-Path: <pedroncr@sapo.pt>
Date: Tue, 01 May 2012 20:06:45 +0100
Message-ID: <20120501200645.Horde.4u5hTaeWCxtPoDRF8GF27AA@beta.mail.sapo.pt>
From: Pedro Nuno Costa Rodrigues <pedroncr@sapo.pt>
Content-Type: multipart/mixed; boundary="=_F-bdJKeWCxtPoDRF7ZSW7AA"
MIME-Version: 1.0
Subject: [B.A.T.M.A.N.] Batman-adv simple configuration example
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
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

This message is in MIME format.

--=_F-bdJKeWCxtPoDRF7ZSW7AA
Content-Type: text/plain; charset=ISO-8859-1; format=flowed; DelSp=Yes
Content-Disposition: inline

Hello!

Sorry about taking your time, but i really need some help...

First of all, sorry about my english, i will try to express the better i can.
I send this need of help for you and for the others developers  
envolved in the batman-adv project, hoping some reply.

My name is Pedro, and i'm writing from Portugal, Oporto.
I'm a student of telecomunications and i'm doing the last work to  
finish my master thesis. It was proposed to me in my school doing a  
management aplication for a batman-adv mesh network... by the way my  
school is ISEP - Oporto Superior Institute of Engeneering.

In this moment i'm trying to setup a basic 2 nodes using batman-adv...
I'm using UBUNTU 10.10 - linux.
I'm using OPENWRT in 2 routers.
The routers are 2 linksys wrt54gs (v1.1 and v3).
I compiled the backfire stable release from:

svn co svn://svn.openwrt.org/openwrt/branches/backfire

Here are my feeds:

src-svn packages  
svn://svn.openwrt.org/openwrt/branches/packages_10.03.2  
svn://svn.openwrt.org/openwrt/packages
src-svn luci  
http://svn.luci.subsignal.org/luci/branches/luci-0.10/contrib/package

I installed the kmod-batman-adv.

I attached a image with a scheme from my test configuration.

..................

When i do:

root@OpenWrt:~# batctl if
br-lan: active
wlan0: active

the two interfaces are active... it seems ok!


root@OpenWrt:~# batctl o
[B.A.T.M.A.N. adv 2012.0.0, MainIF/MAC: br-lan/00:13:10:7c:da:71 (bat0)]
   Originator      last-seen (#/255)           Nexthop [outgoingIF]:    
Potential nexthops ...
00:06:25:00:63:7b    0.412s   (247) 00:06:25:00:63:7b [     wlan0]:  
00:06:25:00:63:7b (247)
00:06:25:00:63:79    0.076s   (246) 00:06:25:00:63:7b [     wlan0]:  
00:06:25:00:63:7b (246)


the node 1 see the node 2... it seems ok!


Here is my /etc/config files for router 1, that is supossed to work as  
a batman-adv gateway:

root@OpenWrt:/etc/config# vi batman-adv
config 'mesh' 'bat0'
         option 'interfaces' 'wifi lan'
         option 'aggregated_ogms' '1'
         option 'ap_isolation' '0'
         option 'bonding' '0'
         option 'fragmentation' '1'
         option 'gw_bandwidth' '5mbit/1024kbit'
         option 'gw_mode' 'server'
         #option 'gw_sel_class'
         option 'log_level' 'all'
         option 'orig_interval' '1000'
         option 'vis_mode' 'server'

after the boot when i do:

root@OpenWrt:~# batctl gw
off

then i do:
root@OpenWrt:~# batctl gw server 5mbit
root@OpenWrt:~# batctl gw
server (announced bw: 4MBit/1024KBit)

should't be necessary do "batctl gw server 5mbit"... it already is  
determinated in the /etc/config/batman-adv... why this happens?

also with the vis mode:

root@OpenWrt:~# batctl vm
client

then i do:

root@OpenWrt:~# batctl vm server
root@OpenWrt:~# batctl vm
server

the same thing happens... why?  ----- the gw definition and the vm  
definition is mandatory to router 2 access internet? or doesn't matter?

here is is my /etc/config files for router 2, that is supossed to work  
as a batman-adv gateway client:

root@OpenWrt:~# vi /etc/config/batman-adv
config 'mesh' 'bat0'
         option 'interfaces' 'wifi lan'
         option 'aggregated_ogms' '1'
         option 'ap_isolation' '0'
         option 'bonding' '0'
         option 'fragmentation' '1'
         #option 'gw_bandwidth'
         option 'gw_mode' 'client'
         option 'gw_sel_class' '2'
         option 'log_level' 'all'
         option 'orig_interval' '1000'
         option 'vis_mode' 'client'

is the file ok?

when i do in node 2:

root@OpenWrt:~# batctl if
br-lan: active
wlan0: active

root@OpenWrt:~# batctl o
[B.A.T.M.A.N. adv 2012.0.0, MainIF/MAC: br-lan/00:06:25:00:63:79 (bat0)]
   Originator      last-seen (#/255)           Nexthop [outgoingIF]:    
Potential nexthops ...
00:13:10:7c:da:71    0.916s   (235) 00:13:10:7c:da:73 [     wlan0]:  
00:13:10:7c:da:73 (235)
00:13:10:7c:da:73    0.080s   (235) 00:13:10:7c:da:73 [     wlan0]:  
00:13:10:7c:da:73 (235)


it seems ok...

root@OpenWrt:~# batctl gw
off
  doesn't seem ok...


then i do:

root@OpenWrt:~# batctl gw client 2
root@OpenWrt:~# batctl gw
client (selection class: 2)

root@OpenWrt:~# batctl vm client
root@OpenWrt:~# batctl vm
client


the gw and vm doesn't start/boot with the start configuration... it's  
the same problem...
why this happens? it's crucial for the batman-adv works correctly?

____________________________________________________________
_____end________________________________________________________
____________________________________________________________

Here is my  network file for router 1 and 2 ( the only difference is  
"lan option ipaddr" and the "wifi option ipaddr"...
Question: is necessary to wifi (wlan0) have static ipaddr or it shouldn't?
The mtu size is ok?



root@OpenWrt:/etc/config# vi network
#### VLAN configuration
config switch eth0
         option enable   1

config switch_vlan eth0_0
         option device   "eth0"
         option vlan     0
         option ports    "1 2 3 4 5"

config switch_vlan eth0_1
         option device   "eth0"
         option vlan     1
         option ports    "0 5"              ######## for V3 is "4 5"

#### Loopback configuration
config interface loopback
         option ifname   "lo"
         option proto    static
         option ipaddr   127.0.0.1
         option netmask  255.0.0.0


#### LAN configuration
config interface lan
         option type     bridge
         option ifname   "eth0.0 bat0 wlan0"
         option proto    static
         option ipaddr   10.3.1.1                #######for router 2  
is 10.3.1.2
         option netmask  255.255.255.0
         option broadcast 10.3.1.255
         option mtu      1500

#### WLAN configuration
config interface        wifi
         option proto    static
         option ifname   "wlan0"
         option ipaddr   10.1.1.1              ########for router 2 is 10.1.1.2
         option netmask  255.255.255.0
         option mtu      1528

#### WAN configuration
config interface        wan
         option ifname   "eth0.1"
         option proto    dhcp

#### BAT configuration
config interface        bat
         option ifname   "bat0"
         option proto    none
         option mtu      1500
___________________________________________________
__end_________________________________________________
_____________________________________________________


Here is the dhcp file:
P.S. i can access the internet through the eth0.0 (ethernet cable)  
both in router 1 and router 2, but i can't access through wireless  
(neither router 1 and router 2)...
Both routers give IP through cable and trough wireless... the  
conections are always made, and it's possible to access using ssh both  
routers, doesn't matter if the connection is made by cable or by  
air... the difference is to access to internet... only works by cable  
in both routers with the scheme i attached...

Is possible to exist conflict with the IP distribution, because the  
"option authoritative    1"?

Is necessary to change some settings?
It is necessary wifi dhcp to the wireless stations to connect? or  
should they manually set an static IP?



root@OpenWrt:/etc/config# vi dhcp
config dnsmasq
         option domainneeded     1
         option boguspriv        1
         option filterwin2k      0  # enable for dial on demand
         option localise_queries 1
         option rebind_protection 1  # disable if upstream must serve  
RFC1918 addresses
         option rebind_localhost 1  # enable for RBL checking and  
similar services
         #list rebind_domain example.lan  # whitelist RFC1918  
responses for domains
         option local    '/lan/'
         option domain   'lan'
         option expandhosts      1
         option nonegcache       0
         option authoritative    1
         option readethers       1
         option leasefile        '/tmp/dhcp.leases'
         option resolvfile       '/tmp/resolv.conf.auto'
         #list server            '/mycompany.local/1.2.3.4'
         #option nonwildcard     1
         #list interface         br-lan
         #list notinterface      lo
         #list bogusnxdomain     '64.94.110.11'

config dhcp lan
         option interface        lan
         option start    51               #########for router 2 is start 101
         option limit    70               #########for router 2 is limit 130
         #option leasetime       12h

config dhcp wan
         option interface        wan
         option ignore   1

config dhcp wifi
         option interface wifi
         option start    51                #########for router 2 is start 101
         option limit    70                #########for router 2 is limit 130

_______________________________________________
______end_______________________________________________
__________________________________________________

Here is my /etc/config/firewall:

what do you think? it's ok?


root@OpenWrt:~# vi /etc/config/firewall
config defaults
         option syn_flood        1
         option input            ACCEPT
         option output           ACCEPT
         option forward          ACCEPT
# Uncomment this line to disable ipv6 rules
#       option disable_ipv6     1

config zone
         option name             lan
         option network          'lan'
         option input            ACCEPT
         option output           ACCEPT
         option forward          ACCEPT

config zone
         option name             wan
         option network          'wan'
         option input            ACCEPT
         option output           ACCEPT
         option forward          ACCPET
         option masq             1
         option mtu_fix          1

config forwarding
         option src              lan
         option dest             wan

config forwarding
         option src              wan
         option dest             lan

config forwarding
         option src              wifi
         option dest             wan

config forwarding
         option src              wan
         option dest             wifi

config forwarding
         option src               lan
         option dest              wifi

config forwarding
         option src               wifi
         option dest              lan


# We need to accept udp packets on port 68,
# see https://dev.openwrt.org/ticket/4108
config rule
         option name             Allow-DHCP-Renew
         option src              wan
         option proto            udp
         option dest_port        68
         option target           ACCEPT
         option family           ipv4

# Allow IPv4 ping
config rule
         option name             Allow-Ping
         option src              wan
         option proto            icmp
         option icmp_type        echo-request
         option family           ipv4
         option target           ACCEPT

# Allow DHCPv6 replies
# see https://dev.openwrt.org/ticket/10381
config rule
         option name             Allow-DHCPv6
         option src              wan
         option proto            udp
         option src_ip           fe80::/10
         option src_port         547
         option dest_ip          fe80::/10
         option dest_port        546
         option family           ipv6
         option target           ACCEPT

# Allow essential incoming IPv6 ICMP traffic
config rule
         option name             Allow-ICMPv6-Input
         option src              wan
         option proto    icmp
         list icmp_type          echo-request
         list icmp_type          destination-unreachable
         list icmp_type          packet-too-big
         list icmp_type          time-exceeded
         list icmp_type          bad-header
         list icmp_type          unknown-header-type
         list icmp_type          router-solicitation
         list icmp_type          neighbour-solicitation
         option limit            1000/sec
         option family           ipv6
         option target           ACCEPT

# Allow essential forwarded IPv6 ICMP traffic
config rule
         option name             Allow-ICMPv6-Forward
         option src              wan
         option dest             *
         option proto            icmp
         list icmp_type          echo-request
         list icmp_type          destination-unreachable
         list icmp_type          packet-too-big
         list icmp_type          time-exceeded
         list icmp_type          bad-header
         list icmp_type          unknown-header-type
         option limit            1000/sec
         option family           ipv6
         option target           ACCEPT

# include a file with users custom iptables rules
config include
         option path /etc/firewall.user

_____________________________________
_____end_____________________________________
__________________________________________


Finally here is my /etc/config/wireless file:

I also have some questions here...
Is necessary the both routers have the same BSSID? Is mandatory to  
have BSSID, or isn't mandatory to aggregate a batman-adv mesh network?
"option network wifi" is correct or should be "option network lan"?



root@OpenWrt:/etc/config# vi wireless
config wifi-device  radio0
         option type     mac80211
         option channel  6
         option phy      phy0
         option hwmode   11g
         option country  PT
         option txpower  20
         option disabled 0



config wifi-iface
         option device   radio0
         option network  wifi
         option mode     adhoc
         option ssid     PR
         option bssid    00:13:10:7c:da:71
         option encryption none

________________________________
______end___________________________
___________________________________


This is it...
Perhaps you don't have the time to analyze all this...
I'm about two months to get this thing done... but i am not capable...
I already asked to my colleagues and to my teachers, but they don't  
know how to...
It's my job...
So i decided to ask for your help, otherwise i think i don't get there  
only by myself... i can't find nothing concrete about these  
configurations anywhere...

Could you please give some light?
I would be very appreciate, and of course i would refer your kindness  
and contribution in the greetings section of my thesis...
Thank you very much.
Best regards and good work.
Pedro Rodrigues
Portugal, Europe



--=_F-bdJKeWCxtPoDRF7ZSW7AA
Content-Type: image/jpeg; name=Scheme_bat-adv.jpg
Content-Language: NIL
Content-Description: Scheme_bat-adv.jpg
Content-Disposition: attachment; size=42528; filename=Scheme_bat-adv.jpg
Content-Transfer-Encoding: base64

/9j/4AAQSkZJRgABAQEAYABgAAD/2wBDAAgGBgcGBQgHBwcJCQgKDBQNDAsLDBkSEw8UHRofHh0a
HBwgJC4nICIsIxwcKDcpLDAxNDQ0Hyc5PTgyPC4zNDL/2wBDAQkJCQwLDBgNDRgyIRwhMjIyMjIy
MjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjL/wAARCALQA8ADASIA
AhEBAxEB/8QAHwAAAQUBAQEBAQEAAAAAAAAAAAECAwQFBgcICQoL/8QAtRAAAgEDAwIEAwUFBAQA
AAF9AQIDAAQRBRIhMUEGE1FhByJxFDKBkaEII0KxwRVS0fAkM2JyggkKFhcYGRolJicoKSo0NTY3
ODk6Q0RFRkdISUpTVFVWV1hZWmNkZWZnaGlqc3R1dnd4eXqDhIWGh4iJipKTlJWWl5iZmqKjpKWm
p6ipqrKztLW2t7i5usLDxMXGx8jJytLT1NXW19jZ2uHi4+Tl5ufo6erx8vP09fb3+Pn6/8QAHwEA
AwEBAQEBAQEBAQAAAAAAAAECAwQFBgcICQoL/8QAtREAAgECBAQDBAcFBAQAAQJ3AAECAxEEBSEx
BhJBUQdhcRMiMoEIFEKRobHBCSMzUvAVYnLRChYkNOEl8RcYGRomJygpKjU2Nzg5OkNERUZHSElK
U1RVVldYWVpjZGVmZ2hpanN0dXZ3eHl6goOEhYaHiImKkpOUlZaXmJmaoqOkpaanqKmqsrO0tba3
uLm6wsPExcbHyMnK0tPU1dbX2Nna4uPk5ebn6Onq8vP09fb3+Pn6/9oADAMBAAIRAxEAPwD3+iii
gAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKA
CiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAK
KKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAoo
ooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiii
gAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKA
CiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAK
KKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAoo
ooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiii
gAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKA
CiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAK
KKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAoo
ooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiii
gAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKA
CiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAK
KKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAoo
ooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiii
gAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKA
CiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAK
KKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAoo
ooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiii
gAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKA
CiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAK
KKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAoo
ooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiii
gAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKA
CiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAK
KKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAoo
ooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiii
gAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKA
CiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAK
KKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAoo
ooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiii
gAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKA
CiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAK
KKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAoo
ooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiii
gAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKA
CiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAK
KKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAoo
ooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiii
gAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiqtre2t6srWtzDOsUjRSGKQOEdeqnHQ
juKJ721tJII7i4hhe4fy4VkkCmR8Z2qD1OAeB6UAWqKKqz3trb3EEE9zFFLcMVhjeQK0pAyQoPJI
HPFAFqiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAo
oooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKAOGh
/wCS33f/AGAI/wD0e1bPjSa1t/BWtT31p9stI7ORpbfzTH5qhTldw5XPqK5PXdVuvDnxUk1b/hH9
c1O0m0iO3D6bZGcK4lZsE5AHHv3FTav4jn8X+CPE1nbeGfEVjONPkEaahYGIzMykBYwCSx9vepfw
6D+3r5fkS6j45udIvdF0TSPDU2o3F9p4uLeGK6VAmMfKzOMBQufmJ6gDHNY/iPxbJ4m+GHi+3vdL
l0rU9OXybq0eUShCSCpDgAMCP84wTr6fp96nj/w/ctZ3C28Xh5oZJTEwVJNyfITjAbg8deKw/Eej
6lPa/E5YtNvJDei1+yhIGPn4jUHZgfNg9cZp9H8/z0/AUd0djpnij+0NcXSNLsTd21lEF1C/Mu2O
CTaMRLwfMf8AvDIC9znisOz+JOsaijanpvgm+vfDwlZBfW93G0zqrbSy2/3j82eM9OaTw9o114E8
VQadplhdSeG9VhDbFDSCxuVXkseSqOAOT/FXE6xokUmo3EmmeCPF2g+KmaRVuNHl/wBDkkb7pack
KIzwTtC4yQelPqJLSx643iYweNLbw9c2nlJd2bXNrdmT/WupAePYRwwB3dTxWbqfxBttKuPETy2U
j6focUXn3Eb5Mk0mMRKuMcArk7uN3SqPjm1v7PwRp2vzPE2t6AYrx2DBVlIAWZM46MC3brijSNFv
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
tx2OL1zxTrnhzX51ufDl/qmjSxobWbSLYzTRyfxrKpbp3DAAduT0xLXwbL41TxFf63Df6Ra63LbN
DbIypOscI+VpOGCsxPK9RgV6hSULzBs8a174a3cXirwzHB4i8X3cDzTCa7kvjI1oBHwVcJiPceMn
r0rptZtta8LeLbnxPpWly6tYX8EcWo2duwE6NHwssan/AFh25G0YJ4/Dv6KNQPGNdhPj2T7Lo/w4
u7C+mmjludX1ayjtGiCupyGwzSEgEEA5HHUV1+t654l8MeJJrl9Jvdb8O3MaCNNOiV7izkAII2cF
1bg5J4/IHuKU0bKyDrdnleh2Mmv/ABFsPEeneFbvw7Z2kU4vJru2W2mvpJAPlMY5YA/NvPU59K9T
7UUUuiQdbi0UUUwCiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKK
KKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooqKWVIYnlldUjQFmZj
gKB1JPYUAeb694O1W++JdtcwQbvD91Jb3eoN5i/663D7F2k5IOY84B+7Vn4o+GNZ1y00+58PRLJq
MLS2rEuExBPGUkOSR0+Ujn8DXd2t1b31rHc2txFPbyLujlicOjj1BHBFNhvba4uZ7eG5ikntyBNE
kgZoiRkBgORkcjNFtLBfW5yvjDw5cT+BbXRdItvNNtLaBIwypiOKRCTliBwqmtHxp4ZXxR4eltEc
w30JE9lcKcNDOvKMD254PsTWvf6nY6Vam61C8t7S3BAMtxKsaAnoMsQKLHULTU7RLuxuobq2kzsm
gkDo2Dg4YcHkEUtX99/yFtYpeG59WuvD1o+uWP2TVPL23EXmI4LjgsCpIweuO2cVm/DrSL/QvAmn
abqUHkXkIk8yPerYzIxHKkjoRXWUU2738wSsrHna6h8SdKabSzoNrreZWEOsm+jt1CMflMkIXOVB
52jnHGTyX2nwl8OT+HdK07X7T+0rixjcecJpIgWkcu+AjDjcTjPavQaSgbZ5j4V+F+m+HviLqWqW
+jfZ7CCOL+zJftLPtcoyy8FyT1/iH0qeHTvF3ga5urfw9pNvr+h3E7zw2hultp7R3O5l3MNrR5zj
v83tz6PRS1A8/wBK0zxZ4g8YWHiLxBYWWjW2nRzR21jHN9onYyKFYvIPkxxkYGexHeoLeb4heE3m
02HRU8V2PmM9rePqSwTohYnZL5mdxGcAjsPwHpFFMDi/BOgapZX+ta/rUVva6hrUsbvZWzbkt0Rc
KC3Rn5O4jgnpXaUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQ
AUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFAHA6cp0D4tanZEbbPX
rVb2DPT7RF8kij3KlWNSacP7f+KOo6gebTQbcWMHcGeUB5WHuF2r+Jqf4gWV0tlpuvabazXV9o14
lwkECF5JYm+SVFA6kqxP4Vb8B6TcaV4Vt/t0ezUbx3vL3I586Vi7A/TIX/gNKP5aA/zNvUjqA06f
+yltjfbD5IumYR7u27aCcfSuB8CW+p2nxC8XRaxqJv73yrJpJQmxFysh2IvZRnA9ep5Neld64zQ7
O5h+JXi27ltpktp4rIQzOhCSFUfdtbocZGcdKa3B/C/l+Z2deV6jbeIU+KXhO61u/tmiluLxbaxs
1by4kELYZmbl3IIycADBx1r0G21Y3WtX2m/2ffxfZAh+1Sw7YJtwziN8/MR0PHBrn/E1ldXHj3wZ
cQ200kNvLdmaVYyViBhIG4jgZPAzQt0w7ryZ2naijtRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQ
AUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUVxnjrVrmM6T4b06aeHUdduxAJb
eQRyQ2yYa4lRmBAYJwOhy2VyRioNfuEu/E+heBtPh8q08o3moxQhURbKMbY4ipXBjkk2oyrztUgj
a2aAO6ooooAKK5Hx8bvTvD//AAkWnRyPf6M4utkbonnW4I8+JmYH5DGC2BzuRCMlRWf4q12LSrbQ
/HVjI76YzxRX7rhFksph8kjqVLsY3ZGUAbhvcYG5qAO+ooooAKKKKACiiigAooooAKKKKACiiigA
ooooAKKKKACmsodSrAFSMEHuKdRQB554Eu4/DemeIdAvXCxeHriSRGJ6Wjgyxn8BuH4Vf+G9pKvh
k6zeLtvdbnfUJgf4Q/3FHsEC/rWV468I6tquvwy6Qn+i6rbjT9WbzFTy4VkVw4B5Y7fMTj+8K9ER
EjRURQqKAFA6ACktr9dge9lscx4o8NaTqVzFrmrWdzqq6ZbymHTVjWVJGI5IiI+d8DABOPbPNcx8
MpLJvFHiU2Vk+iRTGF00SeFoZYgAQZjGQFXdxwmRwM9q6jxG/iyw1KDUdAt4tVtBEYp9JklSBmYn
IlSVh1HQqTjHTmqHh3S9c1DxbN4r8QadDpU32IWFvYRzid1TfvZnkXgkkDAHQe/UiD2O6ooopgFF
FFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUU
UAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQ
AUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFAB
RRRQAUUUUAcD41gmtfGvgjXzFJLaWl7NZTCJSzI10gijc9ggbAJJ/iGAScUX0M2n/GvSNUlika01
TR5dMieNSRHNG5n+c9AGQNtwSSVPGBmuu1XS7LXNLuNN1O2S5s7hNkkT9GH8wQcEEcggEYIqDUND
ttV0yCzvmknkt3jmhumVPNjnQ5WZfl2hwefu7TkggqSKANeue8G/8gS5/wCwrqX/AKWzV0Nc94N/
5Alz/wBhXUv/AEtmoAq/ES6Nt8PddH2ee4kuLVrSKKBNzvJN+6QAd/mdenPoCeK5nxto95F8I9I8
GCPztSvvsOlRvCC0ayJtdnY43CMLC5JwSBzjrjvdQ0e01S9sbi8j85bCU3EMT4KCbGFkPGdygtjn
A3ZwSFKrJo1pca3batcJ511aRNFa7wCIN/32XjO5gFBJJwFwMZbcAadFFFABRRRQAUUUUAFFFFAB
RRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFF
FFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUU
UAFFFFABRRRQAUUUUAFFFFABRRRQBkaB4i0nxPpY1LRr5Lu0LFN6gqVYdQysAVPQ4IHBB6EVJpet
6frRvRp9x532K7ks7j5GXZMmNy8gZxkcjI968S+G4/4Qvwv4Z8VQ/JpWryvZa4W5EbCaRbefJwI1
Una5LbcEfKW5rQsdf1TQtE8TRaKIF1PVfHFzpttNOfkgeXbiQjBzjb0x3zg42kA9wqpqF9b6bp1z
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
ooooAKKKKACiiigAooooAKKKKACiiigAooooA4Dw/wD8ed7/ANhXUP8A0smrVrK8P/8AHne/9hXU
P/SyatWtlscE/iYUUUUyQooooAKKKKACiiigAooooAKKKKACsrRdes9C1PxBFfQakpn1BZomh024
mR0+zQLkNGjL95GHXtWrRSauXCfI7kv/AAneif3NX/8ABLef/GqP+E70T+5q/wD4Jbz/AONVFRU8
hp7d9iT/AITvRP7mr/8AglvP/jVRw+P9AuYEngOqSwyKHSRNHu2VlIyCCIuQR3orF8H/APIk6D/2
Drf/ANFrRyD9u7bG/wD8J3on9zV//BLef/GqP+E70T+5q/8A4Jbz/wCNVFRRyC9u+xJ/wneif3NX
/wDBLef/ABqsbxL4lsdZ0uGxsYNVed7+ycb9KuY1CpcxOxLPGFACqTkntWrRRyA67fQKKKKswCii
igAooooAKKKKAE8G/wDH54n/AOwqv/pHbV1Vcr4N/wCPzxP/ANhVf/SO2rqqxe53x+FC0UUUigoo
ooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigDlPGX/H54Y/7Cjf
+kdzS0njL/j88Mf9hRv/AEjuaWtIbHLX3CiiirMAooooAKKKKACiiigArF8H/wDIk6D/ANg63/8A
Ra1tVi+D/wDkSdB/7B1v/wCi1oK+ybVFFFBIUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAYnj
D/kSNf8A+wbcf+i2r0SvO/GH/Ika/wD9g24/9FtXolZz3OqhsxaKKKg3CiiigAooooAKKKKACiii
gAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooA4Dw//AMed7/2FdQ/9LJq1
ayvD/wDx53v/AGFdQ/8ASyatWtlscE/iYUUUUyQooooAKKKKACiiigAooooAKKKKACiiigAooooA
KxfB/wDyJOg/9g63/wDRa1tVi+D/APkSdB/7B1v/AOi1oK+ybVFFFBIUUUUAFFFFABRRRQAUUUUA
FFFFACeDf+PzxP8A9hVf/SO2rqq5Xwb/AMfnif8A7Cq/+kdtXVVi9zvj8KFooopFBRRRQAUUUUAF
FFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFAHKeMv+Pzwx/2FG/9I7mlpPGX
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
5/8AHa6Wii4WRzX/AAgeif8APTV//B1ef/HaP+ED0T/npq//AIOrz/47XS0UXCyOa/4QPRP+emr/
APg6vP8A47R/wgeif89NX/8AB1ef/Ha6Wii4WRzX/CB6J/z01f8A8HV5/wDHaP8AhA9E/wCemr/+
Dq8/+O10tFFwsjmv+ED0T/npq/8A4Orz/wCO0f8ACB6J/wA9NX/8HV5/8drpaKLhZHNf8IHon9/V
/wDwdXn/AMdpsHgXRLZ5mgfV4jK++Qx61eLvbAXJxLycKoz6ADtXT0UBZI5//hDdM/5+tc/8Ht7/
APHqP+EN0z/n61z/AMHt7/8AHq6GigZzE/hLT4oJZEfX53VCyxx67dhnIH3RunAyenJA9SKm/wCE
N0z/AJ+tc/8AB7e//Hq2Z/PaCVbd445ypCPIhdVbHBKggkZ7ZGfUVBpN5Nf6PY3txayWktxbxyyW
0md0LMoJQ5AOQTjoOnQUAZv/AAhumf8AP1rn/g9vf/j1H/CG6Z/z9a5/4Pb3/wCPV0NFAHPf8Ibp
n/P1rn/g9vf/AI9UFx4G0a7i8qeTWJU3q+yTWrxhuVgynBl6ggEHsQDXUUUAcz/wgeif89NX/wDB
1ef/AB2j/hA9E/56av8A+Dq8/wDjtdLRRcVkc1/wgeif89NX/wDB1ef/AB2j/hA9E/56av8A+Dq8
/wDjtdLRRcLI5r/hA9E/56av/wCDq8/+O0f8IHon/PTV/wDwdXn/AMdrpaKLhZHNf8IHon/PTV//
AAdXn/x2j/hA9E/56av/AODq8/8AjtdLRRcLIzdH0Kx0KKeKxWZRPL50rS3Ekzu+1VyWkZm+6ijr
2rToooGFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFA
BRRRQAUUUUAFFFFABRRRQAUUUUAFc/4E/wCSe+Gv+wVa/wDopa6Cuf8AAn/JPfDX/YKtf/RS0AdB
RRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFF
FFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUU
UAFFFFABRRRQAUUUUAFFFFABWR4fM/8AYsMMyXSvbPJahrty8sqxO0aysxAyXVA+cfxd+ta9Z5d4
9XSI3EZSa3ZhA0ihlKMAWRNuWB8wBiWwuEAHzE0AaFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFF
FABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUU
AFFFFABRRRQAUUUUAFFFFABXP+BP+Se+Gv8AsFWv/opa6Cuf8Cf8k98Nf9gq1/8ARS0AdBRRRQAU
UUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRR
RQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFF
ABRRRQAUUUUAFFFFABWXcWMba7Yaj5U7yxRTWoKMoREk2OzMDgnmFFG3P3uRjkalV54IriMJNFHK
gdXCuoYBlYMp57hgCD2IBoAsUVUsJri4062mvLb7JdSRI01v5gfynIBZNw4bByMjrirdABRRRQAU
UUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRR
RQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABXP+BP+Se+Gv+wVa/8Aopa6Cuf8Cf8A
JPfDX/YKtf8A0UtAHQUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFA
BRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAF
FFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAZmn3bSzXdrMJ0uIJWO24eEu0TM2xw
IycRnDKu4BjsORkEnTqrcXXkT2kXkTSfaJjFuiTcsWEZ9zn+Ffk25/vMo71aoAKKKKACiiigAooo
oAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiig
AooooAKKKKACiiigAooooAKKKKACiiigAooooAK5/wACf8k98Nf9gq1/9FLXQVz/AIE/5J74a/7B
Vr/6KWgDoKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKK
KACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAoooo
AKKKKACiiigAooooAKKKKACiiue8XeL9N8F6THqOqJcNBJMIFECBm3FWboSOMKaAOhorysfH7wef
+WOqj626/wDxdSj49eDT/DqX/gOP/iqAPT6K8w/4Xz4NIP8AyEeP+ncf/FUo+O/g89tS/wDAYf8A
xVAHo88byIFSaSIh1bcgUkgMCV+YEYIGD3wTgg4InrzWP44eEZXCIupFmOABbZJPp1qz/wALf8Pb
2T7HrG5QCR9iOQDnHf2P5GgD0GivMz8dvBwOP+Jj9fs3/wBeg/HbwaO+of8AgN/9egD0yivMj8d/
Bg76h/4Df/XpD8efBvYaifpbj/4qgD06ivLv+F9eDv8Annqf/gOv/wAVXd+HdftPE+hW+sWAlFrc
btglUK3ysVOQCe6mgDWooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKK
ACiiigAooooAKKKKACiiigAoorK8Q3ctj4a1W8gfZNb2c0sb4B2sqEg4PHUd6ANSivDE8b+KdRV5
01ya2AkeLy4beAr8jFM/PGxyduTzjJOMDADv+Ep8W9vFF5+Nra//ABqr9nIXMj3KivCz4q8Y/wAP
imcfWytz/wC06ibxP44P3fFsg+un25/9ko9nILo95orxOw8b+MbO3aObVLG+cuWEtzYYZRgfKPLd
BjjPTPJ56Ytf8LE8XD+LQz/25Sj/ANrUckguj2KivHD8R/GI6JoR+ttMP/alRt8SPG/8MPh78YZv
/jlLkkF0ez0V5HY/E3xJFbsuoaPpVzNvJV7e6kgULgcFWRyTnPOfTjjm/a/E/UZtQsoJfD9tGlxd
Q27Mmos5TzJFTdgwjON2cZHSjkkF0em1z/gT/knvhr/sFWv/AKKWugrn/An/ACT3w1/2CrX/ANFL
UjOgooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKK
KACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAoooo
AKKKKACiiigAooooAK8/+LkcUnhazWaNJF+3Jw4BH+rk9a9Arz/4vtt8KWh/6f0/9FyUAeQQaG0q
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
Eazc6rqeoWcskkDW4httzDaWVtxZgvOVxjH49qAPW6KKKACiiigAooooAKKKKACiiigAooooAKKK
KACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooA4vWpgnjmCH/AJ62IH5M5/pVlraNyC8a
sR0JGao+JvD3iG+8VW2r6M+mf6PAqbbySQZb95nhVPGHGDnqDxU0vhzxNeC3dvEcFgfkM8VpYiTH
TcqPIT74Yp77e1aJq1mS07ltYQvRQPpTvLqnc/D6G7B+0eI/ELk/3bxYx+SIB+leQaxomn23i680
2xZrqK2kERubh45ndgoL4ZUGNrEqVOSCp57BqzdkhWPZLq6s7FN93dQW64zumkCD9ax5vGvhmD/m
LRT/APXqrT/+iwa4hLTAAAAA7CuX+Icos/DXk8brmVU/AfMT+g/OrasriR69b+N/Dl40iWt+ZpUQ
u0SwuGx0zggeo/Os+5+IVrGxS20m+mI6MzRoh/HcT+leMfC61lTV72d1wkmnybPfEkea7DNSndDs
dNN4+1iUf6Pptjb+hlmeY/kFT+dJD431sDEw09/eO3dP5yGubBpc07gTTSyXOoXd7M5aa6kEj8AA
EIqADHbCCgGogadmkB2Ph5d2mD/eNa4SszwwN2kj/fNaz/KcVSEJgCms1MZ6jZ6AHM9avhlv+Kr1
iP0sbM/m9z/hWTboZ7hUHTOT9K1fDJ/4rbXR/d0+xH/j9yf61M9hrc7GiiisSwooooAKKKKACiii
gAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKA
CiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAK
KKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAoo
ooAKKKKACiiigAooooAKKKKACiuI8U/E/wAP+EdSax1AXUsqIrObdUcITkhWG4ENjDYx0ZT3rye+
/aG1W4e4Wzsra0gZNsWIzJLGduNwcsFJzkjMeOgIPd2A+hNQvbfTtOub66k8u3tommlfaW2ooJY4
HJ4B6V4R4c0+UF5JZXmkC/vJZGLNI7HLMSeSSckn3ritT+M3irUtMu9NlvTJb3ULwS+ZDECyMCp+
6gxwTXU+GPF9rqLPFYSFXUljbzoNzDjkYzx9D2q4WTJZ162lea/EdWPiGwhl8gW9vbGbdKeNzlgM
jPI+QV7FpmraXdskU0Zt5W455Un61v3Oh6ZeW7QXaWs0Lj5o5MMrD3Bq5O4kfNHhjWbTw5rU1zqH
nyRXdu0RvEXcrOzKR0PCgKfU+1d/p0Wla1F5mlalDdEjPlxyYdfqjAMK6m8+EXg2QO9kkmn3DciW
2nfj/gJJXHtiuD1f4J6ubtpLLUNM1CHri4R4JPplFwfqTU6jNabR7iJ8Egf74IqvJZXEfPl7h6rz
Xnzazq3grVLjTEub7TbmBtrwxyrcQ5ODna/HIxzXqHhDV38ayGPSZDPcJAZZbfU0QDKyBSBcQhSP
lZSAYTyDz0NF0FjJyQcHg+9G6vQ9Y0GTTbKGaTSrucMP339nf6QITkDlTh3BJ/hU4wScCsK00zS9
Xnlisby0lmhJWWAlo5YyDghozypB45HWjfYRreEhu0fP+2a25rcyJ8v3h096raFpz6daPA6bQHyv
OeK1wlWhHOM+KiZ63dQOm28Xn6jNbwRjrJNIIx+ZIrPsta0OWUNpEc+pMZREJLG3knjDnHBlAMa8
MCcsMA5PFJjL2mWRij82QfO44HoP8ak8NWtwnjDxDeNHi2eK0gjfjl0EjMMdeBKn5+xq5p4v7wzC
fSbmx8vGw3UkREuc9PLd8YwOuOo684vaPp9xZC7kuWj8y6uPOKRsWWMBEQAMQM/cz0H3sc4yYk1Y
aWprUVQvNW03TpoIr7ULW1kuMiFJ5lQyYxnaCecZHT1rOsfGOgXhjVNTigkllEMcN4rW0sjnGAqS
hWbOQAQDk8dQazKOgooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKAC
iiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKK
KKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooo
oAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKAMq+8P6Lqd0LrUNIsLu4CC
NZZ7ZJHCgk7ckE4ySce5rBl+GHhCe4knfSXV5HLkJeTqoJOeFDgKPYAAdq7Oii4HAal4F+HOnmKP
VbWxt/Oz5a3d8678Yzjc/OMj8xXj3j74e+E9Fsor3RPEVrOhIRke4R5d5PBAjAXZjJJO3G3gsWAH
oHxH+FOp+IdWvNZ0W9Cz3Me+aFm2MzoiqoQ4wQwUDDEYPOcHC+B6r4P8RaXard6hpt5HC7eWrzQS
R5bBO351BJwCce1MRoaD8QdU0uWOK8cXtouFKv8A6xVz/C3Un/ezxxxXpl18e9DjT/QtFv5mx0mZ
Ix+YLV4LLBJC+yWNo2/uupBpiqzHCgkn0FNSaCyPX739oDVH/wCPDQ7KEf8ATeRpf5bawbv40+NL
iTdFfW9qv9yK2Qj/AMfDGuMTQ9WcBk0u9YHoRbuQf0rXsvAHivUEDwaHdBP7zpt/nzReQWQ+2A8X
axdan4g1yzgmk5Z5wymVgAANsSNgY7gdjX0H4Fn+HXhnQXutN1a2aWGIx3FzOHjlkx87bIn+baSR
woO7aASxWvFLb4NeLLkAiK2j9pHZSPzWt2y+AerSKrXmq2cR7pGGb9cUWYHrN98a/Blo0QivJ7sO
DuEMWwx4xjIkKHnPGAehzjiuF1z9oWC5ins7HRIXgd2Qtd5nSaEgjDR/JgkYyMsOo561Jp/wJ0iJ
g17eSzeq5OP02mt+1+Dvgy3cO+nSTEHOHnfH5ZosFzzC3+LP2SSV7HR7K0EgwYbdbiOFeMfLGtwE
U+4Ayeetb2nfEnQfISfVvA8t7byGMXV3fXE10i4PLRpMJAvUkKHGeATwDXqNn4J8MWDBrXRraFh3
UHP861H0rTpLZrdrKAxOMMuwc0AUrXxvbwW0UFr4P8TwwRKFjiXSjGqKBgADIAAHaotR+KOn6TAk
+o6D4hs4ncRo01kFDOc4UfNyeDx7USaRqumWKQeGdXezSKQOltcjz4iAABH8+WWPCgbUK45xin6t
fWmuWUWkeJdKurU3G4CW3BuII5CSi/Nt9G3ZePYMHJ4GU0FzjtV+MXiJ7rbpHhG9SBWYb7i0lkMq
5G04BTYcZyPm6jnjnM0XxR8RbzXLGG91K7trdj50n2m2thvjQruXCpkE7gO3XPauhj8NanDaySeF
tYstatbaQxeSsqs2dwyjHdhWVSpyGUdcRjgVVnudOub6GHVrO4sbuCMXEbzq0W1T1O7gquVIO8KG
weDg48mvjMVh5pzp3h1a1f3HbCjQqRfLK0vPY7LTdRsdOsxBbKIhnc5JyzserMxOWYnksSSTyanm
123eJ0kZXRgQV4OR6VxH9n6oP39rdQ6haSL5kZyFkAPIAI+Vwc9flx75rOa71PzPLOjal5p/h8kE
f99Z2/rXXRzPBVo8yml5N2a+8554epF2aNma+vNEt/L0O+/s7Tcu80SCPEJOPnQOpVVHJZRgclsZ
zu3NJ8U65aGODVYLa/hUc3ULGKYgLxmMgozEjkh0HPCjGDyc+ia3qFmIvKt7aOdCkvnybnjB4+6o
Ktx/tCuohsRDDHEpJCKFBY5JwO9eDm2dRo1Iywk1K+63Xkd+FwylBxqxt2fU3LDxtpF1G5uWuNMk
jRnlW/iMaRgHHMvMR6g4VycfQ434LiG6t47i3lSaGVQ6SRsGV1IyCCOCCO9efyXNhBcLbT3ltHO/
3YnlUMfoCc1i2t5pOm+JFj0a0vY9UuCwZLRDAsxCtlijlUmwCxzh8cnjrWmCzurXdpUn6pf5mdXC
Qj8MvvPYqK5Twq3iB5rs6peSz2wkYRrc2YilU4XA3rtBX73RDyfvnGK6uvoYvminaxwtWdhaKKKs
QUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFAB
RRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFF
FFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUU
UAFFFFABRRRQAUUUUAFFFFABXB/EXWNT06OztbS3RrG7jnW7eSASKcbAsZ3Arhg8nBGTt44BrvK4
/wCIKlvD8Y2MYxPvlkCnbEixuxdj0VRjqcDmnHcTPNdA8I+ELxVF3aO8qY2rcXLOn4Aniu1tfCeg
WQAttMhiA7JkD8s1xcMDJtkQkZGVYdCP6iun0rWZEVYZ+QBgZ4/WtmuxNzooLW2t/wDU28Uf+6gF
WN1RRusi7lYEfyqGW5YErEuf9o1NrjuXATS5rN3XLjBkb8BikFqzfeLH60+UVzS82MdZFH1NKJov
+eqf99CqK2XtUv2VEGXIUep4p8qC5bEsf/PRP++hTxJH/fX86pD7KoyZo/wbNMa9tE+7uc+wx/Ol
ZBc0fNj/AL35CmSSLIhTyywIxzWcNUBOFtiT2+b/AOtVTUNfGnKrXtxbWCN91rhxGD+LHFFkFy5a
6QlnfXF9ZbrW7uIhFLLF/GAcglTlWYc4JBIyR0Jqrfi6isoW1zSrTxD5KyL9ohiWG6jQoB8iscM7
FfmKvH2wvAFE+oXSWcN0z3ctvMgeJ7K0kuA6kZBBiVuCO/Sobe016/C3FrpDRphHU6rOLcyA88Kg
kZSO4cKRnp1wnygrjH8CzW1lLeeE9TuLaS8YTiC9XYgDMGxgplMAtncpc8AkHmqJ1TxJAWhm8J3U
k8agMyFghcjPVQwxgjlWfnI6ivRtNS5i0y1jvdhukhRZjGxKlwo3YJAJGc9h9Ku4rysTleExL5qk
FfutH87bnRGvOOiZ5kV8YatFb/2bo8enrMHDzXh4jIz2JV1yRgHy26g4xzWpH4J1K7s4IdV1+dgV
zcLbDy33Y6LIm3gN3KcjsM8dzSfjRRyvB0fgpr56/iwlXqS3Zy+l+AtB0u1hgS3eZ433mZm2NId2
RvEYVWHbBGCBznmt2y02x01JI7Czt7RJHMjrBEsYZyACxAHJwBz7CrtFd6SWiMgooopgFFFFABRR
RQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFF
ABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUA
FFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAU
UUUAFFFFABRRRQAUUUUAFFFFAHIal4EsZ2t30thpRgBQQQwqbZ1LbjmLjDct8yFTk87gAK5bULF9
JuryO/ia1ghO5Llwfs7xk4U+bgKrZOCjEHPTcCCfV6WqUmhNHnFpNNav5cysV6EHgitFru2T7oZz
7LgfrVm/8JFLt7zR7gQ5iWM6fN/x7EKDjZgZhY/KMrlcAkoxOaRPDeoyadGTJZWd+c7wyvdxDnjB
zETx6gcnvjJtTRNiqNRUdLcf99f/AFqQ3d3KpMceFHdUzV2LwXFMVfUtUv7k+WFaKBxaxh+MsvlB
ZB3wGduDzk81rz6Dpd3ZRWd5p8F3BEoVVu0E54GASXySfc5J70ucfKcfY6iuqX0tnZajDPdxKWkg
iuFLoAQCSoOQMkDp3FMZrmWd4LbTdWvLhVLECzaFcZx/rJ/LQ9egJPtwa9AgghtbeO3t4kihiUIk
cahVRQMAADgADtU9LnY+U4rS9C1aeTdqVnbWsDRBl2XRklVzj5XQIFGMnJVzyOM5yJj4T1CW4kEu
txw2pUhFsrBVlByMEvK0gPGRwo6g8Y57Cip5mFkYOleFtP0pi8cl7cSNF5UjXV1JKsnTLGMnywTj
+FR1OMA4q3Z6DpGnXz3tlpVjbXcilXnht0R2UkEgsBkjIH5CtOikMKKKKACiiigAooooAKKKKACi
iigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKK
KACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAoooo
AKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigA
ooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACi
iigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKK
KACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAoooo
AKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigA
ooooA//Z
--=_F-bdJKeWCxtPoDRF7ZSW7AA--

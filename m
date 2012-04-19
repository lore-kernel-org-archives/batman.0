Return-Path: <hexiled@nixbits.net>
Message-ID: <4F9077E8.30805@nixbits.net>
Date: Thu, 19 Apr 2012 16:39:04 -0400
From: HeXiLeD <hexiled@nixbits.net>
MIME-Version: 1.0
References: <4F8DD568.3040102@nixbits.net> <4F8E63E9.5020605@codigosur.org>
In-Reply-To: <4F8E63E9.5020605@codigosur.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [B.A.T.M.A.N.] Batman configuration and MTU
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

@ Nicolás

Right now i am trying this setup and batman is not complaining about MTU
as it can be seen as set. The purpose of this setup is to allow wireless
and wired clients to to use the mesh as if a user connects to the router
over wired and accesses the gateway one or 2 nodes after.

However i now have dhcp problems for wireless clients as the router
fails to assign the wireless client, the ip. The client (netbook)
connects but gets no ip. MTU seems to be fixed with this setup.

Would you be able to show some of those working examples ?

~# cat /etc/config/batman-adv
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
        option 'interfaces' 'wlan0'

# cat /etc/config/wireless
config 'wifi-device' 'radio0'
        option 'type' 'mac80211'
        option 'channel' '11'
        option 'phy' 'phy0'
        option 'hwmode' '11g'
        option 'country' 'UK'
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
        option 'network' 'wifi'

~# cat /etc/config/network
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
        option ports    "0 5"

#### Loopback configuration
config interface loopback
        option ifname   "lo"
        option proto    static
        option ipaddr   127.0.0.1
        option netmask  255.0.0.0

#### LAN configuration
config interface lan
        option type     bridge
        option ifname   "eth0.0 bat0"
        option proto    static
        option ipaddr   192.168.1.1
        option netmask  255.255.255.0

#### WIFI configuration
config interface wifi
        option proto    none
        option mtu      1528

#### WAN configuration
config interface wan
        option ifname   "eth0.1"
        option proto    dhcp

On 04/18/2012 02:49 AM, Nicolás Echániz wrote:
> On 04/17/2012 05:41 PM, HeXiLeD wrote:
>> I have being doing some testing with several types of configurations
>> with custom openwrt build and batman in oder to try to come with a basic
>> default "plug & play" ready to deploy firmware evolving the least
>> changes possible other than the router's ip and not much more.
>> I have tried several configurations, more than one subnet and have being
>> trying to see a way to make some nice HOW-Tos regarding this matter for
>> several types of configurations.
>>
>> So far and from what i seen all working and half working examples do not
>> work for everyone or at least no one or very few post complete
>> configurations of all files in /etc/config/  that actually fully work.
>>
>> Then there is the question if bridging. Some say bridge this, others say
>> do not bridge that. None supply a fully working example that can be
>> replicated. (i am glad i access the routers over serial cable which i
>> recommend to everyone if they are working on builds and configurations.
> 
> I can send you some sample configs if you wish, I copied some snippets
> in this mail.

I would appreciate that very much

>> config 'wifi-iface'
>>         option 'device' 'radio0'
>>         option 'hidden' '0'
>>         option 'mode' 'adhoc'
>>         option 'ssid' 'wireless'
>>         option 'bssid' '02:16:b8:6b:0a:1a'
>>         option 'encryption' 'none'
>> 	#option 'network' 'lan' #is optional or must match bridge name
>>         option 'mtu' '1528' #mtu seems to be ignored - needs fix
> 
> 
> AFAIK mtu is set in config/network, not in config/wireless
> 
>> # cat batman-adv
>> config 'mesh' 'bat0'
>>         option 'ap_isolation' '0'
>>         option 'bonding' '0'
>>         option 'aggregation' '1'
>>         option 'fragmentation' '1'
>>         option 'gw_bandwidth' '3mbit/384kbit'
>>         option 'gw_mode' 'client'
>>         option 'gw_sel_class' '5'
>>         option 'orig_interval' '1000'
>>         option 'vis_mode' 'client'
>>         option 'interfaces' 'wlan0 eth0.0'
> 
> 
> I believe you have your bridges mixed up.
> 
> For a normal situation, you should make your batman interfaces members
> of bat0 and then add bat0 to your br-lan, like so:
> 
> 
> config 'mesh' 'bat0'
> 	option 'interfaces' 'wlan0-1 eth0'
> 
> config 'interface' 'lan'
> 	option 'type' 'bridge'
> 	option 'proto' 'static'
> 	option 'netmask' '255.255.248.0'
> 	option 'gateway' '10.5.0.1'
> 	option 'dns' '8.8.8.8'
> 	option 'mtu' '1500'
> 	option 'ipaddr' '10.5.0.2'
> 	option 'ifname' 'bat0 wlan0'
> 
> config 'interface' 'wlan0_1'
> 	option 'proto' 'none'
> 	option 'mtu' '1528'
> 	option 'ifname' 'wlan0-1'
> 
> 
> 
> In this example, wlan0 runs an open AP where clients can connect, while
> other mesh nodes connect through eth0 and wlan0-1.
> 
> and this is the corresponding wireless config:
> 
> config 'wifi-device' 'radio0'
> 	option 'type' 'mac80211'
> 	option 'macaddr' '00:15:6d:3e:XX:XX'
> 	option 'hwmode' '11ng'
> 	option 'channel' '1'
> 	option 'country' 'US'
> 	option 'txpower' '27'
> 	option 'htmode' 'HT20'
>     option 'noscan' '1'
> 
> config 'wifi-iface'
> 	option 'network' 'lan'
> 	option 'device' 'radio0'
> 	option 'encryption' 'none'
> 	option 'mode' 'ap'
> 	option 'ssid' 'quintanalibre.org.ar'
> 
> config 'wifi-iface'
> 	option 'device' 'radio0'
> 	option 'encryption' 'none'
> 	option 'mode' 'adhoc'
> 	option 'ssid' 'mesh.quintanalibre.org.ar'
> 	option 'bssid' '02:12:34:56:78:9A'
> 	option 'mcast_rate' '54000'
> 
> 
> side note: experimenting with mcast_rate is an interesting to force bad
> routes out of the picture.
> 
 According to openwrt mcast for broadcom is still in trunk stage, i
tried it with stable release but i am not sure it it actually worked as
it should.


> I believe that the only time when you want a different bridge setup is
> when you need to have batman and non-batman connections on the same
> interface (a router's eth switch), then you'd use the setup described in
> this document:
> http://www.open-mesh.org/wiki/batman-adv/Bridge-loop-avoidance
> 
> 
> 
>> The last problem i now face (assuming that this configuration is valid)
>> is the MTU settings which seem to be ignored no matter where i add them;
>> including creating the following for the other interfaces:
>>
>> config 'interface' 'wifi'
>>         option 'proto' 'none'
>>         option 'ifname' 'wlan0'
>>         option 'mtu' '1528'
> 
> Here we use a similar method to get the MTU properly set (as you can see
> in the previous config snippet).
> This works well for us.
> 
> 
>> I have lost quite a lot of sleep over these problems and it is natural
>> that i might be missing something very simple.
>>
>> batman_adv: bat0: The MTU of interface eth0.0 is too small (1500) to
>> handle the transport of batman-adv packets. Packets going over this
>> interface will be fragmented on layer2 which could impact the
>> performance. Setting the MTU to 1528 would solve the problem.
> 
> have you tried setting the MTU from command line, like so:
> # ifconfig wlan0 mtu 1528
> 
> does this succeed?
> 
>> batman_adv: bat0: The MTU of interface wlan0 is too small (1500) to
>> handle the transport of batman-adv packets. Packets going over this
>> interface will be fragmented on layer2 which could impact the
>> performance. Setting the MTU to 1528 would solve the problem.
> 
> we have found no solution for setting MTU above 1500 for wired
> interfaces. If anyone has instructions about this, I'd also be very
> interested.

Same issue here. Also looking for a possibility.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.17 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iQIcBAEBAgAGBQJPkHfoAAoJEA1GFAMAMJs7+LAP/2jWIOxwApoueW95ggzzpyjl
F/+vI9Dh/jwIXUByTGOVmRxG2wD8fb0iyFZ8aUKlp2xjxhiHruhPWzqcdcnvI9qQ
qRHXcaItnWUvRHb1eayJBrWrL6UHHgaoKR29KwDgurD6OjIZFTp0OMRXmp3w3Sc8
8qlOX6NXGjNd4ovDn+RxtMzKTUbE4iX9gPNaLkAQvvpppgSrIJvrt8Alqgaj6oDj
MqtJRjXV+xw60+Bjndu72dFOg4NBLKXHnyLifH1LQ9yCDs6hnTdTYi9sDXgGF6Ip
uqNHLm6pQq2p+ubzVykYbupu68M3eHLnmHqbIplQn2mBECsax0g/NyVi1BhJmxQm
qKWvD3Oo23uBrXlVKAqME1casQ0IlZuHeI9XFq3sGyfpBewfsYk6JdUZEJ+ySDXA
lfe/YP+jHBJqnF4GBIAxELzMGJ9FK64dHL5zD+3OT0c/XQ/iXPKu0nrwCWfGxaLA
54KRicheBUNCMiBmiSlqKXzKalkf063K31Ck6gVWjegBQpfvbK7WgWqy+kRmd1Fg
zkxesyRdG7GiWBK1CHcRRBG3KrmyrSKy5l+ZiBtkuQr+kS7h2fCCSobiVmwjLFg1
QgpdIQOVBQsT9GaPqrXtzHnCdlzO648kQiFJdqO9oDvV3lFvqlYSfx4I4k66zXYW
itBjNS3c2Y0pwqB85mQf
=dwAw
-----END PGP SIGNATURE-----

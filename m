Return-Path: <contact@wifibot.com>
References: <572DF6E3.3030901@wifibot.com> <112511932.Eq5c9Kmyda@sven-edge>
From: contact <contact@wifibot.com>
Message-ID: <572E1219.7070005@wifibot.com>
Date: Sat, 7 May 2016 18:04:41 +0200
MIME-Version: 1.0
In-Reply-To: <112511932.Eq5c9Kmyda@sven-edge>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [B.A.T.M.A.N.] no able to switch routing algo to V ?
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: Sven Eckelmann <sven@narfation.org>, b.a.t.m.a.n@lists.open-mesh.org

Thank you, it is working and it is more clear for me.

I have switched to V but when I switch on other V nodes, my first node 
reset or freeze, probably a kernel panic. Need to plug a rs232 to be 
able to see what could be the problem.
I will switch back to IV.

for info my network file:

config interface 'lan'
         option ifname 'eth0 bat0'
         option force_link '1'
         option type 'bridge'
         option proto 'static'
         option ipaddr '192.168.204.1'
         option netmask '255.255.255.0'
         option ip6assign '60'

config interface 'mesh'
         option mtu '1532'
         option proto 'batadv'
         option mesh 'bat0'
         option routing_algo 'BATMAN_V'

config interface 'bat'
         option ifname 'bat0'
         option proto 'static'
         option mtu '1532'

and my wireless :

config wifi-device  radio0
         option type     mac80211
         option channel  1
         option hwmode   11g
         option path     'pci0000:00/0000:00:00.0'
         option htmode   HT20
         option txpower 22
         option disabled 0

config wifi-iface
         option device   radio0
         option network  mesh
         option mode     adhoc
         option ssid     mesh
         option encryption none
         option bssid 02:CA:FE:CA:CA:42
         option ifnam adhoc0

Best Regards,

Laurent

On 07/05/2016 16:18, Sven Eckelmann wrote:
> On Saturday 07 May 2016 16:08:35 contact wrote:
>> Hello,
>>
>> I just got openwrt 15.05.1 with batman-adv 2016.1 on 3 picostation HP,
>> this time a selected before the build of openwrt batman V option, I can
>> see it when it ask for available routing algo ,
>>
>> root@OpenWrt:/etc/init.d# cat /sys/kernel/debug/batman_adv/routing_algos
>> Available routing algorithms:
>>    * BATMAN_IV
>>    * BATMAN_V
>>
>> but when I do :
>>
>> echo BATMAN_V > /sys/module/batman_adv/parameters/routing_algo
>>
>> It does nothing, still on BATMAN_IV during session and on reboot ?
> This module parameter only controls what routing algorithm is chosen when a
> new batman-adv interface is created. So if you already have created it then
> changing the parameter doesn't do anything to the already existing batman-adv
> interface. Also rebooting a device will reset it either to the default or to
> the one you've explicitly specified during the loading of the modules.
>
> But you seem to use OpenWrt. It allows to specify the routing_algo in
> /etc/config/network and should be applied right before the batman-adv
> interface is created. You just have to make sure that you don't specify
> conflicting things. An example of a simple configuration is:
>
>      config interface 'batnet'
>              option mtu '1532'
>              option proto 'batadv'
>              option mesh 'bat0'
>              option routing_algo 'BATMAN_V'
>
> The wireless configuration would then normally reference this batnet network:
>
>      config wifi-iface 'wmesh'
>              option device 'radio0'
>              option ifname 'adhoc0'
>              option network 'batnet'
>              option mode 'adhoc'
>              option ssid 'mesh'
>              option 'mcast_rate' '18000'
>              option bssid '02:CA:FE:CA:CA:40'
>
> This information was taken from Batman-adv-openwrt-config wiki page [1]
>
> Kind regards,
> 	Sven
>
> [1] https://www.open-mesh.org/projects/batman-adv/wiki/Batman-adv-openwrt-config


Return-Path: <patrick.bosch@uantwerpen.be>
MIME-Version: 1.0
In-Reply-To: <209e7d19833543a0981c27e181d5bdcb@CAS01.ad.ua.ac.be>
References: <CANQCUfmMwMeqjrm2kz==e7EZDXavqqu2CChw9hytnMjx-zda=w@mail.gmail.com>
 <209e7d19833543a0981c27e181d5bdcb@CAS01.ad.ua.ac.be>
Date: Mon, 13 Jul 2015 18:53:01 +0200
Message-ID: <CANQCUfmhOKfp_J53aVhiMLawqEDyByvVuyN7u8GzhTbhvOy0zA@mail.gmail.com>
From: Patrick Bosch <patrick.bosch@uantwerpen.be>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [B.A.T.M.A.N.] Batman advanced receiving packets on bat0 with
 same source and destination address and performance issues
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: b.a.t.m.a.n@lists.open-mesh.org

Hi Simon

I hope I can make it a bit clearer and not more confusing. ;)
I just saw that my drawing looks different in the mail then what is
intended. It seems that the Linksys router and the gateway are
connected via WiFi, which is not the case. The client and gateway are
connected via WiFi.

The Linksys router serves as a DHCP server. There are cables from the
router to the gateway and to the client. Both are connected to the
main port of the Nanostation. The gateway/client notation means the
batman-adv gateway feature notation.
The gateway has one Vlan in the switch configuration, defined for both
ports. So main port and secondary port are reached by eth0.1. This
interface is bridged with the bat0 interface.
This is what I found on both, the OpenWRT page and batman-adv page as
a standard configuration if I want to add the ethernet ports to the
mesh.
The client has two Vlans, one for each port. Eth0.2 is the main port
and eth0.1 is the secondary port. The secondary port is bridged to the
bat0 interface and the main port is not. This seems to be the problem.
When I tcpdump on the main port (eth0.2), I can see the batman-adv ARP
replies broadcasting, which I would not expect to see as this
interface is not bridged to bat0. What I would expect is nothing from
batman-adv at all. The broadcast is every 10 seconds.
I continuously ping both devices from my laptop that is connected to
the client. For both devices, pings are lost. For the gateway more
than for the client. For the client it is usually 1-3 and for the
gateway from 1 up to 10-15. This does not happen regularly. It ranges
from around 30 to 120 seconds. When I lose pings, the SSH session is
also not responding at all. So, it is not really slow, but it seems
that there is packet loss for a few seconds. I hope this example is a
bit clearer.

I will add the output tomorrow, right now I don't have access to the device.

Kind regards
Patrick

On 13 July 2015 at 17:26, Simon Wunderlich <sw@simonwunderlich.de> wrote:
> Hi Patrick,
>
> after reading your text three times I still don't understand your setup. :)
> Maybe its just me, but unless someone else answers, maybe you can help me:
>
>  * Where is that Linksys router you have in that network drawing?
>  * With Client/Gateway mode, are you referring to batman-adv gateway feature?
>  * Could you perhaps simplify your explanation to one specific case where it
> "slow" where you don't expect it to be? Also, it would be helpful to minimize
> the network setup for this case and describe it one more time (including all
> ports).
>  * Also, another helpful thing would be to post your "batctl if" output to see
> which devices are part of the the batman interface
>
>
> From your explanation, it sounds like you have some kind of bridge loop going
> on in your network. Maybe you can check whether you have lots of broadcast
> packets coming in (e.g. by using tcpdump or batctl td).
>
> Thanks,
>     Simon
>
> On Thursday 09 July 2015 16:12:12 Patrick Bosch wrote:
>> Hello everyone
>>
>> I'm trying to set up a mesh, but I'm running into some issues, where
>> I'm not sure if I'm doing something wrong or if there is a bug hidden
>> somewhere.
>>
>> I'm using the Nanostation M5 XW with OpenWRT Chaos Calmer RC2 and only
>> OpenWRT packages.
>> The trouble occurs on a Nanostation in client mode, not in gateway mode.
>>
>> My setup:
>>
>> Laptop --- Client-mode --- Linksys router --- Gateway-mode
>>
>>                                      ----------WiFi-----------
>>
>> Laptop is connected to secondary port. The main port is connected
>> through a wire, the interface is not bridged to bat0. On the gateway,
>> the main and secondary port are bridged to bat0. The main port is used
>> for the connection to the router.
>>
>> What I'm trying to do is set up a mesh through WiFi and bridged to it
>> is the secondary port of the Nanostation. There will be clients
>> connected to it at some point. The main port is not bridged as this is
>> connected to a network that has to be completely isolated. The main
>> port is used for PoE and as a debugging connection with SSH. If I
>> bridge it, it simply uses the wired connection, which is not intended.
>> But even so, I still see Batman messages on the interface for the main
>> port, although it is not bridged.
>> If I don't connect any data to the main port, only power, it seems to
>> work fine. As soon as I connect it to data, I see two things. First,
>> on the bat0 interface messages with the same source and destination
>> arrive. Second, the SSH connection to the client Nanostation becomes
>> really bad from time to time, but not consistently. My computer is
>> connected to the secondary port of the Nanostation. Both of these
>> occurrences seem to correlate, but both are not consistent.
>>
>> As far as I understand it, batman advanced should not use the wired
>> interface on the client Nanostation. But it sends packets on that
>> interface. I think the problem of the bad performance lies also there,
>> but I am not sure.
>> I hope somebody can help me. Following are my configurations:
>>
>> Network:
>>
>> config interface 'loopback'
>>         option ifname 'lo'
>>         option proto 'static'
>>         option ipaddr '127.0.0.1'
>>         option netmask '255.0.0.0'
>>
>> config switch
>>         option name 'switch0'
>>         option reset '1'
>>         option enable_vlan '1'
>>
>> config switch_vlan
>>         option device 'switch0'
>>         option vlan '1'
>>         option ports '0t 1'
>>
>> config switch_vlan
>>         option device 'switch0'
>>         option vlan '2'
>>         option ports '0t 5'
>>
>> config interface 'mesh'
>>         option mtu '1532'
>>         option proto 'batadv'
>>         option mesh 'bat0'
>>
>> config interface 'bat0'
>>         option ifname 'bat0'
>>         option proto 'none'
>>         option mtu '1532'
>>
>> config interface 'br'
>>         option type 'bridge'
>>         option ifname 'eth0.1 bat0'
>>         option proto 'static'
>>         option ipaddr '10.123.0.2'
>>         option netmask '255.255.255.0'
>>
>> config interface 'wan'
>>         option proto 'dhcp'
>>         option ifname 'eth0.2'
>>         option hostname 'iFEST2'
>>         option defaultroute '0'
>>
>> config interface 'wan6'
>>         option proto 'dhcpv6'
>>         option reqaddress 'try'
>>         option reqprefix 'auto'
>>         option ifname 'eth0.2'
>>
>> Wireless:
>>
>> config wifi-device  radio0
>>         option type 'mac80211'
>>         option hwmode '11a'
>>         option path 'platform/ar934x_wmac'
>>         option htmode 'HT20'
>>         option channel '40'
>>         option txpower '17'
>>         option country 'BE'
>>         option disabled '0'
>>
>> config wifi-iface
>>         option device 'radio0'
>>         option ifname 'adhoc0'
>>         option encryption 'psk2'
>>         option network 'mesh'
>>         option ssid 'mySSID'
>>         option mode 'adhoc'
>>         option bssid '02:CA:FE:CA:CA:40'
>>         option mcast_rate '18000'
>>         option key 'myKey'
>>
>> Batman:
>>
>> config 'mesh' 'bat0'
>>         option 'aggregated_ogms'
>>         option 'ap_isolation'
>>         option 'bonding'
>>         option 'fragmentation'
>>         option 'gw_bandwidth'
>>         option 'gw_mode' 'client'
>>         option 'gw_sel_class'
>>         option 'log_level'
>>         option 'orig_interval'
>>         option 'vis_mode'
>>         option 'bridge_loop_avoidance' '1'
>>         option 'distributed_arp_table'
>>         option 'multicast_mode'
>>         option 'network_coding'
>>         option 'hop_penalty'
>>         option 'isolation_mark'
>>
>> These are two different translocal tables that I get,
>> 04:18:d6:61:81:54 is the MAC of the node in question:
>>
>> Locally retrieved addresses (from bat0) announced via TT (TTVN: 28):
>>        Client         VID Flags    Last seen (CRC       )
>>  * 9e:90:31:79:cd:b8   -1 [.P....]   0.000   (0x02c4aa75)
>>  * 9e:90:31:79:cd:b8    0 [.P....]   0.000   (0x4620303d)
>>  * e8:80:2e:e7:a4:df   -1 [......]   0.730   (0x02c4aa75)
>>
>> Locally retrieved addresses (from bat0) announced via TT (TTVN: 29):
>>        Client         VID Flags    Last seen (CRC       )
>>  * 9e:90:31:79:cd:b8   -1 [.P....]   0.000   (0xd3ed0426)
>>  * 04:18:d6:61:81:54   -1 [......]  30.370   (0xd3ed0426)
>>  * 9e:90:31:79:cd:b8    0 [.P....]   0.000   (0x4620303d)
>>  * e8:80:2e:e7:a4:df   -1 [......]   0.010   (0xd3ed0426)
>>
>> The transglobal one,  04:18:d6:61:81:68 is the MAC of the gateway
>>
>> Globally announced TT entries received via the mesh bat0
>>        Client         VID  (TTVN)       Originator      (Curr TTVN)
>> (CRC       ) Flags
>>  * da:2b:ea:63:42:38    0   ( 32) via 04:18:d6:60:81:68     ( 71)
>> (0x9079f118) [....]
>>  * 04:18:d6:61:81:54   -1   ( 71) via 04:18:d6:60:81:68     ( 71)
>> (0x4bb17292) [....]
>>  * 04:18:d6:61:81:68   -1   ( 32) via 04:18:d6:60:81:68     ( 71)
>> (0x4bb17292) [....]
>>  * da:2b:ea:63:42:38   -1   ( 32) via 04:18:d6:60:81:68     ( 71)
>> (0x4bb17292) [....]
>>
>> Kind regards
>> Patrick



-- 
Patrick Bosch, PhD Student
University of Antwerp - iMinds
Dept. Mathematics and Computer Science
MOSAIC research group
Middelheimlaan 1 - Room M.G.215
2020 Antwerpen - Belgium
Email: patrick.bosch@uantwerpen.be
Phone: +3232653858

Return-Path: <oguzhan@kayhan.name.tr>
MIME-Version: 1.0
References: <CANKYHpeiWj7w2KEnkEfjUHWKfbhEAj7kMVE5hL5xv6O_1ZVFwg@mail.gmail.com>
 <1684592.5WYlJ4OYfx@bentobox> <CANKYHpe_cG=dKv5z4tecjb24U_P2ipWoQPownNCxKySU_FozQw@mail.gmail.com>
 <5962426.I90Fg3i1QP@bentobox> <CANKYHpcZU09emNFy3yf4K0F5s8gzT6giosqfCDNj278f6Z3_mQ@mail.gmail.com>
In-Reply-To: <CANKYHpcZU09emNFy3yf4K0F5s8gzT6giosqfCDNj278f6Z3_mQ@mail.gmail.com>
From: Oguzhan Kayhan <oguzhan@kayhan.name.tr>
Date: Tue, 28 Apr 2020 12:28:25 +0300
Message-ID: <CANKYHpcYxPD1tF4EB2hFT891X=FwqiRbo3xCTofxSgdteqES6g@mail.gmail.com>
Subject: Re: configuration issue
Content-Type: text/plain; charset="UTF-8"
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: Sven Eckelmann <sven@narfation.org>
Cc: b.a.t.m.a.n@lists.open-mesh.org

Hello
Yes, changing to 80211s mode seems to work.

Now my config is as follows on both wifi nodes

wireless:
config wifi-iface 'wmesh'
        option device 'radio0'
        option ifname 'mesh0'
        option mode 'mesh'
        option mesh_id 'test'
        option mesh_fwding '0'
        option mesh_ttl '1'
        option mcast_rate '18000'
        option encryption 'none'

network:

config interface 'eth1'
        option ifname 'eth1'
        option proto 'static'
        option mtu '1500'
        option ipaddr '10.1.200.7'
        option netmask '255.255.255.0'
        option gateway '10.1.200.1'

config interface 'bat0_hardif_wlan'
            option mtu '1532'
            option proto 'batadv'
            option mesh 'bat0'

config interface 'bat0_hardif_eth0'
        option mtu '1532'
        option proto 'batadv'
        option mesh 'bat0'
        option ifname 'mesh0'

config interface 'lan'
            option type 'bridge'
            option ifname 'eth2 eth0 bat0'
            option proto 'static'




Now here comes the second part..
How can I make the encryption over mesh?

with ad-hoc there were wpa-2psk encryption on luci interface..
But with 80211s, there is no encryption available on luci, and also
wireless connection can not be establisehd if i manaully write any psk
etc on wifi settings.

Is there a walkthru for this specially for openwrt?

Regards


On Mon, Apr 27, 2020 at 9:18 PM Oguzhan Kayhan <oguzhan@kayhan.name.tr> wrote:
>
> That helps a lot Sven..
> I notified gateworks about it..
> And also I will try the examples you provided.
>
> Best Regards
>
>
>
> On Mon, Apr 27, 2020 at 8:19 PM Sven Eckelmann <sven@narfation.org> wrote:
>>
>> On Monday, 27 April 2020 18:35:29 CEST Oguzhan Kayhan wrote:
>> [...]
>> > *I 'm running Gateworks Newport as controller board. And updated from their
>> > repository Thats the version they had..Actually I tried updating the feeds
>> > to the latest version but, It threw error on compiling..So , didnt waste
>> > too much time and stick on the 2017.4 version.But if needed, I will try to
>> > update versions also.*
>>
>> Please write them and ask them to adjust their repositories to actually ship
>> OpenWrt 18.06 with the up-to-date feeds. We don't support 2017.4 anymore and
>> will not provide patch backports for 2017.4-0 from openwrt-routing. But we
>> have a lot of stable backport patches in 2018.1-11. And 2018.1-11 build likes
>> a charm when the main OpenWrt repository is actually an 18.06.
>>
>> And to me, it looks like Gateworks 18.0x is not even based on OpenWrt 18.06
>> but on something which was forked 7 months (1287 commits) before the release
>> of 18.06.0 - and we are currently at OpenWrt 18.06.8 on the old stable branch
>> and 19.07.2 on the current stable branch.
>>
>> You don't even have the "newest" (up to 28 month old) security fixes in
>> gateworks 18.0x - and there are quite at some security and stability patches
>> which you should get integrated.
>>
>> > > [...]
>> > > > config wifi-iface
>> > > >         option device 'radio0'
>> > > >         option ifname 'mesh0'
>> > > >         option network 'mesh'
>> > > >         option mode 'adhoc'
>> > > >         option ssid 'mesh'
>> > > >         option bssid '02:CA:FE:CA:CA:40'
>> > > >         option mcast_rate '18000'
>> > > [...]
>> > >
>> > > Please think about switching to meshpoint without forwarding.
>> >
>> >
>> > *I'd be glad if you give more detail what you mean.*
>>
>> The example configuration was given below. What more details do you need? You
>> already noticed yourself that it doesn't support IBSS/adhoc.
>>
>> >
>> > >
>> > >     config wifi-iface 'wmesh'
>> > >         option device 'radio0'
>> > >         option ifname 'mesh0'
>> > >         option network 'bat0_hardif_mesh0'
>> > >         option mode 'mesh'
>> > >         option mesh_id 'mesh'
>> > >         option mesh_fwding '0'
>> > >         option mesh_ttl '1'
>> > >         option 'mcast_rate' '18000'
>> > >
>> > > At least in my experience, the IBSS support in the device firmware is
>> > either
>> > > not there or starting to rot.
>> > >
>> >
>> >
>> >
>> > *That might be the problem.On 802.11ac card, iw phy gives supported
>> > interface modes as;managed, AP, AP/VLAN,monitor, Meshpoint      but 802.11n
>> > gives IBSS,managed, AP, AP/VLAN,monitor, Meshpoint, p2p-client, p2p-go
>> > modes..*
>> > *So.. does it shows 802.11ac doesnt support batman?
>>
>> Hu? batman-adv is not IBSS. It can run on all kind of interface types. But it
>> makes more sense to run it on meshpoint without forwarding (mesh_fwding 0) or
>> IBSS/adhoc.
>>
>> > or is there any other
>> > ways to try besides ad-hoc mode? Both cards are DoodleLabs*
>>
>> Use a meshpoint interface without forwarding. As shown in the example
>> configuration in my first mail.
>>
>>
>> [...]
>> > > A device just cannot be in a bridge and in batadv at the same time. Just
>> > not
>> > > possible because the bridge would steal all the ethernet packets before
>> > > batman-adv would receive them. So it is not even allowed to have two
>> > masters
>> > > (batadv interface and a bridge) for a single interface (wlan0, eth0, ...).
>> > >
>> >
>> > *So, what is the correct way to do that then..*
>> > *Any examples for this scenario?*
>>
>> Don't try to add the ethernet in both bridge and batman-adv as slave. Doesn't
>> work - so I cannot give you an example.
>>
>> If you want to still transport stuff over ethernet which is also used to
>> bridge to some other interface, try macvlan or vlan's on top of the ethernet
>> interface. The macvlan will create a new ethernet interface which just uses a
>> different mac address. A vlan interface on top of the ethernet will just but a
>> vlan header between the ethernet header and the next layer. So I am guessing
>> you want to first try macvlan (requires kmod-macvlan):
>>
>>     config interface 'bat0_hardif_wlan'
>>             option mtu '1532'
>>             option proto 'batadv'
>>             option mesh 'bat0'
>>
>>     config interface 'lan'
>>             option type 'bridge'
>>             option ifname 'eth2 eth0 bat0'
>>             option proto 'static'
>>
>>     config device 'veth0'
>>             option name 'veth0'
>>             option type 'macvlan'
>>             option ifname 'eth0'
>>
>>     config interface 'bat0_hardif_eth0'
>>             option mtu '1532'
>>             option proto 'batadv'
>>             option mesh 'bat0'
>>             option ifname 'veth0'
>>
>> Or if it is no problem to use VLANs (here 123):
>>
>>     config interface 'bat0_hardif_wlan'
>>             option mtu '1532'
>>             option proto 'batadv'
>>             option mesh 'bat0'
>>
>>     config interface 'lan'
>>             option type 'bridge'
>>             option ifname 'eth2 eth0 bat0'
>>             option proto 'static'
>>
>>     config interface 'bat0_hardif_eth0'
>>             option mtu '1532'
>>             option proto 'batadv'
>>             option mesh 'bat0'
>>             option ifname 'eth0.123'
>>
>> Kind regards,
>>         Sven

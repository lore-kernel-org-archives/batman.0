Return-Path: <vinay@orxrail.com>
Message-ID: <4D66BBC9.80101@orxrail.com>
Date: Thu, 24 Feb 2011 15:12:57 -0500
From: Vinay Tharigopula <vinay@orxrail.com>
MIME-Version: 1.0
References: <4D668F3F.4080700@orxrail.com> <20110224194414.GA15337@Sellars>
In-Reply-To: <20110224194414.GA15337@Sellars>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Subject: Re: [B.A.T.M.A.N.] batman-adv mesh slows down wired clients
	(bridge-loop-avoidance)
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

Linus, Thanks for replying....

I am having trouble finding binaries of batman-adv 2011.0 for OpenWRT . 
Are they available or do I have to build them myself  ?

Interfaces:

On my router, totally there are 4 interfaces.

wlan0 - The infrastructure -type network - with Test1 SSID
wlan1-  The adhoc network with BSSID "xx:xx:xx:xx:xx:xx"
eth0 - the 4 lan ports.
eth1 - the wan port.

bat0 has wlan1 added to it.

There is a bridge "br-lan" with bat0 eth0 eth1 and wlan0.

On the "chosen gateway" router. I have observed this.

batctl tg

Globally announced HNAs received via the mesh bat0
  * 7c:c5:37:6a:ca:cd via 06:24:a5:d8:5d:19
  * e2:45:34:51:32:1c via 06:24:a5:d8:5c:16
  * 00:24:a5:d8:5c:16 via 06:24:a5:d8:5c:16
  * 06:b0:29:d9:45:e5 via 06:24:a5:af:f9:fb
  * 7c:c5:37:78:3c:6c via 06:24:a5:d8:5d:19
  * 00:24:a5:af:f9:fb via 06:24:a5:af:f9:fb
  * 00:1e:c1:c7:53:c2 via 06:24:a5:af:f9:fb
  * 00:24:a5:d8:5d:19 via 06:24:a5:d8:5d:19
  * 92:b3:f4:d5:c6:f1 via 06:24:a5:d8:5d:19

Note: This is from a group of 4 routers with 2 plugged in via wire.

batctl tl.

It is announcing around 60 hosts and constantly increasing , pretty much 
all the hosts connected to the switch that it is plugged into. !

-Vinay

On 2/24/2011 2:44 PM, Linus Lüssing wrote:
> Hi Vinay,
>
> On Thu, Feb 24, 2011 at 12:02:55PM -0500, Vinay Tharigopula wrote:
>> Hello..
>>
>> I succesfully configured a batman-adv mesh to add access points to
>> our existing wired lan.  I am using Openwrt 10.04 and batman-adv
>> 2010.1.0. DHCP and everything works as expected. Any wired or
>> wireless client connecting to the network gets an IP from a DHCP
>> server hooked into the switch etc etc.
> The bridge-loop-avoidance feature has been added in 2011.0.0 and
> is not available in 2010.1.0.
>
> If switching to 2011.0.0 helps, don't read any further :).
>
>
> Could you explain a little more which interfaces you've added to
> batman-adv and which interfaces you are bridging with bat0?
> (ifconfig, brctl show, batctl if output from one router would be
> helpful)
>
>> Our Network configuration:
>>
>> 8 batman-adv routers with a wireless mesh  with two or more of the
>> routers having a wired connection directly to the switch. In this
>> case, the 8 routers decide to pick one of the "plugged in" routers
>> as a gateway to avoid bridge loops. This is fine.
>>
>> I have been running into issues with wired clients however.
>>
>> When a wired client plugged into the switch tries to contact a wired
>> client plugged into the same switch, the packets manage to get lost.
>> I believe they are are going through the wireless routers plugged
>> into the same switch.
>>
>> Instead of going like this..
>>
>> PC 1 ---->  switch1 --->  PC 2
>>
>> they seem to be going like this... (my guess).
>>
>> PC 1 --->  switch1 --->  wireless router 1 ----(wireless mesh
>> link)---->  wireless router 2 ---->  switch1 --->   PC 2.
> Could you please verify with "batctl td" (or tcpdump/wireshark) if
> the packets are leaving on the wireless router 1's wifi interface?
>
>> I think this is because the translation tables on the bat node are
>> announcing that even the wired clients are connected to them.
> Could you check with batctl tl and batctl tg if these tables are changing
> rapidly? If you do not have any client roaming, then these tables are
> expected to stay rather static.
>
>> This is causing extreme delays even in wired clients. Any help will
>> be appreciated. Should I enable STP in on the switch ports ?
> It does not sound like having disabled STP is your problem.
>
>> - Vinay
>>
> Cheers, Linus


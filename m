Return-Path: <b.a.t.m.a.n-bounces@lists.open-mesh.org>
Date: Sat, 6 Nov 2021 22:08:50 +0100
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@c0d3.blue>
Subject: Re: Unable to get DHCP after join wlan0 WIFI mesh network
Message-ID: <YYbu4iyiAp5HlUXZ@sellars>
References: 
 <CA+HNRgC0FKMtSiDOZR3E_T_77C0QXv+r9kqncKNO5-ARwj4ZYA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: 
 <CA+HNRgC0FKMtSiDOZR3E_T_77C0QXv+r9kqncKNO5-ARwj4ZYA@mail.gmail.com>
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

Hi,

Glad to see that more and more people are experimenting with WiFi
mesh networks.

On Fri, Nov 05, 2021 at 04:22:11PM -0700, Dweb Fan wrote:
> Dear all,
> 
> Thanks for making such a great project!
> 
> I'm following the guide from
> https://github.com/binnes/WiFiMeshRaspberryPi, and setting up wifi
> mesh network on top of raspberry pi 3B+. Below steps are good now:
>  - batctl ping works (peer can ping each other through both IP and MAC address)
>  - mac os wifi client can discover the ad-host network, and join the network

This guide seems to set up two WiFi interfaces. wlan0 in ad-hoc
mode and wlan1 in AP mode. wlan0 is a secondary interface of bat0
and wlan1+bat0 are bridged:

    ---br0---
   /         \
 bat0      wlan1(ap)
  |
wlan0(adhoc)

On wlan0 is supposed to be only used to interconnect batman-adv
nodes. The batman-adv protocol is primarily spoken there.

Client traffic from your mac os wifi client is probably not able
to speak the batman-adv protocol and is therefore supposed to go
"over" bat0 instead of "under" bat0. So your mac os client should
connect to the wlan1 AP interface.

The traffic is then bridged from wlan1 to bat0 and batman-adv will
then encapsulate the client traffic. And then forward the
*encapsulated* traffic on wlan0 automatically to the correct
neighbor node.

Hope this helps.

Regards, Linus

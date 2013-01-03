Return-Path: <ff@stephan.homeunix.net>
Content-Type: text/plain; charset=iso-8859-1
Mime-Version: 1.0 (Apple Message framework v1085)
From: =?iso-8859-1?Q?Jan_L=FChr?= <ff@stephan.homeunix.net>
In-Reply-To: <201301030957.04081.lindner_marek@yahoo.de>
Date: Thu, 3 Jan 2013 12:03:11 +0100
Content-Transfer-Encoding: quoted-printable
Message-Id: <4687DDE1-A80F-46C5-B6BC-99763C1D856F@stephan.homeunix.net>
References: <B9683C50-CBE6-40F6-B084-187E41B04CE4@stephan.homeunix.net>
 <50E31C20.6010604@altermundi.net>
 <ABCFB139-9D63-48DB-8C1F-8A0D6E10AD02@stephan.homeunix.net>
 <201301030957.04081.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] Unterstanding gateway-mode - why do nodes have a
	"sticky" gateway
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
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

Hello,

Am 03.01.2013 um 02:57 schrieb Marek Lindner:

> On Thursday, January 03, 2013 07:28:02 Jan L=FChr wrote:
>>>> The client should use 6a:4b:93:de:00:84 as a gatway, since it =
provides
>>>> much higher data rates - however, it is stuck at aa:31:0e:4a:0f:1d.
>>>=20
>>> I have observed the same behavior.
>>=20
>> That's quite frustrating. Can I debug, when and why batman-adv =
actually
>> chooses as specific gateway?
>=20
> Yes, you can. Enable the batman-adv debug log at compile and runtime. =
While=20
> retrieving the 'batman' log messages you should see something like:
> Adding route to gateway ..
> Changing route to gateway ..
> Found new gateway ..
> etc
>=20
> Maybe you can post the result here ?
>=20

Ok, Let's give it a try:

=3D=3D=3D Command Log=20
a) Situation on node at beginng - just one gateway, the right one.
Freifunk-b0487acb2d58:~# batctl gwl
      Gateway      (#/255)           Nexthop [outgoingIF]: gw_class ... =
[B.A.T.M.A.N. adv 2012.4.0, MainIF/MAC: wlan0-1/b2:48:7a:cb:2d:59 =
(bat0)]
=3D> 72:8b:06:40:61:2e (248) 72:8b:06:40:61:2e [  mesh-vpn]: 215 - =
96MBit/96MBit

b) Enable gateway mode on the backup gateway
root@fastd3:~# /usr/local/sbin/batctl gw server 1Mbit/1Mbit

Gateway-List is:
Freifunk-b0487acb2d58:~# batctl gwl
      Gateway      (#/255)           Nexthop [outgoingIF]: gw_class ... =
[B.A.T.M.A.N. adv 2012.4.0, MainIF/MAC: wlan0-1/b2:48:7a:cb:2d:59 =
(bat0)]
=3D> 72:8b:06:40:61:2e (255) 72:8b:06:40:61:2e [  mesh-vpn]: 215 - =
96MBit/96MBit
   aa:31:0e:4a:0f:1d (255) aa:31:0e:4a:0f:1d [  mesh-vpn]:  39 - =
1024KBit/1024KBit

c) Disable regular gateway, force node to switch to backup
kif:~# batctl gw_mode client

Gateway-List is:
reifunk-b0487acb2d58:~# batctl gwl
      Gateway      (#/255)           Nexthop [outgoingIF]: gw_class ... =
[B.A.T.M.A.N. adv 2012.4.0, MainIF/MAC: wlan0-1/b2:48:7a:cb:2d:59 =
(bat0)]
=3D> aa:31:0e:4a:0f:1d (255) aa:31:0e:4a:0f:1d [  mesh-vpn]:  39 - =
1024KBit/1024KBit

d) Re-enable regular gateway
root@kif:~# /usr/local/sbin/batctl gw server 100Mbit/100Mbit

Gateway-List is=20
Freifunk-b0487acb2d58:~# batctl gwl
      Gateway      (#/255)           Nexthop [outgoingIF]: gw_class ... =
[B.A.T.M.A.N. adv 2012.4.0, MainIF/MAC: wlan0-1/b2:48:7a:cb:2d:59 =
(bat0)]
   72:8b:06:40:61:2e (254) 72:8b:06:40:61:2e [  mesh-vpn]: 215 - =
96MBit/96MBit
=3D> aa:31:0e:4a:0f:1d (255) aa:31:0e:4a:0f:1d [  mesh-vpn]:  39 - =
1024KBit/1024KBit

e) Wait some time

f) Stop Logging

=3D=3D=3D End of command Log

=3D=3D=3D Node log of that hour
http://jluehr.de/batman-adv.log.gz

zgrep -i gateway batman-adv.log.gz
[   1022240] Gateway class of originator aa:31:0e:4a:0f:1d changed from =
0 to 39
[   1035100] Gateway class of originator 72:8b:06:40:61:2e changed from =
215 to 0
[   1035100] Gateway 72:8b:06:40:61:2e removed from gateway list
[   1035830] Changing route to gateway aa:31:0e:4a:0f:1d (gw_flags: 39, =
tq: 255)
[   1046020] Gateway class of originator 72:8b:06:40:61:2e changed from =
0 to 215




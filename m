Return-Path: <ff@stephan.homeunix.net>
Content-Type: text/plain; charset=iso-8859-1
Mime-Version: 1.0 (Apple Message framework v1085)
From: =?iso-8859-1?Q?Jan_L=FChr?= <ff@stephan.homeunix.net>
In-Reply-To: <201301032300.04942.lindner_marek@yahoo.de>
Date: Thu, 3 Jan 2013 16:52:42 +0100
Content-Transfer-Encoding: quoted-printable
Message-Id: <6D44E9FE-9AC6-4747-8BF6-52E6647C0625@stephan.homeunix.net>
References: <201301032300.04942.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] Packet-Loss-Peaks in a Freifunk-Network
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

Am 03.01.2013 um 16:00 schrieb Marek Lindner:

> On Thursday, January 03, 2013 22:16:32 Jan L=FChr wrote:
>> We noticed a few, unusual things:
>> -> regardless of the link tested (kif or fastd3) and regardless of =
the node
>> (node1, node2) small interruptions (loss-peaks) are appearing. -> =
These
>> peaks appear almost synchronous, a few "noise" comes from different
>> vpn-links and node-wan-uplinks. -> Since all links are wired, =
radio-noise
>> won't have an impact
>> -> The losses appear in batman-adv 2011.2.0 as well as in batman-adv
>> 2012.4.0. Thus I suspect that batman-adv is triggering theses
>> interruptions.
>=20
> If you believe batman-adv is the culprit, please remove batman-adv =
from your=20
> test setup and repeat the exact same test. Otherwise we move into the =
realm of=20
> speculation.

Well, I started echoing on the underlying VPN-connection as well and =
changed the chart-titles for clearance:

In chart 4 and chart 5 RTT / Loss from kif.kbu to node-1 is measured.=20
In chart 4 kif is sending ICMPv6 to the link-local address of =
bat0-interface - in chart 5 the link_local address of the underlying =
vpn-interface is used.

The loss-peaks appear in char 4 (bat0) only.

Thanks for your help,

Keep smiling
yanosz

>=20
> PS: Forgot to click "reply to all", sorry for that.

Well, I set it f2up this list, since you're node subscribed. Sorry for =
not mentioning it.=

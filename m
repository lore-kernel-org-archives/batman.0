Return-Path: <andre_mailinglist@net-forces.com>
Content-Type: text/plain; charset=iso-8859-1
Mime-Version: 1.0 (Apple Message framework v1251.1)
From: Andre Courchesne <andre_mailinglist@net-forces.com>
In-Reply-To: <201201270445.50388.lindner_marek@yahoo.de>
Date: Thu, 26 Jan 2012 16:46:44 -0500
Content-Transfer-Encoding: quoted-printable
Message-Id: <4210BF92-C0BC-4862-9711-6F8214494082@net-forces.com>
References: <9AAB212A-A9C6-41CD-BACA-0BA1542FA8F5@net-forces.com>
	<201201270313.19652.lindner_marek@yahoo.de>
	<53319420-548B-407C-94EA-AD8BA1B3F73C@net-forces.com>
	<201201270445.50388.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] ap_isolation issue
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
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

Ok, did a bit of tcpdump and my test was the following:

	tcpdump running on the linux firewall on the NIC (5.0.0.1) where =
AP#1 is connected.

=46rom the linux server I ping AP#1 (T004) and as expected I see:

16:37:38.013775 arp who-has 5.0.0.1 tell T004
16:37:38.013792 arp reply 5.0.0.1 is-at 00:0e:2e:bd:d7:88 (oui Unknown)
16:37:39.010099 IP 5.0.0.1 > T004: ICMP echo request, id 22020, seq 24, =
length 64
16:37:39.010345 IP T004 > 5.0.0.1: ICMP echo reply, id 22020, seq 24, =
length 64

Pinging AP#2 (T003), I only get:

16:39:05.165998 arp who-has T003 tell 5.0.0.1

But there are no arp replies.=20

If I disable ap_isolation on AP#1, and make sure I do not have T003 in =
the arp table it finally gets it but takes a bit:

[root@andre-test~]# ping T003
PING T003 (5.1.180.144) 56(84) bytes of data.
=46rom 5.0.0.1 icmp_seq=3D2 Destination Host Unreachable
=46rom 5.0.0.1 icmp_seq=3D3 Destination Host Unreachable
=46rom 5.0.0.1 icmp_seq=3D4 Destination Host Unreachable
=46rom 5.0.0.1 icmp_seq=3D6 Destination Host Unreachable
=46rom 5.0.0.1 icmp_seq=3D7 Destination Host Unreachable
=46rom 5.0.0.1 icmp_seq=3D8 Destination Host Unreachable
=46rom 5.0.0.1 icmp_seq=3D10 Destination Host Unreachable
=46rom 5.0.0.1 icmp_seq=3D11 Destination Host Unreachable
=46rom 5.0.0.1 icmp_seq=3D12 Destination Host Unreachable
=46rom 5.0.0.1 icmp_seq=3D15 Destination Host Unreachable
=46rom 5.0.0.1 icmp_seq=3D16 Destination Host Unreachable
=46rom 5.0.0.1 icmp_seq=3D19 Destination Host Unreachable
=46rom 5.0.0.1 icmp_seq=3D20 Destination Host Unreachable
64 bytes from T003 (5.1.180.144): icmp_seq=3D23 ttl=3D64 time=3D4.84 ms
64 bytes from T003 (5.1.180.144): icmp_seq=3D24 ttl=3D64 time=3D2.91 ms
64 bytes from T003 (5.1.180.144): icmp_seq=3D25 ttl=3D64 time=3D2.53 ms
64 bytes from T003 (5.1.180.144): icmp_seq=3D26 ttl=3D64 time=3D1.47 ms
64 bytes from T003 (5.1.180.144): icmp_seq=3D27 ttl=3D64 time=3D1.50 ms
64 bytes from T003 (5.1.180.144): icmp_seq=3D28 ttl=3D64 time=3D1.46 ms
64 bytes from T003 (5.1.180.144): icmp_seq=3D29 ttl=3D64 time=3D1.47 ms

With the tcp dump traces:
16:44:38.378149 arp who-has 5.0.0.1 tell T003
16:44:38.378215 arp reply 5.0.0.1 is-at 00:0e:2e:bd:d7:88 (oui Unknown)




On 2012-01-26, at 3:45 PM, Marek Lindner wrote:

> On Friday, January 27, 2012 04:39:24 Andre Courchesne wrote:
>> Sorry for the reply on the other post, getting tired I guess...
>>=20
>>=20
>> So...
>>=20
>> Ok, disabling loop avoidance has no effect.
>>=20
>> Has ap_isolation been tested in this type of scenario?
>=20
> Antonio is the real expert on the AP isolation but judging your debug =
output=20
> I'd say the AP isolation has nothing to do with your problem. Also, =
the=20
> disable/enable action seems to point into the same direction.
>=20
> The AP isolation only drops packets from wireless clients. You should =
see a=20
> "W" in the flags section of the "batctl tg" dump:
> 02:69:fe:45:a3:cf  (  1) via ae:86:74:01:b4:94     (  2)   [...]
> Try connecting with a wireless device and you will see it. Unless we =
have a=20
> bug the traffic from the linux firewall should not be dropped (I see =
no W).
>=20
> You could get packet dumps to find out where the pings are dropped. =
Maybe that=20
> brings us closer to understanding what is going on.
>=20
> Regards,
> Marek


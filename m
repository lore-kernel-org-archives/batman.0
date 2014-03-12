Return-Path: <martin@hundeboll.net>
Message-ID: <5320965F.1030900@hundeboll.net>
Date: Wed, 12 Mar 2014 10:16:15 -0700
From: =?UTF-8?B?TWFydGluIEh1bmRlYsO4bGw=?= <martin@hundeboll.net>
MIME-Version: 1.0
References: <CANHt3YGgN754sR4V2v0jpgMoTSSg0OVmGMOTRQ3zrF8dS5mA_Q@mail.gmail.com>
 <5313B316.701@wirelesspt.net>
In-Reply-To: <5313B316.701@wirelesspt.net>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="RDDCqEW5jsuCPdgD8oo22LC40hVO8A1K5"
Subject: Re: [B.A.T.M.A.N.] Network coding multi-hop bandwidth loss
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
To: cmsv@wirelesspt.net, The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--RDDCqEW5jsuCPdgD8oo22LC40hVO8A1K5
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi cmvs,

Thanks for testing NC.

On 2014-03-02 14:39, cmsv wrote:
> I just found out /(the hard way) that using network coding (batman-adv
> 2013.4) that i have a massive, unbelievable bandwidth loss if i have
> more than one hop to the destination
>=20
> I tested this in a real scenario with 11 nodes as well as 3 nodes in a
> house with 3 floors and having one per each floor.
>=20
> Here is the example with 3 nodes
>=20
> A <------ B -----> C
>=20
> From node B to iperf reports me 15 mbit
> From node B to node C iperf reports me 9 mbit
>=20
> Then, from node C to node A i get values bellow 1 mbit such as 647kbits=

> or less.
> More than 3 nodes is to forget.
>=20
> uci set batman-adv.bat0.network_coding=3D0 disables nc and solved the
> problem which brought the network bandwidth to a more realistic and
> mathematical acceptable bandwidth level.
>=20
> Is this finding known by others ?

Have you verified that both node A and C have working promiscuous mode?
One way to do this is to transmit udp packets from B to A with iperf and
count the number of received packets on C with tcpdump.

In addition, you should note that NC doesn't bring a gain for
unidirectional flows, so even though TCP sends ACKs in the reverse
direction, the gain is probably eaten up by the delay added by node B,
in order to increase the chance of coding opportunities.

When you have verified the working promisc mode, can you repeat the test
and tell us the results?

And also test with two TCP flows: A -> C and C -> A ?

Thanks!

--=20
Kind Regards
Martin Hundeb=C3=B8ll
Frederiks All=C3=A9 99, 1.th
8000 Aarhus C
Denmark

+45 61 65 54 61
martin@hundeboll.net


--RDDCqEW5jsuCPdgD8oo22LC40hVO8A1K5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBCgAGBQJTIJZiAAoJEI7EM4tTnYEZW84P/2OlMfWpMPQ4SaPTLrNKdV+X
NUWM5BZT+318VAlgE7H7GyABpODK3r4zmBcWAnWCLmHo0ChvaaN7kU4BXU9pLb2I
0Z1RWG29ZsvQJYSQdOJZBBJfE4pdvxeIMmI4jF41BKo+FIp/XRjFkwcaGU6wS8ml
NnDyvz60MLWqBF8jUoMXkqfh8WG/quopsN/6ba2mqxsWf2eC2TbeCSPMvh78RLMf
N+bHqAAiMs9hZODE0jSdTS4lcBWexzDbBcnU8EM4szuGRmJayiqSwhyjrwQnbQBI
MvrH6PAHVAEhv3gr1p0sHaAUcUVdttDP6lSLSHnQcvkpO2BQMXNN7FJ224rLlQC8
UlnXnoMX7aq8ECOUpCjLxqsenqb9d9qMvT8kZiX6k5RXvd30EamNQNc5HeAaT/ZU
exJV0eyKkd6dS/wQRVmBVKgi4tu0d977XFxFCHe8NCuXP3G3Deo/0oAyRQG/0SaU
ap+YbmUuYYtqHUjkJ+36s51DLn33uzbhY70ciz9TuDWZfa4oeKXrf4UYGMAS41e+
aK2blpILOnoYVF3sGwI8AS7e5YgIizuTY+FQDFuWXLC+8lA46FbrJYc23RQj7OMh
s8U2RtPAwOl7yCYgugrsGw0sWui40wdbppuKBWhNaaq4FWUdFmpVqJg2NJa1QH0B
NTFLF9YB/5k92f1v679a
=QzZc
-----END PGP SIGNATURE-----

--RDDCqEW5jsuCPdgD8oo22LC40hVO8A1K5--

Return-Path: <mschiffer@universe-factory.net>
Message-ID: <4FE3E069.1090309@universe-factory.net>
Date: Fri, 22 Jun 2012 05:03:05 +0200
From: Matthias Schiffer <mschiffer@universe-factory.net>
MIME-Version: 1.0
References: <4FE1350E.9040807@versatic.net>
	<201206211028.18281.lindner_marek@yahoo.de>
	<4FE3DA9B.9040401@versatic.net>
In-Reply-To: <4FE3DA9B.9040401@versatic.net>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig28177E9B86F09E0A9CBA730E"
Subject: Re: [B.A.T.M.A.N.] packets not processed by batman on eth0
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

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig28177E9B86F09E0A9CBA730E
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi,
it might be your VLAN configuration - as far as I know, 0 is not a valid
VLAN id.

But I also found that batman-adv doesn't work on VLAN interfaces on my
OpenWRT routers. As a workaround you can create a new bridge that only
contains the VLAN interface and add the bridge to bat0 instead.

Regards,
Matthias


On 06/22/2012 04:38 AM, Genevi=E8ve Bastien wrote:
> Hi,
>=20
> On 12-06-21 04:28 AM, Marek Lindner wrote:
>> Hi,
>>
>>> I talked to marec last week on irc (I'm tahini).  I have a linksys
>>> router that runs batman on the eth0 interface and other routers or
>>> laptops are connected to it.  Problem is, even though the batman pack=
ets
>>> pass from the other machines to the linksys, it seems something weird=

>>> happens on the linksys and the interface is not recognized as a batma=
n
>>> neighbor.
>> the problem is that leon does not receive any packets from its
>> neighbors. Its
>> log only repeatedly states "Sending own packet" but no information abo=
ut
>> incoming packets is printed. If you compare it with the other logs you=

>> will
>> see what I mean.
> But doesn't the 'batctl td eth0' output show it receives the packets
> from the neighbors?  What happens to those packets?
>=20
>> A common mistake leading to this symptom is a bridge misconfiguration.=

>> Is eth0
>> on leon part of a bridge ?
> No, the bat0 interface is on the bridge, but eth0 is a vlan, I think.=20
> Maybe it is a vlan misconfiguration?
> Attached are some outputs and config files from leon.  What other
> commands should I look for to help find the problem?
>=20
> Thanks,
> Genevi=E8ve




--------------enig28177E9B86F09E0A9CBA730E
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk/j4GkACgkQq3qIxbiQM9g5yQCbB5mrGD96vqoh6YPjBQy4Ck5j
01oAoJ0KeQaTKow6lVHbkpHqjKmrPQ3A
=e0ub
-----END PGP SIGNATURE-----

--------------enig28177E9B86F09E0A9CBA730E--

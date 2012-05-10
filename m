Return-Path: <mschiffer@universe-factory.net>
Message-ID: <4FAC290D.3000206@universe-factory.net>
Date: Thu, 10 May 2012 22:46:05 +0200
From: Matthias Schiffer <mschiffer@universe-factory.net>
MIME-Version: 1.0
References: <4FA54C09.6000303@universe-factory.net>
	<4FAA970F.7080901@hundeboll.net>
	<4FAC1B52.7050804@universe-factory.net>
	<201205110419.56441.lindner_marek@yahoo.de>
In-Reply-To: <201205110419.56441.lindner_marek@yahoo.de>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigBAA99DEDA8B4ED1FCD67B537"
Subject: Re: [B.A.T.M.A.N.] [PATCHv2] batman-adv: fix visualization output
 without neighbors on the primary interface
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
--------------enigBAA99DEDA8B4ED1FCD67B537
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

On 05/10/2012 10:19 PM, Marek Lindner wrote:
> On Friday, May 11, 2012 03:47:30 Matthias Schiffer wrote:
>> 2nd, I think without batman-adv specific extensions LLDP isn't very
>> useful, as the LLDP daemon only cares about the bat0/bridge MAC
>> addresses, and not the hardif MAC addresses which are visible in the
>> vis. The softif MAC addresses are shown in the vis as TT records, of
>> course, but as one can't really discern between the adresses of the no=
de
>> itself and those of other clients on the bridge, it's rather useless i=
n
>> my opinion.
>=20
> I understand all reason except for the last one. What are you trying to=
=20
> achieve that you need to auto-discover all batman-adv interfaces ? Are =
you=20
> trying to replace vis ?=20
> As far as I understood Martin was trying to point you to a protocol whi=
ch=20
> broadcasts arbitrary data on layer2 (similar to mDNS on layer3).

I'm trying to merge vis data with other data, so I can create a map
which contains node information as well as link qualify information et
cetera. To archive this, I need a reliable way to relate batman-adv vis
nodes with LLDP nodes.

Matthias


--------------enigBAA99DEDA8B4ED1FCD67B537
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk+sKQ0ACgkQq3qIxbiQM9hqBwCdHrVB0v48pfWvi0CLs6AYSsL9
kJoAnjP4aSRoNR8FjXa/G4O7vk1LxSZ9
=lNqg
-----END PGP SIGNATURE-----

--------------enigBAA99DEDA8B4ED1FCD67B537--

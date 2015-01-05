Return-Path: <moritzwarning@web.de>
Message-ID: <54AADBED.4030509@web.de>
Date: Mon, 05 Jan 2015 19:46:05 +0100
From: Moritz Warning <moritzwarning@web.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="jeCwTot8qulBpChhd4VxSmBvggXoxEmaN"
Subject: [B.A.T.M.A.N.] get a list of IP addresses to all neighbor nodes
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

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--jeCwTot8qulBpChhd4VxSmBvggXoxEmaN
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi,

I try to display a list of IPv6-Addresses of all neighbors on each node s=
o users
can jump/click from a nodes HTTP status page to another (sounds like fun!=
).

The basic approach would be to use an IPv6 ULA address (prefix+ some MAC =
address) for the node
and to somehow get the MAC part from batman.

A list might generate by this:

for mac in $(batctl o -H | grep 'No' -v | cut -b 37-53 | sort | uniq); do=

	addr=3D"$(ula_addr $prefix $mac)"
	echo "	<li><h3><a href=3D\"http://[$addr]\">$mac</a></h3></li>"
done

The problem is now to understand where this MAC comes from. Does it belon=
g to a node or client (we do not want clients displayed)?
Afaik, the MAC is the address of the interface of the neighbor node, whic=
h might be one of several belonging to that node.
A solution might be to give a node an ULA-address for each interface batm=
an-adv uses.

Is there a nicer solution?


--jeCwTot8qulBpChhd4VxSmBvggXoxEmaN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQEcBAEBCAAGBQJUqtvtAAoJECHrh56PP4wp0MUH/RUMTsKyz7uziPCpnbQRMbDX
lI5ScVl2BzdHVG93oH2Bde3O0/QzYlkdZO9tcm2yonfW4462QZK1quNi2Nd10MHx
wJV8kIEGlx4X1o/kHp+MS2NkrHsfXH0W7aa1shEjLMKWhdB23P1GOu5Qf+h47iQ1
6Hb0NsPTiBk/JiV2Cfc6HwnUVrAcSrUDvYFH86dMyRVR0ol9ClwgdbfObsPRAqbX
R5QdRp1VplmYHP2LmJlhKtSVWxW+ea/IX9NeMkzIhXGSWadBC3BQTPu9zZXscAG1
LdTIHgRXWS4tzNGzJ3FTamEkfkhVEp+olnh95TkVaDpeXfEMYdm0beSJdCCvwz0=
=zVkq
-----END PGP SIGNATURE-----

--jeCwTot8qulBpChhd4VxSmBvggXoxEmaN--

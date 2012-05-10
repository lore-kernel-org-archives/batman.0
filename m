Return-Path: <mschiffer@universe-factory.net>
Message-ID: <4FAC1B52.7050804@universe-factory.net>
Date: Thu, 10 May 2012 21:47:30 +0200
From: Matthias Schiffer <mschiffer@universe-factory.net>
MIME-Version: 1.0
References: <4FA54C09.6000303@universe-factory.net>
	<201205071440.21129.lindner_marek@yahoo.de>
	<4FA7AD9B.2030604@universe-factory.net>
	<201205081404.14409.lindner_marek@yahoo.de>
	<4FA916EB.8030609@universe-factory.net>
	<CAHD-aqKEcv0F7ZKL1xsXOj8k1ZvRM1YXvOYKadj44SUBPpff4g@mail.gmail.com>
	<4FAA970F.7080901@hundeboll.net>
In-Reply-To: <4FAA970F.7080901@hundeboll.net>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigD74AD256C38A00D5AC25055A"
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
--------------enigD74AD256C38A00D5AC25055A
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 05/09/2012 06:10 PM, Martin Hundeb=C3=B8ll wrote:
> While reading about TLV's on wikipedia[1], I came across a MAC discover=
y
> protocol[2], LLDP, which eventually lead me to OpenLLDP[3]. If this als=
o
> works on 802.11, I think we have a winner :)

Okay, so I tested 4 open-source LLDP implementations yesterday [1-4]...
while LLDP works fine over batman-adv, I didn't find it very useful.

1st, implementations [1-3] aren't very configurable, and [4], an
implementation by Intel, is hard to configure and *huge* (stripped
binary ~400KB). Most of the implementations don't support announcing
IPv6 addresses (I'm not sure which anymore), although that isn't really
an important feature for me, as I'd use it mostly to announce hostnames
for the MAC addresses, but I consider software that only supports IPv4
as deprecated. Also, most of these projects seem to be dead for years.

2nd, I think without batman-adv specific extensions LLDP isn't very
useful, as the LLDP daemon only cares about the bat0/bridge MAC
addresses, and not the hardif MAC addresses which are visible in the
vis. The softif MAC addresses are shown in the vis as TT records, of
course, but as one can't really discern between the adresses of the node
itself and those of other clients on the bridge, it's rather useless in
my opinion.

Matthias

[1] http://openlldp.sourceforge.net/
[2] https://code.google.com/p/ladvd/
[3] https://github.com/vincentbernat/lldpd/wiki
[4] http://www.open-lldp.org/open-lldp



--------------enigD74AD256C38A00D5AC25055A
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk+sG1IACgkQq3qIxbiQM9gMuQCaAqcEroz2o/Z2ZJntdHxquWpn
ZQUAoKC2gyg8Q9IxI0FfBzOFHWVxZScw
=jWN+
-----END PGP SIGNATURE-----

--------------enigD74AD256C38A00D5AC25055A--

Return-Path: <mschiffer@universe-factory.net>
Message-ID: <4FA7AD9B.2030604@universe-factory.net>
Date: Mon, 07 May 2012 13:10:19 +0200
From: Matthias Schiffer <mschiffer@universe-factory.net>
MIME-Version: 1.0
References: <4FA54C09.6000303@universe-factory.net>
	<20120506201435.GA27416@pandem0nium>
	<4FA75113.40401@universe-factory.net>
	<201205071440.21129.lindner_marek@yahoo.de>
In-Reply-To: <201205071440.21129.lindner_marek@yahoo.de>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig636CAA01F5EEB7ECDE4DB499"
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
--------------enig636CAA01F5EEB7ECDE4DB499
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

On 05/07/2012 08:40 AM, Marek Lindner wrote:
> If you wish to replace the mac addresses with readable name you can sim=
ply use=20
> a bat-hosts file to tell batctl which mac address should be replaced. C=
heck=20
> the bat-hosts section in our batctl online manpage:
> http://downloads.open-mesh.org/batman/manpages/batctl.8.html

I know about bat-hosts, but this only works when the host displaying the
data knows all the MAC address/hostname mappings. For community meshs
like Freifunk networks it would be much nicer to allow each host to
supply its own hostname for vis in my opinion. I think one possibility
to add this without breaking compatiblity would be adding a hostname
record after the neighbor entries in the vis packets.

It would be nice to convert the reserved field in the vis packet
stucture to a flags field for things like this, but AFAICS the current
code never sets this to zero, but this is a byte of uninitialized memory
that is sent over the network - but again, I might be overlooking things
as I'm not yet familar with the code.

Matthias


--------------enig636CAA01F5EEB7ECDE4DB499
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk+nrZsACgkQq3qIxbiQM9hFawCfaKAB+7z+3PTRo+mYAoUnVNqK
x5wAnj2a4X0N8rMJfTBj+zK4jOwOINVc
=81MQ
-----END PGP SIGNATURE-----

--------------enig636CAA01F5EEB7ECDE4DB499--

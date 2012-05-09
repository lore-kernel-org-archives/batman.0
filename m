Return-Path: <mschiffer@universe-factory.net>
Message-ID: <4FAA8634.7070809@universe-factory.net>
Date: Wed, 09 May 2012 16:59:00 +0200
From: Matthias Schiffer <mschiffer@universe-factory.net>
MIME-Version: 1.0
References: <4FA823EB.7070309@universe-factory.net>
	<201205081359.26707.lindner_marek@yahoo.de>
	<4FA92B3A.40000@universe-factory.net>
	<201205091904.27376.lindner_marek@yahoo.de>
In-Reply-To: <201205091904.27376.lindner_marek@yahoo.de>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigB3ECF9F545950C15C1EF401C"
Subject: Re: [B.A.T.M.A.N.] The current state of the batman-adv vis code
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

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigB3ECF9F545950C15C1EF401C
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

On 05/09/2012 01:04 PM, Marek Lindner wrote:
> On Tuesday, May 08, 2012 22:18:34 Matthias Schiffer wrote:
> How the rcu replace / update mechanism works is pretty clear to me. My =

> question geared towards our own code base. At which point would you use=
 this=20
> rcu update ? Every time an element in the hash is modified ?

Yes, my idea is to use this whenever a new packet is inserted into the
vis hash to ensure the vis data a reader sees is always as consistant as
possible. I know it wouldn't be fatal for the vis if a packet is missing
from the data sometimes, but in my opinion a clean update is nicer :)

Matthias


--------------enigB3ECF9F545950C15C1EF401C
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk+qhjQACgkQq3qIxbiQM9gZTQCg0yCOksIFqqf6xtRQGF+kCv5v
g9UAn2v0b2maSmm+k9bE98YmGllCwbuw
=8KOk
-----END PGP SIGNATURE-----

--------------enigB3ECF9F545950C15C1EF401C--

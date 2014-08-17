Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Sun, 17 Aug 2014 21:10:47 +0200
Message-ID: <2012653.G3xfvbBHvG@prime>
In-Reply-To: <1408073366-12008-1-git-send-email-linus.luessing@web.de>
References: <1408073366-12008-1-git-send-email-linus.luessing@web.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2481572.Gqjn98aX8L";
 micalg="pgp-sha1"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCHv8 0/3] Multicast optimizations for bridges
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


--nextPart2481572.Gqjn98aX8L
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"

On Friday 15 August 2014 05:29:23 Linus L=C3=BCssing wrote:
> This patchset enables the usage of the batman-adv multicast optimizat=
ions
> for scenarios involving bridges on top of e.g. bat0, too.
>=20
> Along come two more patches adding according debugging facilities
> to make it possible for the user to check why the multicast
> optimizations might not work ideally to give hints about
> what they might change about their topology.
>=20
> Cheers, Linus
>=20
> Changes in v8 (thanks to Simon's suggestions):
> - PATCH 2/3:
> * print shadowing status log of an appearing and shadowing querier, t=
oo
>   (the bridge-querier-existence call has an additional 10s delay
>    to ensure reports had their time to arrive -
>    the bridge-querier-port call doesn't have that)
> - PATCH 3/3:
> * changing debugfs output from "+" and "-" to "U/4/6" and "."
> * fixing "no querier present" logic (introduced in [PATCHv7 3/3])
>=20

Looks good now! I gave it another round in my emulator setup, and could=
n't find=20
anything to complain about. ;)

Tested/Reviewed-by: Simon Wunderlich <sw@simonwunderlich.de>

for this series.

Thanks!
    Simon
--nextPart2481572.Gqjn98aX8L
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEABECAAYFAlPw/jsACgkQrzg/fFk7axYgXgCgghG911qjrxoHhMsFVza3nE4a
PSwAn0hKnu312zRYQQ8yjjDIqfIpON17
=DSKo
-----END PGP SIGNATURE-----

--nextPart2481572.Gqjn98aX8L--


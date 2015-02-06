Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Fri, 06 Feb 2015 18:49:53 +0100
Message-ID: <2309579.S6OkIGZQ1N@prime>
In-Reply-To: <54D4B9DE.8010605@altermundi.net>
References: <54D4B9DE.8010605@altermundi.net>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1728007.LxLGYsvqUu";
 micalg="pgp-sha1"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] wireshark-batman-adv dissector for v15
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


--nextPart1728007.LxLGYsvqUu
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

On Friday 06 February 2015 09:55:58 Gui Iribarren wrote:
> On 06/02/15 09:38, Sven Eckelmann wrote:
> > I can only talk about the simple two node installation I had when I=

>=20
> was forced
>=20
> > to write the wireshark-batman-adv dissector for v15.
>=20
> last week i lurked the internet for this, without success.
> Is it published in a place so obvious i couldn't imagine?
> Is it published at all?
>=20
> I'm hoping to find a BLA2 crazy loop :grin: but only looking at ARP
> packets it's not evident where the problem is :)
>=20
> thanks for any pointer!

We did upstream it:

https://www.wireshark.org/lists/wireshark-commits/201411/msg00249.html

not sure if this is in any release yet, though. Worst case, compile wir=
eshark=20
from=20trunk, that's always fun. :D

Cheers,
    Simon
--nextPart1728007.LxLGYsvqUu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEABECAAYFAlTU/sUACgkQrzg/fFk7axZg0wCeKRU5tQm9nerSmAli0mOsy0jH
+ZMAn3pWGHzLE/s7XZ7zk69iO2zb0AAp
=81Yy
-----END PGP SIGNATURE-----

--nextPart1728007.LxLGYsvqUu--


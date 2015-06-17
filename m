Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Wed, 17 Jun 2015 18:35:12 +0800
Message-ID: <1821570.YM9HADYYvt@voltaire>
In-Reply-To: <1434467426-4281-2-git-send-email-linus.luessing@c0d3.blue>
References: <1434467426-4281-1-git-send-email-linus.luessing@c0d3.blue>
 <1434467426-4281-2-git-send-email-linus.luessing@c0d3.blue>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart4719964.jmdzdFsGrT";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCHv4 maint 1/5] batman-adv: Make DAT
	capability changes atomic
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


--nextPart4719964.jmdzdFsGrT
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

On Tuesday, June 16, 2015 17:10:22 Linus L=FCssing wrote:
> Bitwise OR/AND assignments in C aren't guaranteed to be atomic. One
> OGM handler might undo the set/clear of a specific bit from another
> handler run in between.
>=20
> Fix this by using the atomic set_bit()/clear_bit() functions.
>=20
> Fixes: 2b1c07b918d2 ("batman-adv: tvlv - add distributed arp table
> container") Signed-off-by: Linus L=FCssing <linus.luessing@c0d3.blue>=

> ---
>  distributed-arp-table.c |    4 ++--
>  types.h                 |    2 +-
>  2 files changed, 3 insertions(+), 3 deletions(-)

Applied in revision bfd0fba.

Thanks,
Marek

--nextPart4719964.jmdzdFsGrT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJVgU1nAAoJEFNVTo/uthzA3wIH/2P1SpX+aO/QS8BIuAtEAsRK
c3UkxEI1k7fFOb/Ef23QxK6E4CwA+yNIePRErAPt11AEr1leIkicMxvfEypvKZEg
fvlZOVGE5UjSUJItuaVrAGimKnOTFPbKKp56mpOWG77jXJm/XL+dxUSvX6uAmbOa
iwotWIKa8LcCwRrn1Z0XvXy5SKuBBBseXFz/pw7kQS0YSvuqdiUNJfxt/yMyuOoO
fG7XaLRWPWyMf2sspEVJWpdlveravlDUzIwze/XBLqrGp2/JJ82HrY48P01LzFwJ
61dsAH/R/BFjspahrwvKlYbQtiGUiTba8dc6gGsCTO2VDxludjmpamk9crj/+Wk=
=/gjF
-----END PGP SIGNATURE-----

--nextPart4719964.jmdzdFsGrT--


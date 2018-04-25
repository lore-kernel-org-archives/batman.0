Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Wed, 25 Apr 2018 19:20:00 +0200
Message-ID: <5068071.JRrNrTIyUx@sven-edge>
In-Reply-To: <20180324233204.27430-1-linus.luessing@c0d3.blue>
References: <20180324233204.27430-1-linus.luessing@c0d3.blue>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2453948.sSdU8nQbV2";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: Avoid old nodes disabling
 multicast optimizations completely
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

--nextPart2453948.sSdU8nQbV2
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

On Sonntag, 25. M=E4rz 2018 00:32:04 CEST Linus L=FCssing wrote:
> Instead of disabling multicast optimizations mesh-wide once a node with
> no multicast optimizations capabilities joins the mesh, do the
> following:
>=20
> Just insert such nodes into the WANT_ALL_IPV4/IPV6 lists. This is
> sufficient to avoid multicast packet loss to such unsupportive nodes.
>=20
> Signed-off-by: Linus L=FCssing <linus.luessing@c0d3.blue>
> ---
>  net/batman-adv/multicast.c      | 29 ++++++-----------------------
>  net/batman-adv/soft-interface.c |  1 -
>  net/batman-adv/types.h          |  3 ---
>  3 files changed, 6 insertions(+), 27 deletions(-)

Patch added as 82707caa4d43 [1].

Thanks,
	Sven

[1] https://git.open-mesh.org/batman-adv.git/commit/82707caa4d4300fc95db2cf=
37f003ca27c20600a

--nextPart2453948.sSdU8nQbV2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAlrguMAACgkQXYcKB8Em
e0Z41g//eSC4X9pZ34Uhi1ijZUArx+1dVRUDRwY6/F+35cQqo5KEGTT0jTWjYJb9
8ZvQOIHywPg6jj0SiovL4Xkl68E/G61MTMttyCS7d/VSWuKS1GKQpi61Wd5UNimZ
4gohHcYWb9fcKB4FlwY0yvz94Yn19Bq4Pz5PgkojfGPOxEvth2Mkx0JT0bbY6bO4
yBBeKaZ4CwZ59SHKNoNedOwiRqrZNpCpw+nyPB2+6hAuwlC59NpBETIbW6JXqwoM
eC2fpxXehuVD5AMqepGGDwbN+IXjJJr4GbvpXLQ+NokgHiAYpc5gAyLszKKBhFWr
JHyZ8kirDgmXf1oF5HSavm4m2JXs0NNIUMTfAwO0vVUeQPMoZc15i3jKBmEO53z8
Dd97TnYv/jiw6AbY0bb7OiaSA2JpjZtEogaH8eW6pBQ5b5KlF6F75vE4O+c61aRM
4O5jKvMkCQQsjaxTNVaYcYCQho6W51P5PwN9wOWKLf99dEmSiQ+5vRBcOhMDAM84
Z3HOatgwKssNIEBvLOr7aRE2UVdJzBT92FVkMTuR8h/65ZmW8ZXMrc3TnsOt0q+2
y3mN3c8+OAQMC9+e8gTeo2VfmDmpRWsbkWRree6cfEoO+REa6z3B1e0mOa3ePfsc
2L5qR6gZIrRGhrRzN3hV8a3O6QZY4sShsCGw6OClB+LMEiPD4ns=
=DSqu
-----END PGP SIGNATURE-----

--nextPart2453948.sSdU8nQbV2--




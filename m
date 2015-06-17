Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Wed, 17 Jun 2015 18:39:54 +0800
Message-ID: <2232099.V71YVDPq5t@voltaire>
In-Reply-To: <1434467426-4281-5-git-send-email-linus.luessing@c0d3.blue>
References: <1434467426-4281-1-git-send-email-linus.luessing@c0d3.blue>
 <1434467426-4281-5-git-send-email-linus.luessing@c0d3.blue>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1830859.5qVznfgdxg";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCHv4 maint 4/5] batman-adv: Make MCAST
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


--nextPart1830859.5qVznfgdxg
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

On Tuesday, June 16, 2015 17:10:25 Linus L=FCssing wrote:
> Bitwise OR/AND assignments in C aren't guaranteed to be atomic. One
> OGM handler might undo the set/clear of a specific bit from another
> handler run in between.
>=20
> Fix this by using the atomic set_bit()/clear_bit() functions.
>=20
> Fixes: 77ec494490d6 ("batman-adv: Announce new capability via multica=
st
> TVLV") Signed-off-by: Linus L=FCssing <linus.luessing@c0d3.blue>
> ---
>  multicast.c |    6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

Applied in revision 201a54b.

Thanks,
Marek

--nextPart1830859.5qVznfgdxg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJVgU56AAoJEFNVTo/uthzAzcQIALHFiu4C0c1DKeaQgVgkfd7n
jyIgeQo47LSozmRA0LyikB6EUBkwQKbykRDXRF9TpFZDaQXUfyLnODsVie60Qx2d
yNWfQIpwRRZRQNzPczXzQ6xsJ20VYfbaICJWCZbSby+C5KNqAO0prUCOQ0NLiX0w
5wRWQrwOQK5VmTvs3uJ0qcFHM6wVyqSUGL7p6/KdNTFzLtlFRE2fRGbBc+CZD6ak
vMNZOrDfMqozsyxLFEF7povpMTOKN46TC/g+5sDlcZzavoWAKzk7OLUHOHjw3MIU
ojk90CEp37Wy3H2sQZdy27vS4nQjXot6ARXCNWj4tQkUIqKKfXBAcLHIMl2lNDU=
=eZ+0
-----END PGP SIGNATURE-----

--nextPart1830859.5qVznfgdxg--


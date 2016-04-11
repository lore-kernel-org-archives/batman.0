Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Mon, 11 Apr 2016 18:51:15 +0800
Message-ID: <2700794.SvUcfDmYga@voltaire>
In-Reply-To: <1457701489-24562-1-git-send-email-sven@narfation.org>
References: <1457701489-24562-1-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1763007.jclRWMaP5R";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH v2] batman-adv: Fix broadcast/ogm queue
	limit on a removed interface
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

--nextPart1763007.jclRWMaP5R
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

On Friday, March 11, 2016 14:04:49 Sven Eckelmann wrote:
> From: Linus L=FCssing <linus.luessing@c0d3.blue>
>=20
> When removing a single interface while a broadcast or ogm packet is
> still pending then we will free the forward packet without releasing =
the
> queue slots again.
>=20
> This patch is supposed to fix this issue.
>=20
> Fixes: d5bbce8465af ("batman-adv: Add missing hardif_free_ref in
> forw_packet_free") Signed-off-by: Linus L=FCssing <linus.luessing@c0d=
3.blue>
> [sven@narfation.org: fix conflicts with current version]
> Signed-off-by: Sven Eckelmann <sven@narfation.org>
> ---
> v2:
>  - rebased patch
>=20
> Patch was resurrected from https://patchwork.open-mesh.org/patch/2921=
/
>=20
> I've requested an rebased version at
> https://lists.open-mesh.org/pipermail/b.a.t.m.a.n/2016-March/014635.h=
tml
> but done it myself because it was rather trivial.
> ---
>  net/batman-adv/send.c | 6 ++++++
>  1 file changed, 6 insertions(+)

Applied in revision 289e386.

Thanks,
Marek

--nextPart1763007.jclRWMaP5R
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJXC4GjAAoJEFNVTo/uthzAasEH/2vIscKNScnKnhRgp1WI745k
9pqWo5HNJGk+zpKhQRFsIuipZ923XWfwVEmbEdkBkcSb1MTt398frN4tZjRMSgRU
0QLTf27wXlIZZqS5FYc1EGwCtRgeZgkW3bCNE/GTd6LcY+oQj4pe3zbxGqR+P7fW
LmccvXwqwGt6mi9v7bBkAXXRQB++IwRYhbMnzHQwuxaLOxjSuv5Wg123IEDLYejA
N6xqwUPrgemK26e1RJnIy1LyD8kaW92aWMUIMIFTJy4R8yxP4PMHHpTscdyyE4wr
J4I1IhclC4wV54xqKFj0We1C9TN74/VdFKzw08N6hU9UE151a7WQEVWWC/U62yQ=
=b4Fa
-----END PGP SIGNATURE-----

--nextPart1763007.jclRWMaP5R--


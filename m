Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Sun, 16 Feb 2014 17:34 +0800
Message-ID: <3098395.PWAj2BAcvB@diderot>
In-Reply-To: <1392542878-17033-1-git-send-email-linus.luessing@web.de>
References: <1392542878-17033-1-git-send-email-linus.luessing@web.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart4676818.iZn1FtBLTp";
 micalg="pgp-sha1"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCHv2] batman-adv: return NULL instead of 0
	in batadv_mcast_forw_ip_node_get()
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


--nextPart4676818.iZn1FtBLTp
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

On Sunday 16 February 2014 10:27:58 Linus L=FCssing wrote:
> batadv_mcast_forw_ip_node_get() returns a pointer, so returning NULL =
in
> error cases is always more appropriate than 0.
>=20
> Introduced by: c8fedbea81eac41a4971bb43353fd52a903d7c4c
> ("batman-adv: Send multicast packets to nodes with a WANT_ALL flag")
>=20
> Reported-by: Antonio Quartulli <antonio@meshcoding.com>
> Signed-off-by: Linus L=FCssing <linus.luessing@web.de>
> ---
> * added Reported-by
>=20
>  multicast.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied in revision 0dd5d2c.

Thanks,
Marek

--nextPart4676818.iZn1FtBLTp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQEcBAABAgAGBQJTAIYMAAoJEFNVTo/uthzAja0H/j6ds4W6x7uYyMTsj6AYahJo
FjwkRs0UAaFDrXmss6LwySCVTv33OWwIVGA4mFK3v3odF0X133p/LGUcZqjoYNvs
VjOKzCHppSBGYUgIKzr5jlUIorbMniJpVdOeq6cFdpAHlqfWPxsmOxyb1164TwZN
xKlHDgZDSunum5a/45bZ/OxklZO0ERV2gviMhLErIPOvpwB8xMzOVEfJLM3fEhB2
F7aikBPkaiHM6JYZtyIdVe0iXAMnMCvZiSsKk36ZsoqWVkR1DAXE87/R5aYnZNtb
rihYxcmT6VP4PWElM72nWvd/SDNYffafW0tvbErF2X1AKBfvnGeK77BNzrclQhA=
=ugIx
-----END PGP SIGNATURE-----

--nextPart4676818.iZn1FtBLTp--


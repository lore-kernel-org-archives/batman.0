Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Sun, 09 Aug 2015 08:25:30 +0800
Message-ID: <1588104.6rWfEYkKHi@voltaire>
In-Reply-To: <1438994221-3746-1-git-send-email-sven@narfation.org>
References: <1438994221-3746-1-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart13329772.eRrSXPyT4f";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: Mark batadv_iv_neigh_print
	as static
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


--nextPart13329772.eRrSXPyT4f
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Saturday, August 08, 2015 02:37:01 Sven Eckelmann wrote:
> batadv_iv_neigh_print is not used outside of bat_iv_ogm.c and should thus
> be marked as static.
> 
> Fixes: 2e1133841c44 ("batman-adv: export single hop neighbor list via
> debugfs") Signed-off-by: Sven Eckelmann <sven@narfation.org>
> ---
>  net/batman-adv/bat_iv_ogm.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Applied in revision a0f15fc.

Thanks,
Marek

--nextPart13329772.eRrSXPyT4f
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJVxp4BAAoJEFNVTo/uthzAH4AIAKyst3fRucBlMJOZq/7hEA1E
wl9MWprNb8Cr8SSVmAyyEiylTzsGYoMWJw48A1qFugm2AqGS//2uOxklWrzS9yNv
iQRFe8RF2kc8q9R7gdakKUfXcpczTN5lCXymvdiBLAbonBUPLtceaxJbb987koNy
WhniPMAK+osNiRUibMfmOeSSXCGECs3FVLN561g6kbPaYdwTbUBpCxb5aEVBp9wq
KfYq43cDcgYJiG0nRbMjrpjpcCZRrOLKNS8RJUnhaySC8pO/+pkdDzi2Bgt7su5C
jED/nbah5gnx0wLJ2YgMrYO0ta65IZaUC+3+K7gOhbDl3E/V4ei9dUNy50Qo+XY=
=G2cW
-----END PGP SIGNATURE-----

--nextPart13329772.eRrSXPyT4f--


Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Wed, 30 Dec 2015 19:44:51 +0800
Message-ID: <1548580.0Tu9DQdEtN@voltaire>
In-Reply-To: <1450101647-9762-1-git-send-email-sven@narfation.org>
References: <1450101647-9762-1-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1685011.8GJbOPF21v";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH] batctl: Remove bogus length check in
	debugfs_make_path
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

--nextPart1685011.8GJbOPF21v
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Monday, December 14, 2015 15:00:47 Sven Eckelmann wrote:
> The length check never used the mesh_iface length in the size calculation.
> Instead it used the length of the mountpoint and the format string. But the
> length of the format string is not the length of the final string.
> 
> Instead remove this check and depend completely on the return value of
> snprintf.
> 
> Signed-off-by: Sven Eckelmann <sven@narfation.org>
> ---
>  debugfs.c | 9 +--------
>  1 file changed, 1 insertion(+), 8 deletions(-)

Applied in revision 72b9683.

Thanks,
Marek

--nextPart1685011.8GJbOPF21v
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJWg8OzAAoJEFNVTo/uthzAm7gH/3hvN3Vb68jxCfbtY4+mRew+
zmTe/s4S1D6QLMjozls6ok17tl+sA2xJgXDkASFgY9v+JfMHunSbMGHSwy4QFCHZ
su+XrHRdW65tkTEU4h9Z+9ia8AmJba11hTnfQI4tHpI7t1VF0bJVDTCjgxXhr6ap
MsbPDTGUKUZ49p20vkF+xdxmyvvyt/7XVuYCLktKqK1txau53DXQIIwNKw4hFqbY
zCMR13WFW5OibZ8PNhGF8HFuouJ+93lwRcTPLqhzJGNNhu8b14WGgqog3WmFRfwC
SzakcIjweIVyanjauW1xTiz/Dp2QuEsEkENICrcVvuWhO42k5slchBUpCLypdeA=
=1Kg4
-----END PGP SIGNATURE-----

--nextPart1685011.8GJbOPF21v--


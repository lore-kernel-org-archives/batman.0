Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Wed, 16 Dec 2015 19:04:12 +0100
Message-ID: <11158131.CtIamLPuTV@prime>
In-Reply-To: <1450101627-9692-2-git-send-email-sven@narfation.org>
References: <1450101627-9692-1-git-send-email-sven@narfation.org>
 <1450101627-9692-2-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart24583232.uGelU87XNH";
 micalg="pgp-sha1"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH 2/2] alfred: Remove bogus length check in
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

--nextPart24583232.uGelU87XNH
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="ISO-8859-1"

On Monday 14 December 2015 15:00:27 Sven Eckelmann wrote:
> The length check never used the mesh_iface length in the size calculation.
> Instead it used the length of the mountpoint and the format string. But the
> length of the format string is not the length of the final string.
> 
> Instead remove this check and depend completely on the return value of
> snprintf.
> 
> Signed-off-by: Sven Eckelmann <sven@narfation.org>

Applied in revision bcd33e6.

Thanks!
    Simon
--nextPart24583232.uGelU87XNH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEABECAAYFAlZxp5wACgkQrzg/fFk7axZeJACg85VwV9exk5F/eQzdNqeUSD8k
ksEAnRvrqIcIqO8HMKHY8mC62+PJ4/63
=KBL+
-----END PGP SIGNATURE-----

--nextPart24583232.uGelU87XNH--


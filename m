Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Tue, 20 Sep 2016 17:51:48 +0200
Message-ID: <2507482.OD8dl7uhAe@bentobox>
In-Reply-To: <20160920135917.24290-1-linus.luessing@c0d3.blue>
References: <20160920135917.24290-1-linus.luessing@c0d3.blue>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart3019384.VzKkxAaE1i";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: Allow selecting BATMAN V if
	CFG80211 is not built
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

--nextPart3019384.VzKkxAaE1i
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

On Dienstag, 20. September 2016 15:59:17 CEST Linus L=FCssing wrote:
> With the new stub for cfg80211_get_station(), we can now build the
> BATMAN V protocol even with a kernel that was built without any
> wireless support.
>=20
> Signed-off-by: Linus L=FCssing <linus.luessing@c0d3.blue>
> ---

Haven't tested it yet but it looks good.

Reviewed-by: Sven Eckelmann <sven@narfation.org>

Kind regards,
	Sven

--nextPart3019384.VzKkxAaE1i
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCgAGBQJX4VsUAAoJEF2HCgfBJntG4lMP/RqQdt5pSkRCYwRbF8TILeS4
7n8UfllsqP2yqbfjPjKCzqjgdOJyiSe+3/dWZR34KBgmLWZZcokf51T7qOkN8y2x
Jy2iNH/vkiih/MPHQ2OySkHFK0p5sQuGDdO32bHyUxdOPfjtjymfgdJVMtfEuuHe
GofT/6rftleoXfpQ8hUo1/Z4CAwruZsBsfmaUPRNmGcD4Sy57hU52VfQiCxN3GjX
4bJomzjwY/KB9ONJ69B3yVtr+hZFG1tHmyg0JVAkde03wXVRWH30pODA8USONVDi
uqldHPJYxP1kNIu4YSmYa8XY+DVdiu7R23iENfg/5esClT0rNTtmFMIefdqF2g/R
ueyry7i2h+OdxEYSJDb7E+H7m4+GS8X+lZYclTlc3DFhMZSiGEJhNnHvquz4BOhm
gtSuJj3py1QPv+Ih1LkkCytYEpvF/SRgkgSMPFE1jDtVxdEfy9alhfatiKfBRVVx
dVLPRWLxg/5Zm8O/2tlRrpV7OAakBN/ceWmCHRqLdZy/XcZrSK4BtnOPY8q3IE/y
1IBa4kJ1FAVXOiNelBLXbpoHVP0XWAcvUPfl6kCBz3C6FOaXazajzTmkfsKHI0EK
QZORe6dIvzUwTns1fh75vJFLsxY28ANKeYJGOVIAfXN5pSqbbgIWtP5u3K3lx1q+
qrS2xVsXP+LUpJmE281j
=D0LE
-----END PGP SIGNATURE-----

--nextPart3019384.VzKkxAaE1i--


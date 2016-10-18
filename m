Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Tue, 18 Oct 2016 14:44:28 +0200
Message-ID: <52744880.oyL8YSgqok@bentobox>
In-Reply-To: <56E2BCD8.9010200@users.sourceforge.net>
References: <56E2BCD8.9010200@users.sourceforge.net>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart5042468.KILKRLk9tn";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] batman-adv: Less function calls in
	batadv_is_ap_isolated() after error detection
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: SF Markus Elfring <elfring@users.sourceforge.net>
Cc: Julia Lawall <julia.lawall@lip6.fr>, b.a.t.m.a.n@lists.open-mesh.org, kernel-janitors@vger.kernel.org

--nextPart5042468.KILKRLk9tn
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

On Freitag, 11. M=E4rz 2016 13:40:56 CEST SF Markus Elfring wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Fri, 11 Mar 2016 13:10:20 +0100
>=20
> The variables "tt_local_entry" and "tt_global_entry" were eventually
> checked again despite of a corresponding null pointer test before.
>=20
> * Avoid this double check by reordering a function call sequence
>   and the better selection of jump targets.
>=20
> * Omit the initialisation for these variables at the beginning then.
>=20
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> Reviewed-by: Sven Eckelmann <sven@narfation.org>
> ---
>  net/batman-adv/translation-table.c | 25 +++++++++++--------------
>  1 file changed, 11 insertions(+), 14 deletions(-)

Applied in 58d8ef2dd0c9f7274f0473a1b1d1ffdacdd914f6 [1].

Kind regards,
	Sven

[1] https://git.open-mesh.org/batman-adv.git/commit/58d8ef2dd0c9f7274f0473a=
1b1d1ffdacdd914f6

--nextPart5042468.KILKRLk9tn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIcBAABCgAGBQJYBhksAAoJEF2HCgfBJntGoV4P/REFBrOoH/fp5ExmVsnTx3k1
UAUzQdd5/Fi+shvsQoO7BSNeGyFPM8VEDcbwC7Cngf2YPXAw5FLWlhPIwkO9ml64
40QX834rsgNnK98ZYJnG49tGULYy2aCLt6gX0tNI59V3/UQRnzXFWnzoKL3+8ij8
KumKP3gtCSLs++MM+qTMCAwD7h0w91hIUtugYo1o/fWK0R3NvV+WUHwLRGOj5dIW
UP2aQJ1jHrjorVuDL/o0sw6HIqWHeE4RLJh+fwS8gaLWKNCdmwjPJPidsxR+7s89
fVekDnOmT767ATknot9CsnN3jHdJv5ucpotvF+JCmrab6q+0oefsseL2NP6X0fu7
FTg86XXOlZ8pF7lPK1Ble/DdHrFJkGqlELNkAq351CeqpMJkHvFsFPs4kLPRvauy
HE70MeHhsLGQQ05rBtJH++cIncqTsd70nNq28DhhIgt95/fjRCHMfAtVN4QOT70U
VrgSUpDq/v0EkLAYqeAKFuokSsSv4lFRuIfqgZ/8776R7b21KUtnhIWLoY3DBnow
bhFFoP1oxwfw0lh49Z3IvfeHP/rb8JOzL4n3tqN2eXtv/GD4iK8mOXKlkOqS0wWd
4+4gRnUH+Z0Zydgb177AaCB821CO03MOBMskLUL1p6i/mvwfBDgLUpXQZ7pQrac7
Bz3tGWS/K1q7Htw8An9i
=8w0G
-----END PGP SIGNATURE-----

--nextPart5042468.KILKRLk9tn--


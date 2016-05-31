Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Tue, 31 May 2016 19:57:37 +0200
Message-ID: <1971303.VRszsITxlU@bentobox>
In-Reply-To: <56E2BCD8.9010200@users.sourceforge.net>
References: <5307CAA2.8060406@users.sourceforge.net>
 <1655341.WCvHHx7pqD@bentobox> <56E2BCD8.9010200@users.sourceforge.net>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2819361.pbR7TpU6y1";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: Less function calls in
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
To: b.a.t.m.a.n@lists.open-mesh.org

--nextPart2819361.pbR7TpU6y1
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Friday 11 March 2016 13:40:56 SF Markus Elfring wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Fri, 11 Mar 2016 13:10:20 +0100
> 
> The variables "tt_local_entry" and "tt_global_entry" were eventually
> checked again despite of a corresponding null pointer test before.
> 
> * Avoid this double check by reordering a function call sequence
>   and the better selection of jump targets.
> 
> * Omit the initialisation for these variables at the beginning then.
> 
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> ---

Reviewed-by: Sven Eckelmann <sven@narfation.org>

See 

 * https://www.kernel.org/doc/Documentation/SubmittingPatches
   Chapter 7: Centralized exiting of functions
 * https://plus.google.com/106378716002406849458/posts/dnanfhQ4mHQ
 * http://article.gmane.org/gmane.linux.documentation/28552


Kind regards,
	Sven
--nextPart2819361.pbR7TpU6y1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCgAGBQJXTdCRAAoJEF2HCgfBJntGO70P/iU7IgHqovdxmKQzXcXC0jRr
cWc+CScCHwK4d63BfuYsA3zBjMFr8qv9o7X0o2frsY9qPTGt0z64nB+rtqUc5vwM
SQ4BcgS9TtzaHmfwzQlnSTAXnrE+7zxRiiM/bUH15g94m4457Huy/4zpn7YfAntI
1mRshwQoLxfnu6Sm79N167A/oD/Qwn0X/ud8AFfiWfM7aNs6pvoM6+niliYoIfrG
mymftMyCPR75mfWYkqYa2MlZZj1UDuLdz6cjUJ09DtmQ3bKNRC/qDN/rOWS1yWge
sxP2qmFChDsWIYOv0/dXTUiw1fmcw/LNRtCsJcGpypbu57gBqXlEMR4PE0wv7ECP
jmJp2pU6tYc/NzqYKVObOVdM2DLLovyIEvtMWYqOZPTI3ZA2fZaItPhOddFRpNtl
XtlwMBFOl5p4uZFPySCCzaRMXrK2LC5Kx9TBHEs1j+bWp3Et1VPsoeNEq160EPJl
/xdXWXYn08RarLFuJk9VZxpKoHfD+KYYE1/XRSW5IXW2BbZLxJlEnOsVU8mIykBZ
O7HK8e/bPz9OdI2B53epEfFC5dWKID7LJUDiCiQeibLAcxJ93HxQaxedmMatYkqG
xylgvmgrvWehebTc4lj6/VEbG8ouKVWsjIGc4zq8iM7UMVScE0ZAWmaOlUqSYg/y
fhVwFiqIjjghtPCVZ3Yq
=ycIv
-----END PGP SIGNATURE-----

--nextPart2819361.pbR7TpU6y1--


Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Thu, 05 Nov 2015 20:25:51 +0100
Message-ID: <7310581.ItoMCAyTIj@sven-edge>
In-Reply-To: <1446750782-30179-1-git-send-email-sw@simonwunderlich.de>
References: <1446750782-30179-1-git-send-email-sw@simonwunderlich.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2250263.uqqogQNrlh";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: Update/repair bridge loop
	avoidance kerneldoc
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: Simon Wunderlich <sw@simonwunderlich.de>
Cc: b.a.t.m.a.n@lists.open-mesh.org

--nextPart2250263.uqqogQNrlh
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Hi,

thanks for the massive update of the kernel function documentation of the 
bridge loop avoidance code.

On Thursday 05 November 2015 20:13:02 Simon Wunderlich wrote:
> Thanks to Sven for starting this and making initial changes.

I don't think this should be in the commit message 

> -/* initialize all bla structures */
> +/**
> + * batadv_bla_init - initialize all bla structures
> + * @bat_priv: the bat priv with all the soft interface information
> + */
>  int batadv_bla_init(struct batadv_priv *bat_priv)

kernel-doc doesn't like that the return value documentation is missing here:

    No description found for return value of 'batadv_bla_init'


Kind regards,
	Sven
--nextPart2250263.uqqogQNrlh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCgAGBQJWO60/AAoJEF2HCgfBJntGvdEQAMOxuhZwdCI5kigSiasF3rnc
O8JPY+YQSkmqd82iAKknsECXAD0mZ3uvlT1RQm7J8nQ8PP92hDV8dQyyrDiJc4oO
nnxngvgiKn/kjHAagK5hNYKnqrMrP1LhANutRSGJAeinDikMSPkLy8OCUWObtWPD
5gDjh4/DBFmL86NJ11Y531d1/ZqvNAzul83b7ztSFRzQkDAVvUx8ZYfdE3Trmwxt
OOcaSi7JrpuCYDFZ3YYxnhojEgTFvs1Jgt835G1A/4umuXHNXfHsI2Er0QHDKgU3
zqTlPl+Vrabo0NMRveYjcNm4CHVAOXHZkgpNVGR8XiLVDaKdm+ASnDV0yQhpPugF
l25j8RfYwHzm2rVSi/YcfO64xzWr+ZzpkEgmLHNy19UjHW8uaoqYJ+ai9X2VhfRz
9zRbjzauic6FH9WOw5fNwBYaERzZtlr/PtiXmGGFvcsjYOvCiByS8+Gv+pjB/azV
W1HrtJB7W8fLFdWmTSE9TpAZCY9+roVoQ8cPNWpKHtaK/vn/FqKS/I1lRPvUfHLK
GMyFzGAZ/ZsMPf44WDTpGNODvP2OTRtRwSq0Tq533SEfEtalX54orhvtqq1xut/J
TRLEC6TskgGdgm+bc8JBSUH/PWJJKYCkyD8i77MvTzaxDXtmo/nV6qJKrZRt88qP
rvIiY1AufukoihcBN7qM
=/Eq3
-----END PGP SIGNATURE-----

--nextPart2250263.uqqogQNrlh--


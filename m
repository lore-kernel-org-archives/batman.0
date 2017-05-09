Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Tue, 09 May 2017 17:50:41 +0200
Message-ID: <38318850.GE51cWUxAf@prime>
In-Reply-To: <20170428202610.27022-1-sw@simonwunderlich.de>
References: <20170428202610.27022-1-sw@simonwunderlich.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2029916.TUcI1g4g74";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: handle race condition for
	claims also in batadv_bla_rx
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: Andreas Pape <apape@phoenixcontact.com>
Cc: b.a.t.m.a.n@lists.open-mesh.org

--nextPart2029916.TUcI1g4g74
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Friday, April 28, 2017 10:26:10 PM CEST Simon Wunderlich wrote:
> From: Andreas Pape <apape@phoenixcontact.com>
> 
> Like in the case of the patch for batadv_bla_tx to handle a race
> condition when claiming a mac address for bla, a similar situation
> can occur when claiming is triggered via batadv_bla_rx. This patch
> solves this with a similar approach as for batadv_bla_tx.
> 
> Signed-off-by: Andreas Pape <apape@phoenixcontact.com>

Hi Andreas,

thanks again for the patch - in general, I think this looks good, although I 
don't follow completely where you saw that. Can you describe the scenario a 
little more?

We usually don't process packets from the mesh sent by nodes on the same LAN 
segment - we look at the originator and check the BLA group using 
batadv_check_claim_group().

There are two things which we could improve documentation-wise:

1.) Have some kernel doc  batadv_tt_local_has_timed_out - we want to have 
kerneldoc for every new function we add.

2.) Describe the scenario in a comment in batadv_bla_rx(). I find the comment 
not too convincing, see above.

Again, if this situation is really happening then I believe this patch 
provides a good solution which I'd like to adopt. :)

Thank you,
     Simon
--nextPart2029916.TUcI1g4g74
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE1ilQI7G+y+fdhnrfoSvjmEKSnqEFAlkR5VEACgkQoSvjmEKS
nqERhw//cXxhO94gD6RIS72fqwXVNodoJkP60nj3JAT2Dc3ooIixfb8rNeWDatg3
jNMrxSlDHq5WW0fBV4SFsG5A4J4Gx4EXq7wZ18ZdJZ7h3VuNt6E6v9CVdrkG5vr8
bKUm/cIrH3SLhZ1c9SUo+GgvUVD2D0ytiSPmAe93W+J+2r8ESgWTEg0fubsrhd3B
HWQXal0XaekQY//tamkZyOhlPKUzHhTmymnAu5yPHc/PmdY8J7Feg1wRUcmcW7CC
Oxz5d6mj1avcJ1NLjoxLwsxjGstNKtyLzp+FCKyvUd348Z0cZoGRhAl0AkoV2f7i
TnNEVGFV/tQfFh/TlmE6+Xv1b44+fY6WXwd6r2xZ+u76Z2W0HREMd3tTOhDJxriB
sxjCd75Rl/X0f1CCKlCavX550Hs6GGJm56TZGsPjV0GrUNvKCkVktW2ucljFouxp
QNZe6iPTdYtuu+XyA+YlIJlzGRNK/SYjO+li90Pifbt85gfN1NTQnDr/glk04kC3
GPqy7p69ypNgXQ9D8ILGiniTeXbDU2izfPImEe8eqIRZDjV0EZGvCZOM6IcaxLxZ
5L/hIXRTBiUNZ0RVb0TL4HGyx1fJpQaj7mDef1JwauVYfp33JA858R2cPsKJz7z3
MXxuosPVT44Dfs8CzuVzx8IyN3YW6MyaBox4C/MsweevShlay2k=
=2Mif
-----END PGP SIGNATURE-----

--nextPart2029916.TUcI1g4g74--


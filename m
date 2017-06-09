Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Fri, 09 Jun 2017 09:09:15 +0200
Message-ID: <4651046.6r6MKhUZbP@bentobox>
In-Reply-To: <20170607145122.18207-1-a@unstable.cc>
References: <20170607145122.18207-1-a@unstable.cc>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart6454555.7gUjFCYIgY";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH] tp_meter: mark init function with __init
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
Cc: Antonio Quartulli <a@unstable.cc>

--nextPart6454555.7gUjFCYIgY
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Mittwoch, 7. Juni 2017 22:51:22 CEST Antonio Quartulli wrote:
> batadv_tp_meter_init() is invoked in batadv_init() only
> which is marked with __init.
> 
> For this reason batadv_tp_meter_init() can be marked with
> __init as well and dropped after module load.
> 
> Signed-off-by: Antonio Quartulli <a@unstable.cc>
> ---
>  net/batman-adv/tp_meter.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

I've added the "batman-adv: " prefix and applied it in 412f93cbbfa8 [1].

Kind regards,
	Sven

[1] https://git.open-mesh.org/batman-adv.git/commit/412f93cbbfa81e31773a513604eb3c7ff5ec814d

--nextPart6454555.7gUjFCYIgY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAlk6SZsACgkQXYcKB8Em
e0YeVA//TFIx9H+FtH5xMTG/1WlDF2mStWJ/bRIKoOGng17laUzpQVIPVXPrmgZ3
Sbzn42ZRPD5cucxTiMVaxgQKfEIsZCm89maFhcSs62TuxjjoAcUt+9KjGkXP87od
GZM8y5EBuC/R+QVGALvyQu/zlr3BlIljwfdu+tiV6qcrmWuwWrMv79c3ZohRWFUx
BOQmLCDuhFGot5ezBGfBxiQFiRVUPW3jeEg9RjSZ0Wb0aev9gjfGgRaC8aG6OIWu
rg+WnDgvxYT/eFDufYhEomJEba3fSJiBM9HsHVOhDFKVtfc7qRMFQvkh44197hgb
dmvatC6JzDxzm4iz5cJ3dq0W3m2HkJTG5vACuSTtVhFOZHq7DbR6NyO9Oh+ZMsTJ
aHIga285pB8+o+rG3Qg20saqYwWA1cuA8V/HdmXUrXrC5c/nqCAQLyeglxxYPcqJ
0MI5uiaaME3Xy96vL6tLnGyC3G8Lh6pr6Zow5w1KobiJ25vA23vM7NWPqCDEDCFQ
yH4vx46XI2ZCAB74j60i0LvVvGdQkt5MtFSKG87jUlvIgrWTErDyuCbjsquEVSFj
XFXf0kRFuvQp+2NEntAI0+WqLIXHXPsLtGjk6oGZ1kjCJOYSBxof0XoJA+uYHWOK
4OOfWP5Oz9Obc5lQsNtUPmtZB3DtsWSbGpgk54HKbbm1KpIok3M=
=30EJ
-----END PGP SIGNATURE-----

--nextPart6454555.7gUjFCYIgY--


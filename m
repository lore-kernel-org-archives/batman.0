Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Fri, 27 May 2016 14:01:42 +0200
Message-ID: <2194016.YKssNhFpyx@prime>
In-Reply-To: <1458157872-15879-3-git-send-email-andrew@lunn.ch>
References: <1458157872-15879-1-git-send-email-andrew@lunn.ch>
 <1458157872-15879-3-git-send-email-andrew@lunn.ch>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart4221905.2g3dJ3dErU";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH v2 2/2] alfred: Mount debugfs before
	reducing capabilities
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
Cc: "B.A.T.M.A.N" <b.a.t.m.a.n@lists.open-mesh.net>

--nextPart4221905.2g3dJ3dErU
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="ISO-8859-1"

On Wednesday 16 March 2016 20:51:12 Andrew Lunn wrote:
> The debugfs helper code has the ability to mount the debugfs file
> system if it is not already mounted. However, it cannot do this
> after the capabilities have been dropped. So perform the mount early,
> and remove all the other attempts to do the mount.
> 
> This is especially important when using network name spaces. Each
> namespace has its own /sys, so the mount of debugfs in the global
> namespace is not visible in other namespaces.
> 
> Signed-off-by: Andrew Lunn <andrew@lunn.ch>
> ---
> v2: Remove the other calls to mount

Applied in revision d08b0e0.

Thanks!
     Simon
--nextPart4221905.2g3dJ3dErU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCgAGBQJXSDcmAAoJEKEr45hCkp6hewQP/RZnFuJMnjLs3hhP6YESFyNN
WQjM+1+fO91oMq3hzMF2CblFm2fW2DpWmanShxwwRnHWgxu4i/jXRIjkxsWxKCrN
LO8nIAX/xbP4JOD/tU2IC5vdyA7ObW2XSz+GbfXSA6Iv62uj5IQzvjBrFeQjzFBC
zzOMzNMpA6w2LVgHkbLxkn6NeBnAznZOytxbnm4MrzmA097C6Zbn0RgPOWOotY9U
fC6Vserx4+Lck0Q7iXVtlh3IrRSMZkHgTrPD6YMr2F6FawWbzIT7fTxr804wDp/R
v9+jX7AeKRWdUW76KZdNKfuaWVsrPEm8Ruq+rTBjtYCuu3hPO7dOHzeLtzudXdGo
HlzppKDB5Cq8qnXnvo/MfNngp0qcekRYR8/lOMkNdROgHXTM16YI0ekwv36aQQn4
sRd9DymOO0yXxlsWC9i94SNOGysDzBr4IDnjdNbGEfAtsTjnFyQt997ItbEtVgDY
yeEaKPB/8ofiUtm/TJtLqiemjR20KqLdc7Fg+4lFweRlNZfxyLlD7dtyTMhXUMGp
5yHheQ6HExkKLZ/p5JSnGQ5w8Yy4F99WWB6Lph1yLBZOcYbQl9gO5gYwDxTalROR
/DE2eCyXS25eAPGlWbxn5R6dHODh5+4m5lSVxbEAmVawWTsDIeZrfz5m5DMrrju2
EFe/R/tL8eBcYy4cC1D1
=VRxz
-----END PGP SIGNATURE-----

--nextPart4221905.2g3dJ3dErU--


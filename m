Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Tue, 07 Mar 2017 16:45:36 +0100
Message-ID: <3325330.3i3GZqDdzm@prime>
In-Reply-To: <13175888.lmslI35NF1@sven-edge>
References: <13175888.lmslI35NF1@sven-edge>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart4820341.3aHZgxPAgY";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH maint 0/3] batman-adv: 2017.0 bugfixes
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

--nextPart4820341.3aHZgxPAgY
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

I've picked those patches of this series into e0948943..ef565a14.

Thanks!
     Simon

On Saturday, March 4, 2017 4:32:23 PM CET Sven Eckelmann wrote:
> Hi,
> 
> here are some patches which are for maint. These address different
> bugs [1,2,3]. The last fragmentation patch is already part of master. But
> Martin Weinelt and Matthias Schiffer identified it as a bugfix for a problem
> of Freifunk Darmstadt. The commit message of this change was therefore
> rewritten to also explain that it fixes this problem.
> 
> Kind regards,
> 	Sven
> 
> 
> [1] https://www.open-mesh.org/issues/326
> [2] https://www.open-mesh.org/issues/327
> [3] https://www.open-mesh.org/issues/328
> 
> Johannes Berg (1):
>   batman-adv: average: change to declare precision, not factor
> 
> Sven Eckelmann (2):
>   batman-adv: Keep fragments equally sized
>   batman-adv: Initialize gw sel_class via batadv_algo
> 
>  compat-include/linux/average.h  | 67
> +++++++++++++++++++++++++++-------------- net/batman-adv/bat_iv_ogm.c     |
> 11 +++++++
>  net/batman-adv/bat_v.c          | 14 +++++++--
>  net/batman-adv/fragmentation.c  | 20 +++++++-----
>  net/batman-adv/gateway_common.c |  5 +++
>  net/batman-adv/soft-interface.c |  1 -
>  net/batman-adv/types.h          |  4 ++-
>  7 files changed, 87 insertions(+), 35 deletions(-)


--nextPart4820341.3aHZgxPAgY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE1ilQI7G+y+fdhnrfoSvjmEKSnqEFAli+1aAACgkQoSvjmEKS
nqF37A/+NJ77RZFO/EoG8BsmGBf5GsMwKN8kDcXMCAzXVHgYLXCtKnVTJM9SDAvi
aOUo5XZYlSxqBzIqZLA2gI1tXsa3BKbRh0jPv3bofrkeA30pdYA/gqdPSl+MVYaP
G4kZ84uJm/nBBpVUR5zRwqBexIkRgfk6lNj43UtrkvPpkVUWMv7WNQGEfQ6bj+Nb
d/k/iS8yyDIE5CCvx6WvrraHa1o3X02zbKPR515PrXyUxijBhUMi/z0bTzO7lVfn
oPXyPjNp1/uC88mrevUd+m5IuRtmWe65ZV9XZfujz1yi0FeQGcp55gfEr4nwxabR
wvEMm/CFTKNhZoX9qQQWcHqI4tBK9+uScBBpvRAK2FSzpciPyCF97XNrlFIV8LsT
O9AZOMhCNGaPcizBpZNnSLT/pKV2IBT+yPjLpkeLvVC1cabJ38TMSZ+fcyXrran7
pEX05AiudDeQ6mSoSuZzV6xtc9yWe17tOnrT1tYHYp0a0p0oF6uGi/nR+1Y19zC5
ekcATyOo2eptfCaqbah9fuHP4zpLM7vKQFO0RaLbNOu8FXHYpWIJZXn/0qHGA06N
8zpKxTM4r0sWVqQYlAyKPdJkwUkgAPxdIrAuBQZnNbIJdVdT/Bpu5vAnZbNnLa+t
FlXuqHlE7WWAIR3KrQcGm6SFjiuMEJTXIXlhQBy8VVk/vL32OTE=
=ZpVh
-----END PGP SIGNATURE-----

--nextPart4820341.3aHZgxPAgY--


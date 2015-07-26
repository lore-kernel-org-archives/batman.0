Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sun, 26 Jul 2015 02:41:58 +0200
Message-ID: <2843280.OVBCaG5TZN@sven-edge>
In-Reply-To: <1898798.WP4bC1arXA@bentobox>
References: <1898798.WP4bC1arXA@bentobox>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1620862.Eh3CeEXRZ1";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] Missing list checks for *list_add*
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


--nextPart1620862.Eh3CeEXRZ1
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Friday 26 June 2015 16:45:01 Sven Eckelmann wrote:
> Hi,
> 
> Simon debugged the refcnt problem and submitted some patches to fix them. I
> had a brief look and noticed that there are possible more problems similar
> to the *list_del* ones - just with *list_add*. Basically some functions use
> some kind of get function, notice that the element does not exist and then
> create a new one to add to the list. Only the "list_add" is protected. The
> result may be that an element in twice in a list when only a single
> occurrence is allowed.
> 
> The problem I saw is batadv_gw_node_update. It first calls
> batadv_gw_node_get to check if an object with this value already exists and
> then uses batadv_gw_node_add to add a node (which may already be added
> between these two calls). So it has to be made sure that nothing modifies
> the list between these two calls).
> 
> Similar looking functions are for example:
> 
>  * batadv_tvlv_handler_register
>  * batadv_nc_get_nc_node
>  * batadv_softif_create_vlan
>  * batadv_tt_global_orig_entry_add

*push*
--nextPart1620862.Eh3CeEXRZ1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCgAGBQJVtCzdAAoJEF2HCgfBJntGOkAQAJtw+n2udij3QrOQ926BP1Kf
4ks5NDCvm2kFXYMhhc7Yi+xmeod/3LDZTdMqq2c6urES5XdjrsEixW0SVVNEc2xX
X1vN4T46l1YNYvJHCnPifjRUg2qHaT39XzOEPoQIrnVgA3FM+dIlApCxcUXvYBeM
cfaSFiEDayOUSGPeIQPIm43VIQZAl4jsOGXnmHs6eWhYw7AxFnuRuylnF0S0VhSF
CftF0psCtndhS4wJo33g9Xo33PuN0lVCM4kuoqtpmv6pu2+So7xIWO5vCB/EN+TU
MvXwqZCsrOV9BCFRBKaRLm4F7/VAIKq9gFzavWZIotaHpxjqrQ4I51PpuRfS8dwy
lF+PkHZ4/jRB2JWw6O5P2n/KFiG8yIRpcSLv3PBPifXBYWkhTJv4AwBAia9Tyk9Y
cRDgfbiEouX4y+/03EPljXq0GKEi+ShNhKiZcoWiZzxHxmdwFukE4q48pS175WK0
JHc+ETr4kKE9ihilC22yePUC5es/MrLBctN0tAn4MPUL2vLnsr2H2gZxmJG/4IfS
/D/vPREQmFYb/h9aGLQdztP78Bl9toYbAoaQSmRNtIAp0iMk5whGqh7F3UP/Rq5v
RCXbUeP97cD6YV9+y4T4yhPq7536X4YUhfTZJUAcqGU5iAdkRaT//5QwqM+j7K/U
WTzTxlm5LGZ9M7oO/g2+
=orqf
-----END PGP SIGNATURE-----

--nextPart1620862.Eh3CeEXRZ1--


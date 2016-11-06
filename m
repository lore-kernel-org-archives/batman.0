Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sun, 06 Nov 2016 11:48:34 +0100
Message-ID: <3987570.iOS7FDS5sO@sven-edge>
In-Reply-To: <1478427394-11607-1-git-send-email-jj.sarton@t-online.de>
References: <1478427394-11607-1-git-send-email-jj.sarton@t-online.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart14640500.2gCn11Ymaq";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [[PATCH] Alfred not working within network name
	space add static to function declaration
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

--nextPart14640500.2gCn11Ymaq
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Sonntag, 6. November 2016 11:16:34 CET Jean-Jacques Sarton wrote:
> Fix scope of function to static
> 
> Signed-off-by: Jean-Jacques Sarton <jj.sarton@t-online.de>
> ---
>  batadv_query.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Please read my reply to https://patchwork.open-mesh.org/patch/16803/

Same applies here.

Kind regards,
	Sven

> 
> diff --git a/batadv_query.c b/batadv_query.c
> index dc8a042..69f5a48 100644
> --- a/batadv_query.c
> +++ b/batadv_query.c
> @@ -136,7 +136,7 @@ int ipv6_to_mac(const struct in6_addr *addr, struct ether_addr *mac)
>  	return 0;
>  }
>  
> -int batadv_interface_check_debugfs(const char *mesh_iface)
> +static int batadv_interface_check_debugfs(const char *mesh_iface)
>  {
>  	char full_path[MAX_PATH + 1];
>  	FILE *f;
> 


--nextPart14640500.2gCn11Ymaq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIcBAABCgAGBQJYHwqCAAoJEF2HCgfBJntGH4UP/1TdvloO7o3mKmbJAT+6/1Tn
n6RlwDEsWDqOMCnk3sTgQxxSNskGSN5CgE2lZYJbQ1lvQj1VoE9vdOKzgnd7Glxx
QUaAGOHYJPbBer/XzUIHAcKUd0dTEpqUZP+xDDjo3c1YvjDbwkBx5zmOUgwKFA4o
ABilP2+gWZzRm67yDtyMl43W9lqz5xLY8CJNCxbnbruhdDEPjZsto27XD0UUbzqk
ZUijfnbKI1Y0xpHB9/dn6JD7vBh0jBPFgMo52CP14KXg6+akIK0SDvYHuZ3zQ1Gg
ls++7/lKywiEA9ixZdCmPTehKVPOzr9wAFsPglU/FmDVY1sJFTJo1rVog5NAuPop
FqRVVpCYxnGFg8tzZ4TgBLcFmfjQlrx4xPZOTE0nb2wAF0phYDxb9Ij5qinvbyMX
t4wF5MpyfX/LJIpLQeRBNYOAbIIqKmC2tK+tj1GTRIKj30nyQqlNwsk76oVyeWCc
JfzAtsFlf2vB1XuCRz8USXbIDmfWTIdXEagyghcX2iqPgcWQOB1f9y04WwtruFHC
TXT7uJcQ2GWgxtImM1sACFKGQ7pAUguJ7g/UMjJi3BR7yQQnZrwmAy5gy37rPXO7
bjwGNNiIjIXQBUDovtF8s8HIpaEIihpQqTJ5NCbn7rYUVQh/vk8VMSjgM74TxHo4
dgn+TGQnPkvCufRXNF7j
=sKYs
-----END PGP SIGNATURE-----

--nextPart14640500.2gCn11Ymaq--


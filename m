Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sun, 17 May 2015 00:50:32 +0200
Message-ID: <26516794.HyuHs5i0nG@sven-edge>
In-Reply-To: <20150516222643.1c390606@i3.local>
References: <20150516222643.1c390606@i3.local>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart10931569.yCn4ZGO4xC";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH] gw-bandwidth: fix potential overflow on
	very large input values, limit them to 100 GBit/s
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n@lists.open-mesh.org>
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


--nextPart10931569.yCn4ZGO4xC
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Saturday 16 May 2015 22:26:43 Ruben Wisniewski wrote:
> Signed-off-by: Ruben Wisniewsi <ruben@vfn-nrw.de>
> ---


Same commit message/topic problems as in the other patch. The
patch also doesn't apply on master/next.

    Applying: gw-bandwidth: fix potential overflow on very large input values, limit them to 100 GBit/s
    fatal: corrupt patch at line 11
    Patch failed at 0001 gw-bandwidth: fix potential overflow on very large input values, limit them to 100 GBit/s
    The copy of the patch that failed is found in:
       /home/sven/tmp/batman-adv/.git/rebase-apply/patch
    When you have resolved this problem, run "git am --continue".
    If you prefer to skip this patch, run "git am --skip" instead.
    To restore the original branch and stop patching, run "git am --abort".

>  net/batman-adv/gateway_common.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/net/batman-adv/gateway_common.c
> b/net/batman-adv/gateway_common.c index 39cf44c..6b0f4d3 100644
> --- a/net/batman-adv/gateway_common.c
> +++ b/net/batman-adv/gateway_common.c
> @@ -71,10 +71,16 @@ static bool batadv_parse_gw_bandwidth(struct
> net_device *net_dev, char *buff,
>  	switch (bw_unit_type) {
>  	case BATADV_BW_UNIT_MBIT:
> +		/* limit input to 100 GBit/s */
> +		if (ldown > 100000)
> +			ldown = 100000
>  		*down = ldown * 10;
>  		break;
>  	case BATADV_BW_UNIT_KBIT:
>  	default:
> +		/* limit input to 100 GBit/s */
> +		if (ldown > 100000000)
> +			ldown = 100000000
>  		*down = ldown / 100;
>  		break;
>  	}


Wouldn't it be better to reject the input and inform the user
about it with an error code (EINVAL or something like that)?

The value looks a little bit randomly chosen. I've looked a little
bit into the "new' TLV code and it seems store store this value inside a
be32 variable when it is sent over the wire. This be32 can
store 4294967295. The unit it represents seems to be in 100 Kib/s.
So you would end up with a max of ~409 Tibit/s.

Maybe you can emphasize more why 100 Gibit/s is a good choice.

Btw. am I the only which gets a little bit sad about the fact
that this function uses kstrtol to parse the input and then
nobody check if ldown or lup is negative? ... sorry, got a little
bit sidetracked.

Also, why does this change not include the upload speed parsing
part of this function?

Kind regards,
	Sven

--nextPart10931569.yCn4ZGO4xC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCgAGBQJVV8m7AAoJEF2HCgfBJntG6vEQAIBLj+aX7TK2lA87TDRJAZsU
29PX2vE1z3K1ykc0NzdtFussCQ4/e1eXhQGDv6I22E4oncu7PbZleRIsa+qrldPb
1dQkAxh/OioD5j+KyK/8e8BX+/pyzuUR01+lWffCo2PfBSNiKYhmnG23PM69tEOM
Bb9XGAkCg3e1goOUw70/HJnC2p+GRMkaaylASJ+Gz4EmeydptL0okx6q48Csv8KH
VPTZ4nJ+Og6TeWL4ktiGKrINq2HgC67GxU51crOl6I8GPpcAui1FmfqtQLhD/Gl7
u6HKRB2VpvFG3d99qWX6qHZmK1wPlGL+jhW2OuvFPXNI5r5nz+MbdA5Dv7uQ2PCm
iFQCLL+bKNpw0bfFye9hMESyvc7D/mepXE2EoP2DWmeaspueCD+ILxf4ww6zLNkH
2CeSe9uqVXQxY+W5jqhcF65vhZBjVey3y59AYR/oZBrFciuUN9fhJ6qf+6Q2Ecqd
t9FytdexmRelwkv5q/B1UcqUCHBBzjGZlVsVV3zElhAFWZHJEBMHgh1+jNRf6716
q92gYmnhC6nyUboiyStYuitrEFFL0ZdbZ0JIzw5VGDFvSRAkY3Zqh2MIQ9wSbnZI
Zlo2Aqc0uUoCkJwwS3+3T1fBhYvI2Lq7/x1D+o8xSGHHZAL2ggce7HLOXRPM8ZGW
AoBP5Xzo8VtDqSfIkFBB
=hJ54
-----END PGP SIGNATURE-----

--nextPart10931569.yCn4ZGO4xC--


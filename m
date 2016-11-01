Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Tue, 01 Nov 2016 15:59:47 +0100
Message-ID: <1578603.hzp8NWRWg0@bentobox>
In-Reply-To: <c87c6dac-72e5-c8ea-a2e1-50a173e53f16@t-online.de>
References: <c87c6dac-72e5-c8ea-a2e1-50a173e53f16@t-online.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart3760888.0xrHqgDZTZ";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] PATCH alfred
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: Jean-Jacques Sarton <jj.sarton@t-online.de>
Cc: b.a.t.m.a.n@lists.open-mesh.org

--nextPart3760888.0xrHqgDZTZ
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Dienstag, 1. November 2016 15:38:48 CET Jean-Jacques Sarton wrote:
> Copy & paste is not allways the right way.
> The previous patch for  netlink.c what not OK. The right patch is:
> 

Same problems as before and patch is also corrupt:

    Applying patch #16799 using 'git am'
    Description: PATCH alfred
    Applying: PATCH alfred
    fatal: corrupt patch at line 6
    Patch failed at 0001 PATCH alfred
    The copy of the patch that failed is found in: .git/rebase-apply/patch
    When you have resolved this problem, run "git am --continue".
    If you prefer to skip this patch, run "git am --skip" instead.
    To restore the original branch and stop patching, run "git am --abort".
    'git am' failed with exit status 128


> 
> 
> +       return 0;
> +}
> 
> diff --git a/netlink.c b/netlink.c
> index 1b5695c..445161d 100644
> --- a/netlink.c
> +++ b/netlink.c
> @@ -365,3 +365,30 @@ int get_tq_netlink(const char *mesh_iface, const
> struct ether_addr *mac,
> 
>         return 0;
>  }
> +
> +int batadv_interface_check_netlink(const char *mesh_iface)
> +{
> +       struct get_tq_netlink_opts opts = {
> +               .tq = 0,
> +               .found = false,
> +               .query_opts = {
> +                       .err = 0,
> +               },
> +       };
> +       int ret = 0;
> +
> +       memset(&opts.mac, 0, ETH_ALEN);
> +
> +       ret = netlink_query_common(mesh_iface,  BATADV_CMD_GET_ORIGINATORS,
> +                                  get_tq_netlink_cb, &opts.query_opts);
> +       if (ret < 0)
> +               return ret;
> +
> +       memset(&opts.mac, 0, ETH_ALEN);
> +       ret = netlink_query_common(mesh_iface,
> BATADV_CMD_GET_TRANSTABLE_GLOBAL,
> +                                  get_tq_netlink_cb, &opts.query_opts);
> +
> +       if (ret < 0)
> +               return ret;
> 

This is wrong BATADV_CMD_GET_TRANSTABLE_GLOBAL will not work with
get_tq_netlink_cb. And translate_mac_netlink will use
translate_mac_netlink_opts. Better create a dummy function which
only operates on "struct nlquery_opts" and returns NL_STOP on the
first call of this function.

Kind regards,
	Sven
--nextPart3760888.0xrHqgDZTZ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIcBAABCgAGBQJYGK3jAAoJEF2HCgfBJntGJvYQAJaKwSiAz7en6x4ObFo2+mI8
hS/aaxd7weUVbq/0BneQke9/tjjVX2Rc/Y9L9exB7+pMurmhgMdtaAD/4/LyU1tE
rwxLoomeCAPdNPplmu3dh/nUXfXgJ+9+6ahJJcww2pW9dBp5WoXCh+COq2whYPrR
mFKX4Bjx4OSbhaWeFg3nwyp7L94PFdySg13LyM4FfABhJ2CwFaqva2lo6T23I39a
2A7odRagma69rbhqVnMCWvl2C+T2HkNQLycK6rbeb5Ly75dPjlZSW013uhzEd5wn
fIoenxGVEsEO0sc49v88CHsMc4dkmDHqGRHAOULSvV7ERXPBDX67w/xEU0iEoVKN
zybmjWNc9xpLllhCnV6OZzoGkgRVxWTPD72Fhkpnt7l4zrvxy1+vBCY8RFX9eoFe
4S/iXGehMggj80j4oB11ytktjv5YOxwOBX0Pbz8BBTLKCeJQr09Z6qa0eFWW+vKn
KCdnksod+oS/Z4QsVpCjv5mqQa0dI8P4sKyt/AHt/QvumK0dNvaAGBRZw2puuHiW
4N5bU32zAOoz7LhYvmNLqWFITtKFh6gvaDhjIzTN1zf4yO7yf+FRRfHA04KUFA16
AiGC2TbzOxjKBrfoBXI3nRBlQvn7QsFOwVzK2BUjvcELGBne+79xF+IBJwhgK4N/
g+LM0uMNHSTJ9/4P7iEQ
=1TjZ
-----END PGP SIGNATURE-----

--nextPart3760888.0xrHqgDZTZ--


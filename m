Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Tue, 01 Nov 2016 16:30:23 +0100
Message-ID: <1488186.Z9SVQLuMSq@prime>
In-Reply-To: <735c49a8-6ccd-9932-5835-27b59b3f1c98@t-online.de>
References: <735c49a8-6ccd-9932-5835-27b59b3f1c98@t-online.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart4061729.mnfz6ZkVgO";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.]
	=?utf-8?q?PATCH_a=C3=B6fred_don=27t_start_idz_with?=
	=?utf-8?q?in_a_network_spaxce?=
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
Cc: Jean-Jacques Sarton <jj.sarton@t-online.de>

--nextPart4061729.mnfz6ZkVgO
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

On Tuesday, November 1, 2016 4:20:07 PM CET Jean-Jacques Sarton wrote:
> Hello I hope that this will be a valid patch.

This doesn't belong into the commit part of a patch.

And no, it doesn't apply:

$ git am -s /tmp/\[B.A.T.M.A.N.\]\ PATCH\ a=F6fred\ don\'t\ start\ idz\ wit=
hin\=20
a\ network\ spaxce.mbox
Applying: PATCH a=F6fred don't start idz within a network spaxce
fatal: corrupt patch at line 7
Patch failed at 0001 PATCH a=F6fred don't start idz within a network spaxce
The copy of the patch that failed is found in: .git/rebase-apply/patch
When you have resolved this problem, run "git am --continue".
If you prefer to skip this patch, run "git am --skip" instead.
To restore the original branch and stop patching, run "git am --abort".

Did you consider spellchecking your subject? There at least 3 typos in this=
=20
single line, and PATCH should be in brackets [].

Svens technical remarks also haven't been considered.

On the plus side, you now have a subject (or something like that), a commit=
=20
log, and a signed off, so I believe we are converging to a mergeable patch =
=2E..

But please, take some time and prepare the patch properly. At least we are =
not=20
in a hurry.

Thank you,
     Simon

>=20
> This patch shall allow to use the debugfs as previouly, including
> the check for valify of the interface used.
> For netns the check seem to be implemented within the function
> netlink_query_common().
> For netlink we check if the originators ans transtable_global
> informations are accessible through netlink.
>=20
>=20
> Signed-off-by: jj.sarton@t-online.de
> ---
> diff --git a/batadv_query.c b/batadv_query.c
> index a671b79..dc8a042 100644
> --- a/batadv_query.c
> +++ b/batadv_query.c
> @@ -136,7 +136,7 @@ int ipv6_to_mac(const struct in6_addr *addr, struct
> ether_addr *mac) return 0;
>  }
>=20
> -int batadv_interface_check(const char *mesh_iface)
> +int batadv_interface_check_debugfs(const char *mesh_iface)
>  {
>         char full_path[MAX_PATH + 1];
>         FILE *f;
> @@ -166,6 +166,18 @@ int batadv_interface_check(const char *mesh_iface)
>         return 0;
>  }
>=20
> +int batadv_interface_check(const char *mesh_iface)
> +{
> +       int ret =3D 0;
> +       enable_net_admin_capability(1);
> +       ret =3D batadv_interface_check_netlink(mesh_iface);
> +       enable_net_admin_capability(0);
> +
> +       if ( ret < 0 )
> +               return batadv_interface_check_debugfs(mesh_iface);
> +       return 0;
> +}
> +
>  static int translate_mac_debugfs(const char *mesh_iface,
>                                  const struct ether_addr *mac,
>                                  struct ether_addr *mac_out)
> diff --git a/netlink.c b/netlink.c
> index 1b5695c..9288770 100644
> --- a/netlink.c
> +++ b/netlink.c
> @@ -365,3 +365,30 @@ int get_tq_netlink(const char *mesh_iface, const str=
uct
> ether_addr *mac,
>=20
>         return 0;
>  }
> +
> +int batadv_interface_check_netlink(const char *mesh_iface)
> +{
> +       struct get_tq_netlink_opts opts =3D {
> +               .tq =3D 0,
> +               .found =3D false,
> +               .query_opts =3D {
> +                       .err =3D 0,
> +               },
> +       };
> +       int ret =3D 0;
> +
> +       memset(&opts.mac, 0, ETH_ALEN);
> +
> +       ret =3D netlink_query_common(mesh_iface,  BATADV_CMD_GET_ORIGINAT=
ORS,
> +                                  get_tq_netlink_cb, &opts.query_opts);
> +       if (ret < 0)
> +               return ret;
> +
> +       memset(&opts.mac, 0, ETH_ALEN);
> +       ret =3D netlink_query_common(mesh_iface,
> BATADV_CMD_GET_TRANSTABLE_GLOBAL, +                                =20
> get_tq_netlink_cb, &opts.query_opts); +
> +       if (ret < 0)
> +               return ret;
> +       return 0;
> +}
> diff --git a/netlink.h b/netlink.h
> index b08e872..9bc75a1 100644
> --- a/netlink.h
> +++ b/netlink.h
> @@ -49,6 +49,7 @@ int translate_mac_netlink(const char *mesh_iface, const
> struct ether_addr *mac, struct ether_addr *mac_out);
>  int get_tq_netlink(const char *mesh_iface, const struct ether_addr *mac,
>                    uint8_t *tq);
> +int batadv_interface_check_netlink(const char *mesh_iface);
>=20
>  extern struct nla_policy batadv_netlink_policy[];


--nextPart4061729.mnfz6ZkVgO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIcBAABCgAGBQJYGLUPAAoJEKEr45hCkp6h0dEP/i1attrIKaTOoQqEwjI+Fx0u
j4nRWtn9orenUKjAXLd9J3wkzAiz/pQAGSfjzihmx+8c6e2JYCNvg/v9G8DQTmi8
8xY1ySynUQtHVh4OR/EJ89GTJ+eyQXbHf271VN+ozmBV1O3e6KvEvG2yZkOtpZ2E
rVtJ7g6PsTQBtnS9o7hoIBR4JXfInnW/bDwcAVOTwchq8wdjBsPk3ML2g7YpRXcq
NzaG0eiyUOgRsJ8pyto7w00RBoyJdV9mUp+2EMBSdsJubJecKpT0qPomY1KErBqa
IQLoO3DTfHVWQyqmnN2JvzjjGsJf6oZVDV/lZiHt75a+/6sGcrr3Kqh/V34/Th4C
pCHK0xuiv413U9u4eHD+KpxULFStHoRWtWDizrRgSdnvK8AhFtcVuqXt2BMdaZTe
z9me4UFbczwnJbI4O54FyAhn6medfttqSadV4UN16nSDvmeYBEdimD38v2tPj+c6
ejJup7TzwKBeeUqbJjJHuXvX4rw4M4nqg8Hm89oM3Z4a0SDFfEvsGuDz7CG9moVf
3u58WKG45Z9/ykSRVQLkMZgeR2ndOR6rMre/tUSk+HZ2RSeLylf38HTOfMOYGgew
as2in6RJnP+Ug9Im229mXMHgrFEtdmLmy9l9s6YruaxWJar1GA6nXhTbq3X+isZG
zwoXovBz/zlel9tzs2/c
=zgay
-----END PGP SIGNATURE-----

--nextPart4061729.mnfz6ZkVgO--


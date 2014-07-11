Return-Path: <antonio@meshcoding.com>
Message-ID: <53BFE146.7050003@meshcoding.com>
Date: Fri, 11 Jul 2014 15:06:14 +0200
From: Antonio Quartulli <antonio@meshcoding.com>
MIME-Version: 1.0
References: <1405081595-23371-1-git-send-email-martin@hundeboll.net>
 <1405081595-23371-2-git-send-email-martin@hundeboll.net>
In-Reply-To: <1405081595-23371-2-git-send-email-martin@hundeboll.net>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="o3ASbiHI88NfLV326BU6UHpMRXE08P540"
Subject: Re: [B.A.T.M.A.N.] [PATCH 02/13] batman-adv: kernel doc fixes for
 bridge_loop_avoidance.c
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
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>
Cc: =?UTF-8?B?TWFydGluIEh1bmRlYsO4bGw=?= <martin@hundeboll.net>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--o3ASbiHI88NfLV326BU6UHpMRXE08P540
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable



On 11/07/14 14:26, Martin Hundeb=C3=B8ll wrote:
> Signed-off-by: Martin Hundeb=C3=B8ll <martin@hundeboll.net>
> ---
>  bridge_loop_avoidance.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>=20
> diff --git a/bridge_loop_avoidance.c b/bridge_loop_avoidance.c
> index a957c81..9946006 100644
> --- a/bridge_loop_avoidance.c
> +++ b/bridge_loop_avoidance.c
> @@ -252,7 +252,7 @@ batadv_bla_del_backbone_claims(struct batadv_bla_ba=
ckbone_gw *backbone_gw)
>  /**
>   * batadv_bla_send_claim - sends a claim frame according to the provid=
ed info
>   * @bat_priv: the bat priv with all the soft interface information
> - * @orig: the mac address to be announced within the claim
> + * @mac: the mac address to be announced within the claim
>   * @vid: the VLAN ID
>   * @claimtype: the type of the claim (CLAIM, UNCLAIM, ANNOUNCE, ...)
>   */
> @@ -364,6 +364,7 @@ out:
>   * @bat_priv: the bat priv with all the soft interface information
>   * @orig: the mac address of the originator
>   * @vid: the VLAN ID
> + * @own_backbone: set if the requested backbone  is local
                          too many white spaces   ^^


Cheers,


--=20
Antonio Quartulli


--o3ASbiHI88NfLV326BU6UHpMRXE08P540
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBCAAGBQJTv+FKAAoJEJgn97Bh2u9epoQP/idQQIkjpZ4A9OIGnODMSMav
PTi97HZmmRzacGcKSoehy0G1HCD3y8mclcTD70kkBgsj6YaU86PfD4imWJLNH/Dp
cipIhOWgMU3Ty5qHO5C7EhmItEIcSUkxOrvBvCSDb/v3yYNw0VtjpuB+DjOtCLNh
iZ1qgwurV7EnHi5gePtvhoNeZQFr005Z+8f4o2KUUToMQVOPjWkcGrpavMui/Au4
CWD7dTOwxmemiIM4zofp6GiNUyKMmuEghKgtiJaJvbj2AJBqmNuJRaI9yDNCltzJ
3WL0a5vjruwx0marLm7QoHY6yUZCWDlETQIwotCQlF+GYONKWHQx1Y85sxs2orf8
lSNXKCNiwySo0NsaRfs2DC9w/qJ/LqNQ5sgp6Hajt4OLSCtcEYQ5xuHEs4jlUIWQ
cIx6WnxOUjOJks5iJsXtTsFk1OmcLsLTFLBFNE1ktGT60qfJS5s1/VPnpTGl9m8T
h/m11Zjg7rLGarULPE1kQPQ/GhlBh7nvyDGa6+gXyMLEFkVxI+Ii4MNt8Y2Q3Tk2
nSvNdRgcHDUaHIt6/XHmkA0uL9eYXMCf3dr22yUUktRoWY0oPRpPoxcUfsfVKylc
9d712uAbdbxNo3Wwbgwui/mRBLbvJDorbNdbg1Um81tTLUyNrB8rYqOKXHTaU30M
yUjugTksaREMF94qiPFy
=0I+4
-----END PGP SIGNATURE-----

--o3ASbiHI88NfLV326BU6UHpMRXE08P540--

Return-Path: <antonio@meshcoding.com>
Message-ID: <53CA3F86.1030707@meshcoding.com>
Date: Sat, 19 Jul 2014 11:51:02 +0200
From: Antonio Quartulli <antonio@meshcoding.com>
MIME-Version: 1.0
References: <1405410077-28764-1-git-send-email-martin@hundeboll.net>
 <1405410077-28764-10-git-send-email-martin@hundeboll.net>
In-Reply-To: <1405410077-28764-10-git-send-email-martin@hundeboll.net>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="jBjED8CkRcrKSUUCsBLAo659dSGfrJTIU"
Subject: Re: [B.A.T.M.A.N.] [PATCHv2 10/13] batman-adv: kernel doc fixes for
 soft-interface.c
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
--jBjED8CkRcrKSUUCsBLAo659dSGfrJTIU
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable



On 15/07/14 09:41, Martin Hundeb=C3=B8ll wrote:
> Signed-off-by: Martin Hundeb=C3=B8ll <martin@hundeboll.net>

Acked-by: Antonio Quartulli <antonio@meshcoding.com>

> ---
>  soft-interface.c | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/soft-interface.c b/soft-interface.c
> index 9bf382d..bc0e44d 100644
> --- a/soft-interface.c
> +++ b/soft-interface.c
> @@ -563,6 +563,7 @@ static void batadv_softif_destroy_vlan(struct batad=
v_priv *bat_priv,
>  /**
>   * batadv_interface_add_vid - ndo_add_vid API implementation
>   * @dev: the netdev of the mesh interface
> + * @proto: must be ETH_P_8021Q
>   * @vid: identifier of the new vlan
>   *
>   * Set up all the internal structures for handling the new vlan on top=
 of the
> @@ -620,6 +621,7 @@ static int batadv_interface_add_vid(struct net_devi=
ce *dev, __be16 proto,
>  /**
>   * batadv_interface_kill_vid - ndo_kill_vid API implementation
>   * @dev: the netdev of the mesh interface
> + * @proto: must be ETH_P_8021Q
>   * @vid: identifier of the deleted vlan
>   *
>   * Destroy all the internal structures used to handle the vlan identif=
ied by vid
>=20

--=20
Antonio Quartulli


--jBjED8CkRcrKSUUCsBLAo659dSGfrJTIU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBCAAGBQJTyj+KAAoJEJgn97Bh2u9e4hsP/0a5KMeMEm4K0H/3131zmgCO
I4j68ni+hunS6Y2NU8cBARiTlJWoIMfw3QjVexFkCm+hbpJCW22meD8q1eiVCF8W
2jFNnWDRB1YcgsrZbnZYQZTjcBDdgFtQTNsXzcAS+cT3QAWZamwEXviDXHsrJsXJ
DmeonTyI8pBO06mlA83cB212ulkR7x7U4mQ7mp7FSvtHzM7RLLuNDZ+vXLnzGiPw
rE7b7fHJwE9vEhzfk12AKog13u5Rlgah727CFDt/zpP+t1kmMpEglWj1RN7W0gga
mjrDlPTcYFLFu1cDB0iNXWzNCLAvS2AA4lYjjsajPS8D7SiVTdllvLUOVgpP/zia
BV5pZbhha+R/cPZPx1m6ITs23G2D0mZK917mzI/J3MDQFm6VldXftfViXubQbRtj
I7eoAMpNCitJr5je0XZrLxHaEdaehJH7vkJKAehjgg+BuqNL/VEjQKdojRE6Ox4b
/o1s1I668HpHHDkNRfV9xk5P0oVKjvMTSazH6LDo0Zbys4dwLTpC7ECeHQIMKU66
mzT1RLCIvtni+z8KDNEo1Iz/VPU1JEoZivXQYI58MpJNO1MvOp/O9pvEQ1Ju8vu+
wcSj8sQi7Byb/oOYRB888rSGCVYahm98gWJPWNTkZ89LTncKpg3JmDdvmRE608yM
LwNEDlJzvY58/nf6vBxF
=c8w0
-----END PGP SIGNATURE-----

--jBjED8CkRcrKSUUCsBLAo659dSGfrJTIU--

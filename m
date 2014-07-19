Return-Path: <antonio@meshcoding.com>
Message-ID: <53CA3F31.1050906@meshcoding.com>
Date: Sat, 19 Jul 2014 11:49:37 +0200
From: Antonio Quartulli <antonio@meshcoding.com>
MIME-Version: 1.0
References: <1405410077-28764-1-git-send-email-martin@hundeboll.net>
 <1405410077-28764-12-git-send-email-martin@hundeboll.net>
In-Reply-To: <1405410077-28764-12-git-send-email-martin@hundeboll.net>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="g58WmV4fuUIfpmLb7lkokL0sj7GHdkFH5"
Subject: Re: [B.A.T.M.A.N.] [PATCHv2 12/13] batman-adv: kernel fixes for
	translation-table.c
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
--g58WmV4fuUIfpmLb7lkokL0sj7GHdkFH5
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable



On 15/07/14 09:41, Martin Hundeb=C3=B8ll wrote:
> Signed-off-by: Martin Hundeb=C3=B8ll <martin@hundeboll.net>

Acked-by: Antonio Quartulli <antonio@meshcoding.com>

>=20
> ---
> v2: better description for @bat_priv
>=20
>  translation-table.c | 12 +++++-------
>  1 file changed, 5 insertions(+), 7 deletions(-)
>=20
> diff --git a/translation-table.c b/translation-table.c
> index 5f59e7f..ca0206f 100644
> --- a/translation-table.c
> +++ b/translation-table.c
> @@ -195,7 +195,7 @@ batadv_tt_global_entry_free_ref(struct batadv_tt_gl=
obal_entry *tt_global_entry)
> =20
>  /**
>   * batadv_tt_global_hash_count - count the number of orig entries
> - * @hash: hash table containing the tt entries
> + * @bat_priv: the bat priv with all the soft interface information
>   * @addr: the mac address of the client to count entries for
>   * @vid: VLAN identifier
>   *
> @@ -280,7 +280,7 @@ static void batadv_tt_local_size_dec(struct batadv_=
priv *bat_priv,
>  /**
>   * batadv_tt_global_size_mod - change the size by v of the local table=

>   *  identified by vid
> - * @bat_priv: the bat priv with all the soft interface information
> + * @orig_node: orig_node to change table on
>   * @vid: the VLAN identifier
>   * @v: the amount to sum to the global table size
>   */
> @@ -691,7 +691,7 @@ out:
>   *  function reserves the amount of space needed to send the entire gl=
obal TT
>   *  table. In case of success the value is updated with the real amoun=
t of
>   *  reserved bytes
> -
> + *
>   * Allocate the needed amount of memory for the entire TT TVLV and wri=
te its
>   * header made up by one tvlv_tt_data object and a series of tvlv_tt_v=
lan_data
>   * objects, one per active VLAN served by the originator node.
> @@ -2339,7 +2339,6 @@ static void batadv_tt_tvlv_generate(struct batadv=
_priv *bat_priv,
>   * @orig_node: originator for which the CRCs have to be checked
>   * @tt_vlan: pointer to the first tvlv VLAN entry
>   * @num_vlan: number of tvlv VLAN entries
> - * @create: if true, create VLAN objects if not found
>   *
>   * Return true if all the received CRCs match the locally stored ones,=
 false
>   * otherwise
> @@ -3284,13 +3283,12 @@ out:
>   * batadv_tt_update_orig - update global translation table with new tt=

>   *  information received via ogms
>   * @bat_priv: the bat priv with all the soft interface information
> - * @orig: the orig_node of the ogm
> - * @tt_vlan: pointer to the first tvlv VLAN entry
> + * @orig_node: the orig_node of the ogm
> + * @tt_buff: pointer to the first tvlv VLAN entry
>   * @tt_num_vlan: number of tvlv VLAN entries
>   * @tt_change: pointer to the first entry in the TT buffer
>   * @tt_num_changes: number of tt changes inside the tt buffer
>   * @ttvn: translation table version number of this changeset
> - * @tt_crc: crc32 checksum of orig node's translation table
>   */
>  static void batadv_tt_update_orig(struct batadv_priv *bat_priv,
>  				  struct batadv_orig_node *orig_node,
>=20

--=20
Antonio Quartulli


--g58WmV4fuUIfpmLb7lkokL0sj7GHdkFH5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBCAAGBQJTyj81AAoJEJgn97Bh2u9ermoQAMHms4Toe2oQUeQiRurrAzhO
K6/XrGI2IgIHhYwl9kVVigweSFTG1QEB+IvzdIss3ZlJhJQpHXJ7GWqM3DlwBCUH
HfdKmVWPpRjt6SlSrse15NzAYBvS5DmeYJE4Q1K1sgZP57Ip3VNZkl3EbQKdWxdp
gvZA9X0653umeZZvJqLjFukJZl/NTb05AAqnUGNPsvnMn1sw+8mYZBP7DHN2d0rE
iFuXC1zgme+//tqDfo2HeUwBWm5iotgxngijo6AP8BbThHVKDfRluvNbsSyFh3Su
BZP4Ti83YOiJ34lC7aX6Oxt39p/bnlfoBh/maHzuCw0GCqsx1zpLs+WaTyiwCGru
+IK+bWOfV4RXF0YA3c1Ztjfr90uZ1PLLkhpUkM9Ng/B8EafhY7fQU0IF9sT/aLuK
/lFrbIdy1cQZp2PbgT4PSNluOc1u7IRJtTqkjM4sGc+vb1ME3MyjPiD/rqW3WPiO
Ia+9yJ5SYCuXBwlaAaP2dSHgMz3N0mjni0jbBsQ8iDUB0y/cbeDgc26JkR6erZ9N
TRh54GIzqBHWMXkcCBMKsOTlvNtu1z4Kq3eBtqeyj4ajgEq7szRwxYd+hQQbgF7f
7Ai7vU9dv8Wkym7fhE9EXekJCKqtDMDrUwBE6CnNnC/6NkL/a8ozLDXMtbXXcw1U
4Uo75Ui4UbZ76P0HUcTU
=xq4S
-----END PGP SIGNATURE-----

--g58WmV4fuUIfpmLb7lkokL0sj7GHdkFH5--

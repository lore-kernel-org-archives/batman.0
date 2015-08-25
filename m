Return-Path: <antonio@meshcoding.com>
References: <1440170118-10876-1-git-send-email-sw@simonwunderlich.de>
 <1440170118-10876-5-git-send-email-sw@simonwunderlich.de>
From: Antonio Quartulli <antonio@meshcoding.com>
Message-ID: <55DC3C65.3010903@meshcoding.com>
Date: Tue, 25 Aug 2015 11:59:01 +0200
MIME-Version: 1.0
In-Reply-To: <1440170118-10876-5-git-send-email-sw@simonwunderlich.de>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="qVtG2c5Hoae0Iiqmu6UjeIvIHwcg4pnI5"
Subject: Re: [B.A.T.M.A.N.] [PATCH-maint 4/4] batman-adv: detect local
 excess vlans in TT request
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: Simon Wunderlich <sw@simonwunderlich.de>
Cc: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>, alessandro@mediaspot.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--qVtG2c5Hoae0Iiqmu6UjeIvIHwcg4pnI5
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 21/08/15 17:15, Simon Wunderlich wrote:
> If the local representation of the global TT table of one originator ha=
s
> more VLAN entries than the respective TT update, there is some
> inconsistency present. By detecting and reporting this inconsistency,
> the global table gets updated and the excess VLAN will get removed in
> the process.
>=20
> Reported-by: Alessandro Bolletta <alessandro@mediaspot.net>
> Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
> ---
>  net/batman-adv/translation-table.c | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
>=20
> diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/transl=
ation-table.c
> index dced2da..1adb72e 100644
> --- a/net/batman-adv/translation-table.c
> +++ b/net/batman-adv/translation-table.c
> @@ -2392,6 +2392,7 @@ static bool batadv_tt_global_check_crc(struct bat=
adv_orig_node *orig_node,
>  	struct batadv_tvlv_tt_vlan_data *tt_vlan_tmp;
>  	struct batadv_orig_node_vlan *vlan;
>  	uint32_t crc;
> +	bool found;
>  	int i;
> =20
>  	/* check if each received CRC matches the locally stored one */
> @@ -2418,6 +2419,26 @@ static bool batadv_tt_global_check_crc(struct ba=
tadv_orig_node *orig_node,
>  			return false;
>  	}
> =20
> +	/* check if any excess VLANs exist locally for the originator
> +	 * which are not mentioned in the TVLV from the originator.
> +	 */
> +	rcu_read_lock();
> +	list_for_each_entry_rcu(vlan, &orig_node->vlan_list, list) {
> +		found =3D false;
> +
> +		for (i =3D 0; i < num_vlan; i++) {
> +			tt_vlan_tmp =3D tt_vlan + i;
> +			if (ntohs(tt_vlan_tmp->vid) =3D=3D vlan->vid) {
> +				found =3D true;
> +				break;
> +			}
> +		}
> +
> +		if (!found)
> +			return false;
> +	}
> +	rcu_read_unlock();
> +

NAK.

we already do this check slightly above in this function with the
following code:

2426                 vlan =3D batadv_orig_node_vlan_get(orig_node,
2427
ntohs(tt_vlan_tmp->vid));
2428                 if (!vlan)
2429                         return false;

batadv_orig_node_vlan_get() returns NULL if we don't know this VLAN for
that Originator, therefore the CRC check fails here.


Cheers,

>  	return true;
>  }
> =20
>=20

--=20
Antonio Quartulli


--qVtG2c5Hoae0Iiqmu6UjeIvIHwcg4pnI5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJV3DxpAAoJEOb/4TMchkvfzZwQAMiaw7fV749Rkf1uUKyEUXzF
attUAUH6SyHtyAHJdCLpVaY6DONkCobntjuI3SGQcTYXxQbBR5PeaxcByfwTQKoN
seWGLD/+ZJOYRmvA7KJTAC7VCwa4eNBRJPrXOQE6fxLNlfrzn/H4j+ZUrPNMmInH
HPZ+JokQ5FMoIAlGv1zSgsV+YkysnUJ5XLvyI8fD++GvL4qZ2DkbM0HgpfPiUSmw
uHDydRUkmJoE5I7bz5OoUtGdaCUjvWbUGoUqfdWu7p9BdnDtDGWJSGKL/6UUx03G
wFDaBhrs0/z7FF4b6JYicrP3xsDZRowqe4HDfGqVnsLQL8QdNqiff/8tbeuYAlcY
sCVbmPFVOcEIwbNJwkaFt3JIeqZSixt0pgM8OVDU8ykIP71xzu/lRp7DiSvCXmh9
G7fgzVNbc9cusFv/yv3OY1MtSWkp9ZWscHG+2qxgPMG1DH4ltJwyaKDUnz3/qD51
PbhsTqeYVnNTke8FS6zw1GTl2DcbYUsoXxSudofLciNPwjJPqqbVKRnYYtCpvtA2
eeLgF/Sg4WhIPkh2/VJK1AglSDhqArBqKNlsmgxykn37j970Atj8tlQdOV33NNpr
JMII0QNFDdzdQVlSsbteCgNQUq7EJD2zowhU8g19FXfRmZYdTSoS/hXwn2MWi9ma
ZHL/ZzeVvN1RhfmXDYZ1
=BJLZ
-----END PGP SIGNATURE-----

--qVtG2c5Hoae0Iiqmu6UjeIvIHwcg4pnI5--

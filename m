Return-Path: <antonio@open-mesh.com>
Message-ID: <52FC802B.3040200@open-mesh.com>
Date: Thu, 13 Feb 2014 09:19:55 +0100
From: Antonio Quartulli <antonio@open-mesh.com>
MIME-Version: 1.0
References: <1392122903-805-1-git-send-email-antonio@meshcoding.com>
 <1392122903-805-19-git-send-email-antonio@meshcoding.com>
 <52FC7FAC.60404@open-mesh.com>
In-Reply-To: <52FC7FAC.60404@open-mesh.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="ldPPUj2rKACv4ETmlMuFM1M90Mo3SERkx"
Subject: Re: [B.A.T.M.A.N.] [RFC 18/23] batman-adv: ELP - use phydev to
	determine link characteristics
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
To: "b.a.t.m.a.n@lists.open-mesh.org" <b.a.t.m.a.n@lists.open-mesh.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--ldPPUj2rKACv4ETmlMuFM1M90Mo3SERkx
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 13/02/14 09:17, Antonio Quartulli wrote:
> On 11/02/14 13:48, Antonio Quartulli wrote:
>> @@ -297,6 +299,7 @@ void batadv_update_min_mtu(struct net_device *soft=
_iface)
>>  static void
>>  batadv_hardif_activate_interface(struct batadv_hard_iface *hard_iface=
)
>>  {
>> +	struct net_device *dev =3D hard_iface->net_dev;
>>  	struct batadv_priv *bat_priv;
>>  	struct batadv_hard_iface *primary_if =3D NULL;
>> =20
>> @@ -315,6 +318,22 @@ batadv_hardif_activate_interface(struct batadv_ha=
rd_iface *hard_iface)
>>  	if (!primary_if)
>>  		batadv_primary_if_select(bat_priv, hard_iface);
>> =20
>> +	/* set the default values */
>> +	hard_iface->bat_v.flags &=3D ~BATADV_FULL_DUPLEX;
>> +	hard_iface->bat_v.eth_throughput =3D 0;
>> +	if (dev->phydev) {
>> +		if (dev->phydev->duplex =3D=3D DUPLEX_FULL)
>> +			hard_iface->bat_v.flags |=3D BATADV_FULL_DUPLEX;
>> +
>> +		/* set the speed according to the phydev setting. Store the
>> +		 * value in Kbps (as done for the other throughput variables)
>> +		 */

And of course this is not Kbps but Mbps/10 (like everywhere else)..


>> +		if (dev->phydev->speed !=3D SPEED_UNKNOWN) {
>> +			hard_iface->bat_v.eth_throughput =3D dev->phydev->speed;
>> +			hard_iface->bat_v.eth_throughput *=3D 10;
>> +		}
>> +	}
>> +
>=20
> For the record: I just moved this chunk into a proper
> bat_algo_ops->bat_iface_activate() API.
>=20
> This initialisation is obviously B.A.T.M.A.N. V specific and cannot liv=
e
> in the batadv_hardif_activate_interface() function.
>=20
>=20
> Cheers,
>=20
>=20


--=20
Antonio Quartulli


--ldPPUj2rKACv4ETmlMuFM1M90Mo3SERkx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBCAAGBQJS/IAuAAoJEEKTMo6mOh1V1o8P/3kmliOFJ3MLGkOeKtABZNah
0eUdIbeekokDD8HCkUtTDjrosrmA+8jahzUMcGtJa2HxXfODQXcDcgdzrIZ9sDOD
XNaB2pmWE9ngKgJVBJAH/ORS5j/5iHZq9jlxd+CH5xgAanZna8k4Fo1uIFyf6ShU
375tzPtbnI0UvCk8vQ+nM7aGxE29g2Nm3DT7OVfOkVLFJdHlcHwigvmwE0d1TjAF
IClL36sTM6ZApOudbw6uubveuVzS725Nw4N9JJYkQsWR7y1D1iAyIrRYklBvRWkL
2sOTO6K4qmjcMx37Ow9t/3ix0fb22J5Ku84vuUk6COtpW5an/lBNF5B4garqE8HA
M4+DtSDwIpuVmD6bis5VwyjB0CXfqh3vNfV9FoE106u2/HhlnbT7HeP4sBUmWIhG
Fm5pfjT+pVXlGZS6iNiGn3dulz1rZdirz5wxrfKIGVbK01kuhBwzhtArSY5GyGyV
2pl4H6q9lS4yGrdU8Fb9rbZM99LlDCkj+h+gmfCsl3JYR6/v3yMDm5QejVhqeEbP
NO7Xa3c2X29jZcIyFNI8JNHDxFf5xeOeYa1SSldpfpYHbOIc1qO1ZtgvqSolVW10
o4ZMFuni746AYGVZdeIRa2K6YcOjTxnd5dkDOOJbDGXj4FMoC35kClhLzauKDW1v
7bplqJ3d1rYjQWmnjb5x
=+q0F
-----END PGP SIGNATURE-----

--ldPPUj2rKACv4ETmlMuFM1M90Mo3SERkx--

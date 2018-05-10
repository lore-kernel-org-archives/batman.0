Return-Path: <a@unstable.cc>
References: <20180510152752.2557-1-mareklindner@neomailbox.ch>
 <6716451.vJRGfGX9qT@sven-edge>
From: Antonio Quartulli <a@unstable.cc>
Message-ID: <f106bf7d-1378-36ac-b415-60535c0d648e@unstable.cc>
Date: Fri, 11 May 2018 00:24:50 +0800
MIME-Version: 1.0
In-Reply-To: <6716451.vJRGfGX9qT@sven-edge>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="ZhbbIuwlL2cYI33V1nUukDC4YpDqS4gjM"
Subject: Re: [B.A.T.M.A.N.] [RFC maint] batman-adv: fix adding VLANs with
 partial state
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>, Sven Eckelmann <sven@narfation.org>
Cc: Marek Lindner <mareklindner@neomailbox.ch>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--ZhbbIuwlL2cYI33V1nUukDC4YpDqS4gjM
Content-Type: multipart/mixed; boundary="cbWIKwQDBmPaIUM0HKHqgBwhyzKU1r6dE";
 protected-headers="v1"
From: Antonio Quartulli <a@unstable.cc>
To: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n@lists.open-mesh.org>, Sven Eckelmann <sven@narfation.org>
Cc: Marek Lindner <mareklindner@neomailbox.ch>
Message-ID: <f106bf7d-1378-36ac-b415-60535c0d648e@unstable.cc>
Subject: Re: [B.A.T.M.A.N.] [RFC maint] batman-adv: fix adding VLANs with
 partial state
References: <20180510152752.2557-1-mareklindner@neomailbox.ch>
 <6716451.vJRGfGX9qT@sven-edge>
In-Reply-To: <6716451.vJRGfGX9qT@sven-edge>

--cbWIKwQDBmPaIUM0HKHqgBwhyzKU1r6dE
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 11/05/18 00:11, Sven Eckelmann wrote:
[...]
>> @@ -683,9 +690,14 @@ static int batadv_interface_add_vid(struct net_de=
vice=20
> *dev, __be16 proto,
>>  	 * flag. This must be added again, even if the vlan object already
>>  	 * exists, because the entry was deleted by kill_vid()
>>  	 */
>> -	batadv_tt_local_add(bat_priv->soft_iface,
>> -			    bat_priv->soft_iface->dev_addr, vid,
>> -			    BATADV_NULL_IFINDEX, BATADV_NO_MARK);
>> +	client_added =3D batadv_tt_local_add(bat_priv->soft_iface,
>> +					   bat_priv->soft_iface->dev_addr, vid,
>> +					   BATADV_NULL_IFINDEX, BATADV_NO_MARK);
>> +
>> +	if (!client_added) {
>> +		batadv_softif_destroy_vlan(bat_priv, vlan);
>> +		return -ENOENT;
>> +	}
>=20
> This looks quite fragile to me. Wouldn't that mean that the vlan would =
also=20
> not be created later? When I remember it correctly, then=20
> batadv_interface_add_vid is the only one which would create the interna=
l vlan=20
> entries in the first place (beside this odd call in batadv_hard_if_even=
t). The=20
> VLAN functionality would therefore be completely broken when such a pro=
blem=20
> happens.
>=20
> 1. batadv_interface_add_vid is called
> 2. vlan is added
> 3. local entry is not added for this vlan
> 3.1. vlan is removed again
> 4. node tries to communicate over this vlan

A failure of this function will cause a failure of the
ndo_vlan_rx_add_vid() call made by the kernel/netlink API which in turns
will reach the userspace.

Ideally any userspace application that attempted to create the VLAN
should be in charge of re-attempting the creation again (I believe).

About your point 4, this should not be possible, because in case of
error the bat0.X interface won't be created by the kernel at all. no?


>=20
> Btw. it is really odd to see code shared between batadv_interface_add_v=
id and=20
> batadv_softif_create_vlan. Especially because batadv_interface_add_vid =
calls=20
> batadv_softif_create_vlan.

This can probably be re-arranged a bit in the master branch.


Cheers,

--=20
Antonio Quartulli


--cbWIKwQDBmPaIUM0HKHqgBwhyzKU1r6dE--

--ZhbbIuwlL2cYI33V1nUukDC4YpDqS4gjM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEERdCuyFSHc3WdqS4EB6U8WA7yzXQFAlr0clIACgkQB6U8WA7y
zXScWw//Q3qNeLCYH6wNiPinV/BRHENEQgKhKVbIZKrmOpjgqicRzR8Wu/hO5wkj
RwK/gNV2iR3eN7jPfZAuSSgapm3DXzJmm4v7MAclVYSHI+xj3kcdj/+wtmGGKMHn
9tPIvah/k/swXetU4c+2EFTDBjZbiAZVuvLarQZPtm1pAooB2pRZcO2COFLgGhwV
anoAQ1QqOfbr1js/IkVWwxvbYfuY0yW3NKRFiFmoPErCoBXT0Y9o6p13BHdt6h69
Zf8vmjAhzfpfK2IAx0kxQ0v+yS0QAmVkNKzogfsDh0ljfRWg1pbpS5IB6XFfzgAw
9UcEpukSszpdQgP4q+ZcYmUjrpjA7mRvetUhUqZB2+AeZIWx0R2Uw8+oicQp1c73
10Zw1BVeNm8TI7EiuMranpGNQxT9UemWElXlEOwkYXmx1ROGgM85r+NZ6frUzs8h
ECq1HI8c3QYeBhFVkgYycAYq8XRHSmuMwXw2uDWHSxFVOErzZj78wtTk492eKL/n
QOfmDRNbAlHx14ZZy+b22P3oid/XlsPxImfScWP8qn7U0Sn3JxSeEEotWkOoK77p
VAclFhh0oHRY/ZfPQdQTmkGftJgNc6LWHL6EC1Jf/mYxPym1D/CydhdJXkgWKdx5
VPco4QAU3CKeI2em2dsTyzpjqnIh2cC7Tdgcfn2cnCiXoWdreC4=
=hWzs
-----END PGP SIGNATURE-----

--ZhbbIuwlL2cYI33V1nUukDC4YpDqS4gjM--

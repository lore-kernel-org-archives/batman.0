Return-Path: <David.Laight@ACULAB.COM>
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 9 Oct 2013 15:11:08 +0100
Message-ID: <AE90C24D6B3A694183C094C60CF0A2F6026B7384@saturn3.aculab.com>
In-Reply-To: <1381322418-1349-11-git-send-email-antonio@meshcoding.com>
References: <1381322418-1349-1-git-send-email-antonio@meshcoding.com>
 <1381322418-1349-11-git-send-email-antonio@meshcoding.com>
From: "David Laight" <David.Laight@ACULAB.COM>
Subject: Re: [B.A.T.M.A.N.] [PATCH 10/16] batman-adv: use CRC32C instead of
	CRC16 in TT code
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
To: Antonio Quartulli <antonio@meshcoding.com>, davem@davemloft.net
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org, Marek Lindner <lindner_marek@yahoo.de>, Antonio Quartulli <ordex@autistici.org>

> CRC32C has to be preferred to CRC16 because of its possible
> HW native support and because of the reduced collision
> probability. With this change the Translation Table
> component now uses CRC32C to compute the local and global
> table checksum.
...
> -/* Calculates the checksum of the local table of a given orig_node */
> -static uint16_t batadv_tt_global_crc(struct batadv_priv *bat_priv,
> +/**
> + * batadv_tt_global_crc - calculates the checksum of the local table =
belonging
> + *  to the given orig_node
> + * @bat_priv: the bat priv with all the soft interface information
> + */
> +static uint32_t batadv_tt_global_crc(struct batadv_priv *bat_priv,
>  				     struct batadv_orig_node *orig_node)
...
>  	for (i =3D 0; i < hash->size; i++) {
>  		head =3D &hash->table[i];
> @@ -1435,27 +1437,24 @@ static uint16_t batadv_tt_global_crc(struct =
batadv_priv *bat_priv,
>  							     orig_node))
>  				continue;
>=20
...
> +			crc ^=3D crc32c(0, tt_common->addr, ETH_ALEN);
>  		}

Are you really generating CRC32 of a pile of ethernet MAC addresses
and the XORing the CRC together?
That gives the same answer as XORing together the MAC addresses and
then doing a CRC of the final value.
So it gives you almost no protection against corruption at all.

...
> -/* Calculates the checksum of the local table */
> -static uint16_t batadv_tt_local_crc(struct batadv_priv *bat_priv)
> +/**
> + * batadv_tt_local_crc - calculates the checksum of the local table
> + * @bat_priv: the bat priv with all the soft interface information
> + */
> +static uint32_t batadv_tt_local_crc(struct batadv_priv *bat_priv)
>  {
...

This looks like a clone of the previous routine.
Surely you can avoid the code duplication.

	David





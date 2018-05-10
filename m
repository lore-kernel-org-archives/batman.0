Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Thu, 10 May 2018 18:11:35 +0200
Message-ID: <6716451.vJRGfGX9qT@sven-edge>
In-Reply-To: <20180510152752.2557-1-mareklindner@neomailbox.ch>
References: <20180510152752.2557-1-mareklindner@neomailbox.ch>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2778062.ivOHZ39yz5";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
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
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Marek Lindner <mareklindner@neomailbox.ch>

--nextPart2778062.ivOHZ39yz5
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Donnerstag, 10. Mai 2018 17:27:52 CEST Marek Lindner wrote:
> Whenever a new VLAN is created on top of batman virtual interfaces
> the batman-adv kernel module creates internal structures to track
> the status of said VLAN. Amongst other things, the MAC address of
> the VLAN interface itself has to be stored.
> 
> Without this change a VLAN and its infrastructure could be created
> while the interface MAC address is not stored without triggering
> any error, thus creating issues in other parts of the code.
> 
> Prevent the VLAN from being created if the MAC address can not
> be stored.
> 
> Signed-off-by: Marek Lindner <mareklindner@neomailbox.ch>

Fixes: 952cebb57518 ("batman-adv: add per VLAN interface attribute framework")

??

[....]
> @@ -604,13 +605,18 @@ int batadv_softif_create_vlan(struct batadv_priv 
*bat_priv, unsigned short vid)
>  	/* add a new TT local entry. This one will be marked with the NOPURGE
>  	 * flag
>  	 */
> -	batadv_tt_local_add(bat_priv->soft_iface,
> -			    bat_priv->soft_iface->dev_addr, vid,
> -			    BATADV_NULL_IFINDEX, BATADV_NO_MARK);
> +	client_added = batadv_tt_local_add(bat_priv->soft_iface,
> +					   bat_priv->soft_iface->dev_addr, vid,
> +					   BATADV_NULL_IFINDEX, BATADV_NO_MARK);
>  
>  	/* don't return reference to new softif_vlan */
>  	batadv_softif_vlan_put(vlan);
>  
> +	if (!client_added) {
> +		batadv_softif_destroy_vlan(bat_priv, vlan);
> +		return -ENOENT;
> +	}
> +

This function (batadv_softif_destroy_vlan) is static and cannot be reached 
from here. The definition+declaration of this function follows the function
were you've added these changes.

[...]
> @@ -683,9 +690,14 @@ static int batadv_interface_add_vid(struct net_device 
*dev, __be16 proto,
>  	 * flag. This must be added again, even if the vlan object already
>  	 * exists, because the entry was deleted by kill_vid()
>  	 */
> -	batadv_tt_local_add(bat_priv->soft_iface,
> -			    bat_priv->soft_iface->dev_addr, vid,
> -			    BATADV_NULL_IFINDEX, BATADV_NO_MARK);
> +	client_added = batadv_tt_local_add(bat_priv->soft_iface,
> +					   bat_priv->soft_iface->dev_addr, vid,
> +					   BATADV_NULL_IFINDEX, BATADV_NO_MARK);
> +
> +	if (!client_added) {
> +		batadv_softif_destroy_vlan(bat_priv, vlan);
> +		return -ENOENT;
> +	}

This looks quite fragile to me. Wouldn't that mean that the vlan would also 
not be created later? When I remember it correctly, then 
batadv_interface_add_vid is the only one which would create the internal vlan 
entries in the first place (beside this odd call in batadv_hard_if_event). The 
VLAN functionality would therefore be completely broken when such a problem 
happens.

1. batadv_interface_add_vid is called
2. vlan is added
3. local entry is not added for this vlan
3.1. vlan is removed again
4. node tries to communicate over this vlan

Btw. it is really odd to see code shared between batadv_interface_add_vid and 
batadv_softif_create_vlan. Especially because batadv_interface_add_vid calls 
batadv_softif_create_vlan.

Kind regards,
	Sven
--nextPart2778062.ivOHZ39yz5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAlr0bzcACgkQXYcKB8Em
e0ZcoxAAqSq7oPNNmYO7MltscPU2JfH62oQVuWDPNFr/dfcu1Cwa7hREieK3WS18
ZQPm1wO49s+W4jgxN9DlGyRrUB1D5pEZ8zojTRsQqrRMjqwPC3wPIeH2buJ0QrYz
WZbBSIS5RqXH40K+9L3ZwRZWl74fR3nCimHY80LlNskNFeGGCKDNurgjiNiRld2p
RU/3Kong8OmiqQaql9ujIg9b5En4/5G8IlcC4m+OOkPrxRASewueYz9qopdJNR0E
S+ja2QftKmgUNo9R7ZeMuF3/yOTTFEChVOsCgod5nedojHgmwpbqs/pXO1alew4b
CEp9HaZ5rLOtribXK2Fk2/dtkQdPQ9JQqcuE31Elo3JCOKx5QZprBDlkt9obuEMI
KMr8L6K9461kUa7zLzrJHStl0uQyMoikQYpXDnwTp0w8pQHbuXC0fuKeQ53edpdt
ECIEpnygQRjldt0Xneq0x7P3rgtksxiGBQBZgDJa9z7s2xUDSo3Wikus3YV+T0z5
s9DbhvaKgSZke44BI6Uh6YPD1r/zqZiwJ6HFmvU3HoinyrG63phRg0Sj8d4QiInH
M/gPikcyAAAAM2tUt9uoQlrIbOS7BwbEZ1kHhZbDl2TlTB6ni5A2vMRsuo8tCsST
6FCnh5HF+V7dYsjZJ74CCmEKDTUBngngye9H6deqMVhGh36mWdI=
=DraD
-----END PGP SIGNATURE-----

--nextPart2778062.ivOHZ39yz5--




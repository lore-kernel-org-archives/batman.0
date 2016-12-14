Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Wed, 14 Dec 2016 15:49:32 +0100
Message-ID: <1682263.buGhbnabNv@bentobox>
In-Reply-To: <20161006064142.20003-1-linus.luessing@c0d3.blue>
References: <20161006064142.20003-1-linus.luessing@c0d3.blue>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1820370.L4I8UOgp2X";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH v2 0/4] Broadcast Avoidances,
	Neighborhood Hash
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

--nextPart1820370.L4I8UOgp2X
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

On Donnerstag, 6. Oktober 2016 08:41:37 CET Linus L=FCssing wrote:
> Hi,
>=20
> Here's the second broadcast avoidance patchset (rebased on the former one=
).
>=20
> Hopefully, those two patchsets together should be an automatic
> approach and replacement for the (non-upstream) no-rebroadcast flag
> patch and the cases it is currently used for.

All patches had conflicts when I tried to apply them. Please check if the b=
ranch ecsv/pu [1] solved the conflicts correctly.

Here are the conflicts (according to rerere diff):

Patch 1
=3D=3D=3D=3D=3D=3D=3D

    --- a/net/batman-adv/originator.c
    +++ b/net/batman-adv/originator.c
    @@ -559,11 +559,8 @@
     			   struct batadv_orig_node *orig_node)
     {
     	struct batadv_priv *bat_priv =3D netdev_priv(hard_iface->soft_iface);
    -<<<<<<<
    -	struct batadv_hardif_neigh_node *hardif_neigh =3D NULL, *pre_neigh;
    -=3D=3D=3D=3D=3D=3D=3D
     	struct batadv_hardif_neigh_node *hardif_neigh;
    ->>>>>>>
    +	struct batadv_hardif_neigh_node *pre_neigh;
    =20
     	spin_lock_bh(&hard_iface->neigh_list_lock);
=20


Patch 2
=3D=3D=3D=3D=3D=3D=3D

    --- a/net/batman-adv/Kconfig
    +++ b/net/batman-adv/Kconfig
    @@ -17,12 +17,8 @@
    =20
     config BATMAN_ADV_BATMAN_V
     	bool "B.A.T.M.A.N. V protocol (experimental)"
    -<<<<<<<
     	depends on BATMAN_ADV && !(CFG80211=3Dm && BATMAN_ADV=3Dy)
    -=3D=3D=3D=3D=3D=3D=3D
    -	depends on BATMAN_ADV && CFG80211=3Dy || (CFG80211=3Dm && BATMAN_ADV=
=3Dm)
     	select CRYPTO_SHA512
    ->>>>>>>
     	default n
     	help
     	  This option enables the B.A.T.M.A.N. V protocol, the successor



Patch 3
=3D=3D=3D=3D=3D=3D=3D

    --- a/net/batman-adv/bat_iv_ogm.c
    +++ b/net/batman-adv/bat_iv_ogm.c
    @@ -1852,22 +1852,17 @@
     		skb_set_network_header(skb, ogm_offset);
     	}
    =20
    -<<<<<<<
     	ret =3D NET_RX_SUCCESS;
    =20
     free_skb:
    +	skb_reset_network_header(skb);
    +
     	if (ret =3D=3D NET_RX_SUCCESS)
     		consume_skb(skb);
     	else
     		kfree_skb(skb);
    =20
     	return ret;
    -=3D=3D=3D=3D=3D=3D=3D
    -	skb_reset_network_header(skb);
    -
    -	kfree_skb(skb);
    -	return NET_RX_SUCCESS;
    ->>>>>>>
     }
    =20
     #ifdef CONFIG_BATMAN_ADV_DEBUGFS
    --- a/net/batman-adv/multicast.c
    +++ b/net/batman-adv/multicast.c
    @@ -1173,21 +1173,15 @@
      */
     void batadv_mcast_init(struct batadv_priv *bat_priv)
     {
    -<<<<<<<
    -	batadv_tvlv_handler_register(bat_priv, batadv_mcast_tvlv_ogm_handler,
    -				     NULL, BATADV_TVLV_MCAST, 2,
    -				     BATADV_TVLV_HANDLER_OGM_CIFNOTFND);
    -
    -	INIT_DELAYED_WORK(&bat_priv->mcast.work, batadv_mcast_mla_update);
    -	batadv_mcast_start_timer(bat_priv);
    -=3D=3D=3D=3D=3D=3D=3D
     	batadv_tvlv_handler_register2(bat_priv, batadv_mcast_tvlv_ogm_handler,
     				      BATADV_IV_OGM, BATADV_TVLV_MCAST, 2,
     				      BATADV_TVLV_HANDLER_CIFNOTFND);
     	batadv_tvlv_handler_register2(bat_priv, batadv_mcast_tvlv_ogm_handler,
     				      BATADV_OGM2, BATADV_TVLV_MCAST, 2,
     				      BATADV_TVLV_HANDLER_CIFNOTFND);
    ->>>>>>>
    +
    +	INIT_DELAYED_WORK(&bat_priv->mcast.work, batadv_mcast_mla_update);
    +	batadv_mcast_start_timer(bat_priv);
     }
    =20
     #ifdef CONFIG_BATMAN_ADV_DEBUGFS



Patch 4
=3D=3D=3D=3D=3D=3D=3D

    --- a/net/batman-adv/send.c
    +++ b/net/batman-adv/send.c
    @@ -797,11 +797,6 @@
     	unsigned long send_time =3D jiffies + msecs_to_jiffies(5);
     	bool dropped =3D false;
     	u8 *neigh_addr;
    -<<<<<<<
    -	u8 *orig_neigh;
    -=3D=3D=3D=3D=3D=3D=3D
    -	unsigned long send_time =3D jiffies + msecs_to_jiffies(5);
    ->>>>>>>
     	int ret =3D 0;
    =20
     	delayed_work =3D to_delayed_work(work);



Kind regards,
	Sven

[1] https://git.open-mesh.org/batman-adv.git/shortlog/refs/heads/ecsv/pu

--nextPart1820370.L4I8UOgp2X
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAlhRW/wACgkQXYcKB8Em
e0YCQw//VwqZ2ljUAO6q/6sCL614Gv5CZ/xgKPc7bpuI7513YgV1TAwuHCk5ivJm
dQPFXK+HxgOIaxp/2D13s1CT94F+oLSAnIq83d9OnIKAMEL/T+xdT/vlgutpVW1a
B2Y7C7BmhA6J1FeKNHKEiNLhZOjYACVtFiQaBYIYLz7Ic8uJlvCaPsR3kAFt9L13
VCtIMbChZQV0C0cycTYZ+ACankGFftAPgl7GVeLW4JkRAOrFWD0rosQCZI6tAJ1J
WI6j3Uq8brrTP5gp1m+15utDuMfeod9Zni/zx8xQlIS9wUjjNs19dUszPNedeok+
BnoRMNx1tHmhqgleE39YpbWzqbAc+0X+8LBpa7e3JT0oMRBba2v5RLQnPteDSZHH
Z0A17X6+7k0ag38JkU7eMAluVGfR7eQAcGeP3Slef+5rPGN0XItiJ2kvvLPtVz9J
eaM+X7LaC3aYjds6Pa+uCU3leD71GwH9tDM5kp9E1kabw9I48Ti18U02xZU6CeN/
iEpRStBa/mahckDg/iXaU7JRbt08Toqc+QZUIspKszjHobelq7YHMbeZzMTPPcr4
rMvT++Qpp3iHy46PITTXWBQDhTII1K2UzlGtNm7BsxRg7XJ/8JHVXTyLFZyVHa29
uo1T7xuiOJtYyJIQCnGcm8Q+OHyLVlQBgkGQDXKYMsSbxsIO/T0=
=31hr
-----END PGP SIGNATURE-----

--nextPart1820370.L4I8UOgp2X--


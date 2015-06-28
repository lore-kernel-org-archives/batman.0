Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Sun, 28 Jun 2015 09:37:20 +0800
Message-ID: <2472003.5ybaWVxMcq@voltaire>
In-Reply-To: <1434893777-17618-2-git-send-email-linus.luessing@c0d3.blue>
References: <1434893777-17618-1-git-send-email-linus.luessing@c0d3.blue>
 <1434893777-17618-2-git-send-email-linus.luessing@c0d3.blue>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart4646826.eGfNVXQpPi";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH 1/1] batman-adv: Always flood IGMP/MLD
	reports
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


--nextPart4646826.eGfNVXQpPi
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

On Sunday, June 21, 2015 15:36:17 Linus L=FCssing wrote:
> With this patch IGMP or MLD reports are always flooded. This is
> necessary for the upcoming bridge integration:
>=20
> An IGMPv2/MLDv1 querier does not actively join the multicast group th=
e
> reports are sent to. Because of this, this would lead to snooping
> bridges/switches not being able to learn of multicast listeners in th=
e
> mesh and wrongly shutting down ports for multicast traffic to the mes=
h,
> leading to packet loss.

I am not quite clear on what the patch does. It helps to support a feat=
ure=20
that is yet to come (upcoming bridge integration) or improves the situa=
tion=20
today ?


>  /**
>   * batadv_mcast_forw_mode_check - check for optimized forwarding pot=
ential
> @@ -376,9 +434,11 @@ static int batadv_mcast_forw_mode_check(struct
> batadv_priv *bat_priv, case ETH_P_IP:
>  =09=09return batadv_mcast_forw_mode_check_ipv4(bat_priv, skb,
>  =09=09=09=09=09=09=09 is_unsnoopable);
> +#if IS_ENABLED(CONFIG_IPV6)
>  =09case ETH_P_IPV6:
>  =09=09return batadv_mcast_forw_mode_check_ipv6(bat_priv, skb,
>  =09=09=09=09=09=09=09 is_unsnoopable);
> +#endif
>  =09default:
>  =09=09return -EINVAL;
>  =09}

This hunk seems not really related to the patch itself ?


>  /**
> - * batadv_mcast_tvlv_ogm_handler_v1 - process incoming multicast tvl=
v
> container + * batadv_mcast_tvlv_ogm_handler_v2 - process incoming mul=
ticast
> tvlv container * @bat_priv: the bat priv with all the soft interface
> information * @orig: the orig_node of the ogm
>   * @flags: flags indicating the tvlv state (see batadv_tvlv_handler_=
flags)
>   * @tvlv_value: tvlv buffer containing the multicast data
>   * @tvlv_value_len: tvlv buffer length
>   */
> -static void batadv_mcast_tvlv_ogm_handler_v1(struct batadv_priv *bat=
_priv,
> +static void batadv_mcast_tvlv_ogm_handler_v2(struct batadv_priv *bat=
_priv,
>  =09=09=09=09=09     struct batadv_orig_node *orig,
>  =09=09=09=09=09     u8 flags,
>  =09=09=09=09=09     void *tvlv_value,

By removing mcast v1 you effectively are breaking compatibility with al=
l nodes=20
running v1 and require everyone to upgrade to v2. Is there a good reaso=
n for=20
that ? The multicast optimizations can't easily work with v1 and v2 ?

By reading your patch it does not become clear why v2 is needed in the =
first=20
place. The tvlv's content seems to be identical ?


> @@ -206,6 +206,8 @@ static int batadv_interface_tx(struct sk_buff *sk=
b,
>  =09if (atomic_read(&bat_priv->mesh_state) !=3D BATADV_MESH_ACTIVE)
>  =09=09goto dropped;
>=20
> +=09skb_set_network_header(skb, ETH_HLEN);
> +
>  =09soft_iface->trans_start =3D jiffies;
>  =09vid =3D batadv_get_vid(skb, 0);
>  =09ethhdr =3D eth_hdr(skb);

Why is this change part of the patch ?

Cheers,
Marek


--nextPart4646826.eGfNVXQpPi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJVj0/bAAoJEFNVTo/uthzA8qMH/25CzrQW36iAWqEEXeu1VTu0
2NJQgXvID+NdcVhqN62UE8nFjqvOR1HN//19qFw/FEOOb6FMqe6w/Sop7ImrSnYp
i5m9Tb0n24Pj92YaSxW7Zq12y0auPG2YwF1Hm/sFa4Y4VWLn31ZioRr06F0sPKc4
JduBMUsHW+fTOEB2t5YcBVfBeqzL7LXaO73LQdF2LV/XcR7gCJpxpfZxJ5wJeaq1
51EeWHqno9cptzQRFBMYpoCUh/o5QDFMGvoPI9vRkpw9cSZFhzElrv+Sfo+OBL6P
XWponATWEHgghP2O5T9w5fm4WTZEYA09DVt7K/3ELIGFGjUb5pNenw/QZyf+cl4=
=iQjP
-----END PGP SIGNATURE-----

--nextPart4646826.eGfNVXQpPi--


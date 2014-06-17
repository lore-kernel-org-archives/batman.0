Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Tue, 17 Jun 2014 22:50:34 +0800
Message-ID: <1982917.uLe1stfMfi@diderot>
In-Reply-To: <1402531227-15447-1-git-send-email-linus.luessing@web.de>
References: <1402531227-15447-1-git-send-email-linus.luessing@web.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart29863806.xnYg52WWAz";
 micalg="pgp-sha1"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: Add multicast optimization
	support for bridged setups
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


--nextPart29863806.xnYg52WWAz
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

On Thursday 12 June 2014 02:00:27 Linus L=FCssing wrote:
> @@ -30,17 +53,21 @@
>   * Collect multicast addresses of the local multicast listeners
>   * on the given soft interface, dev, in the given mcast_list.
>   *
> + * If there is a bridge interface on top of dev, collect from that o=
ne
> + * instead.
> + *
>   * Returns -ENOMEM on memory allocation error or the number of
>   * items added to the mcast_list otherwise.
>   */
>  static int batadv_mcast_mla_softif_get(struct net_device *dev,
>  =09=09=09=09       struct hlist_head *mcast_list)
>  {
> +=09struct net_device *bridge =3D batadv_mcast_get_bridge(dev);
>  =09struct netdev_hw_addr *mc_list_entry;
>  =09struct batadv_hw_addr *new;
>  =09int ret =3D 0;
>=20
> -=09netif_addr_lock_bh(dev);
> +=09netif_addr_lock_bh(bridge ? bridge : dev);
>  =09netdev_for_each_mc_addr(mc_list_entry, dev) {
>  =09=09new =3D kmalloc(sizeof(*new), GFP_ATOMIC);
>  =09=09if (!new) {

Maybe I am missing something but shouldn't we fetch the entries from th=
e=20
bridge interface instead of dev ?


>  /**
> + * batadv_mcast_mla_br_addr_cpy - copy a bridge multicast address
> + * @dst: destination to write to - a multicast MAC address
> + * @src: source to read from - a multicast IP address
> + *
> + * Converts a given multicast IPv4/IPv6 address from a bridge
> + * to its matching multicast MAC address and copies it into the give=
n
> + * destination buffer.
> + *
> + * Caller needs to make sure the destination buffer can hold
> + * at least ETH_ALEN bytes.
> + */
> +static void batadv_mcast_mla_br_addr_cpy(char *dst, const struct br_=
ip
> *src) +{
> +=09if (src->proto =3D=3D htons(ETH_P_IP)) {
> +=09=09/* RFC 1112 */
> +=09=09memcpy(dst, "\x01\x00\x5e", 3);
> +=09=09memcpy(dst + 3, ((char *)&src->u.ip4) + 1, ETH_ALEN - 3);
> +=09=09dst[3] &=3D 0x7F;
> +=09}
> +#if IS_ENABLED(CONFIG_IPV6)
> +=09else if (src->proto =3D=3D htons(ETH_P_IPV6)) {
> +=09=09/* RFC 2464 */
> +=09=09memcpy(dst, "\x33\x33", 2);
> +=09=09memcpy(dst + 2, &src->u.ip6.s6_addr32[3],
> +=09=09       sizeof(src->u.ip6.s6_addr32[3]));
> +=09}
> +#endif
> +=09else
> +=09=09memset(dst, 0, ETH_ALEN);
> +}

Is there no cleaner way to do this ? "\x01\x00\x5e" and "\x33\x33" look=
s=20
pretty hackish. Are there no defines for mcast prefixes somewhere ?


> +/**
> + * batadv_mcast_mla_bridge_get - get bridged-in multicast listeners
> + * @dev: a bridge slave whose bridge to collect multicast addresses =
from
> + * @mcast_list: a list to put found addresses into
> + *
> + * Collects multicast addresses of the bridged-in multicast listener=
s
> + * from the bridge on top of the given soft interface, dev, in the
> + * given mcast_list.
> + *
> + * Returns -ENOMEM on memory allocation error or the number of
> + * items added to the mcast_list otherwise.
> + */
> +static int batadv_mcast_mla_bridge_get(struct net_device *dev,
> +=09=09=09=09       struct hlist_head *mcast_list)
> +{

That is probably where my confusion is coming from. Why do we query the=
 bridge=20
interface again ?


> @@ -195,19 +306,18 @@ static bool batadv_mcast_mla_tvlv_update(struct=

> batadv_priv *bat_priv) mcast_data.flags =3D BATADV_NO_FLAGS;
>  =09memset(mcast_data.reserved, 0, sizeof(mcast_data.reserved));
>=20
> -=09/* Avoid attaching MLAs, if there is a bridge on top of our soft
> -=09 * interface, we don't support that yet (TODO)
> -=09 */
> -=09if (batadv_mcast_has_bridge(bat_priv)) {
> -=09=09if (bat_priv->mcast.enabled) {
> -=09=09=09batadv_tvlv_container_unregister(bat_priv,
> -=09=09=09=09=09=09=09 BATADV_TVLV_MCAST, 1);
> -=09=09=09bat_priv->mcast.enabled =3D false;
> -=09=09}
> +=09if (!batadv_mcast_has_bridge(bat_priv))
> +=09=09goto skip;
>=20
> -=09=09return false;
> -=09}
> +=09mcast_data.flags |=3D BATADV_MCAST_WANT_ALL_UNSNOOPABLES;
> +
> +=09if (br_multicast_has_querier_adjacent(bat_priv->soft_iface, ETH_P=
_IP))
> +=09=09mcast_data.flags |=3D BATADV_MCAST_WANT_ALL_IPV4;
>=20
> +=09if (br_multicast_has_querier_adjacent(bat_priv->soft_iface, ETH_P=
_IPV6))
> +=09=09mcast_data.flags |=3D BATADV_MCAST_WANT_ALL_IPV6;
> +
> +skip:
>  =09if (!bat_priv->mcast.enabled ||
>  =09    mcast_data.flags !=3D bat_priv->mcast.flags) {
>  =09=09batadv_tvlv_container_register(bat_priv, BATADV_TVLV_MCAST, 1,=


Please find a more intuitive goto label ('skip' is quite generic).


> @@ -233,13 +344,17 @@ void batadv_mcast_mla_update(struct batadv_priv=

> *bat_priv) int ret;
>=20
>  =09if (!batadv_mcast_mla_tvlv_update(bat_priv))
> -=09=09goto update;
> +=09=09goto skip;
>=20
>  =09ret =3D batadv_mcast_mla_softif_get(soft_iface, &mcast_list);
>  =09if (ret < 0)
>  =09=09goto out;
>=20
> -update:
> +=09ret =3D batadv_mcast_mla_bridge_get(soft_iface, &mcast_list);
> +=09if (ret < 0)
> +=09=09goto out;
> +
> +skip:
>  =09batadv_mcast_mla_tt_retract(bat_priv, &mcast_list);
>  =09batadv_mcast_mla_tt_add(bat_priv, &mcast_list);

Again, 'skip' isn't very self-explanatory.

Cheers,
Marek


--nextPart29863806.xnYg52WWAz
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABAgAGBQJToFW+AAoJEFNVTo/uthzATccIAMRek5Y+WJSgoOQNZr9QbnGT
YoKcN7fB3ACVr3qJZ6Kn3hvNc7PjVPKHs1g/gFYimsd4TB2Dr2+K4qGc61B70HX0
HJ1AP2i1jlfrxdDqfnjNrgAZJYe/6mWbP/0zC01++kn3ZqSX+qb59dXg//5TcT45
9mfME0023htoZx62NCegCxYSmCdeQNtkcZBjjVkS6ch+XOXwLauwzG+9TZ30Nv9G
Nklw+CQ+4Hn6qGhwUzIWnILd/LNmozrXNSbpQUbq4JfhB+ca+L7ma28ZNU8IjoIK
L0NTjhMIpOMJr0rX80vrZlvNgsH4kfahjCM0TTGkX03ulyNSr28Gcsuk9IdpPsg=
=QFHM
-----END PGP SIGNATURE-----

--nextPart29863806.xnYg52WWAz--


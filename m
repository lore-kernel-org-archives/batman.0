Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Sat, 19 Jul 2014 18:11:50 +0800
Message-ID: <21319292.8F7hNISJSU@diderot>
In-Reply-To: <1405391898-5258-1-git-send-email-linus.luessing@web.de>
References: <1405391898-5258-1-git-send-email-linus.luessing@web.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart3244057.jG4jWnFnqa";
 micalg="pgp-sha1"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCHv5 1/2] batman-adv: Add multicast
	optimization support for bridged setups
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


--nextPart3244057.jG4jWnFnqa
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

On Tuesday 15 July 2014 04:38:17 Linus L=FCssing wrote:
>  /**
> + * batadv_mcast_get_bridge - get the bridge on top of the softif if =
it exists
> + * @soft_iface: netdev struct of the mesh interface
> + *
> + * Returns either a bridge interface on top of our soft interface or=

> + * NULL if no such bridge exists.
> + */

The kernel doc should mention that the bridge object's refcount is incr=
eased=20
(if found).


> +update:
>  =09if (!bat_priv->mcast.enabled ||
>  =09    mcast_data.flags !=3D bat_priv->mcast.flags) {
> +=09=09if (!bat_priv->mcast.enabled)
> +=09=09=09sprintf(str_flags_old, "<undefined>");
> +=09=09else
> +=09=09=09sprintf(str_flags_old, "[%c%c%c]",
> +=09=09=09=09(bat_priv->mcast.flags &
> +=09=09=09=09 BATADV_MCAST_WANT_ALL_UNSNOOPABLES ?
> +=09=09=09=09 'U' : '.'),
> +=09=09=09=09(bat_priv->mcast.flags &
> +=09=09=09=09 BATADV_MCAST_WANT_ALL_IPV4 ? '4' : '.'),
> +=09=09=09=09(bat_priv->mcast.flags &
> +=09=09=09=09 BATADV_MCAST_WANT_ALL_IPV6 ? '6' : '.'));
> +
> +=09=09sprintf(str_flags_new, "[%c%c%c]",
> +=09=09=09(mcast_data.flags &
> +=09=09=09 BATADV_MCAST_WANT_ALL_UNSNOOPABLES ? 'U' : '.'),
> +=09=09=09(mcast_data.flags &
> +=09=09=09 BATADV_MCAST_WANT_ALL_IPV4 ? '4' : '.'),
> +=09=09=09(mcast_data.flags &
> +=09=09=09 BATADV_MCAST_WANT_ALL_IPV6 ? '6' : '.'));
> +
> +=09=09batadv_dbg(BATADV_DBG_MCAST, bat_priv,
> +=09=09=09   "Changing multicast flags from '%s' to '%s'\n",
> +=09=09=09   str_flags_old, str_flags_new);

IMHO the debug log should be more verbose about why a given flag was en=
abled or=20
disabled. As it is now, one can't learn anything from this log that isn=
't already
part of the mcast table. If you think that is too big of a change you c=
an also
move this chunk into a separate patch.

Cheers,
Marek

--nextPart3244057.jG4jWnFnqa
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABAgAGBQJTykRnAAoJEFNVTo/uthzAOn8IAIPlOywqNCwu7KEamJ/B/d3l
Lz2XLFppAHYovSqUIA8YT6mpmD0KmTsUe4IsqeaEQoAbClN4CYJ3K82nO4GdffiT
PNXCzfbW7vXJahAhmZYqtCrl9oFKfZrHZ/PX4o+p5YjIqsiWVF9xhiUSf93C3fnr
Lb9dy5QynHhWGbiLSyzy7YEQOsemVBc0MYT8DNxBpmfC21WRWysDOkUjt1SnNjsD
U1+lm1UFnUx+8PNVuuMBtLXnW5Z3LlLFs83oeTSc8/FYv9FZiQGFGKsf8ViNVtoz
8qEjOanAaT+C4NP80Gh3oeZZGS53fAVE2BDvsDgG7TjGBrUOi2zudfLjd+hxsp0=
=abuP
-----END PGP SIGNATURE-----

--nextPart3244057.jG4jWnFnqa--


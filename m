Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Subject: Re: [PATCH v4 1/2] batman-adv: mcast: detect,
 distribute and maintain multicast router presence
Date: Mon, 10 Jun 2019 07:39:17 +0200
Message-ID: <4372099.eJBBBCqJL5@sven-edge>
In-Reply-To: <20190610004535.13725-2-linus.luessing@c0d3.blue>
References: <20190610004535.13725-1-linus.luessing@c0d3.blue>
 <20190610004535.13725-2-linus.luessing@c0d3.blue>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2073850.6bWSJXWb6U";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
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

--nextPart2073850.6bWSJXWb6U
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

On Monday, 10 June 2019 02:45:34 CEST Linus L=FCssing wrote:
> If a multicast router is detected then this is signalized via the new
> BATADV_MCAST_WANT_ALL_RTR4 and BATADV_MCAST_WANT_ALL_RTR6
> multicast tvlv flags (which are sent flipped over the wire for backwards
> compatibility - so that old nodes will always have them "set").

This doesn't seem to match the code (see below).

> diff --git a/include/uapi/linux/batadv_packet.h b/include/uapi/linux/bata=
dv_packet.h
> index 4ebc2135..23a43043 100644
> --- a/include/uapi/linux/batadv_packet.h
> +++ b/include/uapi/linux/batadv_packet.h
> @@ -107,12 +107,20 @@ enum batadv_icmp_packettype {
>   * @BATADV_MCAST_WANT_ALL_UNSNOOPABLES: we want all packets destined for
>   *  224.0.0.0/24 or ff02::1
>   * @BATADV_MCAST_WANT_ALL_IPV4: we want all IPv4 multicast packets
> + *  (both link-local and routeable ones)
>   * @BATADV_MCAST_WANT_ALL_IPV6: we want all IPv6 multicast packets
> + *  (both link-local and routable ones)
> + * @BATADV_MCAST_WANT_NO_RTR4: we have no IPv4 multicast router and ther=
efore
> + * only need routeable IPv4 multicast packets we signed up for explicitly
> + * @BATADV_MCAST_WANT_NO_RTR6: we have no IPv6 multicast router and ther=
efore
> + * only need routeable IPv6 multicast packets we signed up for explicitly
>   */
>  enum batadv_mcast_flags {
>         BATADV_MCAST_WANT_ALL_UNSNOOPABLES      =3D 1UL << 0,
>         BATADV_MCAST_WANT_ALL_IPV4              =3D 1UL << 1,
>         BATADV_MCAST_WANT_ALL_IPV6              =3D 1UL << 2,
> +       BATADV_MCAST_WANT_NO_RTR4               =3D 1UL << 3,
> +       BATADV_MCAST_WANT_NO_RTR6               =3D 1UL << 4,
>  };


--nextPart2073850.6bWSJXWb6U
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAlz97QUACgkQXYcKB8Em
e0ajqxAAnU7cPbmhTh56EHb81ORS2v7JPlkh6/XgEBnM4a2kuOo6vWBmd14X85gc
NVH1ui1ZoE6DndJrwWzhko22l7rdjmwVlooTL8CZWlVQ/nB72OkZO/lYaLOvKL5A
3i9KvB8w9Ouf1zKSuL8yEFTR5jivj0meTZsBxyW0TPuMOTogpSMTb7RwxScgNxT3
06BVvMg7FoAUKan2XjpTpqCcWm49WAmL7l8eoCfeac8nbJ+a5TPg+Zy803WTEPlJ
MyYfw/F3UrJF/TMqNNEytAEXLROS/rHz1TMMnBMKk7b1KA0TUYPIR6N2+V90SYqc
htJxkL/6o0Vrjf9z3iv9ylXtZAasK/Ls9amdvL74RCeNyYwetyEl1ZbjPHx3Wb/s
bV+UzFev60iadaz+VuIhAbAmNoJNM6ExaTJKjoFwb9Wur+b+0BudEg/Yhb/8s+xj
1lgRQyhFOg04P3Oqof0aHPc0i4qc+4uZnxH5GlKLF3Volcs5/zLDfsWKYbmsCoF5
qIkaF8r5lJN9+ct98XQkEFk99WhT3EcIaInJWi6f/SuvqNEkuv/NPBNyOsBWWk5l
sNpOfIub+Hjp0w0Cl7O4LusMbsr8UON/WlRg3pQwmRmJ6Vt2lK0dV1bqz9YvFRcs
Qs08kIaTOLhYntPb4poxzgQqFCMw2o40ofBh+i2zN5qzEV91SEM=
=oRbX
-----END PGP SIGNATURE-----

--nextPart2073850.6bWSJXWb6U--




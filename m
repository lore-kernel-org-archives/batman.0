Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Wed, 13 Apr 2016 22:32:43 +0200
Message-ID: <1891393.XZXRhtYPY0@sven-edge>
In-Reply-To: <1460576087-21474-1-git-send-email-a@unstable.cc>
References: <1460576087-21474-1-git-send-email-a@unstable.cc>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart4523817.oArv4Ho8Am";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: B.A.T.M.A.N V - make sure
	iface is reactivated upon NETDEV_UP event
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
Cc: Antonio Quartulli <a@unstable.cc>

--nextPart4523817.oArv4Ho8Am
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Thursday 14 April 2016 03:34:47 Antonio Quartulli wrote:
[...]
> diff --git a/net/batman-adv/types.h b/net/batman-adv/types.h
> index 9abfb3e..316af66 100644
> --- a/net/batman-adv/types.h
> +++ b/net/batman-adv/types.h
> @@ -1277,6 +1277,7 @@ struct batadv_forw_packet {
>  struct batadv_algo_ops {
>  	struct hlist_node list;
>  	char *name;
> +	void (*bat_iface_activate)(struct batadv_hard_iface *hard_iface);
>  	int (*bat_iface_enable)(struct batadv_hard_iface *hard_iface);
>  	void (*bat_iface_disable)(struct batadv_hard_iface *hard_iface);
>  	void (*bat_iface_update_mac)(struct batadv_hard_iface *hard_iface);

kernel-doc is missing for @bat_iface_activate

Kind regards,
	Sven

--nextPart4523817.oArv4Ho8Am
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCgAGBQJXDqzrAAoJEF2HCgfBJntGD/8P/RYylDVcoxkkgQWBDBq1zdvg
F9wbMKidHblquIZrU7h/Dnt7sdDH7/31M95Ol5+26T00lVIGq3Nzh7Y4Y/faCpI5
GmuOpBIOA1LuDvzHt7J0bY2u0SODxhgp5bsYQ+Ki9VJlFjKkuNv5nJhoHbgFvlaE
yG3nK2aw3j1LTKUb2L38bamubKap5Rv4AC5f/4Uz3KF457kNzu/PQjcY4s8TWuos
+xlWokZ5+Ey1fp2tRZEQjZ+passqXh7BPwfuhb1ax3pkHMC1M3oovSlyzPqTP6bC
UyXRqItqqyrwWRMBmTB3YFwUMHmYNvsjAk9ZWIpaRw86kGUiIu47XYjCcE3x8HIR
CXMnS53pBV5PSQqKQ7nR7mtCVwqkU2iBYnIoO26U2gmEc/9UCoeULiady0F70ouF
BRXHChe5luJ1a2NaMKXMCYM6UHb93sDnMXncRiMfCyacPUVZ1C/ikvmX0Ji/UnOB
R4WQrVC0NkG51brlAA7sPvRsTQI9t/u8slAnRpGKInfGxFX7fujkC0577rxAzTFB
vFHxJOOSqP1fnh8AjYDw6en0gVSGcZ7NRpu095aCXKowNnuxRIwyfM1OShGRLHCy
5/vJ+JEMChITITkdAUVlR5SGQ2OPxHfPBgEeoPPbCrJZXMBYQJAjHbKOJB5+I71L
LV2CB2vGysnH1LuY4i/5
=VNqu
-----END PGP SIGNATURE-----

--nextPart4523817.oArv4Ho8Am--


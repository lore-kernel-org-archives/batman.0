Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Tue, 31 May 2016 15:30:50 +0200
Message-ID: <10464750.uX2rJqW38e@bentobox>
In-Reply-To: <1464103086-8365-1-git-send-email-linus.luessing@c0d3.blue>
References: <1464103086-8365-1-git-send-email-linus.luessing@c0d3.blue>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart3354316.FD7SZu2Apb";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: Remove unused primary_if
	variable
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

--nextPart3354316.FD7SZu2Apb
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

Hi,

On Tuesday 24 May 2016 17:18:06 Linus L=FCssing wrote:
[...]
> diff --git a/net/batman-adv/bat_iv_ogm.c b/net/batman-adv/bat_iv_ogm.=
c
> index 5a7923c..2076048 100644
> --- a/net/batman-adv/bat_iv_ogm.c
> +++ b/net/batman-adv/bat_iv_ogm.c
> @@ -529,35 +529,26 @@ static void batadv_iv_ogm_emit(struct batadv_fo=
rw_packet *forw_packet)
>  {
>  =09struct net_device *soft_iface;
>  =09struct batadv_priv *bat_priv;
> -=09struct batadv_hard_iface *primary_if =3D NULL;
> =20
>  =09if (!forw_packet->if_incoming) {
>  =09=09pr_err("Error - can't forward packet: incoming iface not speci=
fied\n");
> -=09=09goto out;
> +=09=09return;
>  =09}
> =20
>  =09soft_iface =3D forw_packet->if_incoming->soft_iface;
>  =09bat_priv =3D netdev_priv(soft_iface);
> =20
>  =09if (WARN_ON(!forw_packet->if_outgoing))
> -=09=09goto out;
> +=09=09return;
> =20
>  =09if (WARN_ON(forw_packet->if_outgoing->soft_iface !=3D soft_iface)=
)
> -=09=09goto out;
> +=09=09return;
> =20
>  =09if (forw_packet->if_incoming->if_status !=3D BATADV_IF_ACTIVE)
> -=09=09goto out;
> -
> -=09primary_if =3D batadv_primary_if_get_selected(bat_priv);
> -=09if (!primary_if)
> -=09=09goto out;
> +=09=09return;
> =20
>  =09/* only for one specific outgoing interface */
>  =09batadv_iv_ogm_send_to_if(forw_packet, forw_packet->if_outgoing);
> -
> -out:
> -=09if (primary_if)
> -=09=09batadv_hardif_put(primary_if);
>  }
> =20
>  /**
>=20

Now the variable bat_priv is not used anymore. :)

Kind regards,
=09Sven
--nextPart3354316.FD7SZu2Apb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCgAGBQJXTZIKAAoJEF2HCgfBJntGY+EP/0ojKuG/EVc8hvmE48MU060l
QMHglyls12DmIxwIIvxrNpbGsaec3j6GeYsbwcr93+oRAu4cOSwQjY/WUX3jjpEV
AYU7uxRcSnwl7xmIvmMbxctQ5emnvCW4zFAIU0F0RC5eWUv7OOIrzKHRy0hY1v0U
8yy2/whsY3ogNP7GFJ2+r/82HWL+3mdkETw9QFpNamxnNCggQgMJnJPbtHmK/GTx
4qFEOJ/kGcBo8q+0Oew0VTG5eZmL6xpxTGs1qRWy+CNBuH4/02+z2DVlhTcPLVNS
AKCtdy80ukAsBAUj6bL/NHUg97rr3dv8FMpdd4oMbnmbjDOSUfekOIxOxQzVoToZ
6Y6d6XprmUc74hHXBj1B3bhm005pv0heE5chAoW0XK3WbyUKu5bQYmbsnVHC24VY
tg6r39b+lWLMe8jg0CZwuAg7amwqUWlFOZhS6C51o0aOdbc4i9Qa3HUyCGyUXyXZ
aMl8JAZyEhjvAMjyUYTpHEH9esc0knlsC2p0AS51Wxd8fwPIeqr/CvuXY2rlGO5w
s4+CwvBIXo34gAleLUhJeSxhQWQgMvL/wVfR6e4SbMy8B0ldkk1ur9YjUW4wvtXs
mJRo7M8xwImH809qga0DcaYSCXaF8JdM1dO4e9jh76E9LNRWFpA38hF4uXWTJFHZ
PBH3HBvzjTA4jfnlGEsV
=j4cQ
-----END PGP SIGNATURE-----

--nextPart3354316.FD7SZu2Apb--


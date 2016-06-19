Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sun, 19 Jun 2016 13:00:18 +0200
Message-ID: <5707464.HeWq3LKJdl@sven-edge>
In-Reply-To: <1465939183-17868-1-git-send-email-linus.luessing@c0d3.blue>
References: <1465939183-17868-1-git-send-email-linus.luessing@c0d3.blue>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart9401462.PQFShZi19m";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCHv3] batman-adv: Introduce forward packet
	creation helper
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

--nextPart9401462.PQFShZi19m
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

On Tuesday 14 June 2016 23:19:43 Linus L=FCssing wrote:
[...]
> +struct batadv_forw_packet *
> +batadv_forw_packet_alloc(struct batadv_hard_iface *if_incoming,
> +=09=09=09 struct batadv_hard_iface *if_outgoing,
> +=09=09=09 atomic_t *queue_left,
> +=09=09=09 struct batadv_priv *bat_priv)
> +{
> +=09struct batadv_forw_packet *forw_packet =3D NULL;
> +
> +=09if (queue_left && !batadv_atomic_dec_not_zero(queue_left)) {
> +=09=09if (queue_left =3D=3D &bat_priv->bcast_queue_left)
> +=09=09=09batadv_dbg(BATADV_DBG_BATMAN, bat_priv,
> +=09=09=09=09   "bcast queue full\n");
> +=09=09else if (queue_left =3D=3D &bat_priv->batman_queue_left)
> +=09=09=09batadv_dbg(BATADV_DBG_BATMAN, bat_priv,
> +=09=09=09=09   "batman queue full\n");
> +=09=09else
> +=09=09=09batadv_dbg(BATADV_DBG_BATMAN, bat_priv,
> +=09=09=09=09   "a mysterious queue is full\n");
> +=09=09goto out;
> +=09}

Returning here directly is most likely easier to read. At least I had t=
o
check twice if the gotos in this function are all correct.

And I would have written it slightly different. I don't want to say tha=
t your
way is worse or my version is better but just add a slightly different =
way
into the discussion

    =09struct batadv_forw_packet *forw_packet;
    =09const char *qname;
   =20
    =09if (queue_left && !batadv_atomic_dec_not_zero(queue_left)) {
    =09=09qname =3D "unknown";
   =20
    =09=09if (queue_left =3D=3D &bat_priv->bcast_queue_left)
    =09=09=09qname =3D "bcast";
   =20
    =09=09if (queue_left =3D=3D &bat_priv->batman_queue_left)
    =09=09=09qname =3D "batman";
   =20
    =09=09batadv_dbg(BATADV_DBG_BATMAN, bat_priv, "%s queue is full\n",=

    =09=09=09  qname);
   =20
    =09=09return NULL;
    =09}

> +       goto out;
> +
> +err:
> +       if (queue_left)
> +               atomic_inc(queue_left);
> +out:
> +       return forw_packet;
> +}

Maybe we can return here directly forw_packet and in the error case
return NULL;

    =09return forw_packet;

    err_inc_queue_left:
    =09if (queue_left)
    =09=09atomic_inc(queue_left);
   =20
    =09return NULL;


> @@ -478,20 +546,16 @@ int batadv_add_bcast_packet_to_list(struct bata=
dv_priv *bat_priv,
>  =09struct batadv_bcast_packet *bcast_packet;
>  =09struct sk_buff *newskb;
> =20
> -=09if (!batadv_atomic_dec_not_zero(&bat_priv->bcast_queue_left)) {
> -=09=09batadv_dbg(BATADV_DBG_BATMAN, bat_priv,
> -=09=09=09   "bcast packet queue full\n");
> -=09=09goto out;
> -=09}
> -
>  =09primary_if =3D batadv_primary_if_get_selected(bat_priv);
>  =09if (!primary_if)
> -=09=09goto out_and_inc;
> -
> -=09forw_packet =3D kmalloc(sizeof(*forw_packet), GFP_ATOMIC);
> +=09=09goto out;

I think you can return here directly

> =20
> +=09forw_packet =3D batadv_forw_packet_alloc(primary_if, NULL,
> +=09=09=09=09=09       &bat_priv->bcast_queue_left,
> +=09=09=09=09=09       bat_priv);
> +=09batadv_hardif_put(primary_if);
>  =09if (!forw_packet)
> -=09=09goto out_and_inc;
> +=09=09goto out;

Same here


All the mentioned things are just nitpicking. So overall:

Reviewed-by: Sven Eckelmann <sven@narfation.org>

Please keep the Reviewed-by in case you you resent the patch and only
include changes which were mentioned in this mail.

Kind regards,
=09Sven
--nextPart9401462.PQFShZi19m
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCgAGBQJXZntCAAoJEF2HCgfBJntG0GMQAKA7y5ubrLZ/uJPgWihKTKF4
yikOqrSQgM01CFndHRDjVr6i9R5jXotNZLttPWMzfS5nFzvQc5evmYiG4WoPxA5N
iFHv53TZGh6oxlID83jrvBlN+k7lbr1TKtuXD4rYgM2NB1Cz/Wx+xSsIhZLncoKC
TwpXPP3KnPQcHNgkFuPiSU9647skSOvJutvthdCQDLbfX++BZkoUG0nBYXii8bTC
Ob1os6yilhMrsC9QNd6Vnw5d6Wa3kOMJi2LgG64aZtEnrS0fpMAph+gPwYLRuAQH
+PLnVSK8sCtvTkNMBxqfHp/cV+wvyIJddzL51E5Q4aSOlSnYc7BSw/jV43NpzXIs
1lp4RfOY4PsPgxb15LKXlRuattQi/u8ff9PIJNsOSARIMtnwfQ40em3p+rbNW2Kl
v79HR4yIyr3IO0PYjX2g/FXvMAL2GeNn47UA+ADZguwamsyTS+7DMq8xqa9Yngir
1IbBWN2JhdNUXHc9V004tjlyN7+5ad9+MHAsZ/IXUsnno1Odcad2iVo8v74HobWT
X3msJ8FUYCih+e1hAjvvUERbHZI6kYSdvkVfZ9gi5vd4DXBFKzEF7vCXeYzw78ql
xRaaMVnfuQimPHc47mRVQ9KIoF44XugdwEu7GTDfCVuBvLQLEX+mcr+CknpeKbkN
eyulBtxht+GhZra6qVD8
=+pAR
-----END PGP SIGNATURE-----

--nextPart9401462.PQFShZi19m--


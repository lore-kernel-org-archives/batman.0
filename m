Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Subject: Re: [PATCH 2/3] batman-adv: allow broadcast packet type with unicast
 destination
Date: Sat, 25 May 2019 12:24:38 +0200
Message-ID: <1643666.5vcEtJMyOp@sven-edge>
In-Reply-To: <20190514073859.2053-3-linus.luessing@c0d3.blue>
References: <20190514073859.2053-1-linus.luessing@c0d3.blue>
 <20190514073859.2053-3-linus.luessing@c0d3.blue>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart4191173.OOtPebQO1S";
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

--nextPart4191173.OOtPebQO1S
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

On Tuesday, 14 May 2019 09:38:58 CEST Linus L=FCssing wrote:
[...]
> +/**
> + * batadv_orig_bcast_tvlv_ogm_handler() - process incoming broadcast tvlv
> + * @bat_priv: the bat priv with all the soft interface information
> + * @orig: the orig_node of the ogm
> + * @flags: flags indicating the tvlv state (see batadv_tvlv_handler_flag=
s)
> + * @tvlv_value: tvlv buffer containing the multicast data
> + * @tvlv_value_len: tvlv buffer length
> + */
> +static void batadv_orig_bcast_tvlv_ogm_handler(struct batadv_priv *bat_p=
riv,
> +                                              struct batadv_orig_node *o=
rig,
> +                                              u8 flags,
> +                                              void *tvlv_value,
> +                                              u16 tvlv_value_len)
> +{
> +       if (flags & BATADV_TVLV_HANDLER_OGM_CIFNOTFND)
> +               clear_bit(BATADV_ORIG_CAPA_HAS_BCAST_URCV, &orig->capabil=
ities);
> +       else
> +               set_bit(BATADV_ORIG_CAPA_HAS_BCAST_URCV, &orig->capabilit=
ies);
> +}
> +

Bitops require #include <linux/bitops.h>

>  /**
>   * batadv_originator_init() - Initialize all originator structures
>   * @bat_priv: the bat priv with all the soft interface information
> @@ -215,6 +236,12 @@ int batadv_originator_init(struct batadv_priv *bat_p=
riv)
>         batadv_hash_set_lock_class(bat_priv->orig_hash,
>                                    &batadv_orig_hash_lock_class_key);
> =20
> +       batadv_tvlv_container_register(bat_priv, BATADV_TVLV_BCAST, 1, NU=
LL, 0);

BATADV_TVLV_BCAST requires #include <uapi/linux/batadv_packet.h>

--nextPart4191173.OOtPebQO1S
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAlzpF+YACgkQXYcKB8Em
e0bUyg//Srrmpgc9QEtn4KifFeCQleLnc/tCdoPqHHFZ0b8b+lsPXrakVdmGXNag
5eA5BhNWhR6X67iKUndCoW4+Q6oF+y91LOJOvibcH8l03cRKPOB4rWcvXcpkjxKh
/Ej85TEVWXt85mFP7uljvvIEL8uxNa2On+Sm4FTRy8bIb9yPPtrU/g1Xdy0Bg7C3
jR6OuzEnUOEHBPtsI3+vbQ2N2hEywt4rnfkvEzIs1Eer4d63loiLlyivbxdpYUR3
aYJMjFWqyTFehjUEeShsuyZeCaoYUy7eDnSoSuhejIOTGBRWatgLcwM+GZ3tAd6Q
u+F/T5jTTQeRUc4pbQw8L+5c8Bn0kZo361uevH0hYJ8iPx93kHyuUiqEbNkRYIFD
8DrOTe6Rc16S9X+fFA08AfkcUl3HsD8xjEpU1uMPFnZymJJBpTfYtSms83z41iIA
BzmyzSW7x18urFODMBTBkf8nCLqpu7h8woxN5NfWlsRYgF2juJrPzPBvkUgnxvdw
WvnwoPE9PHjs8vjfpCSYk3eysFSLBRSzfuhG7QXL2VBuF9YGZ464biY/D/7FyXuz
FkFNuw1DrusJuVJavWcLtugCoIRJIwnkQOU1vEU4BzoujqHkzi6ZdnbQ9ostMAzB
A3Vg5Avb+nUuahxHDaaD18hZbwChKxN2vjcxJvSEIqmuivchOac=
=ruvL
-----END PGP SIGNATURE-----

--nextPart4191173.OOtPebQO1S--




Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sun, 22 Jan 2017 13:40:26 +0100
Message-ID: <20070873.3LG4eVWnEf@sven-edge>
In-Reply-To: <20161219102951.GK6323@otheros>
References: <20161006064142.20003-1-linus.luessing@c0d3.blue>
 <1616382.Ux6hIh5e6R@bentobox> <20161219102951.GK6323@otheros>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2093780.F3VGNG1fzN";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH v2 3/4] batman-adv: Introduce packet type
	independent TVLV handler API
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

--nextPart2093780.F3VGNG1fzN
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

> @@ -1842,8 +1844,12 @@ static int batadv_iv_ogm_receive(struct sk_buff *s=
kb,
> =20
>                 packet_pos =3D skb->data + ogm_offset;
>                 ogm_packet =3D (struct batadv_ogm_packet *)packet_pos;
> +
> +               skb_set_network_header(skb, ogm_offset);
>         }
> =20
> +       skb_reset_network_header(skb);
> +
>         kfree_skb(skb);
>         return NET_RX_SUCCESS;
>  }

[...]
On Donnerstag, 6. Oktober 2016 08:41:40 CET Linus L=FCssing wrote:
> What do you think about wrapping the WARN_ON, while loop and
> skb_reset_network_header() into a new function with a functional,
> non-modifying touch regarding the input skb?
>=20
> Or do you think I should just remove the
> skb_reset_network_header() here?

Hm, my point was not actually about the loop or the skb_set_network_header =
or
the WARN_ON. I only don't know why a skb_reset_network_header would be
necessary before a kfree_skb/consume_skb.

It also doesn't seem to be used in a later patch.

Kind regards,
	Sven
--nextPart2093780.F3VGNG1fzN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAliEqDoACgkQXYcKB8Em
e0YSlxAAz3LCaehGGslTtysYXSVSUSPhQEmWkGIQCEPoh2I4eUWjZH7HBcePZ9Kg
apYtOx2Q9d+f/1iHrL7UtjF7lLJ1MYOSXHYL/DFxTmoTXexBYpyWu6Xk6LOyxrdn
9uFidlvQMNfpcT4RrC9BFq79BOUgVltHBVZ/q6cMZh5X7NRxBaRwM7RRR1wN69kg
4fnd5B86KC7h88dQslAEszxCR4bdR2yPqh1m4HvOLIBUfgRZBD5U9KboPmBnBMBN
PBmWipCkOnGpbL6Du1KFRgYh/M7MRCB8m3Um6DCiQk7vOeziVzGtLjLr4wGOh9c7
Ya96XddBush4PUaKD5x2G8i599r4sMStEQO73NlTFjLoNti+HHNsYWdH3gUgXdMM
ZqF0INgMPhtD19agV+WItOpj65KT9MK7iBRIh4dApKmU5hL6exRDGreG7vwLsK6h
1rCRB7BratUtSYeTIWAP0j4C+yVoKtXaIXpG15hTaK1ll1iCzheHFPvq8PJDACMJ
Ku0zEVShhkbaQ1LfCuwP3AJk5j7T6XD/BMa1Fj207CEe8dsEa8e4RIDzKnGWAFZx
Ilu2Wb13GpMrx6Ngxm51vbul7PL77hewGJOB2p6eY/Pu/AnQ+cdBszU/Kp1SuOz4
oobST9hsOG41FtdbzEjEfRA0uIpOGL6O0o7kTwoSx7Jx/MmHWCo=
=hUGi
-----END PGP SIGNATURE-----

--nextPart2093780.F3VGNG1fzN--


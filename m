Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Wed, 14 Dec 2016 15:50:38 +0100
Message-ID: <1616382.Ux6hIh5e6R@bentobox>
In-Reply-To: <20161006064142.20003-4-linus.luessing@c0d3.blue>
References: <20161006064142.20003-1-linus.luessing@c0d3.blue>
 <20161006064142.20003-4-linus.luessing@c0d3.blue>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart4844546.OZcDgDFdCY";
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

--nextPart4844546.OZcDgDFdCY
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

On Donnerstag, 6. Oktober 2016 08:41:40 CET Linus L=FCssing wrote:
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

Why must we skb_reset_network_header before the kfree?

Kind regards,
	Sven=20
--nextPart4844546.OZcDgDFdCY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAlhRXD4ACgkQXYcKB8Em
e0ai1Q//S6N9kbhH68PWCaABCyWGE7ixWfwoLF4B+8JcYu/FgBJurL3fBc78Cvz0
lqJz9zg0Lh/myph7+bplduW3zOM5tr+5x8H1x9YsVo3BmdpzwjfxUdbXoVxUeT0b
u1szXxKFponYMfteu4lGaj1tlqQEIGiGTsLKXAGtWYIOt3IVp9bh2TDtMxM/hnFn
D8niI3Hk9RRMfBHKDRgRlQGgt+Y8QMhIWplhj/yChQ7O/wwdoMaZq0tnfNqoIRP5
pt6amp8Rtl9Atv0TT17MSXdpC+kuz/BllNmqbAAflXKQ+HSMHPABIz9bvAvgk2jN
1ItEiAEdO12eJRUFhVjOp0Pl4++yq5Vsr0E9jqdpkWk81812P+MslBxIZi7PKp5i
9NbEhlBY4D8jmBccy5jNifbFsEg6zJM6JvxY+reMcOvLc2D4/JH9fysaUVv2klIR
10cJDhC4Bq2KIXqDexZz9mxpH0VWMvnnrnVCV5le0QNLUJIM0EiP9z6O428jHd6f
12C8I9A5SimIgpbbK5zGdSF4ICcHeENLJdz6lbQnyuJk1zaF2s1KxmSvfJyrg9zn
GLpD8ZRxEPy/CU4ZZSakGB2Lit6hryIfpWDHi2sCrvfjC/gLyJ6roa2u9kP7rjM9
dUwAkJPLW6f1rEf4vpVB1wA1mE4VVcd2A8R/rYtxuil7zEpPc50=
=2Edt
-----END PGP SIGNATURE-----

--nextPart4844546.OZcDgDFdCY--


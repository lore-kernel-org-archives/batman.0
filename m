Return-Path: <a@unstable.cc>
Date: Fri, 4 Mar 2016 23:37:22 +0800
From: Antonio Quartulli <a@unstable.cc>
Message-ID: <20160304153722.GE3945@prodigo>
References: <20160304152132.GV15541@lunn.ch>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="XRI2XbIfl/05pQwm"
Content-Disposition: inline
In-Reply-To: <20160304152132.GV15541@lunn.ch>
Subject: Re: [B.A.T.M.A.N.] Use of ref_get_unless_zero() ?
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>, Andrew Lunn <andrew@lunn.ch>


--XRI2XbIfl/05pQwm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 04, 2016 at 04:21:32PM +0100, Andrew Lunn wrote:
> Hi
>=20
> I'm sometimes getting a crash after removing a hard interface when the
> batadv_send_outstanding_bat_org_packet() is called in a work queue.
> It calls
>=20
> static void batadv_iv_ogm_aggregate_new(const unsigned char *packet_buff,
>                                         int packet_len, unsigned long sen=
d_time,
>                                         bool direct_link,
>                                         struct batadv_hard_iface *if_inco=
ming,
>                                         struct batadv_hard_iface *if_outg=
oing,
>                                         int own_packet)
> {
>         struct batadv_priv *bat_priv =3D netdev_priv(if_incoming->soft_if=
ace);
>         struct batadv_forw_packet *forw_packet_aggr;
>         unsigned char *skb_buff;
>         unsigned int skb_size;
>=20
>         if (!kref_get_unless_zero(&if_incoming->refcount))
>                 return;
>=20
>         if (!kref_get_unless_zero(&if_outgoing->refcount))
>                 goto out_free_incoming;
>=20
>=20
> Given that we have:
>=20
> static inline void batadv_hardif_put(struct batadv_hard_iface *hard_iface)
> {
>         kref_put(&hard_iface->refcount, batadv_hardif_release);
> }
>=20
> does using kref_get_unless_zero() make sense? If it is zero, hasn't it
> been freed by the kref_put that set it to zero?

Not sure if this is the case but what if batadv_iv_ogm_aggregate_new() is c=
alled
within a rcu_read protected context concurrent to the kref_put setting the
refcount to zero ?

If I am not wrong, in this case if_incoming/outgoing will
still be valid (until the rcu_read_unlock()) but the refcount will be 0.

Does it make sense ?

Cheers,


--=20
Antonio Quartulli

--XRI2XbIfl/05pQwm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJW2auyAAoJENpFlCjNi1MRlWoP/A9W2j8hDtAdq9gZZsVNBZTq
A9Lb5h4/wO8pv/AqpND2+QJQMz80C+UVaNMNFgAEFVuCfJ+zY2bOfg570Dl6BxGy
/ZLZf6BA0bMMFRErtFN26Da8sQQ9o5kvh2CoxYCgWDZaQQtWfUngqpC3oAr1KC+K
r9X6hp/iuDxXvPHeoxTcPtLJ4AMqqNjDQhQiiO1K7A5GgNJnwFWIPobK6rD/uOo7
c5qpMOnI7b+0Jn64htpPpWh2jajaoEi9yHIJg2yibZf86XFkYJaEwh9bIYBat/6g
5egrfUcPz6swrFwlM2ltg0GTk3Km+hXlSXVGb10PxFxxBi9SH15fn5UY9+Lfx7l6
/1qXs+M6KBnJhFIcnkpHZUtFmJXhX5UUIh0M+gA+7HlHbCViAHseeKL3pUhAqZQa
E7s5BpCD0oVkzCKPASEsaRqS7ut+CWADwpdEtChhbMYjdJU2MyIKroply7pJ81z4
1UkU/7tymE1l09l9MUpirYw04jYrM1Cm03sLKebpkYcBc/cPT8ZcFI69KGzj+irL
QtrFwX2DRxorFtRFCAiJeT0FZTWXuiDJfWFB4rBPjIGtbp+nqeL1hCVGLJWYNfWJ
zvLGtMbjHLsglUEEkSEPyGlSYQwYj+quFhNJnGacnopmYF10HDJMvEeLhrf6nIug
Fub1leKtksqsOD4rDiR3
=HvzN
-----END PGP SIGNATURE-----

--XRI2XbIfl/05pQwm--

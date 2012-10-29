Return-Path: <ordex@autistici.org>
Date: Mon, 29 Oct 2012 16:31:58 +0100
From: Antonio Quartulli <ordex@autistici.org>
Message-ID: <20121029153158.GD3142@ritirata.org>
References: <1351523401-9188-1-git-send-email-ordex@autistici.org>
 <1704253.EuqF38gjUr@bentobox>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="dFWYt1i2NyOo1oI9"
Content-Disposition: inline
In-Reply-To: <1704253.EuqF38gjUr@bentobox>
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: don't free resources when
 DAT is disabled
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
To: Sven Eckelmann <sven@narfation.org>
Cc: b.a.t.m.a.n@lists.open-mesh.org


--dFWYt1i2NyOo1oI9
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 29, 2012 at 04:30:10PM +0100, Sven Eckelmann wrote:
> On Monday 29 October 2012 16:10:01 Antonio Quartulli wrote:
> > Freeing all the resources when DAT is disabled need a much more complic=
ated
> > locking system to prevent concurrent enable/disable operations to destr=
oy
> > the internal state of the component. For now it is safe to avoid such
> > freeing operation at all when DAT gets disabled.
> >=20
> > Signed-off-by: Antonio Quartulli <ordex@autistici.org>
> > ---
> >  distributed-arp-table.c | 10 ----------
> >  sysfs.c                 |  3 +--
> >  2 files changed, 1 insertion(+), 12 deletions(-)
> >=20
> > diff --git a/distributed-arp-table.c b/distributed-arp-table.c
> > index c933615..7921030 100644
> > --- a/distributed-arp-table.c
> > +++ b/distributed-arp-table.c
> > @@ -1061,13 +1061,3 @@ out:
> >  		batadv_dat_entry_free_ref(dat_entry);
> >  	return ret;
> >  }
> > -
> > -void batadv_dat_switch(struct net_device *net_dev)
> > -{
> > -	struct batadv_priv *bat_priv =3D netdev_priv(net_dev);
> > -
> > -	if (atomic_read(&bat_priv->distributed_arp_table))
> > -		batadv_dat_init(bat_priv);
> > -	else
> > -		batadv_dat_free(bat_priv);
> > -}
>=20
> Also remove it from distributed-arp-table.h

Right, thanks.


--=20
Antonio Quartulli

=2E.each of us alone is worth nothing..
Ernesto "Che" Guevara

--dFWYt1i2NyOo1oI9
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iEYEARECAAYFAlCOoW4ACgkQpGgxIkP9cwdhzwCgk0vJxYOuSZalJiK8obLIWLJa
j/sAn2a601wDY6AX9Lhu6P77F9/5BSRa
=MoOK
-----END PGP SIGNATURE-----

--dFWYt1i2NyOo1oI9--

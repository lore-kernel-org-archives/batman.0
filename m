Return-Path: <a@unstable.cc>
Date: Thu, 10 Mar 2016 09:15:45 +0800
From: Antonio Quartulli <a@unstable.cc>
Message-ID: <20160310011545.GI13448@prodigo.lan>
References: <1457484919-3935-1-git-send-email-a@unstable.cc>
 <13752331.CEKO7ckMJS@sven-edge>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="PMULwz+zIGJzpDN9"
Content-Disposition: inline
In-Reply-To: <13752331.CEKO7ckMJS@sven-edge>
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: fix typ0 in kerneldoc
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


--PMULwz+zIGJzpDN9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 09, 2016 at 10:11:43PM +0100, Sven Eckelmann wrote:
> On Wednesday 09 March 2016 08:55:19 Antonio Quartulli wrote:
> > Signed-off-by: Antonio Quartulli <a@unstable.cc>
> > ---
> >  net/batman-adv/distributed-arp-table.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >=20
> > diff --git a/net/batman-adv/distributed-arp-table.c
> > b/net/batman-adv/distributed-arp-table.c index 919a8d2..ab79f3a 100644
> > --- a/net/batman-adv/distributed-arp-table.c
> > +++ b/net/batman-adv/distributed-arp-table.c
> > @@ -717,7 +717,7 @@ void batadv_dat_status_update(struct net_device
> > *net_dev) }
> >=20
> >  /**
> > - * batadv_gw_tvlv_ogm_handler_v1 - process incoming dat tvlv container
> > + * batadv_dat_tvlv_ogm_handler_v1 - process incoming dat tvlv container
> >   * @bat_priv: the bat priv with all the soft interface information
> >   * @orig: the orig_node of the ogm
> >   * @flags: flags indicating the tvlv state (see batadv_tvlv_handler_fl=
ags)
>=20
> You've missed some (see
> https://git.open-mesh.org/batman-adv.git/commit/94399934a5e050073e1146ecf=
c48fe58ac3551b3
> for the update patch):

May I resend this patch with your sign-off as well ?

Cheers,

--=20
Antonio Quartulli

--PMULwz+zIGJzpDN9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJW4MrBAAoJENpFlCjNi1MR5NIQAKimu6Q7ZJWt2y9XxEM9Ax3t
Tl/ZujKSqT2Inj7Pfk9Z8VhypOY79Ik4HgyVfpZ19HTiDcx4wUd+W6wT6mq0Q9Um
2v+NJdg+28Q3IHiUxdvlHbEdkLc31wRhKt7x4ns/a5Ch8uazBWUpcSq0mllPaeph
eqx7EcoMhKB22yOgZ8hnNzcLE9CRd5iCp/YQarl6WJoWjfk54afpRDaSFX0MuN16
QcgLpCm4XjI4fTOKuyVfDGDgwoUYo4XAz2ZhbO0VCgOQq7r0ePCJUj2DjJTuBfkB
RHCCMkbmtW3T3/B55XVy5f3PMpYvUX2P+3DtMYRVzzgygdg/VhO7Idard1B35T82
cm2kyvAzxIdNjCD1DQVskufnJAbN7fcId6VSjhKvE9o/Oym3ajRgC77kY/+I82ZO
QQkhkH4J4V4qTtVgA5Q6UKtuqK7O5miCSgbUx28XjDp1E77447Rul8wDlUvaXQvs
A2anQZsWef+zK/jD29qU5HzPzZjdtHgsrTy9DFUsWTc0rZ991v8nRRGqREl9NrCk
X3vrvKtmlZtSkC/4QJSpWdtqvp7g9d+xwxspBjEcmj56uNM3oGAkvgQe7JAlpy8/
wQjAKrtZ1VBjphJ+tYmMPLzFBl4Igk3m9NHDFGvoS9z9JjtuqMy1PWCpJ7sMRymq
YYpprBbQRuUJSUie9rU8
=UmfI
-----END PGP SIGNATURE-----

--PMULwz+zIGJzpDN9--

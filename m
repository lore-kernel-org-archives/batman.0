Return-Path: <ordex@autistici.org>
Date: Wed, 17 Oct 2012 20:48:39 +0200
From: Antonio Quartulli <ordex@autistici.org>
Message-ID: <20121017184839.GS7023@ritirata.org>
References: <1350479255-904-1-git-send-email-linus.luessing@web.de>
 <20121017133640.GR7023@ritirata.org>
 <trinity-466685df-dab6-476d-be38-9f1320389eff-1350499385870@3capp-webde-bs10>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="mz5eWKkhz39mMVQV"
Content-Disposition: inline
In-Reply-To: <trinity-466685df-dab6-476d-be38-9f1320389eff-1350499385870@3capp-webde-bs10>
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: Do not add multicast MAC
 addresses to translation table
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
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>


--mz5eWKkhz39mMVQV
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 17, 2012 at 08:43:05PM +0200, "Linus L=C3=BCssing" wrote:
>=20
>=20
> > Gesendet: Mittwoch, 17. Oktober 2012 um 15:36 Uhr
> > Von: "Antonio Quartulli" <ordex@autistici.org>
> > An: "The list for a Better Approach To Mobile Ad-hoc Networking" <b.a.t=
=2Em.a.n@lists.open-mesh.org>
> > Betreff: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: Do not add multicast MA=
C addresses to translation table
> >
> > On Wed, Oct 17, 2012 at 03:07:35PM +0200, Linus L=C3=BCssing wrote:
> > > The current translation table mechanism is not suitable for multicast
> > > addresses and we are currently flooding such frames anyway.
> > >=20
> > > Therefore this patch prevents multicast MAC addresses being added to =
the
> > > translation table.
> > >=20
> > > Signed-off-by: Linus L=C3=BCssing <linus.luessing@web.de>
> > > ---
> > >  soft-interface.c |    3 ++-
> > >  1 file changed, 2 insertions(+), 1 deletion(-)
> > >=20
> > > diff --git a/soft-interface.c b/soft-interface.c
> > > index 2d1f895..9955319 100644
> > > --- a/soft-interface.c
> > > +++ b/soft-interface.c
> > > @@ -180,7 +180,8 @@ static int batadv_interface_tx(struct sk_buff *sk=
b,
> > >  		goto dropped;
> > > =20
> > >  	/* Register the client MAC in the transtable */
> > > -	batadv_tt_local_add(soft_iface, ethhdr->h_source, skb->skb_iif);
> > > +	if (!is_multicast_ether_addr(ethhdr->h_source))
> > > +		batadv_tt_local_add(soft_iface, ethhdr->h_source, skb->skb_iif);
> >=20
> > How can the source address be multicast? Usually multicast addresses ar=
e found
> > in the destination field...
> >=20
> > Is there any scenario where this is possible? I am wondering whether we=
 should
> > directly drop packet having mcast address as source..
>=20
> Hm, no, I do not have a specific scenario in mind. I only accidentally no=
ticed such an FF:FF:FF:FF:FF:FF mac address in our vis graph here when I ma=
de a typo with the tool 'mausezahn'.
>=20
> I don't know of any RFC or so which would generally forbid using a multic=
ast source MAC for every ether type (although for sane IPv4/v6 stacks I hav=
en't seen something like this before either and yes, I bet it's not allowed=
 there).
>=20
> The Linux bridge I had on top of bat0 was happily forwarding such frames =
into batman-adv. So I thought doing it like the bridge code - forwarding bu=
t with no learning - might be the right way?

I think you are right. We should not care about the payload logic. If that =
is
not allowed for the upper layer, then that layer will drop the packet once
received.


So we should keep forwarding such packets and yes, we should prevent learni=
ng
=66rom them. Therefore:

Acked-by: Antonio Quartulli <ordex@autistici.org>

Thanks a lot Lin=C3=BCs.
Cheers,

--=20
Antonio Quartulli

=2E.each of us alone is worth nothing..
Ernesto "Che" Guevara

--mz5eWKkhz39mMVQV
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iEYEARECAAYFAlB+/YcACgkQpGgxIkP9cwd1ngCfTJ8ziW3GxGaAZb42wK9oNqPB
DzMAoJymIVTgAuKrkFGczNeywRgZXGxG
=8Mvt
-----END PGP SIGNATURE-----

--mz5eWKkhz39mMVQV--

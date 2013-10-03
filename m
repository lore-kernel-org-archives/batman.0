Return-Path: <simon.wunderlich@s2003.tu-chemnitz.de>
Date: Fri, 4 Oct 2013 00:11:52 +0200
From: Simon Wunderlich <simon.wunderlich@s2003.tu-chemnitz.de>
Message-ID: <20131003221152.GB9172@pandem0nium>
References: <1378312060-30922-1-git-send-email-siwu@hrz.tu-chemnitz.de>
 <1378312060-30922-6-git-send-email-siwu@hrz.tu-chemnitz.de>
 <20131001090009.GD1448@neomailbox.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="WYTEVAkct0FjGQmd"
Content-Disposition: inline
In-Reply-To: <20131001090009.GD1448@neomailbox.net>
Subject: Re: [B.A.T.M.A.N.] [RFCv2 5/6] batman-adv: consider outgoing
 interface in OGM sending
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
Cc: Simon Wunderlich <simon@open-mesh.com>


--WYTEVAkct0FjGQmd
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 01, 2013 at 11:00:09AM +0200, Antonio Quartulli wrote:
> On Wed, Sep 04, 2013 at 06:27:39PM +0200, Simon Wunderlich wrote:
> > @@ -574,6 +562,13 @@ batadv_iv_ogm_can_aggregate(const struct batadv_og=
m_packet *new_bat_ogm_packet,
> >  		if (!primary_if)
> >  			goto out;
> > =20
> > +		/* packet is not leaving on the same interface.
> > +		 * TODO: some other parts here could be reworked as the
> > +		 * outgoing interface is specified now.
> > +		 */
>=20
> What does this TODO exactly mean? What could be reworked?
>=20

There might be some more places where we can optimize/save a few cycles. Th=
e forw_packet
was scheduled for all interfaces instead of individual interfaces before. T=
herefore direct
link flag handling might be simplified. TBH I'm not sure and the aggregatio=
n code is not
too easy to understand, so I preferred to not break it and put that TODO. :P

> > @@ -1449,6 +1489,10 @@ batadv_iv_ogm_process_per_outif(const struct eth=
hdr *ethhdr,
> >  					  if_outgoing, tt_buff, dup_status);
> >  	rcu_read_unlock();
> > =20
> > +	/* don't forward packet if no outgoing interface was specified */
> > +	if (!if_outgoing)
> > +		goto out_neigh;
>=20
> can this really happen? or does it mean we have a BUG?
>=20

No, this is one of the main cases actually. batadv_iv_ogm_process_per_outif=
() is called:

 * first for the out interface NULL
 * then for all interfaces

However the OGM is not forwarded for the NULL interface, only for the hard =
interfaces according
to the respective rules. The if_outgoing =3D NULL case is only for locally =
generated packets.

> > @@ -539,9 +542,12 @@ void batadv_send_outstanding_bat_ogm_packet(struct=
 work_struct *work)
> > =20
> >  	/* we have to have at least one packet in the queue
> >  	 * to determine the queues wake up time unless we are
> > -	 * shutting down
> > +	 * shutting down.
> > +	 *
> > +	 * only re-schedule if this is the "original" copy.
> >  	 */
> > -	if (forw_packet->own)
> > +	if (forw_packet->own &&
> > +	    forw_packet->if_incoming =3D=3D forw_packet->if_outgoing)
> >  		batadv_schedule_bat_ogm(forw_packet->if_incoming);
>=20
> What do you mean with "original" copy? Can an "own" packet have if_incomi=
ng !=3D
> if_outgoing?

Yes, for the forw_packet of the primary interface we have multiple copies n=
ow
for each outgoing interface (secondary interfaces). However we want to resc=
hedule
the OGM only once per period. This is why the check is neccesary. I'll rewo=
rk the
comment to make this more clear ...
>=20
>=20
> Cheers,
>=20
> --=20
> Antonio Quartulli



--WYTEVAkct0FjGQmd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEARECAAYFAlJN66gACgkQrzg/fFk7axYpkACg8lqofoV0oik1Wi0M0+bVqjTm
2w8An2xUva86P7XGFUTdM6wHdgUc6uNp
=LkAp
-----END PGP SIGNATURE-----

--WYTEVAkct0FjGQmd--

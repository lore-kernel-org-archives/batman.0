Return-Path: <ordex@autistici.org>
Date: Tue, 25 Jun 2013 15:03:16 +0200
From: Antonio Quartulli <ordex@autistici.org>
Message-ID: <20130625130316.GC3136@ritirata.org>
References: <1371232209-7808-1-git-send-email-linus.luessing@web.de>
 <1371232209-7808-2-git-send-email-linus.luessing@web.de>
 <201306250547.20341.lindner_marek@yahoo.de>
 <20130625125508.GA20017@Linus-Debian>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="iFRdW5/EC4oqxDHL"
Content-Disposition: inline
In-Reply-To: <20130625125508.GA20017@Linus-Debian>
Subject: Re: [B.A.T.M.A.N.] [PATCHv6 1/3] batman-adv: Multicast Listener
 Announcements via Translation Table
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


--iFRdW5/EC4oqxDHL
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 25, 2013 at 02:55:08PM +0200, Linus L=C3=BCssing wrote:
> > > --- a/Makefile
> > > +++ b/Makefile
> > > @@ -27,6 +27,8 @@ export CONFIG_BATMAN_ADV_BLA=3Dy
> > >  export CONFIG_BATMAN_ADV_DAT=3Dy
> > >  # B.A.T.M.A.N network coding (catwoman):
> > >  export CONFIG_BATMAN_ADV_NC=3Dn
> > > +# B.A.T.M.A.N. multicast optimizations:
> > > +export CONFIG_BATMAN_ADV_MCAST_OPTIMIZATIONS=3Dy
> >=20
> > Can we please find a shorter define ? How about "CONFIG_BATMAN_ADV_MCAS=
T" ?=20
> > That would be in line with the rest.
>=20
> Hm, yes I also don't like the length of that so much. But I had
> dismissed "CONFIG_BATMAN_ADV_MCAST" so far because I thought it
> might seem as if batman-adv were not able to handle multicast at
> all without that option.
>=20
> What about CONFIG_BATMAN_ADV_MCAST_OPT (hm, that could suggest
> 'optional', too...) or CONFIG_BATMAN_ADV_MCO?
>=20
> .oO(also don't sound as nice as the other CONFIG_ exports...)
>=20
> Ok, maybe CONFIG_BATMAN_ADV_MCAST is still the best option. I'll
> change it to that.

I agree with using the CONFIG_BATMAN_ADV_MCAST too.


>=20
> >=20
> >=20
> > > +struct batadv_hw_addr {
> > > +	struct list_head	list;
> > > +	unsigned char addr[ETH_ALEN];
> > > +};
> >=20
> > All struct defines should go into types.h or packet.h if they are sent =
over=20
> > the wire.
>=20
> This struct isn't sent over the wire, it's just for local book
> keeping. I was thinking about naming it 'struct batadv_mcast_hw_addr'
> but didn't do that because it is so generic and thought maybe
> because of that it might be reusable in the future.
>=20
> Hm, maybe it's better to rename it to 'struct
> batadv_mcast_hw_addr' anyways and leave it in that place to avoid
> bloating types.h/packet.h with "unimportant" structs and defines?

I think this struct should go into type.h too. Many structs in there are us=
ed by
a single component only, but it is better to keep them into the same file.
And yes, renaming to batadv_mcast_hw_addr is probably better (given that it=
 is
used by the mcast component only).

Cheers,

--=20
Antonio Quartulli

=2E.each of us alone is worth nothing..
Ernesto "Che" Guevara

--iFRdW5/EC4oqxDHL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBCAAGBQJRyZUUAAoJEADl0hg6qKeODQ4QAJDLWoc/2GHpZAgcpd59t9dv
o8rVVwF07Y/glwbIL+2l0/r6PGZ7GvQu61vE3h0zVoEYgv8K6B/0/qDQ+xiksbyr
TzylTgIIeP5QW6atoWjQcGlm1gKvFRbF5HUvQNlDIwvNRrncZ9Yak0MjWPzDAz9M
sVmf1jGh/VV03cAV8/VMsYC3T8onAAsto59RBvyOHbbAEz6v6QtOiMa5HCpDG4ET
JEAVKRyWgit022kG2AQ6bc/RGBTz61pfya4twRmSxp2dgLvVsMGZ4KkdW0up7PQa
bAJGAe07KKswrnL/yWE0hrbSik0sXarTEsYeI8a8lJIG3WFAsPuXutPTNeqkftiA
RRr1pPxU1mzucZxc58KYhsBsf4fG3otvwAEbWUwK0u+UrpPz1m2KuJ0qDXDhGtDm
hW5Ch2UlmosZ4WuCt9zovRDlPNQbfuEoPoVw4v0uVFXddwllCfW0Pah06f+g8ZeS
6nleWkjb9ypfPhp3SMyZigh4dSqFAdyKwmzbozKjlC0tMGVInr+laxfjEYCJZP1L
kfQku2seMRjTI7DJYCczUigCq/CaX9Ou+IMabCKB67aoZoINVfq8quOdtJ3pgclr
ZLgfJn12rLr2CbeDlss2e7/4ccYmRrpbNglYYjw6RmhM+k39+x0bYAXXh/peW4Th
BQwSj05MMMdQ99ae75//
=TopO
-----END PGP SIGNATURE-----

--iFRdW5/EC4oqxDHL--

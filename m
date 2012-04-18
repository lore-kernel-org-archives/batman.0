Return-Path: <ordex@autistici.org>
Date: Wed, 18 Apr 2012 10:37:15 +0200
From: Antonio Quartulli <ordex@autistici.org>
Message-ID: <20120418083714.GG27966@ritirata.org>
References: <1334701645-25862-1-git-send-email-ordex@autistici.org>
	<1334701645-25862-3-git-send-email-ordex@autistici.org>
	<4F8E7C5E.9010301@hundeboll.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="GdbWtwDHkcXqP16f"
Content-Disposition: inline
In-Reply-To: <4F8E7C5E.9010301@hundeboll.net>
Subject: Re: [B.A.T.M.A.N.] [PATCH 2/5] batman-adv: clear ADD+DEL (and
 viceversa) events in the same orig-interval
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: Martin =?utf-8?Q?Hundeb=C3=B8ll?= <martin@hundeboll.net>
Cc: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>


--GdbWtwDHkcXqP16f
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 18, 2012 at 10:33:34AM +0200, Martin Hundeb=C3=B8ll wrote:
> Hi Antonio,
>=20
> On 04/18/2012 12:27 AM, Antonio Quartulli wrote:
> > +	/* check for ADD+DEL or DEL+ADD events */
> >   	spin_lock_bh(&bat_priv->tt_changes_list_lock);
> > +	list_for_each_entry_safe(entry, safe,&bat_priv->tt_changes_list,
> > +				 list) {
> > +		if (!compare_eth(entry->change.addr, addr))
> > +			continue;
>=20
> Please add an empty line here.

Is this really needed for some specific reason?

>=20
> > +		if (!(!(flags&  TT_CLIENT_DEL)&&  /* ADD op */
> > +		      entry->change.flags&  TT_CLIENT_DEL)&&
> > +		    !(flags&  TT_CLIENT_DEL&&
> > +		      !(entry->change.flags&  TT_CLIENT_DEL))) /* ADD op */
> > +			continue;
>=20
> This is messy and hard to unerstand. Couldn't you use some tmp vars like =
this:
>=20
> int local_del =3D (flags & TT_CLIENT_DEL) =3D=3D TT_CLIENT_DEL;
> int change_del =3D (entry->change.flags & TT_CLIENT_DEL) =3D=3D TT_CLIENT=
_DEL;
>=20
> if (local_del =3D=3D change_del)
> 	continue;
>=20
> I'm not 100% sure I understood the original if correctly, but that just p=
roofs the need to rework it :)

eheh, I know I like to mess up the code with boolean formulas :D
Thank you for your feedback, I will simplify it.

>=20
> > +		/* DEL+ADD in the same orig interval have no effect and can be
> > +		 * removed to avoid silly behaviour on the receiver side. The
> > +		 * other way around (ADD+DEL) can happen in case of roaming of
> > +		 * a client still in the NEW state. Roaming of NEW clients is
> > +		 * now possible due to automatically recognition of "temporary"
> > +		 * clients */
>=20
> Remember newline for */ :)

yes .-.


Thanks again!


--=20
Antonio Quartulli

=2E.each of us alone is worth nothing..
Ernesto "Che" Guevara

--GdbWtwDHkcXqP16f
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQEcBAEBAgAGBQJPjn06AAoJEFMQTLzJFOZFHU4IAJ4XtuZ6EIuiu+cmFs1M8XrF
V5tUviCNlT1hEfPDT4JW+OfD4sdo/quebXnpr1pYePNA62Oy5AidR8UOscVGdFSH
0nea39xkvW6jPbjjkciQHFNHEu6F4fckE/9rNeS0UVg/DYbo9tVFRh6Ogcd29yLM
OPz4++6FzHRYbS5ocKDtrvsR6ahG86rGJz18+bdXfiYrqeXLdzr4dE7hY0mHCuRi
AgxsX1C18KPrsGpDquQ2y9BRQrNE5PuPVLel3SUKFLTFJtOMs5k+6Gjdpk3+FkMu
IuAbE/lTIFP28MtX7SrgjA0nXsEPAwVBOf9mCzjA01KlQIgkfYKOTkVWZy24+/w=
=EcF5
-----END PGP SIGNATURE-----

--GdbWtwDHkcXqP16f--

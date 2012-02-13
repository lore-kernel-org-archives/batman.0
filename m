Return-Path: <ordex@autistici.org>
Date: Mon, 13 Feb 2012 21:33:52 +0100
From: Antonio Quartulli <ordex@autistici.org>
Message-ID: <20120213203343.GA19783@ritirata.org>
References: <1328830902-11574-1-git-send-email-ordex@autistici.org>
	<1328830902-11574-4-git-send-email-ordex@autistici.org>
	<201202112159.58282.lindner_marek@yahoo.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="3uo+9/B/ebqu+fSQ"
Content-Disposition: inline
In-Reply-To: <201202112159.58282.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCHv5 3/9] batman-adv: Distributed ARP Table
 - create DHT helper functions
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
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>


--3uo+9/B/ebqu+fSQ
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 11, 2012 at 09:59:57PM +0800, Marek Lindner wrote:
> On Friday, February 10, 2012 07:41:36 Antonio Quartulli wrote:
> > +       for (select =3D 0; select < DHT_CANDIDATES_NUM; select++) {
> > +               max =3D 0;
> > +               max_orig_node =3D NULL;
> > +               if (!chosen_me) {
> > +                       /* if true, wrap around the key space */
> > +                       if (bat_priv->dht_hash > ip_key)
> > +                               max =3D DAT_ADDR_MAX - bat_priv->dht_ha=
sh +
> > +                                       ip_key;
> > +                       else
> > +                               max =3D ip_key - bat_priv->dht_hash;
> > +                       max =3D bat_priv->dht_hash;
>=20
> Somehow this does not make sense to me. Why do we calculate a magic value=
 for=20
> "max" if we set it to bat_priv->dht_hash afterwards ?

Thank you, actually I didn't spot it in the tests because of the limited nu=
mber
of nodes involved. I thought they were enough.

> Moreover, the name dht_hash is a bit confusing. At first I thought it is =
a=20
> pointer to a hash (read: orig_hash/tt_local_hash/tt_global_hash/etc).

ok, I'll rename it to dht_id (or dht_addr ?)

> Perhaps=20
> the comment should explain what and why the magic is supposed to achieve=
=20
> instead of stating what the c code is obviously doing ?
>=20

I agree :-)


Thanks!


Cheers,

--=20
Antonio Quartulli

=2E.each of us alone is worth nothing..
Ernesto "Che" Guevara

--3uo+9/B/ebqu+fSQ
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.18 (GNU/Linux)

iQEcBAEBAgAGBQJPOXOsAAoJEFMQTLzJFOZFKsEH/1xsQSyOtJuECkdSLWnR2s6h
1tt8y/RAGtH/ZrpIA35GlfAhmNkPudzG/2QNcb3bFbvPOkGlZRay3KdT1CVV11R9
MVwwwmxiftkZxlfYqKz7lYgj7afoqlTwOdg3vWrD0LQMIB3ymSLmQV54h1OgJQ8U
iQHNAdrC8RECLhAmqycRqrk6B3585eeXLAsXnBzWvvr+Vc53WbuIL4JzUYP3oZZT
uu2+zkefIZYkZHXz0axwFAai/XNOsO+El7SZxqjuK1hiPpVJ7F0TS4ESFRs7lyij
ziADgQAryWDR8SrGp1D2CvHuUs+1H4dbdMtS46075yDMJzUdodLczSdjWP2qOqQ=
=dHK6
-----END PGP SIGNATURE-----

--3uo+9/B/ebqu+fSQ--

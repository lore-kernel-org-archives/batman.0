Return-Path: <ordex@autistici.org>
Date: Sat, 20 Apr 2013 15:56:36 +0200
From: Antonio Quartulli <ordex@autistici.org>
Message-ID: <20130420135636.GB5732@ritirata.org>
References: <CAP5XTDOompgC27u857UaC6UZ6pk1mg6BnLdtsEL1uMgMq452bw@mail.gmail.com>
 <20130419123826.GB13226@ritirata.org>
 <CAP5XTDM4yWxbjEDSDkAyAuizLQDh97Ea616tGOs-dS5YBKgX-A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="n2Pv11Ogg/Ox8ay5"
Content-Disposition: inline
In-Reply-To: <CAP5XTDM4yWxbjEDSDkAyAuizLQDh97Ea616tGOs-dS5YBKgX-A@mail.gmail.com>
Subject: Re: [B.A.T.M.A.N.] [RFCv3] batman-adv: Modified DAT structures and
 functions in order to support both IPv4 and IPv6
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


--n2Pv11Ogg/Ox8ay5
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 19, 2013 at 09:39:17 +0300, Mihail Costea wrote:
> On 19 April 2013 15:38, Antonio Quartulli <ordex@autistici.org> wrote:
> >
> > I think this define is pretty overkill..What about creating a function =
which
> > only takes care of converting a generic DHT data in a string. Later you=
 can
> > invoke this function when you want to print an IPv4/6 using batadv_dbg.
> >
> > Here is an example:
> >
> > char *batadv_dat_data_to_str(struct batadv_dat_entry *dat_entry,
> >                              const char *buf, size_t buf_len)
> > {
> >         /* do something and put the string representation of the entry =
in the
> >          * buf, without exceeding buf_len.
> >          * Remember to use IS_ENABLED(CONFIG_IPV6) inside
> >          */
> >
> >
> >         return buf;
> > }
> >
> > Then you can call it directly as parameter of a batdv_dbg function. E.g:
> >
> > batadv_dbg(....," %s\n", batadv_dat_data_to_str(entry, buf, buf_len));
> >
> > I think this approach would be better and easy to extend for future dat=
a types.
> > If you like this approach, what do you think about sending a patch now =
to add
> > this function to the current code?
> >
>=20
> This could work. buf could be a string with a given pattern inside
> (let's say %data, or something similar) that would be automatically
> converted to the right type (like %pI4, or %pI6c.

mh..I did not quite get this..If you know how to implement this "pattern
substitution" you can send a patch with that. Otherwise what I proposed abo=
ve is
just another way of doing that, which is at least simpler and easier to read
than the macro you proposed before (imho)


Cheers,

--=20
Antonio Quartulli

=2E.each of us alone is worth nothing..
Ernesto "Che" Guevara

--n2Pv11Ogg/Ox8ay5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBCAAGBQJRcp6UAAoJEADl0hg6qKeO3hIP/0hN53/86MITI/I64OP8bzBi
K9zBWvmetxVDjpwDfn7vx9AF7sqX3it8VR/hB98new32ZTOvnwgIcma2pi5ZqqKm
vhTmLG6nLbnY5M2jpTCkC5Wm/HdoJeryXOBmnhbCMeVvu2UqHYmLkXmVwNesCh68
xvFhmMq3ScTHcoUYhLhU3shh1A449VZlIw65ybEs9IZ4fGBrgza0w5NYnC1KmZZG
PoEX79ogZslS9ODhKHREum4/jCoKoPB2S/3TqBY0H6NPpKd8R9Mx5PMudrNjfMem
yMtF+Pm068aE1rAkjBb+gXfhlKzW8ZEk9GR7IYEalN3/lgLm9Z4xO70B0r6XuqVd
egcHkULLY2HvALoNWY3bFcm4YQpj7qJ5XsW1dwc75IwrPqkFLAqUkEKsJeH5IbL2
Vo7D4i6Mgy+NdLwp7mT/UBvk2iY3MhW9q5+R5Ixt+INoqb9su70fm70sHSPy0eRs
7ppa8pLUpOFvoIF2KpOoUHNnpHtwoDCtDpA6RD2+JXK3CNfbLZKTtr8ocF4zlUzy
hGAxxxhB3tEF+XLfny203Jxz9PQrVEEvDd8a4MW74P5aH0L/qLu3e8ux4cAnGYj4
p858hHvs7Rn1pS8J9rQtpcyggb9dMJgXzXj3lM6uGxl/b+daSm2C4+YSXEs3MsdT
7doF/6loB8b7+fJ/8o8M
=mSCT
-----END PGP SIGNATURE-----

--n2Pv11Ogg/Ox8ay5--

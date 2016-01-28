Return-Path: <a@unstable.cc>
Date: Thu, 28 Jan 2016 10:29:30 +0800
From: Antonio Quartulli <a@unstable.cc>
Message-ID: <20160128022930.GB22112@prodigo.lan>
References: <1453312110-32683-1-git-send-email-andrew@lunn.ch>
 <1453312110-32683-5-git-send-email-andrew@lunn.ch>
 <20160128012807.GA22112@prodigo.lan>
 <20160128014007.GA28633@lunn.ch>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="XF85m9dhOBO43t/C"
Content-Disposition: inline
In-Reply-To: <20160128014007.GA28633@lunn.ch>
Subject: Re: [B.A.T.M.A.N.] [PATCH 4/4] batman-adv: debugfs: Add netns
	support
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: Andrew Lunn <andrew@lunn.ch>
Cc: b.a.t.m.a.n@lists.open-mesh.org


--XF85m9dhOBO43t/C
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 28, 2016 at 02:40:07AM +0100, Andrew Lunn wrote:
> On Thu, Jan 28, 2016 at 09:28:07AM +0800, Antonio Quartulli wrote:
> > On Wed, Jan 20, 2016 at 06:48:30PM +0100, Andrew Lunn wrote:
> >=20
> > [...]
> >=20
> > > +static DEFINE_MUTEX(batadv_debugfs_ns_mutex);
> >=20
> > [...]
> >=20
> > > +static void batadv_debugfs_ns_put(struct net *net)
> > > +{
> > > +	struct batadv_debugfs_ns_entry *ns_entry;
> > > +
> > > +	mutex_lock(&batadv_debugfs_ns_mutex);
> > > +	list_for_each_entry(ns_entry, &batadv_debugfs_ns, link) {
> > > +		if (ns_entry->net =3D=3D net) {
> > > +			kref_put(&ns_entry->refcount, batadv_ns_entry_release);
> > > +			break;
> > > +		}
> > > +	}
> > > +	mutex_unlock(&batadv_debugfs_ns_mutex);
> > > +}
> > > =20
> >=20
> > Andrew, is there any particular reason why in this case we use a mutex =
instead
> > of a spinlock + RCU ? I imagine it is something related to debugfs..or =
just to
> > make the code simpler as we don't really require a full-blown RCU strat=
egy ?
> =20
> I just wanted it to be KISS. We are on a very slow path, only called
> when interfaces are added and removed. Keeping it KISS makes it easier
> to review, make sure i have an unlock for every lock, etc. It is also
> what is the kref documentation suggests.

ok, thanks for explaining, Andrew!
I agree with that, but I wanted to be sure I was understanding the ratio
behind :)


> > how about:
> >=20
> > 	debugfs_ns_dir =3D batadv_debugfs;
> >=20
> > > +	if (net !=3D &init_net) {
> > > +		debugfs_ns_dir =3D batadv_debugfs_ns_get(net);
> > > +		if (!debugfs_ns_dir)
> > > +			goto out;
> > 	}
> >=20
> > 	hard_iface->debug_dir =3D debugfs_create_dir(name, debugfs_ns_dir);
> >=20
> > isn't it nicer? :)
>=20
> O.K, i will rearrange.

The last chunk reported in my reply could be rearranged the same way.




Thanks a lot!
Other than these points the patch seems sound to me.

Cheers,


--=20
Antonio Quartulli

--XF85m9dhOBO43t/C
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJWqX0KAAoJENpFlCjNi1MRkIkP/0ljkEOHxE7ESzTv+TbFRcPW
m/Qcyl6Rb9csPJwEmKfNr+FhoxemRfFJERCxv5e0yYjAo6wr2Vj6wPuX9QOJjdkm
cFiHfZ/h/0oCMXUbLTf0OTAuMnPiMJBeexMcaJhzdH1wbyE1fBDWGN9p63Czv+xd
jupStQJsS8wymGvz3kWUP4ZYYJvvI/7biU22O6WaSTJLOYlsqmYZ/m6YRmV5SAer
eOgVyepja7a+PVWQ2KCohdP6JwHN489qhNTrLJRRd+acdBO3NowLhzcRMicSVwwq
5vyZYT5E/Zmwhfpl7j5eLT/1jpNg2pB7QPAZG8yRVy9xSI+NMJ1sv+hshhDu9Zil
y0fLoy2QrZ6TmIz13eRGhlxvEsRZzyJvzNlXr1EWrZoY364ek2U/ebAPGU3NlRGN
qA3JD+AV2hehWG+PTPi5xziRo0KESIsLjObuyQk/Em2ubcnfDNmP3unMANBHei99
uyzcXZxBTqzIQhnFjDAKzxvVcga1P/Zaa2e1v1caYA8U2a34Hk51J2cEQ64Kr0mS
X4pm7dkBBlRGeczFDm8+YS6ES8xnEF689haKK03cLiyq9hTdJBgQw36z2kN3nOCW
try0FJ3HXnI3/KMlq1BcoRDfkDhtCLupp+hBsrk9mCWzwZFlMwfFNNtbFd3upmKO
pKb4Z9wXm/CJKYq5eXTR
=d2Vd
-----END PGP SIGNATURE-----

--XF85m9dhOBO43t/C--

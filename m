Date: Tue, 18 Nov 2008 01:12:07 +0100
From: Simon Wunderlich <simon.wunderlich@s2003.tu-chemnitz.de>
Subject: Re: [B.A.T.M.A.N.] Batman security
Message-ID: <20081118001207.GB11646@pandem0nium>
References: <35301.149.5.32.200.1226956767.squirrel@www.rivertowermail.com>
	<20081117220052.GB6516@pandem0nium>
	<57655.149.5.32.200.1226965691.squirrel@www.rivertowermail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="oC1+HKm2/end4ao3"
Content-Disposition: inline
In-Reply-To: <57655.149.5.32.200.1226965691.squirrel@www.rivertowermail.com>
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@open-mesh.net>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.open-mesh.net>
List-Unsubscribe: <https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=unsubscribe>
List-Archive: <http://list.open-mesh.net/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@open-mesh.net>
List-Help: <mailto:b.a.t.m.a.n-request@open-mesh.net?subject=help>
List-Subscribe: <https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@open-mesh.net>


--oC1+HKm2/end4ao3
Content-Type: text/plain; charset=utf8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey Derek,

yep, thats the point: people want encryption, but personally i think no
encryption is better than a flawed encryption which leads to the
assumption that "your data is safe". People will bother about securing
their own connection, using SSL or VPNs, and that's generally a good
thing. :)

Maybe using a VPN from each AP to a central server is an option for you.=20
In this case you could give each AP its own certificate, and only one=20
node is compromised if a bright person hacks it. (On the other hand, if the
bright person knows how to hack one box, he can easily hack another ...
;)

regards,
	Simon

On Mon, Nov 17, 2008 at 11:48:11PM -0000, Derek C wrote:
> Hi Simon,
>=20
> I'll look into WPA-NONE (I haven't found much information yet all right).=
=20
> I'm just a bit concerned about no encryption at all - although you are
> right about using a shared key when its fully considered).
>=20
> I'm planning on controlling the MESH boxes myself and giving people free
> broadband (I need to control the boxes because its very hard to get things
> working exactly right).  But still - I'm sure some bright people will get
> into a box and thats the key out.  But people worry about encryption, or
> lack of, even if its flawed
>=20
> Derek
>=20
>=20
> On Mon, November 17, 2008 10:00 pm, Simon Wunderlich wrote:
> > Hello Derek,
> >
> >
> > no, there isn't something like this in BATMAN. You might want to have a
> > look at WPA-NONE though, which can encrypt both data and routing traffic
> > on the 802.11 layer for Ad-Hoc networks with TKIP or AES/CCMP (beware,
> > it's pretty undocumented ...).
> >
> > For both, the OLSR security routing plugin (as far as i understood it)
> > and WPA NONE, you have the problem of a shared, symmetric key. If each =
node
> > has the key and you have a pretty decentralized setup, you might see yo=
ur
> > key on a website or ebay before you can even think about it. ;)
> >
> > So the first question should be what you secure against whom, which
> > possible attackers are to be considered etc. We can discuss this furthe=
r if
> > you want. Not implementing a security feature in BATMAN was not only a
> > design decision for minimalism, but we also could not find a scenario
> > where this "protection" would be useful or would handle the situation
> > better than conventional mechanisms.
> >
> > best regards, Simon
> >
> >
> > On Mon, Nov 17, 2008 at 09:19:27PM -0000, Derek C wrote:
> >
> >> Hi all,
> >>
> >>
> >> Is there any way to secure the traffic on the adhoc NIC with BATMAN -
> >> like the secure plugin in OLSRd?
> >>
> >> thanks,
> >>
> >> Derek
> >>
> >>
> >>
> >> --
> >> Derek C
> >>
> >>
> >> _______________________________________________
> >> B.A.T.M.A.N mailing list
> >> B.A.T.M.A.N@open-mesh.net
> >> https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n
> >>
> >>
> > _______________________________________________
> > B.A.T.M.A.N mailing list
> > B.A.T.M.A.N@open-mesh.net
> > https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n
> >
> >
>=20
>=20
> --=20
> Derek C
>=20
> _______________________________________________
> B.A.T.M.A.N mailing list
> B.A.T.M.A.N@open-mesh.net
> https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n
>=20

--oC1+HKm2/end4ao3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFJIghXrzg/fFk7axYRApi/AJ95IPgsEugZ/IGS8VinyjTDv+kMyQCggiJ/
5uFgQsK4vARa5cLgAZpKwfw=
=kWp0
-----END PGP SIGNATURE-----

--oC1+HKm2/end4ao3--

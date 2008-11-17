Date: Mon, 17 Nov 2008 17:22:46 +0100
From: Simon Wunderlich <simon.wunderlich@s2003.tu-chemnitz.de>
Subject: Re: [B.A.T.M.A.N.] Visualization server
Message-ID: <20081117162246.GA26966@pandem0nium>
References: <49626.149.5.32.200.1226911838.squirrel@www.rivertowermail.com>
	<200811171044.56591.sven.eckelmann@gmx.de>
	<39216.149.5.32.200.1226916266.squirrel@www.rivertowermail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="EeQfGwPcQSOJBaQU"
Content-Disposition: inline
In-Reply-To: <39216.149.5.32.200.1226916266.squirrel@www.rivertowermail.com>
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


--EeQfGwPcQSOJBaQU
Content-Type: text/plain; charset=utf8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

sorry for the link breakage, we're in the middle of moving our wiki to a
new system. Please use

https://www.open-mesh.net/batman-old/vis

in the meantime.=20
(btw, Can you tell me where you have seen the link to this page?)

regards,
	Simon

On Mon, Nov 17, 2008 at 10:04:26AM -0000, Derek C wrote:
> Hi Sven,
>=20
> That's great - the vis server compiled and ran perfectly.  I'll try it out
> with a few test nodes now.
>=20
> thanks very much
>=20
> Derek
>=20
> On Mon, November 17, 2008 9:44 am, Sven Eckelmann wrote:
> > On Monday 17 November 2008 09:50:38 Derek C wrote:
> >
> >> Hi all,
> >>
> >>
> >> Is there any links re: a batman visualization server?  (servers
> >> themselves and/or the visualization protocol format?)
> > Sry, but I don't understand what you want here. Ok, I will add
> > informations for the stuff in the parenthesis.
> >
> > For downloads see https://dev.open-mesh.net/batman/wiki/Download
> >
> >
> > Specification does only exist in form of the source code.
> > The nodes will only send their current neighbors and quality informatio=
ns
> > to the vis server over udp (port 4307) The format of the packets is not
> > really complex.
> >
> > The basic packet has a header which looks like that:
> > address sender_ip; /* 4 bytes network byte order */ guint8 version;    =
/*
> > currently 23 */ guint8 gw_class;   /* encoding:
> > http://tools.ietf.org/html/draft-openmesh-b-a-t-m-a-n-00#section-7.1 */
> > guint8 tq_max;     /* maximum transmission quality */
> >
> > After the header are n data chunks which looks always like:
> > guint8 type;  /* 1 - NEIGH; 2 - SEC_IF; HNA - 3 */ guint8 data;  /* (ty=
pe
> > =3D=3D NEIGH) transmission quality between two nodes
> > (type =3D=3D HNA) current netmask */
> > address ip;   /* 4 bytes network byte order - address of the host which
> > link (sender_ip -> ip) is described here */
> >
> >> I've seen a link to https://www.open-mesh.net/batman/vis but I've
> >> noticed that (generally) links to open-mesh.net seem to all give 404s.
> > Yes, the page was removed (only some screenshots on it and nobody creat=
ed
> > a HTTP 301 Moved Permantly rewrite for it. Maybe somebody could add
> > following to the .htaccess inside the folder for
> > https://www.open-mesh.net/batman/ (or
> > configure the apache otherwise): RewriteEngine On
> > RewriteRule .* https://dev.open-mesh.net/batman/ [R=3D301,L]
> >
> >
> > Take a look at
> > http://web.archive.org/web/20080109231515/http://open-mesh.net/batman/v=
is
> > for the old page.
> >
> > Best regards,
> > Sven Eckelmann
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

--EeQfGwPcQSOJBaQU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFJIZpWrzg/fFk7axYRAvcBAJ9d8Aqy9uQCTQEwMopGhDRYof19xgCeLw2t
dWK54vXL6nZ7QmQKGvkCP/g=
=gnp5
-----END PGP SIGNATURE-----

--EeQfGwPcQSOJBaQU--

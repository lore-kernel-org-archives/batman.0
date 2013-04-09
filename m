Return-Path: <ordex@autistici.org>
Date: Tue, 9 Apr 2013 11:01:01 +0200
From: Antonio Quartulli <ordex@autistici.org>
Message-ID: <20130409090101.GB3624@ritirata.org>
References: <516398DB.3070108@wirelesspt.net>
 <20130409062848.GA3624@ritirata.org> <5163D7ED.3030204@einfach.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="VrqPEDrXMn8OVzN4"
Content-Disposition: inline
In-Reply-To: <5163D7ED.3030204@einfach.org>
Subject: Re: [B.A.T.M.A.N.] horst and batman-adv
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
To: Bruno Randolf <br1@einfach.org>
Cc: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>


--VrqPEDrXMn8OVzN4
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 09, 2013 at 09:57:17AM +0100, Bruno Randolf wrote:
> On 04/09/2013 07:28 AM, Antonio Quartulli wrote:
> > On Tue, Apr 09, 2013 at 12:28:11AM -0400, cmsv wrote:
> >> I found about Horst a few years ago when i got to know olsr and it's
> >> usefulness for olsr mesh networks and recently decided to check it out
> >> again.
> >> Although i do see an option for batman i am not sure if it refers to
> >> batmand or batman-adv and as i wait for an answer from it's developer.
> >>
> >> My question is if there are any plans for a similar tool from open-mesh
> >> side.
> >> I am also curious to know if someone is using it with batman-adv or
> >> anything equivalent/similar or close ?
> >> What are our options.
> >>
> >> http://br1.einfach.org/tech/horst/
> >
> > Hello cmsv,
> >
> > I've used it once, but without any interaction with batman-adv or olsr.
> > I just looked for the pollution in the channels.
> >
> > How is it supposed to interact with the protocol?
>=20
> Hello!
>=20
> I'm the author of "horst". There is not much interaction with the=20
> protocol, except that the packets are marked as such, e.g. nodes which=20
> send OLSR packets are marked as OLSR nodes, nodes which send batman (L3)=
=20
> messages marked as batman nodes. It's quite easy to add the same for=20
> batman-adv, but it's not there at the moment.

Oh ok, thanks for the explanation Bruno!

So, as I suspected, there is nothing preventing from using it with batman-a=
dv.
We will only miss the mark on the nodes.

@cmsv: so there is no need for "another tool", horst itself can be used
in a batman-adv network as well :)

Cheers,

--=20
Antonio Quartulli

=2E.each of us alone is worth nothing..
Ernesto "Che" Guevara

--VrqPEDrXMn8OVzN4
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBCAAGBQJRY9jNAAoJEADl0hg6qKeOewoQAIRT2W51c2EzXVC7sWZe8o6h
AL+9p70zD+NSA3Jxb1IxHip7U1/9vhF+1yyHT4jzRoa0eazp5xzWboNipE7LEesT
mUgntwt6ZGt7AerV5X/xh28YgD1yhegvJ56S22UQ0sdCKjITTl3ToZL/UYRyyNy+
U80jbRQphF+CtvQmfpYLzT+dO4FcCww5weXA/u/KgVHAAOl0L6kwYEj8gKb5mHHf
fGrwMz1MEqJFgHROZ7wl4DuiZ7GfufUo6oB4+umBEf/6XCGnE4u6cUYyz7gTOuIw
W+xbjg3ccEZ5yQoDR7r0vsN/SOdGqwud1q3gkKYXVj82SxvF6heGEuBbrDcb7IK1
SQsTTUe9n53du/jnyGtNoTgfQ44SbBVAVbdtXTvHGuUQSu0jsf//k+3AosFcdeUl
EBgg5QAZ6PMYtKtFowGvrsfu9zXPVQKp2t+ktkauD4cIEssX3tuNWzuoG47oLN0w
//1dKhoALUsVLOHsoAIEwPHwqjDnpsbuk/MuNmtndWpuXbXFDMH1Im/NfBa48n4x
BzZu4dvuSjaZguLkDEmYQKeqljYagmSKRnVHXVeIoZNOqRMGCANhNXOsK3mb6wS7
n9MdETOZxQ+gxisDdfwlE9zrmkHpZ2o6cl1WAqYCAfLYSctEOLK5l/go0UAuWcLd
HFF6P7INg6Xciydkfnny
=/6n0
-----END PGP SIGNATURE-----

--VrqPEDrXMn8OVzN4--

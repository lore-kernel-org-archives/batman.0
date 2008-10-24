Date: Fri, 24 Oct 2008 13:31:54 +0200
From: Simon Wunderlich <simon.wunderlich@s2003.tu-chemnitz.de>
Subject: Re: [B.A.T.M.A.N.] dose batman-adv support multi-gateway
Message-ID: <20081024113154.GA7911@pandem0nium>
References: <200810241543070787033@mail.ioa.ac.cn>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="mYCpIKhGyMATD0i+"
Content-Disposition: inline
In-Reply-To: <200810241543070787033@mail.ioa.ac.cn>
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


--mYCpIKhGyMATD0i+
Content-Type: text/plain; charset=utf8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello =E5=94=90=E9=BC=8E,

Gateway things are not handled by batman-adv, this is a Layer 3 issue.

But lets assume you have a router/gateway C in the wired network of your
2 gateways A, B. Then there are two possible routes:

You -----(mesh)----> A ---> C
You -----(mesh)----> B ---> C

Only one of these routes is chosen, depending on which route looks
better for the BATMAN algorithm in the moment of sending the packet.=20
So it always uses only the best route, but not both (as you can see,=20
it always chooses the "better gateway").=20

Using both routes simultaneously is an open research topic (look for=20
buzz-/keywords like "multipath routing"), but we have no working=20
implementation for this. In the best case its possible to gain more
bandwidth, but this is only possible with multiple disjoint
(interference-free) routes.

Don't hesitate to ask more if i couldn't answer your question.

regards,
	Simon

[1] http://www.cs.huji.ac.il/labs/danss/sensor/adhoc/routing/lee_2001splitm=
ultipath.pdf

On Fri, Oct 24, 2008 at 03:43:07PM +0800, =E5=94=90=E9=BC=8E wrote:
> hi
> dose batman-adv support multi-gateway.=20
> If there is a router  which connets two mesh devices(gateway) through sam=
e layer 2 wired network, can the mesh network select a better gateway to th=
e router for one packet.=20
>=20
> 2008-10-24=20

> _______________________________________________
> B.A.T.M.A.N mailing list
> B.A.T.M.A.N@open-mesh.net
> https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n


--mYCpIKhGyMATD0i+
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFJAbIqrzg/fFk7axYRAkASAJ9bH+r2bg6McjgRKDW1lorcPL0YQgCcD1/h
94BUhPkH8Y4Otz/+QieHsQA=
=BT0+
-----END PGP SIGNATURE-----

--mYCpIKhGyMATD0i+--

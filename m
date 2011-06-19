Return-Path: <simon.wunderlich@s2003.tu-chemnitz.de>
Date: Sun, 19 Jun 2011 21:41:19 +0200
From: Simon Wunderlich <simon.wunderlich@s2003.tu-chemnitz.de>
Message-ID: <20110619194119.GB30791@pandem0nium>
References: <BANLkTi=1-+rypSNN-GJvi1rCh_W_SCVH0w@mail.gmail.com>
	<201106191309.01399.lindner_marek@yahoo.de>
	<BANLkTi=3o4mFyrRnVo8WZF5gCejzFVPGCQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="cmJC7u66zC7hs+87"
Content-Disposition: inline
In-Reply-To: <BANLkTi=3o4mFyrRnVo8WZF5gCejzFVPGCQ@mail.gmail.com>
Subject: Re: [B.A.T.M.A.N.] Vis server
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


--cmJC7u66zC7hs+87
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Wayne,

if you want access from outside the mesh, you should set up one of the mesh=
 nodes
to share information, e.g.:

 1.) set up a netcat server which constantly runs "batctl vd dot"
 2.) periodically (or on demand?) ssh in to a mesh node which

We have used solution 1 for meshs3d and it works quite fine. It will give y=
ou pretty
much the same behaviour as the old vis server.

Regards,
	Simon

On Sun, Jun 19, 2011 at 01:39:06PM +0200, wayne abroue wrote:
> On Sun, Jun 19, 2011 at 1:09 PM, Marek Lindner <lindner_marek@yahoo.de> w=
rote:
> >
> > Hi,
> >
> >> I'm trying to interogate vis on a bat-adv server node, Can anybody
> >> point me in the right direction, It's for use with this
> >> http://villagetelco.org/2011/06/spud-simple-unified-dashboard-for-mesh=
-netw
> >> orks/ It works with batman, but not with bat-adv.
> >
> > unlike batmand (our layer 3 implementation) batman-adv has the vis serv=
er
> > built-in. Using the layer 3 vis server on top of batman-adv won't help =
you.
> >
> > Please read our documentation regarding the layer 2 vis server first an=
d feel
> > free to come back with any questions you might have:
> > http://www.open-mesh.org/wiki/batman-adv/VisAdv
> >
> > Regards,
> > Marek
> >
>=20
> Thanks Marek, I get this, and vis is working internally in my bat-adv
> environment, What this implementation is trying to do is monitor the
> vis from outside the mesh, thus my question?
> How could this be achieved?
>=20
> Wayne
>=20

--cmJC7u66zC7hs+87
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAk3+UN8ACgkQrzg/fFk7axZLVQCfbG5mn2s/q7Uyv+uNWouw2f3D
SigAn29lAPjnW0wnf4A2zhgxi5OgaZh7
=1trs
-----END PGP SIGNATURE-----

--cmJC7u66zC7hs+87--

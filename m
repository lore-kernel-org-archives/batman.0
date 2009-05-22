Date: Fri, 22 May 2009 13:08:26 +0200
From: Simon Wunderlich <simon.wunderlich@s2003.tu-chemnitz.de>
Message-ID: <20090522110826.GA26812@pandem0nium>
References: <1242937180.14711.14.camel@turing.asconix.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="6TrnltStXW4iwmi0"
Content-Disposition: inline
In-Reply-To: <1242937180.14711.14.camel@turing.asconix.lan>
Subject: Re: [B.A.T.M.A.N.] VIS server for batman-adv-kernelland
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@open-mesh.net>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.open-mesh.net>
List-Unsubscribe: <https://lists.open-mesh.net/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.net/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@open-mesh.net>
List-Help: <mailto:b.a.t.m.a.n-request@open-mesh.net?subject=help>
List-Subscribe: <https://lists.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=subscribe>
To: christoph.pilka@googlemail.com, The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@open-mesh.net>


--6TrnltStXW4iwmi0
Content-Type: text/plain; charset=utf8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Christoph,

On Thu, May 21, 2009 at 10:19:40PM +0200, Christoph Pilka wrote:
> Hi folks,
>=20
> my goal is to visualize batman-adv-kernelland network topology. 'echo
> "server" > /proc/net/batman-adv/vis' activates vis server on the mesh
> node directly, right?=20

Yes, that's right.
> Do the other nodes find the vis server
> autmagically?=20

Yup, they do.

> What happens, if I wanna use more than one vis server?=20

The running vis servers synchronize each other. You can set up multiple
vis servers inside your mesh (this is different from L3 batman).

> And
> the last and most important question: is it possible to run a vis server
> outside the mesh running layer 2 batman-adv?=20

That's not possible. They only run within the batman-adv module, and you
can only access the data locally on the node. One thing you can do is
building a script with ssh, e.g.

ssh <yournode> 'cat /proc/net/batman-adv/vis'

which would give you the topology even on a remote node.
What you can also do is building a vis server similar to the L3 one
on the node by using netcat and a small shellscript which prints out
/proc/net/batman-adv/vis in a loop.


> The layer 3 vis runs fine
> but I have no clue how to get the visualization running on batman-adv
> nodes. How to tell the vis server on the mesh nodes to output their data
> to a dot-draw server (s3d) ? Lot of questions ;-)

if you build a vis server with netcat and a shellscript this will be possib=
le.
Please note however that you might need to patch the s3d visualization prog=
ram
(olsrs3d or meshs3d) as it expects IP addresses, not MAC addresses. This is=
 not
hard to do ....

>=20
> For the German readers: I am documenting all the stuff on
> http://debian.asconix.com/batman-advanced-openwrt-howto but I think, the
> way I'm describing in the vis chapter is the way to get vis running in
> layer3 batman, isn't it?
>=20

Right, your description references to the layer 3 vis server. Layer 2 is
a little bit different ...
> Greets,
> Chris
>=20
> --=20
> "Privacy in residential applications is a desirable marketing
> option." (ETSI EN 300 175-7 Ch. A6)
>=20
> _______________________________________________
> B.A.T.M.A.N mailing list
> B.A.T.M.A.N@open-mesh.net
> https://lists.open-mesh.net/mm/listinfo/b.a.t.m.a.n
>=20

--6TrnltStXW4iwmi0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkoWh6oACgkQrzg/fFk7axazzwCdEj0eeCi+lI10Fjo3IXevv78Q
PWYAn01bptuXhZX+bo6rXE5Sm1n8N3jt
=ouCT
-----END PGP SIGNATURE-----

--6TrnltStXW4iwmi0--

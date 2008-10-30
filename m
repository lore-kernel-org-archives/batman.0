Date: Thu, 30 Oct 2008 21:16:28 +0100
From: Simon Wunderlich <simon.wunderlich@s2003.tu-chemnitz.de>
Subject: Re: [B.A.T.M.A.N.] batman - how does "fast internet connection"
	connection work
Message-ID: <20081030201628.GA1015@pandem0nium>
References: <1225349370.13082.53.camel@desiree>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="sm4nu43k4a2Rpi4c"
Content-Disposition: inline
In-Reply-To: <1225349370.13082.53.camel@desiree>
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
To: david.lloyd.johnson@gmail.com, The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@open-mesh.net>


--sm4nu43k4a2Rpi4c
Content-Type: text/plain; charset=utf8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello David,

On Wed, Oct 29, 2008 at 11:49:30PM -0700, david johnson wrote:
> Hi
>=20
> First an introduction - I am a David Johnson - I've been working on mesh
> protocols for a few years now and I've built a 49 node wireless grid to
> benchmark mesh protocols in South Africa:
> http://wirelessafrica.meraka.org.za/wiki/index.php/49-node_Indoor_Mesh
>=20
> Elektra and I did some experiments with batman (do I have to use the
> dots @#!!!) and olsr at the beginning of the year and we wrote a paper
> showing how batman outperforms olsr on CPU usage and better throughput
> due to less flapping. The results were very impressive!

Nice. :)

>=20
> I'm now in the USA starting a PhD in mesh and I've decided to work on
> batman in one of my networking projects. We have this idea to try and
> improve gateway location performance by measuring real throughput at the
> gateway and then allowing nodes to optimally pick gateways that will
> give them the best throughput to the Internet but in a fair manner - ie.
> one user musn't disadvantage another.

That sounds interesting! Please keep us informed. ;)

>=20
> I would like to understand how the =EF=BB=BF"fast internet connection" ga=
teway
> location node works
> batmand -r 1 [interface]?:
>=20
> It says it considers link quality and advertised gateway class - what
> formula does it used to combine these two together so that it compare
> others against each other.

You can look it up at batman.c:393 (in the current trunk)
The formula used is:

  max( TQ^2 * download_speed )=20

(with a constant factor which is not relevant for the maximum, so i
skipped it)
TQ is the average transmit quality to the gateway, download_speed=20
is its advertised download speed.=20

best regards,
	Simon

--sm4nu43k4a2Rpi4c
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFJChYcrzg/fFk7axYRAr5JAKCAxD+N8ebLVmwb5rw+p4ZVnwLYNgCdEuki
iBskZJ8BgAgFr7ir4BC7pM8=
=MuC+
-----END PGP SIGNATURE-----

--sm4nu43k4a2Rpi4c--

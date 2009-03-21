Date: Sat, 21 Mar 2009 09:53:36 +0100
From: Bastian Bittorf <bittorf@bluebottle.com>
Message-ID: <20090321085336.GL32483@amd>
References: <49C40762.3050109@java-system.com>
	<200903210917.54806.lindner_marek@yahoo.de>
	<49C49C1A.6050100@java-system.com>
	<200903211634.46493.lindner_marek@yahoo.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Z/kiM2A+9acXa48/"
Content-Disposition: inline
In-Reply-To: <200903211634.46493.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] What do you think of this result?
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
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@open-mesh.net>


--Z/kiM2A+9acXa48/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

* Marek Lindner <lindner_marek@yahoo.de> [21.03.2009 09:45]:

> or less. This is an approximation of the reality. If you have ideas how t=
o=20
> improve it let us know. Meanwhile, we can try to help getting your wifi u=
p to=20
> speed (see antonios mail).  :-)

in OLSR networks we change the multicast-rate, to allow only links
with "reasonable" bandwith to be used. Maybe this is also a good
idea for batman. In a dense network, set you multicast-rate to
12mbit on all nodes, in a "normal" network you can use e.g. 5.5 mbit.
(this helps the routing daemon and does nearly not change the
normal network behavior)

important question:
are batman-adv-packets transfered in multicast-rate?

greets,
Bastian Bittorf

--Z/kiM2A+9acXa48/
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAknEqxAACgkQDonSpHhHLlwEhwCgjJQxq4bz/Poz+qXXBAFuFSbs
7KsAniPkAqUBzPU+tHqAn8ta6K90Ntjb
=4ovL
-----END PGP SIGNATURE-----

--Z/kiM2A+9acXa48/--

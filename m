Date: Fri, 13 Feb 2009 14:08:40 +0100
From: Bastian Bittorf <bittorf@bluebottle.com>
Message-ID: <20090213130840.GX28964@amd>
References: <mailman.134.1234470500.960.b.a.t.m.a.n@open-mesh.net>
	<499494DE.1070304@gmail.com> <20090213002143.GA27725@pandem0nium>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="npbjE3dh3wBH6WIP"
Content-Disposition: inline
In-Reply-To: <20090213002143.GA27725@pandem0nium>
Subject: Re: [B.A.T.M.A.N.] Wimax-Stuff and Ideas
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


--npbjE3dh3wBH6WIP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

* Simon Wunderlich <simon.wunderlich@s2003.tu-chemnitz.de> [13.02.2009 01:3=
0]:

[sorry for mixing up threads]

> WiFi has some kind of range limit due to the acknowledgement timeout,
> but you can easily overcome this by increasing the timeout (at least the=
=20
> madwifi driver allowed to change this timeout). Another
> limit is of course the allowed transmit power, or EIRP. The limit is

Thats not true for special tasks like disaster management.
It's no problem (and allowed) to work with 40.000 mW in such a situation.
Ask somebody from the german THW for details.

Normally you have some cars with built-in radio's, that are placed on
e.g. hills to build up the backbone and do an "shortshot" down to
the base of the hill to the workers (with another freq)

Wimax is the worse idea i have ever heard of for such a situation.
Just look at the frequencies, and it _must_ be clear that it was not
build for long range. You have to lower the frequency to get a higher
range...so take WiFi or use 900 MHz GSM...

bye, Bastian Bittorf / weimar.freifunk.net

--npbjE3dh3wBH6WIP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkmVcNcACgkQDonSpHhHLlxYWQCgpoFHR3jt3h8ewkTJzZ5NfXM3
1QwAoODoi2BepsfmEcheuJYUMAE7fnuJ
=z0og
-----END PGP SIGNATURE-----

--npbjE3dh3wBH6WIP--

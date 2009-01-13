From: Sven Eckelmann <sven.eckelmann@gmx.de>
Date: Tue, 13 Jan 2009 19:46:15 +0100
Message-Id: <1231872376-21395-1-git-send-email-sven.eckelmann@gmx.de>
In-Reply-To: <1F97746F-9493-4343-A46A-B2A9A727E13B@7degrees.co.za>
References: <1F97746F-9493-4343-A46A-B2A9A727E13B@7degrees.co.za>
Subject: Re: [B.A.T.M.A.N.] Compile vis under FreeBSD and OSX
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@open-mesh.net>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.open-mesh.net>
List-Unsubscribe: <https://list.open-mesh.net/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=unsubscribe>
List-Archive: <http://list.open-mesh.net/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@open-mesh.net>
List-Help: <mailto:b.a.t.m.a.n-request@open-mesh.net?subject=help>
List-Subscribe: <https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=subscribe>
To: b.a.t.m.a.n@open-mesh.net

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Tuesday 13 January 2009 11:52:35 Antoine van Gelder wrote:
> Some additional includes are required to compile the B.A.T.M.A.N.
> visualization daemon under FreeBSD and OSX.
Hm, the headers are also needed on other plattforms. In linux we have deep includes in some headers but this must not be always that way. I would say that they should be included in all supported plattforms.
Maybe you can have a look at my patch so I didn't messed up the osx support (dont have an OS X here to test it).

Best regards,
	Sven

PS: Interested in porting batmand again to *bsd plattforms?

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkls4VMACgkQqQGwKVlMoDviDACfY11IQ9KlbHK/tQdLBhjrXwAj
QFMAni4jyaTT7TKqeNt6hiaKiLkQ400d
=BqO1
-----END PGP SIGNATURE-----


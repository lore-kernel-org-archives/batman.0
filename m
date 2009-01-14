From: Sven Eckelmann <sven.eckelmann@gmx.de>
Date: Wed, 14 Jan 2009 01:45:26 +0100
References: <1F97746F-9493-4343-A46A-B2A9A727E13B@7degrees.co.za>
	<1231872376-21395-1-git-send-email-sven.eckelmann@gmx.de>
	<1F63FEA4-ED42-48C5-B45E-87BF3764F4BB@7degrees.co.za>
In-Reply-To: <1F63FEA4-ED42-48C5-B45E-87BF3764F4BB@7degrees.co.za>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart3253940.13PCtOqkYt";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200901140145.34127.sven.eckelmann@gmx.de>
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
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@open-mesh.net>

--nextPart3253940.13PCtOqkYt
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Tuesday 13 January 2009 22:29:25 Antoine van Gelder wrote:
> On 13 Jan 2009, at 20:46 , Sven Eckelmann wrote:
> > PS: Interested in porting batmand again to *bsd plattforms?
>
> Possibly - it would be nice to have the option to mesh with a beastie :)
>
> Do you have a rough idea of what broke since it last worked ?
Don't know when it worked the last time but it doesnt compile at the moment.

There are also some parts marked as "not implemented" in bsd/route.c
You must check if all functions in bsd/*.c are in sync with linux/*.c

Best regards,
	Sven

--nextPart3253940.13PCtOqkYt
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkltNaYACgkQqQGwKVlMoDtn/ACgyS7rTL747LHMJHTJJlwNqonf
sngAoJd46/VWimOCr4GkDXrj/0EB3P69
=PSda
-----END PGP SIGNATURE-----

--nextPart3253940.13PCtOqkYt--

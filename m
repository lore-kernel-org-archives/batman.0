From: Sven Eckelmann <sven.eckelmann@gmx.de>
Subject: Re: [B.A.T.M.A.N.] Batman gateway lock ups
Date: Mon, 8 Sep 2008 09:08:28 +0200
References: <5635aa0d0809050801k1c5f0bd5wa366574efedd910f@mail.gmail.com>
In-Reply-To: <5635aa0d0809050801k1c5f0bd5wa366574efedd910f@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2205066.T8rpCm8Gk7";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200809080908.31586.sven.eckelmann@gmx.de>
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

--nextPart2205066.T8rpCm8Gk7
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Friday 05 September 2008 17:01:24 Outback Dingo wrote:
> [...]
> http://www.pastebin.ca/1194874
>
> pertinent info
> dmesg | grep 'batgat loaded'
> batgat: [init_module:96] batgat loaded  rv1025
> uname -a
> Linux nightwing 2.6.23.16 #16 Tue Apr 22 20:00:17 ART 2008 mips unknown
> root@nightwing:~# batmand -v
> WARNING: You are using the unstable batman branch. If you are interested =
in
> *using* batman get the latest stable release !
> B.A.T.M.A.N. 0.3-beta (compatibility version 5)
> [..]
Thx for your report. I looked a little bit at the the call stack but it is=
=20
really hard to guess the functions when you don't have the symbol table. It=
=20
looks a little bit like most of the functions are kernel thread/scheduling=
=20
related. Only one function <c00c8650> is  from a module. Can you please sen=
d=20
the /proc/modules file so we can find in which module it is so we can check=
 if=20
it could be a batgat related. Further investigations could be done by check=
ing=20
the symbols of batgat.ko with nm - but this would not help very much becaus=
e=20
it is stripped down. Maybe someone else has a good idea.

Now to something you said on the nightwing mailing list:
> i think the version of batgat being used has a bug as confirmed by someon=
e in
> the batman irc room, note only gateways have this issue, clients do not
> crash at all.
If you mean me (Lazhur on irc) then I have to say that I am not a developer=
=20
nor a spokesman of b.a.t.m.a.n. and I never confirmed that it is batgat rel=
ated=20
=2D only that something crashed/lock up.
I cannot find any crash related bug fixes in the batgat trunk directory - s=
o it=20
doesn't seem to be a known problem (if it is a batgat problem at all).

Best regards
	Sven Eckelmann

--nextPart2205066.T8rpCm8Gk7
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkjEz2wACgkQqQGwKVlMoDuPdQCeLWx+WUhUktZBVPbHdD2+A/Yq
pkgAoIsTu7X9YK1SH6do8sp4Tw3Dx5uY
=TeWc
-----END PGP SIGNATURE-----

--nextPart2205066.T8rpCm8Gk7--

Return-Path: <linus.luessing@web.de>
Date: Sun, 30 Aug 2009 23:47:19 +0200
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@web.de>
Message-ID: <20090830214719.GA3905@Linus-Debian>
References: <20090830013647.GA26017@Linus-Debian>
	<20090830195553.GA2410@pandem0nium>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="J2SCkAp4GZ/dPZZf"
Content-Disposition: inline
In-Reply-To: <20090830195553.GA2410@pandem0nium>
Sender: linus.luessing@web.de
Subject: Re: [B.A.T.M.A.N.] [patch] adding subgraph-feature to vis-output	in
	dot-file-format
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.net>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.net>
List-Unsubscribe: <https://lists.open-mesh.net/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.net/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.net>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=help>
List-Subscribe: <https://lists.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.net>


--J2SCkAp4GZ/dPZZf
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Yep, works fine for me, compiled and run it on our three virtual
machines and looks the same as with my original patch. I also had
a quick look at the json output and I think the patch should not
have broken anything of that either, but a json-expert should have
a look at it again. Also it might make sense to introduce
something comparable to the subgraphing-feature of the
dot-file-format to the json output, wouldn't it? Otherwise you
will still see seperated graphs with json output if nodes are
having multiple interfaces. So someone might have to write and
commit a patch for that sometime in the future as well.

Thanks for reviewing the patch.

Cheers, Linus

--J2SCkAp4GZ/dPZZf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iQIcBAEBAgAGBQJKmvNmAAoJEBKw7u43QNpfI8gP/2JnxGOu0oL/c+pK9b3tfzM4
yXhhw//wkGm2Wkb1zdIVsW21f+bDgfIWCT/fEG0FUcaBVBdV4NQXFJK6qex+BUua
52MqdBw+8CarYuIoPvQyB/4JuhZj2AxnFMlvLnnolGVoV51gdAieFJRw3pDiqwZb
FpvIVvx8gmSqEEJ8IvTVA2k6M+A9cmngnRMMnV8Ddb+JgD5XcwDXbSLkPQo7kAev
7Y3CU/XYzkIwyYBnMSjjYIXMUukb5jRdMMgWP7ZjGZ2jaQhdyvIDcNw58nnqLJod
HGHgqt8ffM6TG/qA6zh3ZHOs7DgwCR0WsabayK2jcCboQ9H7RhHqh1rew7FC+mO5
wdI4qCIs9ccgvWgPVaXoL9dajbsq03RXu44euJ4gx/yzJs9QAJmIaGbflFkMlCfE
j89tSles8oZzV9OayAVs5UkvdyWjXRph2ufqYPXv5sl54y69pp1JYyEWxX6Hze7n
KIS5rD9lUWFlD+YkQASIlht3QhuIS2kAmJ0bmH27pgZyngjlZgXsISq6CMub1Hya
gD7AXjpUk4Bu+M32i8kRGWZoce/Z/m0avVwTFkQGRolVe/uUVoWFNS0KskAKDuEj
UbRqpWdmdoQmUQO5oGISnXhYlhWQugwF2QouKx8yqoR6rSfEoF81j4DOowY79uk3
tvI5GL2t0iMSOirNGt9y
=liMV
-----END PGP SIGNATURE-----

--J2SCkAp4GZ/dPZZf--

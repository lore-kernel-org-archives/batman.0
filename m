Message-ID: <4821B37C.4080608@leo34.net>
Date: Wed, 07 May 2008 15:49:48 +0200
From: Daniel Paufler <dpaufler@leo34.net>
MIME-Version: 1.0
References: <51B22798-78A8-4425-BAEA-530297B1518A@cslab.ece.ntua.gr>
In-Reply-To: <51B22798-78A8-4425-BAEA-530297B1518A@cslab.ece.ntua.gr>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigAF0A72A9643F9DA9E2DDFD33"
Subject: Re: [B.A.T.M.A.N.] 0.3 final <-> quagga
Reply-To: dpaufler@leo34.net,
	The list for a Better Approach To Mobile Ad-hoc Networking
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

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigAF0A72A9643F9DA9E2DDFD33
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hello

Antony Chazapis wrote:
> For now, the plug-in just supports sending routes to zebra, not the
> opposite (redistributing routes from other protocols). That was also
> the case with the older - rv502 - version.

Marek Lindner wrote:
> You mean batman should distribute zebra routes on the fly ? That is pos=
sible -=20
> even _today_.   :-)=20
> You can add and delete HNA routes via the unix socket. HNA is a way to =
flood=20
> the batman network with routes which do not belong to batman.

I am mainly interested in redistributing zebra routes to batman as i do
with olsr_quagga plugin. This way, i can think about switching from olsr
to batman 0.3. Perhaps, you will enable it in your code again.

Thx

Daniel

--=20
Dipl. Inf. (FH) Daniel Paufler
Angewandte Informatik - Computer Aided Facility Management




--------------enigAF0A72A9643F9DA9E2DDFD33
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFIIbN+q6ymFUkZLTIRAtMAAJ9Gftkr1W5LKMpx7gyevbfOAqqCfQCfXofe
p1FyEKlVtRXx14JAVMC6Q4I=
=WxFT
-----END PGP SIGNATURE-----

--------------enigAF0A72A9643F9DA9E2DDFD33--

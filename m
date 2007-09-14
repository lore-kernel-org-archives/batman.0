Date: Fri, 14 Sep 2007 08:46:28 +0200
From: Simon Wunderlich <simon.wunderlich@s2003.tu-chemnitz.de>
Subject: Re: [B.A.T.M.A.N.] translation of batman-adv
Message-ID: <20070914064628.GA1471@hrz.tu-chemnitz.de>
References: <002d01c7f5cc$825d8910$0cdbe29f@happy0bc06a65b>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="UugvWAfsgieZRqgk"
Content-Disposition: inline
In-Reply-To: <002d01c7f5cc$825d8910$0cdbe29f@happy0bc06a65b>
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


--UugvWAfsgieZRqgk
Content-Type: text/plain; charset=utf8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey,

i tested this today (and fixed a 2 bugs regarding this ;), and that
works. I used the same setup as you described, and when reassociating it
kept pinging ... :)
The host-announcements for the bridging are sent with the
batman-packets, and it takes 1 second maximum for the ap node to make
the first announcement when it got a new host. (But probably a little longe=
r until
the whole mesh-network knows).
If you want to use this please use the batman-saxnet branch of
batman-advanced for now until its merged back into the trunk.

Best Regards,
        Simon

On Thu, Sep 13, 2007 at 02:08:30PM +0800, =E5=94=90=E9=BC=8E wrote:
> hi!
> Dose the translation of batman-adv support fast roaming between batman no=
des(every batman node has two wireless interface under a bridge,one works i=
n ap mode,another works in adhoc mode for batman' routing)

> _______________________________________________
> B.A.T.M.A.N mailing list
> B.A.T.M.A.N@open-mesh.net
> https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n


--UugvWAfsgieZRqgk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFG6i5Erzg/fFk7axYRAnxJAJ0dVrM2GoG0y9Yh6JSeuQwdeR3cHgCgpMeY
XuZzvbh6AV9fOaNu/XJDr1g=
=bc4W
-----END PGP SIGNATURE-----

--UugvWAfsgieZRqgk--

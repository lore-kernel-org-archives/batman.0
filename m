Date: Thu, 5 Jun 2008 09:47:52 +0200
From: Simon Wunderlich <simon.wunderlich@s2003.tu-chemnitz.de>
Subject: Re: [B.A.T.M.A.N.] Batman-Advanced Kernel land
Message-ID: <20080605074752.GA25354@hrz.tu-chemnitz.de>
References: <4846B27B.9020907@csp.it>
	<200806041811.38881.sven.eckelmann@gmx.de>
	<200806051038.19094.lindner_marek@yahoo.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="qDbXVdCdHGoSgWSk"
Content-Disposition: inline
In-Reply-To: <200806051038.19094.lindner_marek@yahoo.de>
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


--qDbXVdCdHGoSgWSk
Content-Type: text/plain; charset=utf8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

I can not reproduce the problem on 2.6.24, but i can on 2.6.22.19=20
with the same batman-adv source (rev1084). So it looks like the=20
two kernel have a different behaviour for this problem.=20

@Paolo: Which kernel version did you use?

As i can reproduce it now, i'll look in this problem. :)

Thanks for the report,
	Simon

On Thu, Jun 05, 2008 at 10:38:13AM +0800, Marek Lindner wrote:
> On Thursday, 5. June 2008 00:11:31 Sven Eckelmann wrote:
> > > Someone can help me?
> >
> > Can you please test it further?
> > I used uml with linux 2.6.22.5 and uml_switch configured as hub to prod=
uce
> > the same problem, but dotslash told me that he wasn't able to reproduce=
 it
> > with his uml image (2.6.24 based). Maybe I can help him to get the same
> > effect it so he can try to find the problem.
>=20
> Same with me -  I can't reproduce the problem but I use a setup similar s=
etup=20
> to Simons setup. Could you try to use 2.6.24 to see whether it depends on=
 the=20
> kernel version ?
>=20
> Greetings,
> Marek
> _______________________________________________
> B.A.T.M.A.N mailing list
> B.A.T.M.A.N@open-mesh.net
> https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n

--qDbXVdCdHGoSgWSk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFIR5oorzg/fFk7axYRAkXyAKDTxXr8wVc8/p27vAuBxCCbBN22oQCfTXsW
Kvet3SSO+tllBYsII92cXq0=
=haao
-----END PGP SIGNATURE-----

--qDbXVdCdHGoSgWSk--

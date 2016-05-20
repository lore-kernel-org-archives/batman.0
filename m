Return-Path: <a@unstable.cc>
Date: Fri, 20 May 2016 15:33:13 +0800
From: Antonio Quartulli <a@unstable.cc>
Message-ID: <20160520073313.GR12056@prodigo.lan>
References: <1462190269.1971.52.camel@biplane.com.au>
 <2079546.oo0Mk8DjMd@bentobox>
 <a1c140db68d543d482a22adfbac42670@BLUPR97MB0100.062d.mgd.msft.net>
 <26642956.zsKuDycQ3V@bentobox>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="+VeMz1SRxFChf6vr"
Content-Disposition: inline
In-Reply-To: <26642956.zsKuDycQ3V@bentobox>
Subject: Re: [B.A.T.M.A.N.] mesh losing internal Ilayer3 connectivity
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>


--+VeMz1SRxFChf6vr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 20, 2016 at 09:23:24AM +0200, Sven Eckelmann wrote:
> On Thursday 19 May 2016 14:22:58 Nick Schaf wrote:
> > I've run into what sounds like a similar problem, but dove in and found=
 more
> > details.  Here's the setup:
> >=20
> > -19 nodes running BATMAN-adv 2014.14.0 on OpenWrt Chaos Calmer; various
> > hardware (D-Link, BBB, Open-Mesh, WRTnode, TP-Link).
>=20
> Only scrolled through your mail. But there are two things which I find od=
d.
> First you use a really old (actually not existing) version of batman-adv.
>=20
> Then you have some TT problems. I think we had many fixes since then whic=
h may
> be related to your problem. But going through 2 years of fixes might be a=
=20
> quite hard (at very cumbersome) journey.=20
>=20
> Maybe it is really a good idea to try to upgrade to the recent version=20
> (2016.1+fixes) from the Chaos Calmers openwrt-routing feed on all your no=
des.=20
> Maybe Antonio remembers one special TT/roaming bug and can recommend one =
to=20
> test. But most likely testing the current version is easier.

I don't recall any superfix which might magically solve the problems you
are seeing. Therefore I'd just follow Sven's suggestion and try running a r=
ecent
version of batman-adv.

Cheers,


--=20
Antonio Quartulli

--+VeMz1SRxFChf6vr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJXPr25AAoJEJ4aZjxxc6bKLBUP/A2o6+B2Ys09Lkty0Yazl4T8
X0C/O2g/7zuCtcwcjQqgz4N1A2zDoMUAAEQIlZv1y2ywtDfB8WFaANPkfd1SO9zs
LPPf3S0Q/NEJ/ywygTfS4/4H5E9wZtMk1AepNtarOb9mlEMT+qc+acUx91V2Ktuo
eD0Ugsf3tq7szz5+CdLU+XfNqc2VGRWkoIWldXwxYfi87ingmz+fZOtJc+tQbYV8
s1cOkA0saoFDPR9jpBem+6GBr8kzeEUG1Y2qhVMKe592kWvksmf+DYvCDPGw3yX9
h71V7wclEVXod9gtQx/csA3ie+nYeIn2/9W1azJxQEuF9Ajq9iw/JTTkJm+9axBN
jXmzR8EX+0jvMcylY8I6s7nHpA2dUYdvt5SG9YuJcVQo6Sykp/L5kmgPdzK1sOVe
tBvnPF6FVGj0ptQ0oWDcu3v5qwLS8IISHksFO37dpzDsWRdkJ+E+9XTHXEdF6ryq
snQ6cxl6GvJGqeKKaGnN4fmvPYUAHGVUuN3A+3TxBapnoiij/E2x6PH9Tq2ho+5K
9pO87itXV1KN63Q1n1zwlX1mQu8mRcl1543Mna9bVmnxJk8iOxIrJQLdmc5NbNO3
qgsIdypt7Pvb9ijQg895Sqkt7qgsA4dtGmeCJlRSHbgQMdveBOUz3w+46NR79X+t
dY8UVC3tRLfOXpYj1tvi
=nwJJ
-----END PGP SIGNATURE-----

--+VeMz1SRxFChf6vr--

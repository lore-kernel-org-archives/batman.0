Return-Path: <ordex@autistici.org>
Date: Tue, 4 Jun 2013 07:13:26 +0200
From: Antonio Quartulli <ordex@autistici.org>
Message-ID: <20130604051326.GJ1226@ritirata.org>
References: <51A3C7E9.7080208@inti.gob.ar> <20130528070057.GC3333@ritirata.org>
 <51ACBCE4.8000506@inti.gob.ar> <20130603160813.GC1226@ritirata.org>
 <51AD0277.1060907@inti.gob.ar>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="9aCKuHbn5v2q3RVc"
Content-Disposition: inline
In-Reply-To: <51AD0277.1060907@inti.gob.ar>
Subject: Re: [B.A.T.M.A.N.] batctl bw performance
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: Gabriel =?utf-8?B?VG9sw7Nu?= <gtolon@inti.gob.ar>
Cc: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>


--9aCKuHbn5v2q3RVc
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 03, 2013 at 05:54:15PM -0300, Gabriel Tol=C3=B3n wrote:
> Hi Antonio,
>=20
>=20
> El 03/06/13 13:08, Antonio Quartulli escribi=C3=B3:
> > Hello Gabriel,
> >
> > first of all thank you very much for testing the bw meter :-)
> > answers follow inline.
>=20
> You're welcome, I think it's an interesting idea.
>=20
> >
> > On Mon, Jun 03, 2013 at 12:57:24PM -0300, Gabriel Tol=C3=B3n wrote:
> >>     Hi Antonio,
> >>
> >>     As you suggested, I've tested the bandwidth meter with batman-adv-=
devel
> >>     38a1b72. I've installed it on two TP-Link WDR-3500 routers.
> >>
> >
> > oky. However, since the bw_meter has not been merged yet, its branch ch=
anges
> > from time to time because it gets rebased on top of the very latest dev=
elopment
> > code. Therefore, when you decide to update your testbed, I'd suggest yo=
u to look
> > at: http://git.open-mesh.org/batman-adv.git/shortlog/refs/heads/ordex/b=
w_meter
> > and pick the commit ID of the last patch at the top.
> >
> > If you have problems in doing this, please ask.
>=20
> I don't understand what commit ids should I use. For example, how could=
=20
> I find the ones you suggested me before for batman (38a1b72b6) and for=20
> batctl (eebba0bfb). Because on the top of the git I see for example the=
=20
> commit d672369c3476f002662fa7e83b76ee56a93a76db for "batman-adv: set=20
> maximum number of BW session", which seems in a different format, right?

Right. Becuase it changes everytime the tree is rebased. Now you won't fin =
that
commit ID anymore. Now you should use the _new_ commit ID of:
"batman-adv: set maximum number of BW session"
(it is not important to change everytime it changes on the git, but in case=
 of
troubles, it may be a good idea to use the current one to see if the proble=
ms
are still there).

>=20
> >
> >>     Running normal iperf inside the routers, and without unloading any=
 kernel
> >>     module, I get 60 Mbps using UDP, 80 Mbps using TCP (I don't unders=
tand why
> >>     TCP works better), and about 4 Mbps with batctl bw -t 10000. Any i=
deas? By
> >>     the way, the batctl ping between routers doesn't  work, I get time=
-out.
> >>     Besides, there's another strange behaviour, when I try to pass tra=
ffic
> >>     from a PC client connected to one router, to the other router usin=
g iperf,
> >>     if I use UDP values of about 100 Mbps, the router that receives the
> >>     traffic and redirects it, reboots. Thanks.
> >>
> >
> > Ok..well, first of all I'd rather check what is wrong in the mesh. If b=
atctl
> > ping does not work, then it means that there is something else which is=
 not
> > working/configured properly.
>=20
> Yes, it's weird, specially because there's connectivity between routers=
=20
> thanks to batman-adv.
>=20
> >
> > For this reason I'll first suggest you to update to this commit id: d67=
2369 .
> > Then, does "batctl o" properly shows the other node with a "reasonable =
TQ"?
>=20
> So, in menuconfig I should select that id for batman-adv-devel right? I=
=20
> wanted to see that  commit on the git page using the search field but I=
=20
> couldn't. By the way, how to know which batctl version use with each=20
> batman-adv-devel commit? Sorry if all these questions are too basic, but=
=20
> I've tried to compile with this d672369 version and I got some errors,=20
> so I'd like to understand if it was related to these things.

no problems. These are not basic questions :) Actually the user usually do =
not
enter these dev details and therefore it is normal to find issues.

For batctl, you should use the last commit ID in this branch (ordex/bw_mete=
r)
http://git.open-mesh.org/batctl.git/shortlog/refs/heads/ordex/bw_meter

>=20
> >
> >
> > By the way, your iperf tests have been done on top of batman-adv? or di=
rectly on
> > the wifi interface?
> >
> > Cheers,
> >
>=20
> I got the results mentioned using interfaces managed by batman-adv.

mh...maybe the pign is not working because of some changes brought by the
bw_meter in the icmp packets. I'll check and I'll let you know.

Cheers,

--=20
Antonio Quartulli

=2E.each of us alone is worth nothing..
Ernesto "Che" Guevara

--9aCKuHbn5v2q3RVc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIbBAEBCAAGBQJRrXd2AAoJEADl0hg6qKeONYQP8gIbufJFFigWAnTdaLb5ZdZL
Fa0Jt1UjgRua3taHw5CrJYmusvZl9Q24fzjDci1n0YpMwbFmqw++u1USlz8uy65+
1T14KNmsjTxb/R5Lm0pUGvpbc4p4TUdAD7J1hLY2UMJUIHhmzsaYZHChuMiceXPV
guUHAsjttRZ5jrvFehyqcVTpJRbHADFyBN80V2rJ/KpfloaM27oNWInO8hd4UBwx
DHDQxGO6HRkq1skx4TVcnyeg8TeWMyeJOnogYSy7MvKPr5UYVrhqhi0karaXNVbW
1zxKn6y71rObu3/zaofTHvCjtERRUeCWmXQzELIKe1S5XlJZUl3xLR0z2QYbE7YX
ZBRei3e9u+IMHKc50Vz+afG3QLV/tTvSw4NcOSngVrEfvmw+x+rPvSJQoCbSrGwC
68Veymon7FoNOlWKlCLrirPxG0+/o6csKp9oTR3Db+CjmGoNqZOPIkvwp0ChtQ0s
wWUdF0ENcv+ZpXsZrkftXc9I2HOH4CdQTtOJGL7CZCro5ZlXz2TXLWRce8HEfU2l
I7Dq/DV5GsIX+CYgqaE1BMINixC1fSOl+D6f1gu/sJKV0lo04/1YBbUkid2Yd25k
ucfk4XY89cfjep1bX3+f++h728ucbhNQNCWSaF4prwRz6u8J36SJrqWPUPDfDyWh
jdJAvI7nx99ImsghQ9A=
=w9CG
-----END PGP SIGNATURE-----

--9aCKuHbn5v2q3RVc--

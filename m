Return-Path: <ordex@autistici.org>
Date: Fri, 4 May 2012 02:08:52 +0200
From: Antonio Quartulli <ordex@autistici.org>
Message-ID: <20120504000852.GA29070@ritirata.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="envbJBWh7q8WU6mo"
Content-Disposition: inline
Subject: [B.A.T.M.A.N.] Improving the roaming procedure: multiple roaming
 within one orig interval
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>


--envbJBWh7q8WU6mo
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello people,

as some of you may know, batman-adv has client fast-roaming support since
version 2011.3.0. This technique has been introduced together with the new
client announcement mechanism and it is described on its wikipage[0].

At the bottom of the same it is also written that multiple roaming of the s=
ame
client within one originator interval are not supported.

Right now I am working on a concept that would enable such possibility. I t=
ried
to summarise my ideas on the wiki as well[1] in order to share with you the
solution I am thinking about.

The document is still a draft and may not be 100% understandable. If you ha=
ve
time and you are curious enough to read the wiki, please drop me your feedb=
ack,
it would really be appreciated :-)

Thank you,

[0] http://www.open-mesh.org/wiki/batman-adv/Client-roaming
[1] http://www.open-mesh.org/wiki/batman-adv/MultipleRoaming

--=20
Antonio Quartulli

=2E.each of us alone is worth nothing..
Ernesto "Che" Guevara

--envbJBWh7q8WU6mo
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQEcBAEBAgAGBQJPox4UAAoJEFMQTLzJFOZFluwH/0q8sOmUYFgT4LGwJ7sWEula
eUmQAHf6EiY1+8jbp+q49ksYacFNMi2GdVJpDwbUe4PWYnYy2jg6PhEMzundODWT
jgC9ck/Rc53OGl/dpcEQG3fP4e1Pg30m5XGLrWbA77H7EFhtx12B496ctwCsuUpE
b2+SuC8/gtxpVT2oT2bRoKd3hayi+e83j6Zr3rdvSKo5gzSIw+VCvphnknp36FXr
p5ug7EQB6ZRbAefYSzbhdTi57e67Xh3Sxh80eS/PdIvpI/BXUjKshM7XfnETBTXt
l5x0KPuyDvoV/CVWEXhE8JRLZ7Qg/uld3a2kZtc+bPcaspol++nNCZ+bK+ParNo=
=0SdT
-----END PGP SIGNATURE-----

--envbJBWh7q8WU6mo--

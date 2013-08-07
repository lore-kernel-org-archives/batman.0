Return-Path: <ordex@autistici.org>
Date: Wed, 7 Aug 2013 18:09:45 +0200
From: Antonio Quartulli <ordex@autistici.org>
Message-ID: <20130807160945.GN2943@ritirata.org>
References: <52020C25.9080705@gmail.com> <20130807090941.GK2943@ritirata.org>
 <52022858.3030105@gmail.com> <20130807120527.GL2943@ritirata.org>
 <52026D74.4060006@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="YH9Qf6Fh2G5kB/85"
Content-Disposition: inline
In-Reply-To: <52026D74.4060006@gmail.com>
Subject: Re: [B.A.T.M.A.N.] DAT issue
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
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>


--YH9Qf6Fh2G5kB/85
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Fernando,

to be honest the set up is not really clear to me, not because of the topol=
ogy
but because of all the bridges you created.

Once thing I am confident enough is
that if you have clients connected to wlan1.N and then you have a bridge
configured as { wlan1, eth0, bat0 } this is not going to work as expected.

Traffic sent over wlan1.1 will not be delivered to the bridge and so not
delivered to bat0.

You should include wlan1.1 in the bridge itself.


Other than DAT, I expect this to be a general problem.


Cheers,

--=20
Antonio Quartulli

=2E.each of us alone is worth nothing..
Ernesto "Che" Guevara

--YH9Qf6Fh2G5kB/85
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBCAAGBQJSAnFJAAoJEADl0hg6qKeO0LYQALBwb2yapFrGR9IfG/qPJ5o4
FeNSsJ9k9owZEhrpZXPBoiytJNb0e21gPqmo4Q7JJ4J5Rg/4j3n8PLG0UDc4Uni2
fJm/veMpJuFDNEzpuTeqoUhvdvKJLsrXgIZDBc5tplFgmns67Dqjo8WF470cg5KP
r5azNwRdlV0e4U3YRpICsDz1H/0uV/pskPQQLcrpzLDP0Nq3Fr9bCFkKRLmu6qX9
9xCP6uzP0+Q1Wy9b/Q9qUpDolAWVZJ43WBKS+EDV2t3o41gH41NaeXww4SUVm2ta
f12icfdVOvIYSC4/cZ2erJ4MndIBtWLR8ih/J+I2g/zxahDLkcQJLdafeRs5d+jT
r+G2ZwA9pDiKn7aXUqUucCVQnWQ4+czD0e6Vn9OmiCjKHWdif/WLJKchdceSEllh
UgV4ckLetwIKaF1IohvpnjuShfCS5ZiAsdl5VCtRFwZvU6vjdU9yBSu98f35qDfU
agWCl9+joE28mQrcjc1yAd35N+JachfXjv9/c7d4abU03icKON51D0LotmIBmI/K
HnBT3+67iipO7N+TTNuNy/hE24lpT8QvRLX/BWe4TOEEU31OK+aSVItZ+g7xAsJy
u1PYKUI3wlrIEfjzePujo2ZPe6eHCB4G4xoOnL/rf8GQEeulow/RQyj22J8HyOGE
7bKkrcN4HBXw+cXPgdPN
=lg22
-----END PGP SIGNATURE-----

--YH9Qf6Fh2G5kB/85--

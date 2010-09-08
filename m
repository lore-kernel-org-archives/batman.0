Return-Path: <sven.eckelmann@gmx.de>
From: Sven Eckelmann <sven.eckelmann@gmx.de>
Date: Wed, 8 Sep 2010 22:42:44 +0200
References: <1283646353-17811-1-git-send-email-sven.eckelmann@gmx.de>
	<AANLkTi=FVyLE6OHTd+_qDbzSLk6fY5j6wBOWkYA810Dj@mail.gmail.com>
	<201009082225.47498.sven.eckelmann@gmx.de>
In-Reply-To: <201009082225.47498.sven.eckelmann@gmx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart5812658.xxDpOry2Fx";
	protocol="application/pgp-signature"; micalg=pgp-sha512
Content-Transfer-Encoding: 7bit
Message-Id: <201009082242.46020.sven.eckelmann@gmx.de>
Subject: Re: [B.A.T.M.A.N.] [PATCHv4] net: Add batman-adv meshing protocol
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
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: netdev@vger.kernel.org, Jesse Gross <jesse@nicira.com>, Andi Kleen <andi@firstfloor.org>, davem@davemloft.net, b.a.t.m.a.n@lists.open-mesh.net

--nextPart5812658.xxDpOry2Fx
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Sven Eckelmann wrote:
> Jesse Gross wrote:
> [...]
> >=20
> > I'm not sure what you mean by "packet number".  It does allow you to
> > specify the output interface based on a number of factors, include the
> > input device.
>=20
> It would mean that for example 5 packets goes over device 1, the next 5
> packets goes over

I should stop writing mails as I get to easily distracted right now:

=2E.. goes over the device 2, the next 5 packets goes over device 3 and the=
 next=20
5 packets goes over device 1, ...

Maybe other things like "5 over device one, 10 over device 2, 2 over device=
 3"=20
could be imagined.

thanks,
	Sven

--nextPart5812658.xxDpOry2Fx
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQIcBAABCgAGBQJMh/VFAAoJEF2HCgfBJntGV14QAImriepZt1PZIoDhyci/apeD
ZLM5RUZhsxfxVhbRZFAsh2kgG1Wjhudw/0BgKt02a+f3Q+Cw889DVWVOyMUStO70
bOhDik5xhJ8b1EcAmPES7L3x45pcdZvWkKDB7nfhQTr5LoYIdQAjLomz6mzTz4nP
PTECCH//v3VNue75huc/vzrf55TvnnKw7ZPaQmss82G6bUJeMxy/11iGZr+fuxQa
Y6PQPdPVc44WtUB9wwwcMTPvYBad8hUTmeoAeD8LvFLSTk5HT6QoMgmqzl7V1uL5
5LI8drXIXJ0XXMXfTdp5urDqBR+rfoebOcs1illa4sbUH5AsIUwMrNO3ZPwJu1Ib
2I5aA5tjFjIBnK67mIrEpehPumeLpV6WBsuLLAVK24BatrWQcoHxh5hgUuvgufLX
KZ+A7+GLjiA5ZDlvhBpqo1/sHGlBbdGRPlZ88yTIf8gkeJ5oD5B2IruNPEbOlL7M
4rhgMvEUPkqyca9GWzb9wt51BXlorfdaXn6tXteYPzyKPTqVA+ZAaqGVB3e7NBf0
ZeGwmTwf3KKMNo6mk0KOc88qrOpdtRYpxhE/wzjYSMhnIXW07V/Jj5rp6cjy938n
I14vQPW+TYVBNK/d82NidaWRip9MiJgWE1Mon84yAn5XAL5bujUd16BvCdUxZcmA
xSecf03f1xJchPmekoG8
=qHND
-----END PGP SIGNATURE-----

--nextPart5812658.xxDpOry2Fx--

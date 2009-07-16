Return-Path: <sven.eckelmann@gmx.de>
From: Sven Eckelmann <sven.eckelmann@gmx.de>
Date: Thu, 16 Jul 2009 09:36:05 +0200
References: <1739bfe0907150649l61d6b0dga6825e84dc45832d@mail.gmail.com>
	<200907152050.18936.sven.eckelmann@gmx.de>
	<F0997A98-262F-4E4A-907A-22E1BDC86CB2@7degrees.co.za>
In-Reply-To: <F0997A98-262F-4E4A-907A-22E1BDC86CB2@7degrees.co.za>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart9758430.tHHbJT8TR1";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200907160936.25169.sven.eckelmann@gmx.de>
Subject: Re: [B.A.T.M.A.N.] [vis] fixed partial json output
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

--nextPart9758430.tHHbJT8TR1
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

> > Maybe someone sees a problem in my proposal. The only thing I see is
> > that the
> > read should appear before locking the current buffer or a "bad
> > person" (me)
> > could delay the new buffers for all others by connecting and then
> > wait for a
> > long time. I see the same problem in your current implementation.
>
> I'm not sure the current implementation performs a read between locks
> but I agree that the server should not block other connections while
> waiting for a response from another connection.
I didn't wanted to say that the current implementation in trunk uses a read=
,=20
but Jonathan Mzengeza's patch does it.

Best Regards,
	Sven

--nextPart9758430.tHHbJT8TR1
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iQIcBAABCgAGBQJKXthlAAoJEF2HCgfBJntGFdQQAIgJtcKlDjCduqBr3daexm8b
s8FjkBsHqmoPeEFuWOkwm5Njq3zFxHhCQKrcwYQkIVET2loLrZrqXzIVmMBfg6te
H2oVj9eThq8F0XQ62yjJEN/ujLvfS5yTS68oIBh/hEBdmil9MDSBDfvqQQhFBkOx
EDmUCVD3kirkT7HzsHW2c8Lo/yYBjo2BE2Ka4XBccyHhV9n5J75llmjTX2kMXKHI
5s/QRx6c/ZYGqQEarrUGOMkwPT0uVTclYdGhgP1Oe9Bp6IBFW6061IuhaW3E1d0p
aA5xxMsTJudsiBIaweSPmibjw7pBFWVbCye2N7jn5brDmFj67Qn6t9QUw8M/5X6B
hkLmUrx5wESrmo/hYdmjWUCE0xPIZbOMg+sqFNKkmQ1gdYcdfx+8BlIivexTS4GO
QXlwslmp+LtrkG+NIRe5Zv/ToBMpxSCv+jyi370qOI9OVgBAvwAKd5r+p1XwyfzL
PU66f7hrNipL05H7a2Wa1FN8qJIgK06g18z2olNR4losQjsf8qqhwZAMkPYSAge5
7Vm4yMCtUOunUAWJ6BHnJ7OFGpp9Qy0lBlig6Ul9tKfK9RY3+srU5B5FjkGKhKGx
Ds7iMdAtzVRZMtvU1lKwis3KtMH8EikgXuKulMX1ZEr4Ioa3SHFpnvEZ0xelqSBa
ZSrRrwbfEDdSwyTiK+8f
=dQ7d
-----END PGP SIGNATURE-----

--nextPart9758430.tHHbJT8TR1--

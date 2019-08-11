Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Subject: Re: [PATCH] batman-adv: Use wifi rx/tx as fallback throughput
Date: Sun, 11 Aug 2019 20:50:38 +0800
Message-ID: <2541950.y14E6QPJ2z@rousseau>
In-Reply-To: <8c0c76dc-5c6b-da84-8e11-700222641db8@measite.de>
References: <20190609101922.2366-1-treffer@measite.de>
 <4907494.lMUJSmCnaO@rousseau>
 <8c0c76dc-5c6b-da84-8e11-700222641db8@measite.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2656540.9Z6To5SbFb";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: b.a.t.m.a.n@lists.open-mesh.org

--nextPart2656540.9Z6To5SbFb
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

On Monday, 10 June 2019 18:06:23 HKT Ren=E9 Treffer wrote:
> > I also don't quite understand what the '!!!' thing is trying to indicat=
e.
> > What is being compared ? But it may be due to my misunderstandings abov=
e.
>
> I haven't done an actual throughput test, and I would expect the outputs
> of my heuristic to be worse.
> So I wanted to give slightly lower values than the expected throughput.
>=20
> The other way to think about it: if you were to replace the
> expected_throughput input where would you over-estimate the link quality
> now?

Sorry, I don't follow that train of thought. Due to the lack of numbers=20
comparing the magic formula (tx /3) with actual throughput we (Antonio and =
I)=20
ran a few tests on ath10k devices using your patch. Surprising to us, this=
=20
approach worked quite well.=20

I will re-post your patch as RFC to encourage others to test the resulting=
=20
B.A.T.M.A.N. V routing decisions. If you happen to have tested more on your=
=20
end, please share your results.

Also, why considering rx on top of tx still isn't clear. Could you explain=
=20
some more ?

Thanks,
Marek



--nextPart2656540.9Z6To5SbFb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEI5CG6MPJfr3knG//U1VOj+62HMAFAl1QDx4ACgkQU1VOj+62
HMBmnAf+JaF3IDMS3Rl7xwTEYlsJI9Ppp/XMxw0Clp4Xs2YkBJv84ea/NxUuv+uQ
zFwp79epkDuYvKh4+yag3MtzVFfDtH2uhjwTQNuV32I6vF52O2PQABismMKvoiv+
OrGLA9/fem2mZ+LFjluNB8krhOYuFlwvVQkNIBtJoWV+oHiWvaWbE+utB+7QyBAt
wX331mT3BcFMf4KtSMrNa8fktjesvM2lZfhptU0CQg2qDM1PYxUtZUu0vty/qlxO
ZhPJsE0P57RUcC/GBKYZln85zbm5hUSE6fQLVIDUWkcmcfINtDiEyDKBnDHuSmLx
aEyaQNXROxctJa1lsIMxUt2IgUkxiw==
=7Z7W
-----END PGP SIGNATURE-----

--nextPart2656540.9Z6To5SbFb--




Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Mon, 21 May 2018 19:51:49 +0200
Message-ID: <1559212.ar4OgO3PtD@sven-edge>
In-Reply-To: <20180521131711.GK7162@otheros>
References: <20180518014754.23644-1-mareklindner@neomailbox.ch>
 <20180518014754.23644-7-mareklindner@neomailbox.ch>
 <20180521131711.GK7162@otheros>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart17553577.I3gx46e7Dd";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH v2 6/7] batman-adv: ELP - use tp meter to
 estimate the throughput if otherwise not available
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
Cc: Linus =?ISO-8859-1?Q?L=FCssing?= <linus.luessing@c0d3.blue>, Marek Lindner <mareklindner@neomailbox.ch>

--nextPart17553577.I3gx46e7Dd
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

On Montag, 21. Mai 2018 15:17:11 CEST Linus L=FCssing wrote:
> What is the advantage of using the ilog2 and shift operator here
> compared to plain multiplications and divisions?

They most likely ran into the problem that they must do a 64 bit division=20
(which cannot be done on 32 bit machines in the kernel directly with C's=20
native "x / y" statement ). But in this case, it is most likely a lot bette=
r=20
to use do_div (or similar function) to avoid a lot of rounding problems whi=
ch=20
this shift approach has.

Kind regards,
	Sven
--nextPart17553577.I3gx46e7Dd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAlsDBzUACgkQXYcKB8Em
e0YDTBAAtXKr8pa9UUuQEcNuWslDKQE4pGXzC58mebUczSGI4jTgu3CLuSSw1McY
MnpP1xEuEelBGM/FvVclkgBvnlv2+nF8pPw9Ynk8NTWlClWFrmoX0xV5cJIEWDge
7s77a2Sa8My1cO70K9j4tzOmE+L44dKSiLN+HRSUQ92SQZzbU7RoHgTPMR/HPhSR
zQgk6RKyWefwMEioDAseX5W24UotZ/Ev0d/FxMn6gZ2+NrVUWm5zs9zY67URlGOj
fzIMSPA78KKVl2ExBN0VlLEdQCt8K2bTSvWs+XqJExLkdo4l67B+1C2qPwO7Cku8
V3zpzuzlArl1TPOnzkyx4fFXafmntUPfF5B2q9VvdnqmYtQkglMYFtxQ+kYqB1r0
yM1dtWKfhyh4HM+cL47BV3sRVUuj6+rfK/+69ODDFKGrNP08UWE+4e6UAcdsdRRf
YDEZjW9hqzEf08cIu/MrUo5CjjOmOT3ZOmoOOFAQPTZcvKst1X7BGYOtcdh3FT8v
NtOwJ6isoplph4dHT4oVc4HXqsdLWB+NEDKu6towP8FT1WuAcBwo30uW9oh2hz4c
cAtWdtsAxxdlqrQm0BqyoBzlpaI0ZjSRxnTWBqaEmYeimKIOKi+S8KlLQ0qXGgiw
dmy1dPmCN3cDogRr4jeo0qLiu/8ZScLQ4VCN9+1NuuUR2HokEgU=
=KbZ3
-----END PGP SIGNATURE-----

--nextPart17553577.I3gx46e7Dd--




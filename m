Return-Path: <ordex@autistici.org>
Date: Sat, 27 Apr 2013 18:01:32 +0200
From: Antonio Quartulli <ordex@autistici.org>
Message-ID: <20130427160132.GA3179@ritirata.org>
References: <1367050948-7626-1-git-send-email-lindner_marek@yahoo.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="EeQfGwPcQSOJBaQU"
Content-Disposition: inline
In-Reply-To: <1367050948-7626-1-git-send-email-lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: check proto length before
 accessing proto string buffer
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
Cc: Marek Lindner <lindner_marek@yahoo.de>


--EeQfGwPcQSOJBaQU
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 27, 2013 at 04:22:28 +0800, Marek Lindner wrote:
> batadv_param_set_ra() strips the trailing '\n' from the supplied
> string buffer without checking the length of the buffer first. This
> patches avoids random memory access and associated potential
> crashes.
>=20
> Reported-by: Sasha Levin <sasha.levin@oracle.com>
> Signed-off-by: Marek Lindner <lindner_marek@yahoo.de>

Thank you for fixing this!

Please, merge this patch in maint.


Cheers,

--=20
Antonio Quartulli

=2E.each of us alone is worth nothing..
Ernesto "Che" Guevara

--EeQfGwPcQSOJBaQU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBCAAGBQJRe/ZcAAoJEADl0hg6qKeOgLkP/2fYOjTJzmT5xItmfolN9L1s
SItE2ZN31pXiXkZPhGN3hVfnk9MTAJloDEpYpxejzjOqPV/aDdBtz7QB2x+lyzPf
cUSftjLn6FQ8DcED6vGivbXIID/vN6bQg1gVliecmKvrKtLT7tUplNafAGF8/Mho
/M+gtOwP9uarFpuTOVF/0hkzSSbnMbpVyfLXSPUp+hWcS3zC5/jIvCJuWSUhWQro
8vsM81qF2y7sASHrm1msMXcplropO0aISZqrWoBmUVJ3j8ENgH0blO5O6arlDIMV
nIXisM/lCAPe38J7PTfQDirrh6LpeodHSEwKvlnSkFvXsmaNFVETaK9TPcNc2bz+
KbLYmJTBWSZcOijHY6/LbwmXCO+6wPBLu51eqcCIWdK6qHjMwlifSGv1sNaA75U7
48qOFtQOV8W+vouG/sWkFJBEDJtRZmCBEqPdCOqLMwPLTEygmic2VFb5oPZEpBsq
mznywyNMVDivvJj3sRQzhh0UXn8PhTqbrNtsfgXiv/biAARSTCDxH1AkIOTaF6rD
26ksC03ve8qdK3L2iII5X3tYUNHGCYQ9v/suESB4vVsInfoRbJp/C7C3XdIkjErK
HsGmOKA1Yb5YmIG42ake/58a/BwN7PZ/8uy8qzr191q9KwVB6I65blzS1Emh6I5V
jjkQuAGHdpvkyFnWiBc8
=Ii8Y
-----END PGP SIGNATURE-----

--EeQfGwPcQSOJBaQU--

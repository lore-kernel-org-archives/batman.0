Return-Path: <ordex@autistici.org>
Date: Wed, 16 Jan 2013 17:01:07 +1100
From: Antonio Quartulli <ordex@autistici.org>
Message-ID: <20130116055904.GB5243@ritirata.org>
References: <1358118740-10458-1-git-send-email-martin@hundeboll.net>
 <1358119232-14781-1-git-send-email-martin@hundeboll.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="jho1yZJdad60DJr+"
Content-Disposition: inline
In-Reply-To: <1358119232-14781-1-git-send-email-martin@hundeboll.net>
Subject: Re: [B.A.T.M.A.N.] [PATCHv3] batman-adv: Return reason for failure
 in batadv_check_unicast_packet()
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
Cc: Martin =?utf-8?Q?Hundeb=C3=B8ll?= <martin@hundeboll.net>


--jho1yZJdad60DJr+
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 14, 2013 at 12:20:32AM +0100, Martin Hundeb=C3=B8ll wrote:
> batadv_check_unicast_packet() is changed to return a value based on the
> reason to drop the packet, which will be useful information for
> future users of batadv_check_unicast_packet().
>=20
> ---
> v2:
>  * Changed return values to defined error codes.
>  * Send as separate patch
>=20
> v3:
>  * Fixed typo in kernel doc
>=20
> Signed-off-by: Martin Hundeb=C3=B8ll <martin@hundeboll.net>

uhm...This signed-off should be part of the commit message.
But other than this this:

Acked-by: Antonio Quartulli <ordex@autistici.org>

--=20
Antonio Quartulli

=2E.each of us alone is worth nothing..
Ernesto "Che" Guevara

--jho1yZJdad60DJr+
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJQ9kIjAAoJEADl0hg6qKeOX18QAKY8zSkkEGll34MnM9pYSyM0
l92fhhuhvM7F4IXG1wkWv3/F/x5lLAARH8dgnJpSJ495+5i1uHD/gH43Anm116fr
ZbTdx+2doulmxz9d43tjdl0nmgHoxXD+s0zsF1WJjqn8w3QZ+L0aKek/XGnlyZT7
F47yEhaX092Pa0UEfddS4BPcvte8crdoy3ZJcSkw6zYLKPWvt1T5zYWuGobM0gxC
ZUtlYVamI8qCZVbq5il2UcLRAIylNRfEur7ss+ePXMbHP/oS2Van1L5i/wgbS3nu
RBeqtmkamKm5NAMVhSDC3k1MYMD22mMC4beT7gaNMh7D077Gw5pkXTgvMZ0dEENF
92lOF9Jd3DtjjFtEleZtgyfKTqaM7rkBPh1uLPq4Nd50fgI1nPfCbOqhIMOAWh64
ohqbwjcGDD7WyUsLKiaNhtqhaH7IKMZ5GZ/VehEhrdjgx+HSOXto6FemcOMT/5zf
+Bez3QdTC1dLe1afvf1VJeQAUOenB05JzKRpoN4dpDragDgfcnbGAHuQ2o42U679
+Doc3wyVmIlLeK9+kOSDR5poOsLT4jXR9QYUHzryhbEESBjG1MU1o4TD7pchgZmw
jQnMMsWywUBXMrQpG/bxUOt5vZ8fW6PBcEG4wW4YhII7lLazDAkfyqpnVBmxwmr2
Ugzlml2/3iqPWyK2Eb24
=vhAt
-----END PGP SIGNATURE-----

--jho1yZJdad60DJr+--

Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Thu, 20 Feb 2014 19:00:03 +0800
Message-ID: <3778635.cDiIDheKpq@diderot>
In-Reply-To: <1392711245-29837-1-git-send-email-linus.luessing@web.de>
References: <1392711245-29837-1-git-send-email-linus.luessing@web.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart4468258.m7H98HPNSW";
 micalg="pgp-sha1"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCHv2] batman-adv: use ether_addr_copy
	instead of memcpy in multicast code
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
To: b.a.t.m.a.n@lists.open-mesh.org


--nextPart4468258.m7H98HPNSW
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

On Tuesday 18 February 2014 09:14:05 Linus L=FCssing wrote:
> ether_addr_copy is supposed to be slightly more efficient for copying=

> mac addresses, so let's use it. This makes recent versions of checkpa=
tch
> happy, too.
>=20
> Introduced by e368857f66620b8483166e8e6556d9c87f9b3e71
> ("batman-adv: Multicast Listener Announcements via Translation Table"=
)
>=20
> Reported-by: Antonio Quartulli <antonio@meshcoding.com>
> Signed-off-by: Linus L=FCssing <linus.luessing@web.de>
> ---
>  multicast.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied in revision fb4756f.

Thanks,
Marek

--nextPart4468258.m7H98HPNSW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQEcBAABAgAGBQJTBeAzAAoJEFNVTo/uthzAA2QIAJZt8Lfr7jv2u6JCEOr50gQ3
Fs8l5VBjgbD1R1gL8N7/ZnXuh1WOl6yGuXGBZGsfHAoChPMKFePOJgdvivksBJok
1thgJ9kFBEXN9tS2ViM+X9emo836sOArFm9v8WB9DMIcmuRj2w7bzLlsUTVrgXsT
LSIc4BpNE7NNhVm/o4uT5KrzdlYmnBIJseVUROcS47/RjRAt5TRNvqdPZ0gdwzC4
7lETkmztdcqbnsVfI+YQ7NUul6wztV9R04gx21ZAEHaafarwEebrGqZacLOBOLnX
JabwQZAsVjYI39IoVJBdMFXWx7dV8P9EUzmtVpt6C5+MyB//WRxtHLPtCTwp2jE=
=Sau7
-----END PGP SIGNATURE-----

--nextPart4468258.m7H98HPNSW--


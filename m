Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Thu, 16 Jan 2014 06:39:46 +0800
Message-ID: <1623843.8haViQbMF3@diderot>
In-Reply-To: <1389789573-1680-1-git-send-email-mareklindner@neomailbox.ch>
References: <1389789573-1680-1-git-send-email-mareklindner@neomailbox.ch>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart4163982.TMj6GxqSLS";
 micalg="pgp-sha1"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH-next] batman-adv: fix batman-adv header
	overhead calculation
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


--nextPart4163982.TMj6GxqSLS
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

On Wednesday 15 January 2014 20:39:33 Marek Lindner wrote:
> Batman-adv prepends a full ethernet header in addition to its own
> header. This has to be reflected in the MTU calculation.
>=20
> Introduced by f1f310d5c261f0214f85afea95d5cd11d49d64c6
> ("batman-adv: consider network coding overhead when calculating requi=
red
> mtu")
>=20
> Reported-by: cmsv <cmsv@wirelesspt.net>
> Reported-by: Martin Hundeb=F8ll <martin@hundeboll.net>
> Signed-off-by: Marek Lindner <mareklindner@neomailbox.ch>
> ---
>  main.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied in revision 746d643.

Regards,
Marek

--nextPart4163982.TMj6GxqSLS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQEcBAABAgAGBQJS1w4+AAoJEFNVTo/uthzA7D8IAKiimeguNfFqI+Jp/UVdhcbl
5sKhY/r/B4AOIqlWK6j6PmHqZBMF0Vp1AH+vEfjU1TrFt/SH9kWqucNd8MDIIfKS
2CFzVKYf9P5fXgH/PFb1Y1xg7qfB1Nch4zQmL8vANGQg3RNt4eiH335iHyzcLhEQ
shLcZGUIcy03AK4kCIik3Jh9IYtUUiQDp43KjAJ4Q+UUoxZHcwFyVINk/eBEQt9d
0Q13w6O+pcmSHMERiH4QLkp5B89qf9fxeMpfjHZyar99ZPSWxUXAIB3LeD4Qn9ZL
iyTr2JxtXfcWUjyzJF95ld5HKrBu3xH9hINj674wVyoLNWXdyubg8q7Mtm40UH4=
=DXwD
-----END PGP SIGNATURE-----

--nextPart4163982.TMj6GxqSLS--


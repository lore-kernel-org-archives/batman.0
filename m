Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Tue, 18 Oct 2016 15:39:36 +0200
Message-ID: <2088086.l1VxCJGyzP@bentobox>
In-Reply-To: <1470566059-3782-1-git-send-email-linus.luessing@c0d3.blue>
References: <1470566059-3782-1-git-send-email-linus.luessing@c0d3.blue>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2003295.t5ZfRSHogU";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [v5,
	1/2] batman-adv: Remove unused skb_reset_mac_header()
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: Linus =?ISO-8859-1?Q?L=FCssing?= <linus.luessing@c0d3.blue>
Cc: b.a.t.m.a.n@lists.open-mesh.org

--nextPart2003295.t5ZfRSHogU
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

On Sonntag, 7. August 2016 12:34:18 CEST Linus L=FCssing wrote:
> During broadcast queueing, the skb_reset_mac_header() sets the skb
> to a place invalid for a MAC header, pointing right into the
> batman-adv broadcast packet. Luckily, no one seems to actually use
> eth_hdr(skb) afterwards until batadv_send_skb_packet() resets the
> header to a valid position again.
>=20
> Therefore removing this unnecessary, weird skb_reset_mac_header()
> call.
>=20
> Reviewed-by: Sven Eckelmann <sven@narfation.org>
> Signed-off-by: Linus L=C3=BCssing <linus.luessing@c0d3.blue>
> ---
>=20
> Changes in v2-v5:
> * none
>=20
>  net/batman-adv/send.c | 2 --
>  1 file changed, 2 deletions(-)

Applied in 3d34c0a675b20cf6dd2b8680188f1ebd399c3589 [1].

Kind regards,
	Sven

[1] https://git.open-mesh.org/batman-adv.git/commit/3d34c0a675b20cf6dd2b868=
0188f1ebd399c3589
--nextPart2003295.t5ZfRSHogU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIcBAABCgAGBQJYBiYYAAoJEF2HCgfBJntGEgQQAMjb2cQ3CxdP+0xoRN6pcFDy
6SSq2+YhorUmdkKF4Sk8WeUDlwn4ps+qj0cK0zlYCDn4BD1dnFnoh5n+at43hVAU
4tJx8Tq6fMZxTLuyLbag/upglzZT5sLJT9B+8+xE6P/h+Mn4yOL4oqQyArsobLNV
g8yZa4wg2DZ0U5v+hLHzrTkUyVo9DOpfemLdBwLnANW2T/AyFjzF60c0SVJYZjzE
gg1jd4VGFL0vhNKk5n6AW4gg93tzmVRApoJt4DkU+1yLiyPJuYac6d2ulaVRaeGG
I8UNIV+Gpa8cDLjZUmWpVmCDttRqLfS4ar+Y0VUkktVCriBSyeCB6cb4h2XterjG
fUUyHVvLDRkVgrw4tisQhxsJQGkHwHsr1agRe+1+gUc7T9tVeNZVilTAzwfjEvAb
ylHqpZGg1K4InQTnf6HFXOtZb+sfe38NyYY0GWCWF3ApTuq7XB+mb4lbTZcL6j9G
nzEZYLCez7PlYquY0TUYJcdGFVdlDPw5VcrNnq9eJ9k3qFJfjYAwHzDatApMtLGp
hDdhqBZsc9nh2g3zPoyBeOqTmN4DWD2piXcK2t01N9BjRT0lgbXJxYZkPiUNjo3z
PJ2MiDleSj/2hdZuR9NWjmTyGgsC4CaG0CYPDqA44/ujwGKAT47wrsnj++LXiB+n
U2JZN3E0TiPzYSEtLA39
=+0A8
-----END PGP SIGNATURE-----

--nextPart2003295.t5ZfRSHogU--


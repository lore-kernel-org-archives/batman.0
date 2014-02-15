Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Sat, 15 Feb 2014 08:29:57 +0800
Message-ID: <3511220.YUgXR4l5xU@diderot>
In-Reply-To: <1392134707-2318-1-git-send-email-antonio@meshcoding.com>
References: <1392134707-2318-1-git-send-email-antonio@meshcoding.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2641022.arbsXqM8S4";
 micalg="pgp-sha1"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH maint 1/2] batman-adv: fix TT CRC
	computation by ensuring byte order
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
Cc: Antonio Quartulli <antonio@open-mesh.com>, Antonio Quartulli <antonio@meshcoding.com>


--nextPart2641022.arbsXqM8S4
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Tuesday 11 February 2014 17:05:06 Antonio Quartulli wrote:
> From: Antonio Quartulli <antonio@open-mesh.com>
> 
> When computing the CRC on a 2byte variable the order of
> the bytes obviously alters the final result. This means
> that computing the CRC over the same value on two archs
> having different endianess leads to different numbers.
> 
> The global and local translation table CRC computation
> routine makes this mistake while processing the clients
> VIDs. The result is a continuous CRC mismatching between
> nodes having different endianess.
> 
> Fix this by converting the VID to Network Order before
> processing it. This guarantees that every node uses the same
> byte order.
> 
> Introduced by 21a57f6e7a3b4455dfe68ee07a7b901d9e7f200b
> ("batman-adv: make the TT CRC logic VLAN specific")
> 
> Signed-off-by: Antonio Quartulli <antonio@open-mesh.com>
> ---
>  translation-table.c | 16 ++++++++++++----
>  1 file changed, 12 insertions(+), 4 deletions(-)

Applied in revision be4385e.

Thanks,
Marek

--nextPart2641022.arbsXqM8S4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQEcBAABAgAGBQJS/rUIAAoJEFNVTo/uthzAfdQH/08yKAGan3mzHsQ3GxJFSeR3
vHceRBmEfRgaiRG4B+9QgFoSmwmeq8dY48ywEEaS2lvwPZqu18wpbwEXLwxObBff
+sl8p9OCRLSMtiieZk3G3gIxdwN1eQQk179ZMjGzCqdglfvFS3wWovMurmnWd4Jl
FQDEyiVkS4OgMWblrvh1FO2tK/ecYeYf8jIJjZeopXBSRKhSnMUK8YE6+Ov9nGwx
Xv25i3V8NGWhiQ19LpJoyLC1dIw7Q9IKWa2THqAuziqKH+HBD1Hy9WHK+lD2TQ7E
qmmi/oQu7+dMSdeD1S8dgC4Hq6NPMd5x8NQowm+9HW1+HjLaoA8Pn0S8L3OKCxc=
=KNr8
-----END PGP SIGNATURE-----

--nextPart2641022.arbsXqM8S4--


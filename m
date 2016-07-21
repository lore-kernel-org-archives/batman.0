Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Thu, 21 Jul 2016 17:58:07 +0200
Message-ID: <9358912.PbkjNdNDRZ@prime>
In-Reply-To: <1465152428-17299-3-git-send-email-sven@narfation.org>
References: <1465152428-17299-1-git-send-email-sven@narfation.org>
 <1465152428-17299-3-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart39707337.hCzA1Em625";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH 03/10] alfred: Add netlink dependencies
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

--nextPart39707337.hCzA1Em625
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="ISO-8859-1"

> diff --git a/vis/batman_adv.h b/vis/batman_adv.h
> new file mode 120000
> index 0000000..72222e9
> --- /dev/null
> +++ b/vis/batman_adv.h
> @@ -0,0 +1 @@
> +../batman_adv.h
> \ No newline at end of file
> diff --git a/vis/netlink.c b/vis/netlink.c
> new file mode 120000
> index 0000000..06d13cc
> --- /dev/null
> +++ b/vis/netlink.c
> @@ -0,0 +1 @@
> +../netlink.c
> \ No newline at end of file
> diff --git a/vis/netlink.h b/vis/netlink.h
> new file mode 120000
> index 0000000..c7a63b5
> --- /dev/null
> +++ b/vis/netlink.h
> @@ -0,0 +1 @@
> +../netlink.h
> \ No newline at end of file

I was wondering why you use symlinks here, while we pull in the other h=
eaders=20
from=20their original paths (../packet.h, ../list.h).

We should probably keep the header handling consistent. What would be y=
our=20
opinion whether we should use relative paths or symlinks?

Thanks,
     Simon
--nextPart39707337.hCzA1Em625
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCgAGBQJXkPEPAAoJEKEr45hCkp6hZ2QQALxDJbEEZDpCKYGNr5lzXsqu
zaBflOnKi56uHYc6PsA9nmdRAs9kC1ET7jOFH9tiXhPZ1xCXwrfD2CKUhoqlthB4
ypEtO322NwiewP1QNbKZoRpKLhyffQuBo92gmoxUXC4/GNyaLndZ3mda1+yDGdoJ
xdlOoEjM61WCljYwjnShblmb/Exxh0WLnGDhUyECAHg2Kwb3rH5Ck4hl99jPCwwn
i38fi9ppJ8kfekwNThfNxXhoQ2aYhNnK4h/alYpr1Lfbq5KwM2nLzl+i8mFuUOfe
BMhG3mtSHaPmMX3DM2wM9N5xG5oBJsG/NwD61vZyF13awq8q3AM3pMJIllrdq2Lq
eNeGuy4sEnxq9eBhE8G48d8XWS5Qvqkqpx06SJ/CFb8WgHjdzCpshF8h23Cbo8te
QccxEmaOULE9WQCJuzWp8zTHxasXD+GWWqXgVtNnQRlUlyz7zBkzGA/ONPCpwPwo
Bl3BqpFZzwLtM+8xNvyJcK5tkzsqE3SfpY2m4JhFL0i3XJ2g0Te2MM0y2QfxJTUc
DKgzxNCRrExFmJHnxP8+i1dUTM3108UWnt+qMOZl6np4448QjEd/R6dVARfj8uoF
zKNewap8eidhGsJO3chOREHy/5NeDbJY0s6GeJXFTWs6ybn87JhqWRj8UJpX9kOc
/3V1xrjgPsADpLCIGLmX
=ewMq
-----END PGP SIGNATURE-----

--nextPart39707337.hCzA1Em625--


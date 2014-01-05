Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Sun, 05 Jan 2014 22:44:34 +0800
Message-ID: <2590012.QFmZgKB3PI@diderot>
In-Reply-To: <1384410369-7437-4-git-send-email-linus.luessing@web.de>
References: <1384410369-7437-1-git-send-email-linus.luessing@web.de>
 <1384410369-7437-4-git-send-email-linus.luessing@web.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart6021050.kGTzZf258s";
 micalg="pgp-sha1"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCHv11 3/6] batman-adv: Announce new
	capability via multicast TVLV
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


--nextPart6021050.kGTzZf258s
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

On Thursday 14 November 2013 07:26:06 Linus L=FCssing wrote:
> diff --git a/multicast.c b/multicast.c
> index cb1984d..9465455 100644
> --- a/multicast.c
> +++ b/multicast.c
> @@ -199,11 +199,46 @@ out:
>  }
>=20
>  /**
> + * batadv_mcast_mla_tvlv_update - update multicast tvlv
> + * @bat_priv: the bat priv with all the soft interface information
> + *
> + * Update the own multicast tvlv with our current multicast related
> settings, + * capabilities and inabilities.
> + */

Return value ?

Cheers,
Marek

--nextPart6021050.kGTzZf258s
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQEcBAABAgAGBQJSyW/XAAoJEFNVTo/uthzA62wIAJ3EVwQzrKbQcUEFZCxmE5Ix
IhtwW4sqnPXKu0+14V2aBTlx5c94Nt750e54uaAFNf4d8fKOZQuw8ATfQHYeraDU
flU07lFShuL201zXXP7+0VQHTDJFtt8ogpJYj5mQUTPnPwqIYKsHjzORRt2XHiDo
p11j2v6HcSZx5F2eqgLpA4V+Gn+hjobJ8yi9xE/aT9o+Kb2Hna4PXg+aR3Ru4KTb
70pKoPUlT/SZhC64PwWuHvegrbq+dBR0T581kF9zXimSpxVmqm/e2CF/E938LPQs
Cusl9v5R7dHV/JuoiqvadVf06moLakYgMaz810xGpgOHjGXu82hSEWuEkuHqvYo=
=d2E8
-----END PGP SIGNATURE-----

--nextPart6021050.kGTzZf258s--


Return-Path: <sven.eckelmann@openmesh.com>
From: Sven Eckelmann <sven.eckelmann@openmesh.com>
Date: Fri, 15 Dec 2017 18:18:58 +0100
Message-ID: <1591888.FGtWPsc1tq@sven-edge>
In-Reply-To: <CAF=yD-JTfT-iOBG6KMhXv=KggoZ4tEP1fiJMiHMA_d0-wYncLQ@mail.gmail.com>
References: <20171205143514.4441-1-sven.eckelmann@openmesh.com>
 <1780732.fBLghQceHc@bentobox>
 <CAF=yD-JTfT-iOBG6KMhXv=KggoZ4tEP1fiJMiHMA_d0-wYncLQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart5046753.MIUEH2JG4I";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [RFC v2 2/6] batman-adv: Rename batman-adv.h to
 batadv_genl.h
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
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Eric Dumazet <edumazet@google.com>, Network Development <netdev@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Jiri Pirko <jiri@mellanox.com>, "David S . Miller" <davem@davemloft.net>

--nextPart5046753.MIUEH2JG4I
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Freitag, 15. Dezember 2017 11:57:55 CET Willem de Bruijn wrote:
> > No, this is also bad because batman_adv.h is MIT license and packet.h is
> > GPL-2. So what other name would you suggest for packet.h? batman_adv_packet.h?
> 
> Sure, that sounds great. Thanks.

Really? Isn't include/uapi/linux/batman_adv_packet.h looking like an accident 
which never should have had happened?

Kind regards,
	Sven
--nextPart5046753.MIUEH2JG4I
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAlo0BAIACgkQXYcKB8Em
e0aK6BAAlzXzbIsR397TU7F1x91ZSG1G7AQnwtW0UCbu28cp9SZpBOQ2kjiisVcc
JsUNgLng3i9yzMAOzp7lCH0OIV4jZEbykQHHjvWibxwh4nyIplkJFTvMKlDK0BUx
uEhttarf+SOZWrw9YBYSY8JzhUII7dsjROAZU2vW8mwGowR/nFrA5ygPf9uxVcXo
+qk88qi94ZUpngFlQIcjgZWrEGwBdsn+XHAFv5uKN6EbHsIqnw4Li4OBuneKx5Yx
tfunveU4yLbjj+jYoKeQEOAaF6Zt3XL8yKWB5P8MT5l56BxOFa5CztrpJTC5OWof
dUi3afdDFPn0ZqP/RhJ5WGGAjnAaXidU+4mGVkxx/cVAcP5GiwMwhZvA1Bs19UBh
p0H2z0226ER4QNjVqnEBMgpVnMzZ26nu2ET9CvxBU4hS88u81px+vYHdecr7Fwmr
qBA4IfAUEfhYqFbvf28fyTUJtB/tjh/9yNRAxc9eBs+BCQ3GBR9DOP4F+YSftvTZ
hURz8OYYi+aGlrN5v2MwE1JX4R+Sf8K2eYRBGF8PZ7TQMWdZlcd+Ibkbgr1vL8My
vHulHiP6N1Ykh5Kcx2saMdaFxRu1WAHKNwk2tNmCg5aSmmM3+tF8C7HYEGEU/jMN
SDpOL3TwUUF5chtiXWD7da9qzekuXedoKZ2akr5XQSSOedRQa0Y=
=dRDS
-----END PGP SIGNATURE-----

--nextPart5046753.MIUEH2JG4I--


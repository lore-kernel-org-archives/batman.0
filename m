Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Fri, 01 Jul 2016 15:48:26 +0200
Message-ID: <1670925.mp1DXEWlck@prime>
In-Reply-To: <1465557064-24406-5-git-send-email-apape@phoenixcontact.com>
References: <1465557064-24406-1-git-send-email-apape@phoenixcontact.com>
 <1465557064-24406-5-git-send-email-apape@phoenixcontact.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1593069.JJEvafSRTi";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH v5 4/6] batman-adv: drop unicast packets
	from other backbone gw
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

--nextPart1593069.JJEvafSRTi
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"

On Friday 10 June 2016 13:11:02 Andreas Pape wrote:
> Additional dropping of unicast packets received from another backbone gw of
> the same backbone network before being forwarded to the same backbone again
> is necessary. It was observed in a test setup that in rare cases these
> frames lead to looping unicast traffic backbone->mesh->backbone.
> 
> Signed-off-by: Andreas Pape <apape@phoenixcontact.com>

Acked-by: Simon Wunderlich <sw@simonwunderlich.de>

I believe Svens previous concerns have been cleared. When you resend this 
patchset, please add my Acked-by into your commit message (unless you do major 
changes in the content ...)

Thanks,
     Simon
--nextPart1593069.JJEvafSRTi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCgAGBQJXdnSqAAoJEKEr45hCkp6howcP/1aqsLRHbSdJqv4lSQCLIuHH
AQ3nE9tFVitovxsQipCmw/5IdhXcQ7+q1mXaGx2bQQ0QamwzkivWPdasafGiiF1u
FIAhu066Y9lAXisOirPXoo7Qnwaer2ftwNMZLxftKPwnmfr/dmvonCoUJKu2HZsC
2jQ7Vqr/l0MDek3jsYT8VFJRBC+hXgx7Auyfh1EekLtepz0slyzUcT85ZHSJbyk/
ki2WNUbkT4CEfOBD1HNoDp0HxXmhJpKwM3arIqH3uMQoD3GBRuOqJi1Or0hr/dlc
lqQTPR7mUwCsUZ7g0clDRoc+L3m8AjhIkKVjjK6Hqnu2b3M0YO1enKbbG2qnG5mn
tb/PlTojBTxNHpfkYAjzkOfMpqCokOAkoZSSOw8FErk0k6bgYG1sNA+Zim5Nv/sT
CB7byEj1ZPmXnsvA1s9xrA1dIMmuv+RsVqzdmb+3YYm8sJkpR8tTU0NEGY5977DQ
/0qiCNQljaAozTWKJrSgtbY0VLxTXVMMUToyNmxBp3oofJkLaw8APfx/TZKqlmqo
A/DU2uNQ7HCZlfn/s02z7lqM8Hesr2r89cFjxbblBiJsY3D4MJS2QHVr7469kwrZ
1tZdBEj+K609+W1R2iYzHq8PiZ7DA25X3z4/9dqlMHxNH38tywwS4agji3ALlYxx
Hg0aAUhbyX3fNk+tZD1P
=hZ5c
-----END PGP SIGNATURE-----

--nextPart1593069.JJEvafSRTi--


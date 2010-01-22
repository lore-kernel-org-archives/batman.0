Return-Path: <sven.eckelmann@gmx.de>
From: Sven Eckelmann <sven.eckelmann@gmx.de>
Date: Fri, 22 Jan 2010 13:16:09 +0100
References: <20100121190251.179780@gmx.net>
In-Reply-To: <20100121190251.179780@gmx.net>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart3269397.VM0Exk1WP2";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <201001221316.10168.sven.eckelmann@gmx.de>
Subject: Re: [B.A.T.M.A.N.] batman-adv on different archs
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: b.a.t.m.a.n@lists.open-mesh.org

--nextPart3269397.VM0Exk1WP2
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Juha Yl=F6nen wrote:
> This looks interesting, I've had problems with the wlan driver before but
>  it has been quite stable for a while. Wlan chip in use is CSR UniFi 1050,
>  with driver compiled from CSR supplied sources.

Cannot find the driver at http://www.csr.com/products/UF1050_over.htm

> I'll try your rawsend and ping capturing during the weekend. Sorry for the
>  bother in advance if this turns out to be due the crappy wlan driver (as
>  said, it has been giving problems earlier, though I haven't seen any
>  packet mangling before).

So please test and capture=20
 * rawsend from ARM
 * ping between laptop and arm=20
 * a "ping -s 1" between laptop and arm

I hope that tests help to see were the problem really is. If the ping -s 1=
=20
works, can you please also capture a some packets of batman-adv 0.2?

Best regards,
	Sven

--nextPart3269397.VM0Exk1WP2
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQIcBAABCgAGBQJLWZcJAAoJEF2HCgfBJntGVYAP/2lMYlmKoDk5xJ8Fha4QRVC0
aYTdJvRCiIqjwyXOj0KGx+zuwvYf18kvhwYvgms3qCY3Ad9tIk5FIa/2pm9BhQwJ
hVWDHFtbdJt6bix+F730OCnlsCkZhCERmyFO8dXPXK3USGTR/G0q6GkPYA2A1lEO
sbjXJ4TyyWc+q8xsGASpsMaMsqWfobzU0WhJuyTmL3jaQltFSqg5SFn6GTIM1Nx3
f82WIZ9aQVfOGVZTp1khw5MWCNUx7OVbhmXpF+Y2g4gGdvP1TgUE2tMslgyQbwGy
31FW8tQedc7a7kzQlAcQY4j8IggJQbAdqemsROUjBNvYsKxqJOujV8Ie8+7WxxBa
ronmOKh91PleC7IidohLEdHSBApG+lVimFQbZ8uZIcGV3P+lv4XbrFyJzf3IX+il
TVwM9uPhbr1MdhWyyn8X1Epd+Gj6Bz9b360r7VzkR+dVRs4dMEkTyAMpSjEb/aDz
RDQ6IO3/kqBkAz3epoIBDCNNlhOMS8ayVoI+KCc+ujgVPRSdi3xiDMf11Brv978e
kIdzeTKMlpzcky2t+1WEe2FmJvqD9WLos+e0nvJlw+qgoKyq+hED78cpiZe5wZaw
lU5IZgLJTiNCDekx9MX5l+EHpvc6V+oir73Fa3O1PGddfmLm+JgKDUuPy7zB/SrH
Me29SjPzQFFOTigyDVJk
=KAfs
-----END PGP SIGNATURE-----

--nextPart3269397.VM0Exk1WP2--

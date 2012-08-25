Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sat, 25 Aug 2012 09:48:13 +0200
Message-ID: <9827732.nI5HHbgEEA@sven-laptop.home.narfation.org>
In-Reply-To: <1345851557-8085-2-git-send-email-lindner_marek@yahoo.de>
References: <1345851557-8085-1-git-send-email-lindner_marek@yahoo.de>
 <1345851557-8085-2-git-send-email-lindner_marek@yahoo.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1489303.ZMike5Ma9y";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7Bit
Subject: Re: [B.A.T.M.A.N.] [PATCH 2/2] batctl: make bisect_* a compile time
	option
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
Cc: Marek Lindner <lindner_marek@yahoo.de>


--nextPart1489303.ZMike5Ma9y
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="ISO-8859-1"

On Saturday 25 August 2012 01:39:17 Marek Lindner wrote: 
>  # standard build tools
> +ifeq ($(CONFIG_BATCTL_BISECT),y)
> +OBJ += $(OBJ_BISECT)
> +CFLAGS += -DBATCTL_BISECT
> +endif

-D is a preprocessor thing. So please move it to CPPFLAGS

Kind regards,
	Sven
--nextPart1489303.ZMike5Ma9y
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAABCgAGBQJQOIM9AAoJEF2HCgfBJntGh9EP/j1TgzdKTNITt0BtWUehpwxs
ep00XshYJ2gWZ1eGXK69OKRmJrxCRVsn9UAtizCZ5puiWVDJzAEwHjNDFuGD0wMK
6MAhcyUJtBqyOOo3EGDQO3dUiCSCEF+lU9awU+pcknAKR8CJ25tFE1yY+MDVHLRh
kYrfiknf/UkPNivAjxO1Z2Phd1ncF1z1JszCcrAUOOqHN/21V3dfSMY8qDYhceYp
F4+T7zM2SmB8Y5rBe03/sBioiQPvsJn7k9NHTD+MG1bl1JNSl+V/L4aeBHLBHWtP
WKu54JKc70yiJfEfGxvQDiQYLfl60oDWXmx+raFI/FPop89rfmQ9kNyw3bxl33XN
2nrhdLboQzhVXRm6PgfYYdHpa6xlfOedopu7leT6Ap7Q+5acnc78QZjBQyphRdn/
1xQRwbfnaojNRc1hc3l5mHf+ik4uG3gabE2UIjNScuFRH7Jmz53wB7F7bz/5KQ8M
fIKV9LeLWWYCSmeqO/LOoV0NlgRxS1/UN9+c8pbBEdGr23NtrgyJg4wIoa0ZMdlG
GtAC67V4X6tXj5kQh8c1sSWbiNa3IT5QeRfyQr7V1UAzOomnHPiYX7GtzWMFFJZK
d5OeOqRUwedQ24NDHeduS6hi3NZ4RERLX8mytiRS/1vCs4fyBcbUj+ylmRXCi9Y4
xm6Lk3HJFuAIjlrtvoow
=QtHs
-----END PGP SIGNATURE-----

--nextPart1489303.ZMike5Ma9y--


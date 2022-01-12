Return-Path: <b.a.t.m.a.n-bounces@lists.open-mesh.org>
From: Marek Lindner <mareklindner@neomailbox.ch>
Subject: Re: [PATCH 1/2] alfred: Avoid large send buffer for fixed size IPC
 commands
Date: Wed, 12 Jan 2022 17:07:42 +0100
Message-ID: <1892741.M55d7pzXy7@rousseau>
In-Reply-To: <20220104091103.162365-1-sven@narfation.org>
References: <20220104091103.162365-1-sven@narfation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart15364136.Uj9UFOjQu5";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

 
--nextPart15364136.Uj9UFOjQu5
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"; protected-headers="v1"
From: Marek Lindner <mareklindner@neomailbox.ch>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>
Subject: Re: [PATCH 1/2] alfred: Avoid large send buffer for fixed size IPC commands
Date: Wed, 12 Jan 2022 17:07:42 +0100
Message-ID: <1892741.M55d7pzXy7@rousseau>
In-Reply-To: <20220104091103.162365-1-sven@narfation.org>
References: <20220104091103.162365-1-sven@narfation.org>

On Tuesday, 4 January 2022 10:11:02 CET Sven Eckelmann wrote:
> For data related IPC commands, a buffer of 65527 bytes is necessary to send
> or receive a complete command. But for non-data related IPC commands
> usually have a fixed size. It is therefore enough to allocate exactly the
> minimum required amount of bytes on the stack for non-data related IPC
> commands.
> 
> Signed-off-by: Sven Eckelmann <sven@narfation.org>

Acked-by: Marek Lindner <mareklindner@neomailbox.ch>

Cheers,
Marek


--nextPart15364136.Uj9UFOjQu5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEI5CG6MPJfr3knG//U1VOj+62HMAFAmHe/M4ACgkQU1VOj+62
HMA/Pgf/Sy51Zhxx2sFgbLO9dCRHtnZg2T5eaAi5pXmbQYp6SWHs8CHudh4QEH5I
zjBtszzhKZN/D2QeqESKctoA08fF2HhPR2FHn0FMqsxiud1tGsPCKlXwWxKFfpUG
dwoyNNOnDbPXqAPS7yT0ttvDyt/RWZTsWn+3n9+8jCqRcpeGVVfLERR1D60HP72B
dq/z4Z/92jh12G3nb/TwgeVUhhk9z3KYljcFNb7ylZzB2zi8nB67aWoqQgPyNYsX
MJ7KUwK2D1BlTCPAd2j0jz9RCYXi6orFviuYxtEzGYA+VUMvGob2tx+/sGN4P2um
LfowZ+qG5to2ujd5sSt2ScQy4VYpiA==
=ildg
-----END PGP SIGNATURE-----

--nextPart15364136.Uj9UFOjQu5--



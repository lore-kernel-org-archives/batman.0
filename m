Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Fri, 15 Apr 2016 00:54:01 +0800
Message-ID: <2029987.oZxyxTf84I@voltaire>
In-Reply-To: <1460451087-18450-1-git-send-email-sven@open-mesh.com>
References: <1460451087-18450-1-git-send-email-sven@open-mesh.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart10509596.6eyXIC5S81";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH] batctl: tcpdump - Add support for bla
	loopdetect
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

--nextPart10509596.6eyXIC5S81
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Tuesday, April 12, 2016 10:51:27 Sven Eckelmann wrote:
> From: Sven Eckelmann <sven.eckelmann@open-mesh.com>
> 
> Complex bridge loop detection was added to batman-adv. It uses so called
> BLA LOOPDETECT ARP packets to find out if there is a loop. The bla2 claim
> function of tcpdump extracts the same information which also
> batadv_bla_send_claim uses for its debug output.
> 
> Signed-off-by: Sven Eckelmann <sven.eckelmann@open-mesh.com>
> ---
>  packet.h  | 1 +
>  tcpdump.c | 6 ++++++
>  2 files changed, 7 insertions(+)

Applied in revision 511de65.

Thanks,
Marek

--nextPart10509596.6eyXIC5S81
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJXD8spAAoJEFNVTo/uthzAOYEH/2uD6LyBWOUDSA8lIErC+N7v
iABrb85+rQbkbz7K9GuH/X9S6w8bR78BizLl3ONwrQuFAyJMhftYap4n5tRrN8DU
quBau5DXIp8EseSSZyvndatDpDesPz4z7IO+o7U5U5MU9O7tAnxPQS80KmTTQx7b
/AB9BzGjhjSWpv8pFTS9fagAEBKwF1m9f5OSmU99frlQalM8ADppalgLGeVWh4v8
GklWUDzrQ4+XmaEKNiCuWdPhNjiieCToIfSxjiPGf+y7hFX17Y49oFO5kncVP7T6
WaigpbQmBHkYSGVjGnJvHp9SkVwwS9R3PrZxtfKboF45oCEDQyRKRfO4PvPlLH8=
=2UFx
-----END PGP SIGNATURE-----

--nextPart10509596.6eyXIC5S81--


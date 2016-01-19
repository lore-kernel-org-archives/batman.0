Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Tue, 19 Jan 2016 23:11:36 +0800
Message-ID: <4037991.EDGUVt5x5N@voltaire>
In-Reply-To: <1452933619-6712-3-git-send-email-mareklindner@neomailbox.ch>
References: <8047297.0qIFjkW2bL@voltaire>
 <1452933619-6712-3-git-send-email-mareklindner@neomailbox.ch>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2107390.9CHonRUv17";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH v2 03/12] batman-adv: ELP - creating
	neighbor structures
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
Cc: Antonio Quartulli <antonio@open-mesh.com>

--nextPart2107390.9CHonRUv17
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Saturday, January 16, 2016 16:40:10 Marek Lindner wrote:
> From: Linus Luessing <linus.luessing@web.de>
> 
> Initially developed by Linus during a 6 months trainee study
> period in Ascom (Switzerland) AG.
> 
> Signed-off-by: Linus Luessing <linus.luessing@web.de>
> Signed-off-by: Marek Lindner <mareklindner@neomailbox.ch>
> Signed-off-by: Antonio Quartulli <antonio@open-mesh.com>
> ---
>  compat-include/linux/average.h |  74 ++++++++++++++++++++
>  net/batman-adv/bat_v.c         |  23 ++++++-
>  net/batman-adv/bat_v_elp.c     | 152
> +++++++++++++++++++++++++++++++++++++++++
> net/batman-adv/bat_v_elp.h     |   4 ++
>  net/batman-adv/main.h          |   3 +
>  net/batman-adv/types.h         |  33 +++++++++
>  6 files changed, 288 insertions(+), 1 deletion(-)
>  create mode 100644 compat-include/linux/average.h

Applied in revision 2c2fe0b.

Thanks,
Marek

--nextPart2107390.9CHonRUv17
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJWnlIoAAoJEFNVTo/uthzA1jIH/0hSa3YkE7vLubWTHMDB4Cuc
QmaLuzLzJlcSagJ2BxKXLl45C0+cC1QmasALDea5yeeScADkXNdTFK7x0vPqPT6e
fzQszl+ECya5V174pKCQeOl7IpAy7OIJmWBQrn3o4XBLdqqUdlee6ouvGJGorZWV
50wht1KogiJcFqe2CymQTsau5eo8GiDDEuugtLLZ7NWQLPsQW0rJSZSyLqnb1pqG
ZIeCJRA3Mazw4aEpIPSIf4N1yMf05a7JFw4jzYn8dNEL38pRsPUBpXGNwdMWqgPl
vMDm91aYW9QTG7CjSYRsnzlCiaWmyTCm7+h8/SaCzsvfX+nh9GnAqp02UEQADeI=
=Ezx0
-----END PGP SIGNATURE-----

--nextPart2107390.9CHonRUv17--


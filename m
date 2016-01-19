Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Tue, 19 Jan 2016 23:16:47 +0800
Message-ID: <1493288.HAzWX9H0N7@voltaire>
In-Reply-To: <1452933619-6712-7-git-send-email-mareklindner@neomailbox.ch>
References: <8047297.0qIFjkW2bL@voltaire>
 <1452933619-6712-7-git-send-email-mareklindner@neomailbox.ch>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart5547908.xyrziZTEm5";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH v2 07/12] batman-adv: add throughput
	override attribute to hard_ifaces
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

--nextPart5547908.xyrziZTEm5
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Saturday, January 16, 2016 16:40:14 Marek Lindner wrote:
> From: Antonio Quartulli <antonio@open-mesh.com>
> 
> This attribute is exported to user space to disable the link
> throughput auto-detection by setting a fixed value.
> The throughput override value is used when batman-adv is
> computing the link throughput towards a neighbour.
> 
> If the value is set to 0 then batman-adv will try to detect
> the throughput by itself.
> 
> Signed-off-by: Antonio Quartulli <antonio@open-mesh.com>
> ---
>  .../ABI/testing/sysfs-class-net-batman-adv         |  9 +++
>  net/batman-adv/bat_v.c                             |  6 ++
>  net/batman-adv/gateway_common.c                    |  4 +-
>  net/batman-adv/gateway_common.h                    |  2 +
>  net/batman-adv/sysfs.c                             | 74
> ++++++++++++++++++++++
> net/batman-adv/types.h                             |  2 +
>  6 files changed, 95 insertions(+), 2 deletions(-)

Applied in revision c513176.

Thanks,
Marek

--nextPart5547908.xyrziZTEm5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJWnlNfAAoJEFNVTo/uthzAawUH/1Wybj2kHYATbmWktOaacsNQ
3YIZCH0iuybtGIZF4e5taQ43W3mbsJ9G3+As8kdvHrl0hC5gtj0Pgwf3NwYAwnbQ
GW/NkIfUxLd3JmZup1OGvNoeXSERi0Zn2cBjAGMwb6wOYhWqR5Ix5R3DFu4Qwd89
RUiX80eOZYlupfxKi/tepXc+ros4p73rFMgxwKgWCA6EigJad39JA4ecVbFX4dRa
bZZvN7t8ae1VqA41UZTgQpKyKAfqG7xEJEfzTHlijgTNCcqLqtjLIGr2B9FUSI6j
47d773oT1K/1+qlVyT/GkSCmYgW+aJD9RDJueuQqRCGvtDZwF1FlLYEZgy5hzis=
=SCeh
-----END PGP SIGNATURE-----

--nextPart5547908.xyrziZTEm5--


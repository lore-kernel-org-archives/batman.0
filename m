Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Sun, 13 Dec 2015 14:04:48 +0800
Message-ID: <2652144.R6jIfFcVYF@voltaire>
In-Reply-To: <1449606915-6457-2-git-send-email-sven@narfation.org>
References: <1449606915-6457-1-git-send-email-sven@narfation.org>
 <1449606915-6457-2-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart7796973.r50SyfaJTo";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH-next 2/3] net: add possibility to pass
	information about upper device via notifier
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

--nextPart7796973.r50SyfaJTo
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Tuesday, December 08, 2015 21:35:14 Sven Eckelmann wrote:
> From: Jiri Pirko <jiri@mellanox.com>
> 
> Sometimes the drivers and other code would find it handy to know some
> internal information about upper device being changed. So allow upper-code
> to pass information down to notifier listeners during linking.
> 
> Signed-off-by: Jiri Pirko <jiri@mellanox.com>
> Signed-off-by: David S. Miller <davem@davemloft.net>
> ---
>  compat-include/linux/netdevice.h | 2 +-
>  net/batman-adv/hard-interface.c  | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)

Applied in revision 4291a5b.

Thanks,
Marek

--nextPart7796973.r50SyfaJTo
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJWbQqAAAoJEFNVTo/uthzAvZUH/1YDgGZWGzxBLHJQNV0QRtRO
3kmCVDavBKf30Wl7aTHmMy6kSK/2dptDD+mnkHpGSR6I1ZumWngMQJwNxYhJxZjp
dCmjF62TbNTpJahA2a9GOR84DT2WTfO8nJY4ojTlyLdEU/HwlrUoN7qBQYwelAtf
Xb2vrrWCcx691BBEQ3cnfmpXIBq6neXYQyH4WIqo34f/EAXRKIAPE8X4X78kV1Rf
2fzcxg+dq7BNdZBsLAAJuCykr4dbfyTj1xxz4zI+iFFmAVurFOH7DEo19oN5Toya
R0elXoZfGyoILoyxJMRp7ON0kX1JRNaVh4lKrjzUsk6Pw5wcR/Z3/GmsqW5CBUs=
=HtUM
-----END PGP SIGNATURE-----

--nextPart7796973.r50SyfaJTo--


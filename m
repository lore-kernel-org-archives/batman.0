Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Wed, 06 Jul 2016 21:17:27 +0800
Message-ID: <2128734.zXG0ccsr5o@voltaire>
In-Reply-To: <1465721000-9174-1-git-send-email-sven@narfation.org>
References: <1465721000-9174-1-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart4369957.6SZDRDaHbq";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH 1/2] batman-adv: Fix speedy join in
	gateway client mode
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

--nextPart4369957.6SZDRDaHbq
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Sunday, June 12, 2016 10:43:19 Sven Eckelmann wrote:
> Speedy join only works when the received packet is either broadcast or an
> 4addr unicast packet. Thus packets converted from broadcast to unicast via
> the gateway handling code have to be converted to 4addr packets to allow
> the receiving gateway server to add the sender address as temporary entry
> to the translation table.
> 
> Not doing it will make the batman-adv gateway server drop the DHCP response
> in many situations because it doesn't yet have the TT entry for the
> destination of the DHCP response.
> 
> Fixes: 9cbc67d9da47 ("batman-adv: change interface_rx to get orig node")
> Signed-off-by: Sven Eckelmann <sven@narfation.org>
> ---
>  net/batman-adv/send.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Applied in revision 12c771d.

Thanks,
Marek

--nextPart4369957.6SZDRDaHbq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJXfQTnAAoJEFNVTo/uthzAS8EH/jvbfMySwhCOY7OSalsuL5oH
Lprdnlsd+JfgvOfubH+6o1eBk+w4EcmZcKqeK//U21Fe6gPhM6hHGvWGCnduF1Jj
pK8WN2kyX91XKshlpKkUhfX3zZxKNJh9jxBv3WrKm/UB2fgiRy/tmO72FBgcI6SH
JKJIJVXyqiXYumTgYtwgl7LxUlB0S+pM3jI2cyt4kIc6BKMDsa9qBpWbcMfcsT50
G0hqUcNYqw0245QYAhFqSe/TGhXNY7uMJc/6fOEUuJfZ6M1bXsKWxLSbpE0ILmOn
DGEjjJYgk14AwfpDSunGIHSLcXf02kUlc2dDj8g2eS0mNSachwpu8g0wFrtmDZs=
=RA3C
-----END PGP SIGNATURE-----

--nextPart4369957.6SZDRDaHbq--


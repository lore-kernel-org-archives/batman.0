Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Tue, 05 Jul 2016 16:38:01 +0800
Message-ID: <29355629.szZ4lRTEom@voltaire>
In-Reply-To: <1466445210-17616-2-git-send-email-sven@narfation.org>
References: <1466445210-17616-1-git-send-email-sven@narfation.org>
 <1466445210-17616-2-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart4646117.HEP406E42L";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH next v2 2/4] batman-adv: Don't propagate
	negative dev_queue_xmit return values
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

--nextPart4646117.HEP406E42L
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Monday, June 20, 2016 19:53:28 Sven Eckelmann wrote:
> batadv_send_skb_packet used by batadv_send_skb_to_orig and its return value
> is given directly to callers of batadv_send_skb_packet.
> 
>     batadv_send_skb_to_orig
>     -> batadv_send_unicast_skb
>        -> batadv_send_skb_packet
>           -> dev_queue_xmit
> 
> These callers of batadv_send_skb_to_orig expect that the skb isn't consumed
> when they receive a -1. But dev_queue_xmit may still have consumed it and
> still returned -1. Thus the free for the skb would be called twice.
> 
> Fixes: e3b8acbff9c8 ("batman-adv: return netdev status in the TX path")
> Signed-off-by: Sven Eckelmann <sven@narfation.org>
> ---
> v2:
>  - rebased on current master
>  - added patch to a common set of related patches
> 
>  net/batman-adv/send.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)

Applied in revision a20149c.

Thanks,
Marek

--nextPart4646117.HEP406E42L
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJXe3HpAAoJEFNVTo/uthzASIIIALH0pRf+TZOV7W3MweQpYmBM
VswFFnQSst/1DzEq8SUFgtRD7owbjEham9ADhNU2+wo9sgx4IgN/0zH4LlMjt6Lg
zrdPGl4LEtxwUMDiSabQiEqMnDc5WVkOwvX17R2AgCpWeg2irSZr0loWzKPE/VWn
wkUZ/aytb4juO3OhVBpi5Av7y4GhIGOwzX/znj8r3afyoxx/ObUtJZ9wTiW38yKC
CKDQhCUCsNMlzJ5ejgtxSZT222qiT1g/Sw40U/H+ez3bUt5Q/fTk17Yhld7FS4xp
TChKTusNWKwOa+GiPgRWbgoVDSxR9CttXbX67Mykuq0jAavJlwplf/rCIeNJRbU=
=UEoI
-----END PGP SIGNATURE-----

--nextPart4646117.HEP406E42L--


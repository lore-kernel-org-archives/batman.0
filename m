Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Fri, 15 Jul 2016 17:02:12 +0800
Message-ID: <2499080.OzjcWsCEoF@voltaire>
In-Reply-To: <1468148369-17048-1-git-send-email-sven@narfation.org>
References: <1468148369-17048-1-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart3257767.memq8p5RrN";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [RFC 1/2] batman-adv: Allow to disable debugfs
	support
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

--nextPart3257767.memq8p5RrN
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Sunday, July 10, 2016 12:59:28 Sven Eckelmann wrote:
> The files provided by batman-adv via debugfs are currently converted to
> netlink. Tools which are not yet converted to use the netlink interface may
> still rely on the old debugfs files. But systems which already upgraded
> their tools can save some space by disabling this feature. The default
> configuration of batman-adv on amd64 can reduce the size of the module by
> around 11% when this feature is disabled.
> 
> Before:
> 
>     $ size net/batman-adv/batman-adv.ko*
>        text    data     bss     dec     hex filename
>      150507   10395    4160  165062   284c6 net/batman-adv/batman-adv.ko.y
>      137106    7099    2112  146317   23b8d net/batman-adv/batman-adv.ko.n
> 
> Signed-off-by: Sven Eckelmann <sven@narfation.org>

IMHO, this seems like a good idea. Can you resend without RFC ? I'll apply 
that change after netlink has been completely merged.

Cheers,
Marek

--nextPart3257767.memq8p5RrN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJXiKaUAAoJEFNVTo/uthzAtK0H/0x4xuWgaKEyqVCKLgZrOcm6
DGORFcfYnLppztwFR+iw/6dEYTl5lfIJkHKBdCcvwzuk7tctFuQzTQ/BL0H9ZDGr
ud8h7JtsFyIHwvENM6DWZTAUAIhkFthSLt+5Xw3mxQopRYZeb0itRHlvoLnO9Uh3
vw9pSpagTUN7BP68hC9Acq4uSzhaieKG0+XDKYo4SEK1YT/fI4r/XRbZCLzz+Hvd
zmZJL+RMjm3h0FDsuucbRGyfkCNrFFI2kdWWruYoB60OrjfRVcJowFKjt6u0YrvT
im/xErqCzxFnCo5tRuHvXjqzos9YxQFu6Uqqfmb5UqQRCCN8actiaCZ4e8JipGo=
=7xtj
-----END PGP SIGNATURE-----

--nextPart3257767.memq8p5RrN--


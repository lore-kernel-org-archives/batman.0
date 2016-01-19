Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Tue, 19 Jan 2016 23:10:18 +0800
Message-ID: <1476626.X6SWSSjghO@voltaire>
In-Reply-To: <1452933619-6712-2-git-send-email-mareklindner@neomailbox.ch>
References: <8047297.0qIFjkW2bL@voltaire>
 <1452933619-6712-2-git-send-email-mareklindner@neomailbox.ch>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart8258190.CCI93O0fM9";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH v2 02/12] batman-adv: ELP - adding basic
	infrastructure
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

--nextPart8258190.CCI93O0fM9
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Saturday, January 16, 2016 16:40:09 Marek Lindner wrote:
> From: Linus Luessing <linus.luessing@web.de>
> 
> The B.A.T.M.A.N. protocol originally only used a single
> message type (called OGM) to determine the link qualities to
> the direct neighbors and spreading these link quality
> information through the whole mesh. This procedure is
> summarized on the BATMAN concept page and explained in
> details in the RFC draft published in 2008.
> 
> This approach was chosen for its simplicity during the
> protocol design phase and the implementation. However, it
> also bears some drawbacks:
> 
>  *  Wireless interfaces usually come with some packet loss,
>     therefore a higher broadcast rate is desirable to allow
>     a fast reaction on flaky connections.
>     Other interfaces of the same host might be connected to
>     Ethernet LANs / VPNs / etc which rarely exhibit packet
>     loss would benefit from a lower broadcast rate to reduce
>     overhead.
>  *  It generally is more desirable to detect local link
>     quality changes at a faster rate than propagating all
>     these changes through the entire mesh (the far end of
>     the mesh does not need to care about local link quality
>     changes that much). Other optimizations strategies, like
>     reducing overhead, might be possible if OGMs weren't
>     used for all tasks in the mesh at the same time.
> 
> As a result detecting local link qualities shall be handled
> by an independent message type, ELP, whereas the OGM message
> type remains responsible for flooding the mesh with these
> link quality information and determining the overall path
> transmit qualities.
> 
> Developed by Linus during a 6 months trainee study period in
> Ascom (Switzerland) AG.
> 
> Signed-off-by: Linus Luessing <linus.luessing@web.de>
> Signed-off-by: Marek Lindner <mareklindner@neomailbox.ch>
> Signed-off-by: Antonio Quartulli <antonio@open-mesh.com>
> ---
>  Makefile                   |   3 +
>  README.external            |   1 +
>  gen-compat-autoconf.sh     |   1 +
>  net/batman-adv/Kconfig     |  14 ++++
>  net/batman-adv/Makefile    |   2 +
>  net/batman-adv/bat_algo.h  |  15 +++-
>  net/batman-adv/bat_v.c     |  74 +++++++++++++++++
>  net/batman-adv/bat_v_elp.c | 193
> +++++++++++++++++++++++++++++++++++++++++++++ net/batman-adv/bat_v_elp.h
> |  27 +++++++
>  net/batman-adv/main.c      |   1 +
>  net/batman-adv/packet.h    |  20 +++++
>  net/batman-adv/types.h     |  18 +++++
>  12 files changed, 368 insertions(+), 1 deletion(-)
>  create mode 100644 net/batman-adv/bat_v.c
>  create mode 100644 net/batman-adv/bat_v_elp.c
>  create mode 100644 net/batman-adv/bat_v_elp.h

Applied in revision a4b88af.

Thanks,
Marek

--nextPart8258190.CCI93O0fM9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJWnlHaAAoJEFNVTo/uthzAr8YH/1acQHSUi9bKMVRFVNC/ftle
zj2zhK3USgqfTNWoqPnTpMMmbpfgqxK1nC4njOZDAVPVy+YF5l6r/x4w45seJp07
3OqYpY7GkIe/AfLhcRrbAeyUqCzUsdge6e3UvmP3D+Ziy8TNIb6279CV14Bv78Mn
okvC5ralDxNSfdUljXBKwbCJdHVECCrOvgRHOVpkzVgI0Xfbr64W59aVeE02+l6S
c+6a3joVJcEL35lUiunJUXca5EFTZeekfSBQe3MJczcKysv2XocrRkog4xffMF8K
5CkhtzMeOKszSXc6iX/+Oo1Zcl9gD1tReNzhq2W906r9hP97akVJ8y1u2f6nA4c=
=ue/s
-----END PGP SIGNATURE-----

--nextPart8258190.CCI93O0fM9--


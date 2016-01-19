Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Tue, 19 Jan 2016 23:14:08 +0800
Message-ID: <1643332.yH5ko5PfH0@voltaire>
In-Reply-To: <1452933619-6712-5-git-send-email-mareklindner@neomailbox.ch>
References: <8047297.0qIFjkW2bL@voltaire>
 <1452933619-6712-5-git-send-email-mareklindner@neomailbox.ch>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2850724.G2Gc6ZWijl";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH v2 05/12] batman-adv: OGMv2 - add basic
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

--nextPart2850724.G2Gc6ZWijl
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Saturday, January 16, 2016 16:40:12 Marek Lindner wrote:
> From: Antonio Quartulli <antonio@open-mesh.com>
> 
> This is the initial implementation of the new OGM protocol
> (version 2). It has been designed to work on top of the
> newly added ELP.
> 
> In the previous version the OGM protocol was used to both
> measure link qualities and flood the network with the metric
> information. In this version the protocol is in charge of
> the latter task only, leaving the former to ELP.
> 
> This means being able to decouple the interval used by the
> neighbor discovery from the OGM broadcasting, which revealed
> to be costly in dense networks and needed to be relaxed so
> leading to a less responsive routing protocol.
> 
> Signed-off-by: Antonio Quartulli <antonio@open-mesh.com>
> ---
>  net/batman-adv/Makefile    |   1 +
>  net/batman-adv/bat_algo.h  |  13 +++
>  net/batman-adv/bat_v.c     |  51 ++++++++-
>  net/batman-adv/bat_v_ogm.c | 279
> +++++++++++++++++++++++++++++++++++++++++++++ net/batman-adv/bat_v_ogm.h
> |  32 ++++++
>  net/batman-adv/main.c      |   6 +
>  net/batman-adv/main.h      |   1 +
>  net/batman-adv/packet.h    |  29 +++++
>  net/batman-adv/types.h     |  18 +++
>  9 files changed, 427 insertions(+), 3 deletions(-)
>  create mode 100644 net/batman-adv/bat_v_ogm.c
>  create mode 100644 net/batman-adv/bat_v_ogm.h

Applied in revision 6328353.

Thanks,
Marek

--nextPart2850724.G2Gc6ZWijl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJWnlLAAAoJEFNVTo/uthzADRQH/13Y3OIogxdssYj6fvos3QC0
9ivgSMbCysnXVfIPnTmtYd96dpG+Sb4l1BTksLPRo2ECGMfo3xzYy7ep8wPN0n1A
AtHeaw2+f2iJvEeuVkN1bjSnBsgBpdq5XSLI3y0HjxBt5ZkedCpsufbmVXIoZn8B
yPKwImwhEwtvhnNFST9KQhUJwAtBnDPcWOk8K1HEx0bxZSK0Lq2Yf+XST5hJRuPD
4Qpd29YwvSYTAhjR4gnGofvywOgbaOrrSFeY3jy/fs6xaN0vOp4JiJ1vuVQZOrq0
DCC2rpiRNkuWJXLZ15R7sd681gdT7CdMnt7nKroGMWfC/3s+Mi5gwssg4E+OGGI=
=xwaO
-----END PGP SIGNATURE-----

--nextPart2850724.G2Gc6ZWijl--


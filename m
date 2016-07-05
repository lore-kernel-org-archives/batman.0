Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Tue, 05 Jul 2016 16:52:14 +0800
Message-ID: <1536732.nPTjFfZg4n@voltaire>
In-Reply-To: <1467445934-13951-1-git-send-email-sven@narfation.org>
References: <1467445934-13951-1-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart3546662.bCMqq2RM6A";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH maint 1/2] batman-adv: Avoid nullptr
	dereference in bla after vlan_insert_tag
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

--nextPart3546662.bCMqq2RM6A
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Saturday, July 02, 2016 09:52:13 Sven Eckelmann wrote:
> vlan_insert_tag can return NULL on errors. The bridge loop avoidance code
> therefore has to check the return value of vlan_insert_tag for NULL before
> it can safely operate on this pointer.
> 
> Fixes: a9ce0dc43e2c ("batman-adv: add basic bridge loop avoidance code")
> Signed-off-by: Sven Eckelmann <sven@narfation.org>
> ---
>  net/batman-adv/bridge_loop_avoidance.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)

Applied in revision e4cffba.

Thanks,
Marek

--nextPart3546662.bCMqq2RM6A
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJXe3U+AAoJEFNVTo/uthzA65EIAIN8vRG7Lw54rJ6g4eNfhqHO
TqvVpF6LH3gRW1wzr26olZSq23RtKQyKqkZH2XESlojQoOLRbSW1c4flIqbjSsT6
v1xrkr8PooCvCi1Nw8/QMlt2A0Tk8Hr85rQ9snCAvN0cpdyMmHf2IreHXHbzaZBd
cgcl/IEjFsL2vBIoK002yWmz0pS4COBbxXuP+ie4ljxm1yz7koroAw/iu3eZQMet
47xM7WHp3XJQ9O5iUsmexZBCcZQPo0PaYFgPobAye0DAtUgpl3w7UPdJTB3YdtgG
7Q1EyWhNBy752j9RJMDetSyaKl0c98JzlydnrzMnMQBlEkriIe0e/ydHE+Z3evI=
=RcKI
-----END PGP SIGNATURE-----

--nextPart3546662.bCMqq2RM6A--


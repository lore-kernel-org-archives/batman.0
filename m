Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Mon, 02 May 2016 21:37:09 +0800
Message-ID: <2365057.Gn8jA0YdNL@voltaire>
In-Reply-To: <1462184858-18072-1-git-send-email-a@unstable.cc>
References: <1462184858-18072-1-git-send-email-a@unstable.cc>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart4623645.OeMAiooJfz";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH maint v3] batman-adv: make sure ELP/OGM
	orig MAC is updated on address change
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
Cc: Antonio Quartulli <a@unstable.cc>

--nextPart4623645.OeMAiooJfz
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Monday, May 02, 2016 18:27:38 Antonio Quartulli wrote:
> When the MAC address of the primary interface is changed,
> update the originator address in the ELP and OGM skb buffers as
> well in order to reflect the change.
> 
> Fixes: a4b88af77e28 ("batman-adv: ELP - adding basic infrastructure")
> Reported-by: Marek Lindner <marek@neomailbox.ch>
> Signed-off-by: Antonio Quartulli <a@unstable.cc>
> ---
> 
> Changes from v1:
> - Fixes: tag added
> - rebased on top of maint
> 
> Changes from v2:
> - kernel-doc added
> 
>  net/batman-adv/bat_v.c | 26 ++++++++++++++++++++++----
>  1 file changed, 22 insertions(+), 4 deletions(-)

Applied in revision a636bf0.

Thanks,
Marek

--nextPart4623645.OeMAiooJfz
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJXJ1gFAAoJEFNVTo/uthzAArgH/04c5UmzxeMeG5apCUP9MfDa
LTOT+Ybodp43ItLwD1wGoKet5Cojdl5s1z3LQrO8YS7rLqBABXV3ZptF7JjVZgMx
PAtVxZCww35NCO+CM/o4ZP+6C4kM3t/gqSUJdmaKp2+CVrAS+x4g7tftbvEb4x+K
VonWjE6elG55643aATIv3pIzMgaBJsf8yzPe2b4QfplS5N73RvF93skFk2g2oYe6
1lT+y94Z7awZQ0Zpy9qOn2Si+ZhptfJFYNjHE3RdYYWfLcufEVKqBKOvUgf9XASY
8JC9mRwZCsJTVa30HGY7mDRhl0RTZS2BQRdcXsqrybgIj+sX5ivL2FrANEYvjJ0=
=fcZN
-----END PGP SIGNATURE-----

--nextPart4623645.OeMAiooJfz--


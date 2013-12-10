Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Wed, 11 Dec 2013 02:22:31 +0800
Message-ID: <2068019.oJ9AMdNAAD@diderot>
In-Reply-To: <1386338835-3302-1-git-send-email-antonio@meshcoding.com>
References: <1386338835-3302-1-git-send-email-antonio@meshcoding.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart11871853.SOaqa6NQEe";
 micalg="pgp-sha1"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH maint] batman-adv: free nf_bridge member
	on locally delivered skb
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n@lists.open-mesh.org>
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
Cc: Antonio Quartulli <antonio@meshcoding.com>


--nextPart11871853.SOaqa6NQEe
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Friday 06 December 2013 15:07:15 Antonio Quartulli wrote:
> If an interface enslaved into batman-adv is a bridge (or a
> virtual interface built on top of a bridge) the nf_bridge
> member of the skbs reaching the soft-interface is filled
> with the state about "netfilter bridge" operations.
> 
> Then, if one of such skbs is locally delivered, the nf_bridge
> member should be cleaned up to avoid that the old state
> could mess up with other "netfilter bridge" operations when
> entering a second bridge.
> This is needed because batman-adv is an encapsulation
> protocol.
> 
> However at the moment skb->nf_bridge is not released at all
> leading to bogus "netfilter bridge" behaviours.
> Fix this by releasing skb->nf_bridge before an skb gets
> delivered to the upper layer in interface_rx().
> 
> Signed-off-by: Antonio Quartulli <antonio@meshcoding.com>
> ---
>  soft-interface.c |  8 ++++++++
>  soft-interface.h | 16 ++++++++++++++++
>  2 files changed, 24 insertions(+)

Applied in revision 9048eb6.

Thanks,
Marek

--nextPart11871853.SOaqa6NQEe
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQEcBAABAgAGBQJSp1vrAAoJEFNVTo/uthzAKoYH/ix4CBjxczHZPmPzEwcZJE24
2fvowrA0kF818TWNVeQV1DIzfTeDxSYfxC30lIe6m38mxTvmMCjPoBldHzxdIvvx
F3FsNl7kBDlhuPFIaDU4F4KazP7Co0unCYqz7iM88w7n1XJ6G+l454Yoptzx6z/t
13uuavrum8oEltLrg+Y2kB2aXkuFKCRji3q+DWVMKY8PKkKKLieLHsaS3gxrwFbn
ssB1oiAZJT8ZaY+r+hf/UUCBuz3JZMi42Jo5TpFxuDxn1mEQ4Z+jWS3w/ISzAYVg
jSWWmHm88rN/D6hIqXoLPHZT017G3Ob5Ceb8PTp00R/3XjI8MSrGoWVoBPC6yBA=
=VbD7
-----END PGP SIGNATURE-----

--nextPart11871853.SOaqa6NQEe--


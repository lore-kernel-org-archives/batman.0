Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Mon, 05 May 2014 00:21:04 +0800
Message-ID: <1591963.nuHQXu0VkJ@diderot>
In-Reply-To: <1398987313-11934-1-git-send-email-antonio@meshcoding.com>
References: <1398987313-11934-1-git-send-email-antonio@meshcoding.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2237298.UQDCo52axs";
 micalg="pgp-sha1"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCHv2 maint] batman-adv: increase orig
	refcount when storing ref in gw_node
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
Cc: Antonio Quartulli <antonio@open-mesh.com>, Antonio Quartulli <antonio@meshcoding.com>


--nextPart2237298.UQDCo52axs
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Friday 02 May 2014 01:35:13 Antonio Quartulli wrote:
> From: Antonio Quartulli <antonio@open-mesh.com>
> 
> A pointer to the orig_node representing a bat-gateway is
> stored in the gw_node->orig_node member, but the refcount
> for such orig_node is never increased.
> This leads to memory faults when gw_node->orig_node is accessed
> and the originator has already been freed.
> 
> Fix this by increasing the refcount on gw_node creation
> and decreasing it on gw_node free.
> 
> Signed-off-by: Antonio Quartulli <antonio@open-mesh.com>
> ---
> 
> Change since v1:
> - properly release orig_node in case of gw_node allocation failure
> 
>  gateway_client.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)

Applied in revision 8dbdee5.

Thanks,
Marek

--nextPart2237298.UQDCo52axs
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQEcBAABAgAGBQJTZmj0AAoJEFNVTo/uthzAx8UH/A+1yeUfv+LPxfgeg/NzdolF
4AHbCN7mA/DNwVSF8gMxCLwRHn1UeNkd48j5dPE50sHtZ1Z66hNfQ7uISGoMgZUL
6ZdPJcdSBM2Eua4wMu35I4Ih3ZbRoE9sM9Kc+wvLsuIDL96OmEst5pdM5cvnAqJq
c+rL13TneYA+WnD0BDybLpGACgCFhvCNUYuzpKS1d1f/1sJ/4tee+EnXMVApREkG
gqaDeHCDyvGXqfUiNRn6zSiyFDPYUhML+Z7QHgqUzJ9E1huXoxumhlgLjLx8W1XF
YOBAZK6hMPMaFupwZ0Pimh3XiI1idkSoF/uIBx5nHF29mJbajGyuc/5v0UrpWJQ=
=gJwj
-----END PGP SIGNATURE-----

--nextPart2237298.UQDCo52axs--


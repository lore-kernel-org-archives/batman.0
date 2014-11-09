Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Sun, 09 Nov 2014 12:29:15 +0800
Message-ID: <3095144.BcCRDmuA7d@diderot>
In-Reply-To: <1408102727-12671-1-git-send-email-sven@narfation.org>
References: <1408102727-12671-1-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1992589.L0F6Wb2V59";
 micalg="pgp-sha1"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH] list: fix order of arguments for
	hlist_add_after(_rcu)
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
Cc: Sven Eckelmann <sven@narfation.org>


--nextPart1992589.L0F6Wb2V59
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Friday 15 August 2014 13:38:47 Sven Eckelmann wrote:
> From: Ken Helias <kenhelias@firemail.de>
> 
> All other add functions for lists have the new item as first argument
> and the position where it is added as second argument.  This was changed
> for no good reason in this function and makes using it unnecessary
> confusing.
> 
> The name was changed to hlist_add_behind() to cause unconverted code to
> generate a compile error instead of using the wrong parameter order.
> 
> [akpm@linux-foundation.org: coding-style fixes]
> Signed-off-by: Ken Helias <kenhelias@firemail.de>
> Cc: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
> Acked-by: Jeff Kirsher <jeffrey.t.kirsher@intel.com>    [intel driver bits]
> Cc: Hugh Dickins <hughd@google.com>
> Cc: Christoph Hellwig <hch@infradead.org>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
> [sven@narfation.org: fix parameter order, add compat code]
> Signed-off-by: Sven Eckelmann <sven@narfation.org>
> ---
> The patch to fix the order of arguments was already submitted to davem via
> http://article.gmane.org/gmane.linux.network/326598
> 
>  compat.h        | 6 ++++++
>  fragmentation.c | 2 +-
>  2 files changed, 7 insertions(+), 1 deletion(-)

Applied in revision 8353fd1.

Thanks,
Marek

--nextPart1992589.L0F6Wb2V59
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABAgAGBQJUXu2bAAoJEFNVTo/uthzAxEEH/06v93d6Sf5cONxFIWeJSuZL
E7pSP5BPyobvMno/YXdRZxAJ9goNlgxrQY5zx4QCc6lupYcPKBS8ki2/y2lyU7EW
ffBhXkZryiFnzJOLyHER08RHSkUAVfIy0yHQzCcjcrnrH1KVzjWiM7YDa0o30SQF
wNRotjVx/atKMZphD8/+INpzMog/+b4xWh6MsxZ0Kl2fMBMTExdhVaAjjRlE+0kW
KqmQjFugLaRzibIqXdZQ1lmaidoTm1Iq7MyD863SgjwJzipXmYHESGad0ViNIt89
01s8x1cJGKW6xB/yEFYb/7LJ8ke88e3G3diosf0SJgbu65i9yOeV8CxbkTuJYUg=
=vgF8
-----END PGP SIGNATURE-----

--nextPart1992589.L0F6Wb2V59--


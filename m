Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Mon, 13 Jun 2016 12:38:01 +0800
Message-ID: <1914668.9zp7YJNLvD@voltaire>
In-Reply-To: <1463492367-25513-1-git-send-email-andrew@lunn.ch>
References: <1463492367-25513-1-git-send-email-andrew@lunn.ch>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1513289.Pn1MLs2dJX";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: Fix hardif remove/add race
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

--nextPart1513289.Pn1MLs2dJX
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Tuesday, May 17, 2016 15:39:27 Andrew Lunn wrote:
> A hard interface can be removed and then added back in quick
> succession. This is particularly true for hdlc interface when changing
> the protocol.
> 
> It is not possible it synchronously remove the sysfs and debugfs
> entries for the hard interface when it is removed because the files
> may be open. Thus removal is deferred. The files may thus already
> exist in sysfs and debugfs when the hard interface is re-added, and
> the operations fail.
> 
> To fix this race, synchronously rename the debugfs and sysfs files to
> a unique temporary name, thus making the name available when the
> interface comes back, yet keeps open files still available.
> 
> Signed-off-by: Andrew Lunn <andrew@lunn.ch>
> ---
>  net/batman-adv/debugfs.c        | 23 +++++++++++++++++++++++
>  net/batman-adv/debugfs.h        |  1 +
>  net/batman-adv/hard-interface.c | 19 +++++++++++++++++++
>  net/batman-adv/sysfs.c          | 17 +++++++++++++++++
>  net/batman-adv/sysfs.h          |  2 ++
>  5 files changed, 62 insertions(+)

Applied in revision 6b0485c.

Thanks,
Marek

--nextPart1513289.Pn1MLs2dJX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJXXjiqAAoJEFNVTo/uthzAaMkH/iSFKZYsd87wxuYS35BJXbBg
LhufsR7vFnG4iAnJfu/Sfv30ZNKIwVTVTLcNcqJ9lhgzVopQOyqpJxeooELTmgjI
TS8K+V91LQRYRAsHH8EaMynmR8VkLrPhxj5Fh6WRdCnRp8jNGhg71+FGMJIMJPL2
NG3qgW2Alz5qS4vz1NTiCmilJsU3xeCJ0bum5bQNIb3Xt7oz7qamlcE0NapOXL0A
biEw6y8FKQGsW1AZG6BmaiMKUJzGCvNDWqgNuHiVMAJ2QifpULOispfXdnk3bdsw
7m6Y3HM10qKMuDqB1l2gqdaIDO1IxKr4Q5gMU5w8Rn6jdLAAIIhrDeIPlzq5Ltw=
=W2sr
-----END PGP SIGNATURE-----

--nextPart1513289.Pn1MLs2dJX--


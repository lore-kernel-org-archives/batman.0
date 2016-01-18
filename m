Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Mon, 18 Jan 2016 09:32:56 +0800
Message-ID: <4313092.G4iAAbGROi@voltaire>
In-Reply-To: <1453024887-7215-12-git-send-email-sven@narfation.org>
References: <1453024887-7215-1-git-send-email-sven@narfation.org>
 <1453024887-7215-12-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1920805.1jdSevNp48";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH v7 12/19] batman-adv: Rename
	batadv_tvlv_container *_free_ref function to *_put
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

--nextPart1920805.1jdSevNp48
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Sunday, January 17, 2016 11:01:20 Sven Eckelmann wrote:
> The batman-adv source code is the only place in the kernel which uses the
> *_free_ref naming scheme for the *_put functions. Changing it to *_put
> makes it more consistent and makes it easier to understand the connection
> to the *_get functions.
> 
> Signed-off-by: Sven Eckelmann <sven@narfation.org>
> ---
> v7:
>  - removed patches which are now applied in the branch master
>  - split *_get -> *_put rename patches into smaller patches only renaming
> single functions
> v6:
>  - removed patches which are now applied in the branch next
>  - rebased remaining patches on the patch
>    "batman-adv: Avoid recursive call_rcu for batadv_nc_node" which was
>    modified by Marek while he applied the patches (this unfortunately made
>    some of the remaining patches slightly harder to apply)
> v5:
>  - add hack which allows to compile against stable kernel like 3.2.44 which
>    also added the kref_get_unless_zero function
> v4:
>  - fix function names in commit messages
>  - fix double whitespace in batadv_tt_orig_list_entry_release kerneldoc
>  - add extra patch for batadv_claim_free_ref kerneldoc fix
>  - change the phrase "free it" in all *_free_ref/*_put functions to "release
> it" v3:
>  - update copyright year
> v2:
>  - split patchset into fixes and kref migration to make it easier when the
>    decision is made where each patch will be applied
> 
>  net/batman-adv/main.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)

Applied in revision 9823941.

Thanks,
Marek

--nextPart1920805.1jdSevNp48
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJWnEDIAAoJEFNVTo/uthzAZywH/ifr16iKIrsO6DqUeaTprBzG
YjeIIvz2ZG0LKobJzimDMyWN5WN9iM9CrCus8pQRhBJL+56Lp3ICwy9a7inbuvx2
Fcm5CKpf9HUrXZemK1sW0Kx5Di5cQYcm/l9/V4ks3QFfY+tmEEQdgCTIO5m9AeM2
qN2AnZTx66LNzC7iQI/mXaoF0hCAuYPnstXn3g2YFVY/aa1eUJZJYHl72F3cgNZL
/DAJzNj9lrNNBwMZKcXoJ85PSnVsd0dlSBVpOFTEcfwQY2BxjHDx0CNRvsP6eJ5a
4fIentugUIz9nX7Rc3EGo0VLuh5XPtd04dNQNVpJf4VPPveRw4Qz2vtAw7bSsbc=
=iGgQ
-----END PGP SIGNATURE-----

--nextPart1920805.1jdSevNp48--


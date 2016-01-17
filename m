Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Sun, 17 Jan 2016 19:57 +0800
Message-ID: <2960611.fobOFzZ9Ca@voltaire>
In-Reply-To: <1453024887-7215-3-git-send-email-sven@narfation.org>
References: <1453024887-7215-1-git-send-email-sven@narfation.org>
 <1453024887-7215-3-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart40363275.sjHB0fP5cT";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH v7 03/19] batman-adv: Rename
	batadv_neigh_node *_free_ref function to *_put
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

--nextPart40363275.sjHB0fP5cT
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Sunday, January 17, 2016 11:01:11 Sven Eckelmann wrote:
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
>  net/batman-adv/bat_iv_ogm.c            | 16 ++++++++--------
>  net/batman-adv/distributed-arp-table.c |  2 +-
>  net/batman-adv/fragmentation.c         |  2 +-
>  net/batman-adv/gateway_client.c        | 14 +++++++-------
>  net/batman-adv/icmp_socket.c           |  2 +-
>  net/batman-adv/network-coding.c        |  4 ++--
>  net/batman-adv/originator.c            | 16 ++++++++--------
>  net/batman-adv/originator.h            |  2 +-
>  net/batman-adv/routing.c               | 14 +++++++-------
>  net/batman-adv/send.c                  |  2 +-
>  net/batman-adv/translation-table.c     |  6 +++---
>  11 files changed, 40 insertions(+), 40 deletions(-)

Applied in revision b68dce4.

Thanks,
Marek

--nextPart40363275.sjHB0fP5cT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJWm4GMAAoJEFNVTo/uthzAqxsIALBfHnuN9D4BPe95qNJJrcYF
prpYRl4vBmdP1idQlcYAUSG3DE2zNs0ILpKVagEp7XYRybfpcE+RY5rD0QOIc+5i
uQ7CV6nGQlsoFa9cHVdpC17wJ6dCaUA14IjFwPInQu6LSCEfgAjqEWv6zQx1EDuY
88OEfW1t3CWThHmMm3zCLYtCoD3pXL2z8S7y+mVjAc0/VFB2vf0sKnpQPZTS/pxK
DSReY33Vh0r4XKPvtKlcsmXICXM4DLnN3uqMHv70aaqPKP/2RsJOtJ7jOgbCmHet
R7OesaUPitUPP/WyCo2I9El7K7j1MsZpxS3AdCNFCv6Z6JqbTx4Y5BiWaMVMMi0=
=RuBm
-----END PGP SIGNATURE-----

--nextPart40363275.sjHB0fP5cT--


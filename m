Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Thu, 07 Jan 2016 00:04:57 +0800
Message-ID: <22690162.8jlU4TIMSR@voltaire>
In-Reply-To: <1451992006-13191-2-git-send-email-sven@narfation.org>
References: <1451992006-13191-1-git-send-email-sven@narfation.org>
 <1451992006-13191-2-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart4553184.PKRhkP3GbG";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH v4 02/31] batman-adv: Fix list removal of
	batadv_hardif_neigh_node
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

--nextPart4553184.PKRhkP3GbG
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Tuesday, January 05, 2016 12:06:17 Sven Eckelmann wrote:
> The neigh_list with batadv_hardif_neigh_node objects is accessed with only
> rcu_read_lock in batadv_hardif_neigh_get and batadv_iv_neigh_print. Thus it
> is not allowed to kfree the object before the rcu grace period ends (which
> may still protects context accessing this object). Therefore the object has
> first to be removed from the neigh_list and then it has either wait with
> synchronize_rcu or call_rcu till the grace period ends before it can be
> freed.
> 
> Fixes: fed2826b490c ("batman-adv: add list of unique single hop neighbors
> per hard-interface") Signed-off-by: Sven Eckelmann <sven@narfation.org>
> ---
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
>  net/batman-adv/originator.c | 18 ++++++++++++------
>  1 file changed, 12 insertions(+), 6 deletions(-)

Applied in revision 6219a1b.

Thanks,
Marek

--nextPart4553184.PKRhkP3GbG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJWjTspAAoJEFNVTo/uthzAy+MIALZtO8cU4HR0XdLfPeSp+xay
0x7URQx6VED8Thp3Ki9rua6VdCUUti2aGjXI1hnwdqH5D3s6JQRi++roXr/0MpLJ
vRGEeJok//O264rsI5GS0Wl8LIdT1CQCwolmA5piwsTKzXn5lDGVfhDsiFt9wTNW
8rPunzr8xnrBHQ+TnxCZ4xtryifpJXDyIJU8AD+3Z7XApRkN66C02mKULNld8ygL
TlUiIW9Xu53JBE8c9BAdnd3T/+nrqOIzxCa0FIG3W5UlXIUGRXSqgYh0lR+JgyKE
5IJ6Koh+tHuh4HRwrXx3PJZJZy4t6L3ms/VpCCwWvOkNBe8FHpZeIyx6HEdZjHQ=
=UuSG
-----END PGP SIGNATURE-----

--nextPart4553184.PKRhkP3GbG--


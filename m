Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Mon, 20 Apr 2015 11:23:15 +0800
Message-ID: <6809018.15Hlry5Imp@voltaire>
In-Reply-To: <13114664.Eg4ODy7KEo@bentobox>
References: <13114664.Eg4ODy7KEo@bentobox>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart6412189.9ggbdjYxox";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH-next 0/6] Patches for batman-adv 2015.0
	release
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
To: b.a.t.m.a.n@lists.open-mesh.org, antonio@meshcoding.com


--nextPart6412189.9ggbdjYxox
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"


Sven,

thanks for the thorough cleanup review.


> Patches which are in batman-adv master but should be in this release:
> 
>  *
> http://git.open-mesh.org/batman-adv.git/commit/3f74f359cb7e96bbc68d62e1fc48
> b04b6efb4ca7

I moved the patch to main (not strictly necessary as maint will be replaced 
soon) and merge my way up to master.


> A patch which should never ever have existed in the first place (please
> correct me when I've missed the actual problem):
> 
>  *
> http://git.open-mesh.org/linux-merge.git/commit/b53915310227cc9b029ba0fa5aa
> e44e50a461f80

This (subtle) problem is about compat.h. Specifically, the kfree_rcu macro 
requires a pre-defined variable name:
#define kfree_rcu(ptr, rcu_head) call_rcu(&ptr->rcu_head, 
batadv_free_rcu_##ptr)

void batadv_free_rcu_softif_vlan(struct rcu_head *rcu);


> The weirdest commit is one which is in batman-adv next but can nowhere be
> found in the kernel trees. It is already part of the release v2014.2.0:
> 
>  *
> http://git.open-mesh.org/batman-adv.git/commit/31f391475cc08724e96ab060ef4a
> a6503d11da8e (havent touched this commit because this is just too weird)

Antonio, can you comment ? Was it forgotten or was there a reason ?

Cheers,
Marek


--nextPart6412189.9ggbdjYxox
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJVNHErAAoJEFNVTo/uthzAcJ4H/iWnYoQLjmzhM/0HL41VqU3w
Ij9iXpwPyEWWtwWn08WaPug64siExf3GwFUvBBWKMlVqfv24xFeMh7ZPP9fEqM4b
WSX5lo1c93T+5CScop/rGbGWD71c16OK4DEuXAnivQFZbxDM1QBBPAx5u6kosfyA
dS7sduW0SW4BYi8plj8jjewt2/vA0b69+4V1vlS34o9bLCT8BsKPGTZt19CBhty7
IfoTgw7vTb163/3V9lRnmpwJM43N9VHxClNlh1BTg8tkBfQGSI8qrv0gza5Gd0ph
lb9T9xz6oBS9DsC694aDamD14PJeEe8X/2KbMBlvpjj/qldGp0inZwAN5tdHUAQ=
=Ix5m
-----END PGP SIGNATURE-----

--nextPart6412189.9ggbdjYxox--


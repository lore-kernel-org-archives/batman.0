Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Mon, 20 Apr 2015 14:30:52 +0800
Message-ID: <28031511.vQmOOoKVTs@voltaire>
In-Reply-To: <7856073.VVMjEpdh4f@sven-edge>
References: <13114664.Eg4ODy7KEo@bentobox> <6809018.15Hlry5Imp@voltaire>
 <7856073.VVMjEpdh4f@sven-edge>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2091804.bLm6R6KjQQ";
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
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: antonio@meshcoding.com


--nextPart2091804.bLm6R6KjQQ
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Monday, April 20, 2015 08:05:20 Sven Eckelmann wrote:
> > This (subtle) problem is about compat.h. Specifically, the kfree_rcu macro
> > requires a pre-defined variable name:
> > #define kfree_rcu(ptr, rcu_head) call_rcu(&ptr->rcu_head,
> > batadv_free_rcu_##ptr)
> >
> > 
> >
> > void batadv_free_rcu_softif_vlan(struct rcu_head *rcu);
> 
> I still don't get it. I wrote the compat code for batadv_free_rcu_* and I
> was  always under the impression that it is not a problem until we have two
> functions which call kfree_rcu with the same variable name and different
> types (something which I've now hopefully solved in my kfree_rcu patch for
> master). And the patch I gave should also show that for this works fine
> after adding batadv_free_rcu_softif_vlan.

I hope Antonio is going to shed some light on the question whether that patch 
made it upstream or not. Depending on that question we can pick the 
appropriate solution.

Cheers,
Marek

--nextPart2091804.bLm6R6KjQQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJVNJ0cAAoJEFNVTo/uthzAwMMH/2f6Swud0r3egZH+cfpllkGB
9kAVR6RWT649g+I37oY98j6vvRkk/l4d3Rmo3C2VcexZt+eKtuZvgyQU3Nt+1nH3
+gVvuy1WbkuEFRUj/X9rgLQIPpLjBuQV+0+/S2TK77Eppiuryaz2il7o8g14QJ9a
yWAYjGCrkFa38vVKHWNUcAbJnypcstGVAR77mCCq7rX5AfC1DoqOZ6INUr4JEzYk
V5XMv+2l5r2pObojFWFButbfRFUzl0aKgZwuVcSXZvEjTmTP85BR0QJp6/Y0W1Pm
SU0Wiy+MfcVXRqAeofTVIq8VWX5mjqhef3KCuCgTWmeGYXf64+iWph7Fsm/c5Ow=
=04Fp
-----END PGP SIGNATURE-----

--nextPart2091804.bLm6R6KjQQ--


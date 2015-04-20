Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Mon, 20 Apr 2015 08:05:20 +0200
Message-ID: <7856073.VVMjEpdh4f@sven-edge>
In-Reply-To: <6809018.15Hlry5Imp@voltaire>
References: <13114664.Eg4ODy7KEo@bentobox> <6809018.15Hlry5Imp@voltaire>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart4413690.v4JfOBi9DZ";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
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
To: Marek Lindner <mareklindner@neomailbox.ch>
Cc: b.a.t.m.a.n@lists.open-mesh.org, antonio@meshcoding.com


--nextPart4413690.v4JfOBi9DZ
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Monday 20 April 2015 11:23:15 Marek Lindner wrote:
[...]
> > A patch which should never ever have existed in the first place (please
> > 
> > correct me when I've missed the actual problem):
> >  *
> > 
> > http://git.open-mesh.org/linux-merge.git/commit/b53915310227cc9b029ba0fa5a
> > a
> > e44e50a461f80
> 
> This (subtle) problem is about compat.h. Specifically, the kfree_rcu macro
> requires a pre-defined variable name:
> #define kfree_rcu(ptr, rcu_head) call_rcu(&ptr->rcu_head,
> batadv_free_rcu_##ptr)
> 
> void batadv_free_rcu_softif_vlan(struct rcu_head *rcu);

I still don't get it. I wrote the compat code for batadv_free_rcu_* and I was 
always under the impression that it is not a problem until we have two 
functions which call kfree_rcu with the same variable name and different types 
(something which I've now hopefully solved in my kfree_rcu patch for master). 
And the patch I gave should also show that for this works fine after adding 
batadv_free_rcu_softif_vlan.

Kind regards,
	Sven
--nextPart4413690.v4JfOBi9DZ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCgAGBQJVNJckAAoJEF2HCgfBJntGzaEP/jpkVfLxQhmYlwSiRbrN7JyF
QcS+C6MDAiszaEtV6dMQvJigf8R71GQekmo5wa1Csiak4NNOsrrmHao65QkcYG8N
FVl7ujDKij1z+HyF1R06SCkvuMJzFf5kkfcKTE21Psw6ifOJqxwqye63ZexQqmXp
hUEElxHkipFCymCCl9X5JG60Qk1aGVBiAsWYxheZdme24RmP6eokw4X5XMnpteC1
rwgEtoudDl8v1IT8lJ2WqUugM/S8s1E9h+gfWkDXyGOlQr+VHFvYSrWbTcjLlgdA
XORSa0amHpKMRaMehGmG5mCI/9DE5JZqnibh3MozDO+3pgjbD0JQhKEDi9KxLBin
KYuimyNAckG2Qa2Dxbc8P6hfuoqBd0e96lvCZxD5lXOXLr/8pHvl/d11mcXmEZ8K
KYUHQEDXeQ4lWM4Qcs46VDPlIPdhwG0Bt16GHE0a9MfKRESAMCedFQcLU+f4qECR
7R6CwDjXVomrd7rqwei/zGtnMeG0TdPg+BsD4VEbfP/hf/7MpNcOe7Ua1c2atC/w
X8z97z9zFAlGcow48BWOWf0kbcsF4CY5nAvuien32xu0MazwP1MwxLbOrCOavgA3
akORcZZUGJVI5lBxl1xDO4pnh3WngyRIeoiOPE9+ZSP0BBgmiMdcvEcl7zASXxPg
lH17reOzUkbE8oHsdGlp
=YMjP
-----END PGP SIGNATURE-----

--nextPart4413690.v4JfOBi9DZ--


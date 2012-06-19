Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Tue, 19 Jun 2012 14:41:34 +0200
Message-ID: <2112512.N0gHzzFGDc@bentobox>
In-Reply-To: <1340107811.6871.32.camel@deadeye.wl.decadent.org.uk>
References: <1340090430-356-1-git-send-email-ordex@autistici.org>
	<2579267.utmNKQaN8a@bentobox>
	<1340107811.6871.32.camel@deadeye.wl.decadent.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1425644.5e020psaxS";
	micalg="pgp-sha512"; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7Bit
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: fix skb->data assignment
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: Ben Hutchings <ben@decadent.org.uk>
Cc: stable@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org, David Miller <davem@davemloft.net>


--nextPart1425644.5e020psaxS
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Tuesday 19 June 2012 13:10:11 Ben Hutchings wrote:
> [...]
> 
> There's not much sense in a 'cc' if you're sending a new message (the
> backport) specificaly to stable.  Instead, use a subject like
> '[PATCH 3.x] original commit summary'.  You do need to make clear that
> this is a backport and not just a request to cherry-pick the upstream
> commit.
> 
> Also, you should wait and send it after the original goes upstream,
> because stable maintainers will usually want to either apply or reject
> immediately rather than storing things up.  Greg's scripts will tell you
> when this happens, or at least when he next checks.

Thanks a lot.

Regards,
	Sven
--nextPart1425644.5e020psaxS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAABCgAGBQJP4HN+AAoJEF2HCgfBJntGhacP/jvmifwVUIPa4nOVpbH24Fcq
BNf3gDwJePQs4AXterAfdx0mhOzvPJH3ZqyzP6CAzFSWr1E1lfAiHO7rxyAHJbVR
RiY9B/3ypf6nCz0JBRldt0ZG/qLTNKEyvPbjolTGLfwqtK+d1swHjPQGq4415Cgf
LfXl1ptUf8VNW5RLLP6XxRyxyF1ynJeyjCPJ3xhZ3QrEkIbWWXjsUJkJziwT5dOR
aD9F7pvkQ6QBh83v59e9/CQosVe7JRUkdwvt91wcwSx6jBYR+odY2TOgq8+kVjZU
zWHDREbE5x3wrpaiQtKCCXJeF8CG/fwwRLp0IEOG6yxw6yfzjkZNKdKD9dxshf0C
IvlehY8SVn1i85ynIAwZTx3aY5tUuwZK/x4HeHeAecBqB5p85pKuUh+SF9qpALOf
6fBDBUvD/6tsCbCuCh+L1wIrG0XR+pvi5CqRBzN2aC987DelZbF94HlDdxgqgHJp
zKSpaqqo9Deuh00/HcQbJByG1bOfqZnrt2UPxivm4LYvy/dUR69ywpC+zAO6r8Ty
TXEjFnZsSklrAmWLLJqBACnKVrvYG0jNBcEJZVvsV+Glr/liYNVUId+VlcbeQX8n
Ry77UL6GR/h95dR/0Zk3NyOaEGPoBon/wQZXVwKOh27lMWSWaxltgnyiX/wMQj3k
YDAl+wChNOg5SuH8u82u
=bfyy
-----END PGP SIGNATURE-----

--nextPart1425644.5e020psaxS--


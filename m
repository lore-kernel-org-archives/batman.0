Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Fri, 11 May 2018 23:58:21 +0800
Message-ID: <2210566.XQyRl1hKcV@lafayette>
In-Reply-To: <2798092.n9DkCtfipy@sven-edge>
References: <20180506195559.32602-1-me@irrelefant.net>
 <20180510144137.32244-1-mareklindner@neomailbox.ch>
 <2798092.n9DkCtfipy@sven-edge>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1802818.6iu6dTKFpL";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [RFC v2] batman-adv: prevent TT request storms
 by not sending inconsistent TT TLVLs
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

--nextPart1802818.6iu6dTKFpL
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Thursday, May 10, 2018 11:50:48 PM HKT Sven Eckelmann wrote:
> Please submit it on top of the maint branch before submitting it the next
> time. The rcu_read_lock isn't there anymore.

I did not intend this patch to go into maint (hence the missing maint subject 
prefix) as I considered that to be more of a sanity check. The "fix adding 
VLANs with partial state" is the real fix.

Though, I am fine with maint too.

Cheers,
Marek

--nextPart1802818.6iu6dTKFpL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEI5CG6MPJfr3knG//U1VOj+62HMAFAlr1vZ0ACgkQU1VOj+62
HMDb6wf/eRzsg9F6+QIUuF6ZJEiVbmH6OEVI/GtkUQGJFbRlNOyQZqicpsPW4JwZ
aA8CqmaV9e3ULoMKASaDoOaToxDkWfjtqPSqve/73vRgFIktfzjwgp7VqJTSps8I
cyXrGyHCNNLbrnkbhsatQqtZNWnrTVPZSfLqw0ScRui9VX9jd1grlYIqs1cJvd/a
ezhTIO9Daf6D/miECu/onZy/CZuQFUHVpa2jleY7srDfuybbE9Kg+8ZfYYCrZE4x
fUKNYjdmwtLtxdUMP2LwblIumWu46w6nYNCdOLGyB5F5CAI9GVhNbZuG1+FcV9VR
TuXlsQzmub9TXo/zJsURXyOPgzA4FA==
=gP4t
-----END PGP SIGNATURE-----

--nextPart1802818.6iu6dTKFpL--




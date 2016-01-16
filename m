Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Sat, 16 Jan 2016 13:30:24 +0800
Message-ID: <1757985.heU4RESuMP@voltaire>
In-Reply-To: <1451992006-13191-10-git-send-email-sven@narfation.org>
References: <1451992006-13191-1-git-send-email-sven@narfation.org>
 <1451992006-13191-10-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2352178.Akec9Ph4vx";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH v4 10/31] batman-adv: Drop immediate
	batadv_hard_iface free function
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

--nextPart2352178.Akec9Ph4vx
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Tuesday, January 05, 2016 12:06:25 Sven Eckelmann wrote:
> It is not allowed to free the memory of an object which is part of a list
> which is protected by rcu-read-side-critical sections without making sure
> that no other context is accessing the object anymore. This usually happens
> by removing the references to this object and then waiting until the rcu
> grace period is over and no one (allowedly) accesses it anymore.
> 
> But the _now functions ignore this completely. They free the object
> directly even when a different context still tries to access it. This has
> to be avoided and thus these functions must be removed and all functions
> have to use batadv_hardif_free_ref.
> 
> Fixes: 9bb33b8d88e3 ("batman-adv: split tq information in neigh_node
> struct") Signed-off-by: Sven Eckelmann <sven@narfation.org>

Applied in revision 2b0f9c9.

Thanks,
Marek

--nextPart2352178.Akec9Ph4vx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJWmdVwAAoJEFNVTo/uthzAh24H/iVKHt1bTGoLBNGyp+xHuDOx
dcHXLxjZVGfsxAbJLsgsFW+RjEgLAPYMgU2bQ84ZLbZ8c1qfwsjyA2MkNCztSu61
4a6NWKnNPeXuAACpCFMSYtptkZ4aS2DV8w/IqB/yGV+yw8m/p8agn4mfRM/M5VYO
5lBUxnAaTfAZlfSi0hyQSke02YbDOoa2bfZBbkoIKxS40sCTIKw3ch/HfMeTFjsk
bR59MMTqmeeLukG/FXv6bzFJrY8Q4HpImCGXFKy29saJWC+JoQgq3Zttpg0+2AmG
b6OhUXuhvhfHVx6ubNi3Kk0tGLtf9+UoDNBFZF0UXjlYY4xjXkA1yh962SrKsBY=
=UN2V
-----END PGP SIGNATURE-----

--nextPart2352178.Akec9Ph4vx--


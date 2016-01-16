Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Sat, 16 Jan 2016 13:11:06 +0800
Message-ID: <3137896.z9Pq6VuGbE@voltaire>
In-Reply-To: <1451992006-13191-6-git-send-email-sven@narfation.org>
References: <1451992006-13191-1-git-send-email-sven@narfation.org>
 <1451992006-13191-6-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1541423.Y3yCVAWLYr";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH v4 06/31] batman-adv: Drop immediate
	batadv_orig_ifinfo free function
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

--nextPart1541423.Y3yCVAWLYr
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Tuesday, January 05, 2016 12:06:21 Sven Eckelmann wrote:
> It is not allowed to free the memory of an object which is part of a list
> which is protected by rcu-read-side-critical sections without making sure
> that no other context is accessing the object anymore. This usually happens
> by removing the references to this object and then waiting until the rcu
> grace period is over and no one (allowedly) accesses it anymore.
> 
> But the _now functions ignore this completely. They free the object
> directly even when a different context still tries to access it. This has
> to be avoided and thus these functions must be removed and all functions
> have to use batadv_orig_ifinfo_free_ref.
> 
> Fixes: de6bcc76ea84 ("batman-adv: split out router from orig_node")
> Signed-off-by: Sven Eckelmann <sven@narfation.org>

Applied in revision f5f8f3e.

Thanks,
Marek

--nextPart1541423.Y3yCVAWLYr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEbBAABCAAGBQJWmdDqAAoJEFNVTo/uthzAC5sH+IzRNRdsb0LZW3r//MPmmZb2
Thf/T/Yh9r/DMb6MJ1Dg2za82pjFO02d8j28miqvfvGHetLBZAPwYJMD7mjDsk7M
t1yXvLCzjwuHJJYMOOG+67ViITnrXY2qaDp2YOxjRRo0ksmM6mWkiPmrbRCIhV2z
lE9Oa5i1Hxws6r4JAbf2eiQWKsamJ85ng5GPBi42eH9Xn/aWV3mTRPQHD/WE0cYL
nvcRewkoR9HCDSrVYI+Oztgaj3c5eYJP9Dwb7vmamp8F3cIWYS+e4j/kAkkgFB/o
q+OMe7D8ti/3UqcyjY38Pp65PGA/ehj3MazZVyNuqtcCO+DapcEgIMcAjqZwaA==
=sYdd
-----END PGP SIGNATURE-----

--nextPart1541423.Y3yCVAWLYr--


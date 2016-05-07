Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Sun, 08 May 2016 06:40:54 +0800
Message-ID: <3034517.WNfr3miojD@voltaire>
In-Reply-To: <572E37C7.5040809@wifibot.com>
References: <572DF6E3.3030901@wifibot.com> <572E2F52.6080908@wifibot.com>
 <572E37C7.5040809@wifibot.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart7723142.ad8ZkexDDK";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] no able to switch routing algo to V ?
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

--nextPart7723142.ad8ZkexDDK
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Saturday, May 07, 2016 20:45:27 contact wrote:
> it seems table, I saw a really fast dynamic route creation. With batman 
> IV the route took sometime 1 min to come and it was really noisy, i 
> tried many settings,
> here with V it is good, when I move toward a node it took less than 1 
> sec to create a new route and the video stream is not interrupted.
> 
> Sometime I loose the route it become a little bit noisy when I stop 
> moving  but here I suspect a wifi problem, need to change my channel.
> 
> I will make more test by adding other nodes on the path of the robot and 
> see how routing is done.

Thanks for the feedback! By all means, share more results (good or bad) once 
available!

Note that the gateway selection feature isn't working with BATMAN V yet. 
Antonio has posted a couple of patches a few days ago but these require some 
further massage.

Cheers,
Marek

--nextPart7723142.ad8ZkexDDK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJXLm72AAoJEFNVTo/uthzA4XUH+QGM2EYcGj2Ey/vvVDHd9/TY
4sQ0mFZ6y0GqSyLjy3oHkjXzre60dQnnMQ6aquZkLfVPGOlrz91Rj+fJmmkD4ISN
GkWVI9RU09B5L5JtOrGzkaruhgvSDXgHWOXPInuj2k5bA+9agVBijsYZkC0yGd2l
4OOY2uaED/um2j5TqIrTcCwEWTQ7R1OzNd2bsVm4eLqB4Y/FQABYay/WnQiDoGUY
6i8/WZhrmDzlSKxMHxSdHFozL9lHVQ8Hq/aYteBRDGKCtXGwOhxPZe+qHYP70Uf8
i6FKfBaoBzQ2cT5sU36trYUcWupn53m0PVrlAFBtDLVnDduG5WHOFn7/rnpkxVU=
=pBxg
-----END PGP SIGNATURE-----

--nextPart7723142.ad8ZkexDDK--


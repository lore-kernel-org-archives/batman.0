Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Thu, 25 Feb 2016 00:12:23 +0800
Message-ID: <1623151.0bLTxGPOFY@voltaire>
In-Reply-To: <56CAE7C9.1070006@wifibot.com>
References: <56CAE7C9.1070006@wifibot.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2153411.SBMOCFfbgu";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] BATMAN-V for robotics
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
Cc: laurent <laurent@wifibot.com>

--nextPart2153411.SBMOCFfbgu
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Hi,

> After some failure last year to us BATMAN-ADV on picostation plugged in
> a mobile robot. I have re flashed last week the last open-wrt with the
> last stable batman-adv (2006.0).
> I still have some problem making a single hop fast.  I have 3 nodes A B
> C, I put the robot (nodeB) very close to node C and A is fare from B and
> C.  B is still connecting directly to A. sometime If I wait for a very
> long time
> the route became A - C - B , what I exactly want. I have this behavior
> since 2010 and on each version I test on picostation.
>
> To resume, when the robot along 2 nodes and it takes a very long time
> before he got a new route to increase his range.

don't know what your definition of 'fast' is but did you play with the 
originator interval ? Check our doc:
https://www.open-mesh.org/projects/batman-adv/wiki/Tweaking#originator-interval

The default settings are tailored for wireless community networks with rather 
static setups. 


> I understand but I could be wrong, that the metric calculation in
> BATMAN-IV is not good for mobile application because of some radio that
> keeps the link until the last minute before beginning to increase their
> packet errors ?

That assessment is not entirely correct. If you can live with the overhead of 
faster originator intervals (read: increasing the protocol exchange rate) you 
can run batman inside cars driving around.

This problem is unrelated to the metric.


> BATMAN-V seems to be more promising because of the new metric
> calculation based on link throughput we get from the driver, and also
> because we can override the data throughput value to force a route (we
> are imagining using GPS for that).

I don't see how you would force a route with BATMAN IV or BATMAN V. The latter 
allows specifying a speed over an interface, not per neighbor. This interface 
speed applies to everything routed over that interface.

The reason why these overrides are missing is simple: It defeats the purpose 
of an automatic protocol. If you want static routes there is no need for 
batman.

Furthermore, meshing based on location / proximity with the help of GPS or 
coordinates only works as long as you don't have any obstacles anywhere. 
Meaning: Not in real world setups.


> I really want to test BATMAN-V,  I tried to switch to BATMAN-V but it
> was not on the available routing algorithm list. Do I need to compile a
> devel version on open-wrt ?

Yes, you would need to compile the devel version hosted on git.open-mesh.org 
(https://git.open-mesh.org/openwrt-feed-batman-adv.git) or wait for the next 
stable release. Feedback is welcome!

Cheers,
Marek

--nextPart2153411.SBMOCFfbgu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJWzdZnAAoJEFNVTo/uthzA5qQH+QH9HNxBBhGid1eTrRIbxl/5
mI8Xvzyaym2v3zhD14xjsKP9S/J2h6FYHvlcITG9uRbIK6y70s487hswWh7voTUH
TApWXQ3F2InFdGVBkvwgJ7sfzRN4imSJbvb4biqX3LQok6ba/b7lNJf7XhKQcRS/
8jSF+7payExbBhxa+Z7DQZVO9I2auaHwiCX8twdiE1nHS+63Drq1bZTl+wnKHjIO
JQT5wkUSY7s0sO/SaWZdFvjNzy6yY240FKsDq4kIj4TKyBmYCi+9DQNf+9bHDihb
R/bz56p+RdGqF7XtS41jmrPuyl22YbYijK+Aifl4HCNAH52wyIHbyQ0eYltl3Ek=
=qLr4
-----END PGP SIGNATURE-----

--nextPart2153411.SBMOCFfbgu--


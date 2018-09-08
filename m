Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sat, 08 Sep 2018 19:38:01 +0200
Message-ID: <8046301.0ldSNLAhfO@sven-edge>
In-Reply-To: <20180907095958.30946-1-mareklindner@neomailbox.ch>
References: <20180907095958.30946-1-mareklindner@neomailbox.ch>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2387932.Z4F31lax4L";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH v5 0/7] B.A.T.M.A.N. V - fallback to tp
 meter estimation if throughput otherwise not available
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
Cc: Marek Lindner <mareklindner@neomailbox.ch>, Ligang LIU <heishuihe2008@163.com>

--nextPart2387932.Z4F31lax4L
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Freitag, 7. September 2018 11:59:51 CEST Marek Lindner wrote:
> Under normal circumstances B.A.T.M.A.N. V retrieves the neighbor
> throughput values to populate its metric tables from the various
> drivers such as WiFi throughput tables and Ethernet throughput..
> Whenever the interface drivers do not export link throughput 
> information manual overrides become necessary. To further 
> automate and thus better support these setups, ELP may call the
> batman-adv throughput meter to schedule a throughput estimation
> to be used to populate the metric table.

I know that this patchset is required to have some throughput estimates for 
non-wifi connections (or for wifi drivers without expected throughput). But 
since we have the other discussion with Ligang LIU, I still have to bring this 
up:

We already know that something (maybe ELP unicast probes and the related 
messages) are "breaking" the connectivity between 2 neighbors in Ligang LIU's 
test setup (with 6 not so well connected nodes). It also seems to be the case 
that the driver doesn't return the expected throughput for each neighbor all 
the time and this missing data would then trigger the single-link tpmeter 
test.

The test seem to be done every 60 seconds (or longer when there is another 
source for the throughput) for each neighbor and by default 1s long. My 
assumption would be now that this test could be even more harmful for wifi 
connections than unicast ELP probes (or whatever is causing Ligang LUI's 
problems). Let us just assume that we have these 6 nodes with 5 neighbors (I 
see a lot more in real world setups). If the tests on the different nodes 
don't overlap (which would also be bad for the test results) than all tests 
would take at least 30 seconds of the 60 seconds. So even without the problem 
in the "Performance Evaluation of BATMAN-adv Wireless Mesh Network Routing 
Algorithms" mailing list thread, the tpmeter fallback has a significant cost.

Is there anything which I missed that could ease my mind?

Kind regards,
	Sven
--nextPart2387932.Z4F31lax4L
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAluUCPkACgkQXYcKB8Em
e0ZsbBAApM8wtAaCZxjMGtzL5lIDlGgAyOlUklIVr1uGOH4feG0al3b7XX2SMc+b
5293bptTnPSwAl7iDgkgtlW854BL15AsKZPqxZq3NhadJJ2xzKwPK4pIhCULKXi5
DmIwXUATes+zAX7coAzoSP6XMzsS7Q4FTCOJKpCeigBJW1ffPi+bzllg4geEeCJ6
bCXEy42Q1naXwWpp5KlXmYK3jkTk6P+qpnTScXyAyc5tIhN4gFVeEf3+fIG2S2YF
il1opiZrVJ2v2jlGiri1hHtBU1B6mlGUMHNbF2O6o5jXwZg+NNJGQLS/gN+Lmwc4
8BZXmWeuBiD0YCVzX8WQGejA/JiRYVvQpY3fb0SxGlH2FIAhuprMDSu2AMojJHXJ
wbpRndssz+R2BKZp30eIP3UZKEF4xp+nPdBbVGCZKDsQH8j0jprth7QbRQgS8gLV
y0ZZR69pQjRGWplz34gIDFlpNYOe2Qogkhk3/kS4NT4eZizGfCMXIelCw4vcqehI
uWjIlusZsIPl30foG+Lp+7AC+0eAEpw+0VLy/bto0voQf4fwgTiQUSq6kcYda6G0
m2Ght5E2IChCE04EA0RTFh/qwkDiN47JvsJw6yoQxmfolx+7PIemeNolPc+mAHWP
8dWr+XSknnuWhPctzyfacx0J0nXkiQh6OPUCTT9OvTanaTNolDw=
=udA5
-----END PGP SIGNATURE-----

--nextPart2387932.Z4F31lax4L--




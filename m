Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Tue, 02 Dec 2014 15:09:52 +0100
Message-ID: <1869231.xPTQmY7LN2@sven-edge>
In-Reply-To: <20141202135703.GC24653@pengutronix.de>
References: <3895904.RefSiyY2EJ@sven-edge>
 <20141202135703.GC24653@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart3004844.BqeOrO8qhe";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH 30/31] batman-adv: packet.h,
	add some missing includes
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
To: Markus Pargmann <mpa@pengutronix.de>
Cc: b.a.t.m.a.n@lists.open-mesh.org


--nextPart3004844.BqeOrO8qhe
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Tuesday 02 December 2014 14:57:03 Markus Pargmann wrote:
> On Tue, Dec 02, 2014 at 02:03:16PM +0100, Sven Eckelmann wrote:
> > Hi,
> > 
> > please explain how this file can now be used unmodified in userspace
> > (batctl) and kernel. If it cannot be done without modifying the file then
> > please provide patches to modify the daily checks which make sure that
> > the files in both repos are the same. I think the batman-adv developers
> > can give you the original scripts.
> 
> I wasn't aware that this file is also used in batctl. Why is it needed
> there?
> Probably I should have a look into the batctl sources.

It is used for things like the tcpdump, ping and traceroute. In the past (svn 
times) it was just a links from batctl to batman-adv. But after the switch to 
git it was decided that both should be kept in sync manually but checked 
automatically.

I would like to give you the mini-check script but I don't have it. And I 
don't have access to the servers anymore. But it is basically checkout of 
master, maint and next of batctl+batman-adv and some calls to cmp (or diff?) 
to check if both files are the same. A mail is sent [1] to a mailing list. 
Someone has to merge the missing changes manually.

Btw. thanks for taking your time to cleanup things.

Kind regards,
	Sven

[1] https://lists.open-mesh.org/pipermail/linux-merge/2014-March/001736.html

--nextPart3004844.BqeOrO8qhe
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCgAGBQJUfcgzAAoJEF2HCgfBJntGxmkP/R6XxTDjLWRYDwF/VIvQEwvt
uvu59e5HP6fW7OAikB4/HrAoUR1rVc8GPSyJWVRs9CUucsi+MMu2TFA8oW0srN+r
03VRwd2h0xqnoGTucdq3qn+P06mDBPO9BpChpEear3/Z19UXmPRQdMPwlSRJnVvp
REnIrZnv/D6MdSY1FJ8zNwgshcNQEBHdym7HpjNa0cR103URuAZtjUPAC6yLUfcg
YvDrfQF2NQLJcqaE3C8qU3OFD63QwdXRs2eCn7JUobBFvB65GGIGqusF0k2w4X2r
lMtkWebBfNly61haEreLNJKJicIA5NO0xUzF1hDYOVKIUAI6+uU/yfXerLzJuTi6
gtRsov6D0MNMpN9OwIpMiHjZpL/d3CbuTZ22Sh2lruG2Ocotbh0XgaoYUjrDKBQ+
XA/rs/A5SICD/OcmaifxHq843iaNzT4XOaMNiwgH8XfOqUZElC94jdCKA75p5v9C
E6XQsnMS8a9y5oDuS7OZzGnK7gaURXJTv5BSJ6dbGbMWR/TftL/z5rO2cP4hEHjb
Uhv/3Wuw4GyycJmglkDVkcfkC41aC8Vw1qHhEfai1yXaqPkp3PIwRg21Q0tXIg2a
qskc8K1ToVw9yIZ65qBZ7jgOMsJlfKbmAk/Kci956pXEYib6C+SFW51apyGsffiD
jNgS80sM4Me79D7XdqIP
=wxgH
-----END PGP SIGNATURE-----

--nextPart3004844.BqeOrO8qhe--


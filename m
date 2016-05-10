Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Tue, 10 May 2016 09:00:49 +0200
Message-ID: <12399409.fEQLp0ttQ1@bentobox>
In-Reply-To: <20160509190608.GA18522@lunn.ch>
References: <1462817239-18104-1-git-send-email-andrew@lunn.ch>
 <1495261.OkJHpVOaGk@bentobox> <20160509190608.GA18522@lunn.ch>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart3945288.asrhfhWL2N";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCHv4 00/12] netns and netlink support
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: Andrew Lunn <andrew@lunn.ch>
Cc: b.a.t.m.a.n@lists.open-mesh.org

--nextPart3945288.asrhfhWL2N
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Monday 09 May 2016 21:06:08 Andrew Lunn wrote:
> > I hope this helps to reduce the conflicts (even when not resolving it
> > completely) between the tp_meter and the netlink patchset.
> 
> Hi Sven
> 
> Do you want to take over my patches and merge them all into one set?

No, this is the last thing I want to do :)

I only want to get the "big" conflicts solved and mark the parts which most
likely will needs to be changed before Marek will accept them.

I will have not much time in the next days to do any private work on it. So it
most likely not the best idea to give me the patchset with a lot of TODOs in
it ;)

I will try to poke Antonio and Marek some more so we get a common starting 
point (the two patches from batctl/batman-adv) which we then can use prepare 
our patchsets with a lot less conflicts.

Kind regards,
	Sven
--nextPart3945288.asrhfhWL2N
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCgAGBQJXMYchAAoJEF2HCgfBJntGVE8P/2NMo52AwKvOw6g59+sjoF9M
HDsqesZZby8dfqWVkQ58hM0Pq3Iqnmml5ih3Jab08bv8e0Qwg969Nq9AmPd68bcm
1db0Tl9fCfxp7Zn5nGzcyKQdMuRcVaBtdJ9dRntcf8qh8/aeGVGY3sf5D2K1iWCG
HgSirl0Q3R23kp+hvfDtGF0qQneVzsdze1n8FditMhLlWRU2lJVEOVaYoTCr3VNt
ZqKPfvwsmsIHQ9IQGroWV+x0oBDXnFtKDMptTlzQFZ2D/NwWmA8QvEzVBucm/dFA
fr/9P+PsiZo7WskjlNpetmED45IFA8zbmNFHDmsn0up6GXfa3hUQLgdw1tREc1Ut
kdrFpKkeD5h13nhC3xc1o7ekV9C6flZ8T0GffUBLq1LH4C24rG6m+G3y2Uw5aHkZ
6iMg6ncNg9cjsHFqMLffSDFbN4A6y0vfiXNgUwXmhPG78Szl8sXAB+pRZlnuZKk+
3mCZ0nmPNlPMazHEL4HLYAsnWha+OcExexDPakWnCju5z1/13R96Jr0Gu5MNHvJJ
S8KziNJtHb1EBn5CS6QwPdBtvF02ewQMeYPjA4Il5SsjJkoQF1rWRuUzcF3apPN7
01bMNSAPhArpkMoIOGkhG7wLr3lKQ3MugJNH/Kv6zmTcNqxMHbNx2YRo+kAViwgp
DMUGzVIt8ETW1hmyIzr+
=gSt5
-----END PGP SIGNATURE-----

--nextPart3945288.asrhfhWL2N--


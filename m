Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Wed, 22 Jun 2016 16:30:59 +0200
Message-ID: <1505099.fSMxhsIeMd@bentobox>
In-Reply-To: <BLU436-SMTP19879B76605F30F2F0DC95DE32C0@phx.gbl>
References: <BLU436-SMTP19879B76605F30F2F0DC95DE32C0@phx.gbl>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart3298173.PAhD0cmg6c";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] question regarding batmand convergence time
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: Thomas Tiotto <thomas.tiotto@outlook.com>
Cc: b.a.t.m.a.n@lists.open-mesh.org

--nextPart3298173.PAhD0cmg6c
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Wednesday 22 June 2016 15:49:48 Thomas Tiotto wrote:
> Good day,
> I'm currently finishing writing my bachelor thesis whose topic is mesh
> networks.  I have been running batmand and comparing it in performance
> to olsrd; one metric I can't seem to be able to measure, though, is
> network convergence time, i.e., the time it takes for a new node to be
> discovered when connected and forgotten when disconnected from the
> network.

Hm, wouldn't it be more interesting to look at olsrd2, babeld, batman-adv,
802.11s, ... [1]? At least these are the "hip" things (without implying
that olsrd is old and grumpy - just not as ultra-hip as olsrd2 ;) ).

> This is due to the fact that batmand doesn't seem to display
> updated information in the same way that olsrd does (with
> DebugLevel=2).  I've tried looking at the routing tables but these also
> aren't updated when a host disconnects and get purged after some time
> has passed.
> Is there any way I can get a real time view of the network to calculate
> the time it takes for a host to be discovered/forgotten?

There is no "real time view" of the network. Just the TQ value and the
purge timeout. An originator doesn't say "goodbye" and thus the TQ value
usually just decreases when no OGM is received directly from them and
after a while the originator is purged.

New originators are discovered when new OGMs are received and will be used
the link is bidirectional and better than other links to specific
originators. So it is not really interesting when a new node is detected
but when a routes are updated (e.g. switched from a route via a
disappeared originator to a different originator). This behavior can be
changed by adjusting the originator interval. Mobile setups need a lower
originator interval and static setups can reduce the amount of overhead
by reducing the originator interval.

Maybe I forgot something in this very brief overview but I haven't looked
at the code of batmand since a while. Elektra, any comments?

But there are also other papers [2,3] which had a look at these things.
Maybe you are interested in checking them out.

Kind regards,
	Sven

[1] http://battlemesh.org/BattleMeshV9
[2] https://www.open-mesh.org/projects/open-mesh/wiki/Experience
[3] https://www.open-mesh.org/projects/open-mesh/wiki/New_papers

--nextPart3298173.PAhD0cmg6c
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCgAGBQJXaqEjAAoJEF2HCgfBJntGA6wP/0qu85rslhD56UjEf0jUG3kR
RyAfRvwlPJZ1LLzaIYYLgHG139oYrPbS2ySzoiZs45WSA4FFmpCVjoGhRUtsbbb1
zLWbEzW0YKeHoIG28K+DF02xVOTFincky0Qq4lxbwUXdPgpfeJ8i0zpqlPp37v9U
1Qz9FvRkrDkGzoeuVrEeWH2ocvDL9gDZ3jmBuG30TlN9jMKbHtVnt5Lq5j5/EDxG
UWIwY2wqMTRWaWlMFNbaMv4oK1voK/GGCjdYArvpRYtkrYr9dDp/va00bTSXnC5U
SPY5UfUzKAWhKtXiTDch3R4+PzV9HzixQw6Jc89vXNa3hMvH9Ds8ticscF5kA/mD
H4M9D2CUvV5ajfZpaMZLCH6fNimqERZVK6IL8/2wbxdBb4XLenYhc7ywPtfma24y
p5F8oCvbJa4uUmjkofRY0yCDGlX6MBSLveb3sifUzxRRoT4iG1wE/xCW3z6l3J5w
w99ObT/XchCCqilpw4YLPAFYU42LE60i+Ut9CewS5ONbelv54lbDZ782+ZSjZ7YG
ivEo34O744sJ/APVNxvgwEQR/vN4MBvfUGKbSsSzt6IJnJJVEV6Nd4v2ImieL3hM
QS926VV1DljO2BpX/y8Mm7ma2cbyZ1u7nwYC5r8A0mEUHef/HWqbLRXdwoDidR6f
JCuJwD2fgipVIyN9SZ7P
=PcMX
-----END PGP SIGNATURE-----

--nextPart3298173.PAhD0cmg6c--


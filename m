Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Wed, 06 Jul 2011 09:43:42 +0200
Message-ID: <1364008.4HQyYqKGTl@sven-laptop.home.narfation.org>
In-Reply-To: <1903541.vB6FKW9Psn@sven-laptop.home.narfation.org>
References: <1309879385-21224-1-git-send-email-ordex@autistici.org>
	<1309879385-21224-2-git-send-email-ordex@autistici.org>
	<1903541.vB6FKW9Psn@sven-laptop.home.narfation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart4697445.DmehtKNnEA";
	micalg="pgp-sha512"; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7Bit
Subject: Re: [B.A.T.M.A.N.] [PATCH 1/6] batman-adv: unify the three starting
	fields of the tt_local/global_entry structures
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
To: b.a.t.m.a.n@lists.open-mesh.org


--nextPart4697445.DmehtKNnEA
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="ISO-8859-1"

On Wednesday 06 July 2011 09:31:11 Sven Eckelmann wrote:
> On Tuesday 05 July 2011 17:23:00 Antonio Quartulli wrote:
> > Now the three starting fields of the tt_local/global_entry structures
> > are
> > unified. This allows to write generalised functions that operate on the
> > flags and refcount field.
> > 
> > Signed-off-by: Antonio Quartulli <ordex@autistici.org>
> > ---
> 
> Ehrm, this is wrong (or at least undefined behaviour). Please read C99
> 6.5.2.3 point 5

Found an extreme nice example [1] for you. Please read it together with the 
C99 paragraph mentioned above.

Kind regards,
	Sven

[1] 
http://coding.derkeiler.com/Archive/C_CPP/comp.lang.c/2007-05/msg03192.html
--nextPart4697445.DmehtKNnEA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABCgAGBQJOFBIuAAoJEF2HCgfBJntGN+gP/3GepP2wCSvhN1zxrbHgFGHb
SQMitQ3kx9uFvRlEXJGBExcVR+zjGkcxF1c0vAxRtckb6xF0PVpl7JHrwx20DWdS
tx4PkLVzXQNy0Wug7Y/+k3p1i9X7UeqK36nlJNaze11+7fP1spGNFlCCfFnqg/vW
NOBTbBFwxqJ9IRItfNxZ3kTPTh6mWGkoxMPL3reOwT45KygKRpyb/2VKpaG4T8Ew
p62v7IhpvIZ2Ld9P91iEa/eW/s7ylh38U9M4fsS+6nZy2QZZRzQcft30aRm1pC1p
PagSn0Qgvv/y+LkDcp0FA8teok1+PAAaIgr7Z30DrrxDrB5UXe4y5+pvjboiaZQG
oeuAZCL+lcfQpI0ZX9PCStGAca/DjfD3lq/6QHMRnoeMOTTikDXh7N/X6VFTxp+n
H7UyCg5B7bXX396l4sQlpbeph8040mtFTbwGw9DuwCte15RYTWbRSmcafT/Elj0G
bM7XROlhh1r1/8UbmmWxDxSu/o0Dq61pdLWkO+dXBT2GEzHYxQAyLfGKPpB+ZlMg
C7XjIiZGNszMQo6PfTd+p3dblJh/xE3OEubbWuyc8w3z38TnNa7U/YYmDU7a5HVo
H7n79EyfJAS7BKZv6rDWIRwoOYD2oyF2wpK76RORrbXhmLEvBt4RAt0d/BxyTZp5
kotc/hx54Kg84vHh+piN
=0z8f
-----END PGP SIGNATURE-----

--nextPart4697445.DmehtKNnEA--


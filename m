Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Thu, 13 Feb 2014 23:39:38 +0800
Message-ID: <2155796.4nLzYnGVik@diderot>
In-Reply-To: <86mwhv5cy8.fsf@coulee.tdb.com>
References: <86r4775d8s.fsf@coulee.tdb.com> <86mwhv5cy8.fsf@coulee.tdb.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart4027860.UThGgQXnI6";
 micalg="pgp-sha1"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH 2/4] openwrt routing feed: batman-adv:
	split kmod and userland into separate packages
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
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>


--nextPart4027860.UThGgQXnI6
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Thursday 13 February 2014 06:01:19 Russell Senior wrote:
> Creates a new package, batctl, split out from the batman-adv package.
> Simplifies the Makefiles, allows QUILT patch management to work,
> removes the quirky naming requirement for patches.  The batctl package
> is a dependency of kmod-batman-adv, retaining the existing dependency
> relationship.

There is no batctl dependency and there should not be one. Some people try to 
save as many bytes as possible ..

Your patch does more than splitting the the Makefile. I'd prefer you send 
these changes separately.

Thanks,
Marek

--nextPart4027860.UThGgQXnI6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQEcBAABAgAGBQJS/Oc+AAoJEFNVTo/uthzAOE8IAIifkjc11p8LxisINq7q3yPu
LSLzTCHAbf9zAdJA6gGEjvPQAyNZ8zfx1Z3YWw2SCxEzjyx56gV43a9rmcO6GMrl
CpUKfVWHR44wmNltvZvsun0+ptWlpv4QI03nnhE5F18cJTfRDcaFKk3R6JE4+9gz
7fKOm1kaOsPkUe3KoeagNstbqnuCOh0UMfJ9LSMOVdYzyZtM7OSx/bUSyUhl2cGX
+J0pjjYxwBUb0+5/h+/R0FXSzvP83wrmKVCHwXbBf3cr3vQ0+p8v0HdhpqeVM4h/
K/mxn5LxE7bF+HmkwtFivZ8TYeIYYfgWmTuYgSQJPD2KFdUc+Gk1HAQtd7COVhM=
=xRTQ
-----END PGP SIGNATURE-----

--nextPart4027860.UThGgQXnI6--


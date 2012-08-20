Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Tue, 21 Aug 2012 00:32:05 +0200
Message-ID: <6567295.mkEhlW2YzJ@bentobox>
In-Reply-To: <CA+h5Vgrcu=R7odK4av7cVs9Ov7+ZSXf0SgPM7riJ2HRpyYUvHA@mail.gmail.com>
References: <CA+h5Vgrcu=R7odK4av7cVs9Ov7+ZSXf0SgPM7riJ2HRpyYUvHA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1962389.fzoJKyJgaf";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7Bit
Subject: Re: [B.A.T.M.A.N.] editing the routing information
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


--nextPart1962389.fzoJKyJgaf
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Sunday 19 August 2012 17:13:28 Dominic Follett-Smith wrote:
> I am using the batmand release and I trying to edit where batman keeps
> a statistic of next best hops to a destination node.

The development focus of many people changed to batman-adv. Therefore, most 
people aren't knowing the code very well (or have to read a while to get into 
the code again).

> I want to change
> the metric in some way to alter the choices that batman makes when
> routing a packet to its destination. However I am rather stuck, and
> would appreciate some direction on where the updating of this
> statistic of next best hops for a destination is done in the batman
> code.

You're request is a little bit too general. Maybe you can go a little bit more 
in detail. Otherwise I can only recommend batman(void) in batman.c and 
update_orig(...) in originator.c

Kind regards,
	Sven
--nextPart1962389.fzoJKyJgaf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAABCgAGBQJQMrrlAAoJEF2HCgfBJntGE50QAJ+dxUUFSFiQdBy0iLcpo4s9
LhvkU7zQTu4VU6edz46P9dVxe7k8hSXqWi0+/q7+nFCljlJAulYCQdrUqSYB2otw
39my0hDehM8qlNQ0QEfCkwefsBnsuDKwjHJYW3cNviWcNkqdrB+Xzn2JXOL6CRmV
LJ2h4NOjh2+GTBXs60B9a/3JOto484UsQN/2itckFvgG2fP6Qh79guZZ8nm7h+CQ
0iwYOR5b7AJKmQoN4miFrhc1fDuVjBeYPq6r+c2+/UtjxDN0Bd/sQsAQBElMz7h/
LF/PJir7c1qVL7y5nZZPdJJS0wDQZsXs0+5goSAdC5RRawDw2rZ5l6uTUk/U/9VM
8VUpSeeOPsa+Hta6ILHXLLCX89w+DJFhM6xGoPAxS7MIOxPM2ygHiHbQSBRFMMjh
aG7kF/imUqVxhy+eILQacZfPnNGWmj7JP3kUDGA2ZCGlHOm5xu9nq5SpxMzI64rc
/l726VigHJUs9g1H9p3CSUpcs6qOc0X2BXVGcWUOzgVm9QEQUcSDP6iA8rvXRQ8B
8B7Med4UgNGtyGTCiJMsqMZMKKsbk8YKu8GbImzIt8K93tcGqoRc/TJjLSb1DNy3
JqxXwAsKkUtxhzlDgzaM0HWoryGT3OkaZINys+QPJOED5yleO3G/5UVsa7xAsTbA
P6WJnu2xRDbt3RwUBACa
=tfBI
-----END PGP SIGNATURE-----

--nextPart1962389.fzoJKyJgaf--


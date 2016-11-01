Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Tue, 01 Nov 2016 16:25:12 +0100
Message-ID: <28433126.Mo1qHJxRqg@bentobox>
In-Reply-To: <5818B129.7090509@yahoo.com>
References: <5818988B.5050600@yahoo.com> <1657394.aEyv3RqyCa@bentobox>
 <5818B129.7090509@yahoo.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2301276.N4DuTDcRyN";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] how to config gateway ?
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: johnzeng <johnzeng2013@yahoo.com>
Cc: b.a.t.m.a.n@lists.open-mesh.org

--nextPart2301276.N4DuTDcRyN
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Dienstag, 1. November 2016 23:13:45 CET johnzeng wrote:
[...]
>                              but i have a question ,   there are two 
> interface bat0( wlan0 and face HostB) and eth0 ( no batman interface and 
> link to internet )  at hostA
> 
>                              echo 1 >/proc/sys/net/ipv4/ip_forward
>                              iptables -t nat -A POSTROUTING -o bat0 -j 
> MASQUERADE

No, masquerading has to be done on the outgoing interface (towards the next
hop which should not see the internal IP addresses - in your example eth0).

Kind regards,
	Sven

--nextPart2301276.N4DuTDcRyN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIcBAABCgAGBQJYGLPYAAoJEF2HCgfBJntGA9sP/0bL4aw8RwgtsoHfUUhdcXQX
47+JVWS7iUrKq9BJcHALNCXTUp12NDXN3Y5iL/Gsq34J9LLpGe038pPhpWTZLPZD
NkzkA7mJxx6NnI2ajCamq0cGRcBKig76FpyV95yumL9s9YDG4X3ysa10DAoXz30O
se8gBH2OFH9o15ecgNOvMit+qGv5065GaiaFCXwS+9XzmKO/m3KgDEu/l9ogXLMr
6gd+pW632LUBINkybF0r8Ifi2yA2Cr5B+Dd8s43gsl+38csrPHOEAgXn3zd/6hYJ
OBWeiPA4eR/M7vEfXP+DKLbzS/t4+JIetajVnLhocu+0wBkI8fr5bj6ct5OnD364
XXNNtSBiOjOMsHoWGfPb5NlWyQCo1ktg1saF/prJrWsTShEMWT2xcwXsYM92NB83
NX0pHyUK++Jsaolip27CRhTIScutwyY/kK8SuaW8/YNMHSmSD8wyTtxL7oTQjcZw
IJulrQ2+Gg4qi+fn6Djs9/z4XgzOg/SDQ7U0T9nnpyXj2mbO8nCCzu7hFTO0dC1s
QxuC3FM5H6lMji5WN1Pwk49OqUkuofG2efLc9v/Lqm3Dk2iMH3rkge+0yVBBcpZF
IySjx0grMiRyjTlk48SFZCMPw64s7qCzfuyu+pKAQfhA0jnISekDW2awTJ7LF464
lpMeGQakpiJTnDHfVB7R
=qMIT
-----END PGP SIGNATURE-----

--nextPart2301276.N4DuTDcRyN--


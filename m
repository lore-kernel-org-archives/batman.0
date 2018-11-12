Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Mon, 12 Nov 2018 18:13:33 +0100
Message-ID: <5197276.b4DnEGo6x7@prime>
In-Reply-To: <B99A1AB9A294834C8DF94185A5E9D18101784D2A0E@NRTV96002.america.zf-world.com>
References: <B99A1AB9A294834C8DF94185A5E9D18101784CE751@NRTV96002.america.zf-world.com>
 <3795505.rC9BEUj0Hg@prime>
 <B99A1AB9A294834C8DF94185A5E9D18101784D2A0E@NRTV96002.america.zf-world.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2034216.JNrDSOKKOf";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] broadcast storms
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: Jake.Harris@zf.com
Cc: b.a.t.m.a.n@lists.open-mesh.org

--nextPart2034216.JNrDSOKKOf
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Hi Jake,

On Monday, November 12, 2018 2:29:07 PM CET Jake.Harris@zf.com wrote:
> My apologies bringing this back but I'm still having trouble with this. Each
> of my 50 nodes sends a 100 byte packet via broadcast every 30 seconds, even
> if coincidently they all transmit it at the same time that's only 5kB of
> data to move, much under the 1MB (default I believe?) bandwidth for
> multicast. Unless there's a large amount of broadcast traffic outside of my
> python program I don't see this being the culprit.

Mhm, this is really not much data ... did you try the multicast as suggested 
in an earlier reply?

> 
> The storms tend to start when connection to a few nodes gets flakey, so I
> can see the reset protection setting being helpful, how do I set
> BATADV_RESET_PROTECTION_MS? Is this an environment variable or do I set it
> with batctl?

BATADV_RESET_PROTECTION_MS is a define in the batman-adv C-code, so it can't be 
set at runtime but only at compile time.

Cheers,
       Simon
--nextPart2034216.JNrDSOKKOf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE1ilQI7G+y+fdhnrfoSvjmEKSnqEFAlvptL0ACgkQoSvjmEKS
nqHb+RAAnWcA18mi177ljF5UZrfZLOlVBeGjhfjaC5ak5MbxYBzhalAkc8n6IUaB
4VLGtrl0pgPtltDdBD2Yg3dbQrDQ1CXQ9ds4tn7BRhE5bwqiCvfKXMoMcKQ2xDZ0
5c9YjAKv7gUeuwchX/IikNv0YetIgMLHUEsCsweDBpX2hnmvtbSkaijreyasoKfn
vgK4iXeQYl1jsZMNcskww1DIqJdj/4RZGHPPkqYxtpOk7LBbt4HN03XlQfQ4Rdh6
bEfIXS6baxXSr+v5ZO6TZGzkALve8pOJpDR6gRR0OBO+T5TorW8u3SV68tAmFuKT
MkUhyUbW1xftfgfArxtu3P7Dbf7mPntvyowdb/pBDkwWVTy2qUW9vMSJdVZJt4Jn
qzotxJTCuGEJZ91182CIprNxZHWqp2V81k3tey8cViIsQabRiSfsFW1ZEjI8o+et
3m2kVlQax8gPpDYKPJQfPtAXA7Y3F6kX8DTqoi0csHeFYcLGIIIg3Z6pBsEamx4F
D/mfiZ36+i6c3LDyEzDWKsOuSqWYKRUjY+LmtsAs2i9RPnC/03Za0L92yQ3wRg03
/fXuFMs/heObJglpMRHgAf4Wo/L60oxfWIoMAra4cBx/9OC7a1t6XrICrzOhOpvu
G7csa9t4kEfvAJYw/fLpLh/7p6jjAK7B20KPAa/YjX+CP9GMCcg=
=FW/M
-----END PGP SIGNATURE-----

--nextPart2034216.JNrDSOKKOf--


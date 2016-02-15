Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Mon, 15 Feb 2016 09:54:52 +0100
Message-ID: <3485451.rMHW1YXhP4@prime>
In-Reply-To: <OF10684F8B.B1994E7A-ONC1257F57.004CBB7B-C1257F57.004DA2CF@phoenixcontact.com>
References: <OF64B7E443.53DA160A-ONC1257F53.003E4656-C1257F53.003FAF34@phoenixcontact.com>
 <2193610.djA1bK6ZTb@prime>
 <OF10684F8B.B1994E7A-ONC1257F57.004CBB7B-C1257F57.004DA2CF@phoenixcontact.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart12684896.GMaK6UXxY7";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] Antwort: Re: Antwort: Re: Re: Antwort: Re:
	Looping unicast packets when using BLA
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: Andreas Pape <APape@phoenixcontact.com>
Cc: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

--nextPart12684896.GMaK6UXxY7
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"

Hi Andreas,

On Friday 12 February 2016 15:07:59 Andreas Pape wrote:
> Simon Wunderlich <sw@simonwunderlich.de> schrieb am 12.02.2016 14:04:23:
> > Von: Simon Wunderlich <sw@simonwunderlich.de>
> > An: Andreas Pape <APape@phoenixcontact.com>
> > Kopie: The list for a Better Approach To Mobile Ad-hoc Networking
> > <b.a.t.m.a.n@lists.open-mesh.org>
> > Datum: 12.02.2016 14:04
> > Betreff: Re: Antwort: Re: Re: [B.A.T.M.A.N.] Antwort: Re: Looping
> > unicast packets when using BLA
> > 
> > Hi Andreas,
> > 
> > On Friday 12 February 2016 11:40:21 Andreas Pape wrote:
> > > > > [...]
> > > > > using dat in combination with bla:
> > > > > 1.Broadcast ARP requests from the backbone network are handled by
> 
> each
> 
> > > > > gateway, leading to multiple dat adress resoultions in parallel.
> > > > 
> > > > That shouldn't be a problem on its own.
> > > 
> > > I think I wasn't precise enough concerning this point. I meant the
> 
> effect,
> 
> > > that
> > > a broadcast ARP coming from a common backbone reaches all gateways. If
> 
> now
> 
> > > accidentally
> > > several gateways can already answer that request due to dat, then the
> > > current code sends
> > > an arp reply from each gateway being able to answer. This broadcast
> 
> does
> 
> > > not even reach
> > > the mesh if all gateways can answer the request (as far as I have
> > > understood the code).
> > > Therefore broadcast handling in the mesh layer does not solve this
> > > problem.
> > 
> > Yes, we may have multiple gateways answering with an ARP reply. But how
> 
> is
> 
> > this a problem? It is redundant, yes, but its just a unicast sent back.
> 
> I
> 
> > don't see this a s problem yet ...
> 
> I would like to prevent duplicated packets as much as possible, even if
> they are unicast packets normally harmlexs for typical PC hardware. But I
> know of enough small embedded devices (sensors and stuff like that) which
> don't like that.....
> 

Thats a good point. In general it could be debated whether we prefer redundant 
replies to no replies at all. But I'd agree to your point, especially since 
having answers from different devices may confuse a switch because it thinks 
there is some mac flapping or worse, having answers from different ports.

>> [...]
> 
> I've just sent the patches. They have the state of my "experiments" last
> year. That means that your latest proposal is not integrated yet.
> I quickly updated my devices in my test setup and it looks good (no
> looping arp requests or multiple replies seen so far).

Thanks a lot! I've reviewed them, we still have some formatting work to do so 
please bear with us with the iterations. Splitting and cleaning them up was 
definitely a great start, this is a very good contribution. :)

Thanks,
     Simon
--nextPart12684896.GMaK6UXxY7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCgAGBQJWwZJcAAoJEKEr45hCkp6hegoP+waqVM/mN54GLxOpPRu3W5Uf
YjVWYxSH8LYPVN53KZPRdXOao5ogoJ3lhm9mmqzvaSqme5gD1xKANgaAS6uW6CST
N1ZROq893KYW+nfGEjmZ9YPyeje/1IuPYS7gxF990eA6PUXNu0GYOzavgOyvbLxC
rjZZGas3x5UGuLIM/4yXJQeXNmk1UiDiQLDFzwvToWzOyA6MoqTYkThAYooIAxdi
uSdnK/u9h1BFnTz3ioGbDOK4FiZ9vrkK2omRa3eUlrk/4tONABQtQ81ov8ZvNMhi
xYjlEAPGln7J0Fi4mpUdycXcArsM0mNVBBYW9J+Fj7y47qrWpnKcV4IQ/kcx1L81
20XA201rjg1J5bo1+WfQJDyoU2J5BHQUTgjfCyUs39seioG0Gmvxo+lI0m20uIYZ
6wvPRD3SoqNrihp0P+6SwEjfrvQBIX57yqOe0nCfbm7WtyJSqb4noZUAQEWsgf1b
CUCAvkpyAM4WyLvQb4wsVOcHXWMtVZO8bd2RtfU+Y9ctUCTMh9uBysYsYkrGTb6V
/6+rNZhgpAN2PWrsAchpR2h3Ilfce/fA3QHp+IxDnUbaKllaITxXwt/8gQ0kB5pL
bFcRA+9eo4WWwL79d8lAyoGKo18odE8Ao5f28Vh4TYr9jQsG0r+Dyhlhs1ljnFiZ
IpmWmhZs/0qxcI3vzJIG
=Hypa
-----END PGP SIGNATURE-----

--nextPart12684896.GMaK6UXxY7--


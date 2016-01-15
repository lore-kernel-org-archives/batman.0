Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Fri, 15 Jan 2016 18:58:34 +0800
Message-ID: <7470581.2UlicqNZs0@voltaire>
In-Reply-To: <20151231110712.GD30632@otheros>
References: <2457136.iz2mu7y0Mc@voltaire> <20151231110712.GD30632@otheros>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart25069273.OyzIShGTl6";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] B.A.T.M.A.N. V leaves the nest
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

--nextPart25069273.OyzIShGTl6
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Hi,

quick summary of the discussion we had:

> * Is the check "If the received neighbor is not (yet) a router,
>   drop the OGMv2" still necessary? If yes why?

that appeared to be a simple misunderstanding of our documentation. The phrase 
was updated to:

If the OGMv2 was received through a neighbor that is not (yet) a router, drop 
the OGMv2.

If the neighbor is not known the link throughput also is not known which is a 
requirement for the protocol to function.


> * Suggestion: Change "If the OGMv2 sequence number is not newer or equal
>   compared to the last received OGMV2 (from any neighbor for this
>   originator) and if the throughput is not better, drop the OGMv2"
>   to:
>   "[...] (from the currently selected router for this originator) [...]"
> 
>   (-> is another sequence number check here redundant?
>       see "Age check above"? maybe some merging+reordering here?)

Yes, you are right - this seems redundant. The second 'age' check has been 
removed from the documentation.


> * What does "is adopted"/"are applied" mean in section 3.2.2 and
>   section 4? Maybe clarify when the internal stats are updated and
>   when the OGMv2?

Each of the mentioned sections clearly states the intend:

 * 3.2.2: If the initial checks above have passed, the internal stats are 
updated ..
 * 4: When an OGMv2 is to be re-broadcasted some of the message fields must be 
changed others must be left unchanged. All fields not mentioned in the 
following section remain untouched:


> * Suggestion:
>   * Move "forward penalties are applied" to section 4
>     and change it to "forward penalties are applied to the OGMv2"

Forward penalties are applied on reception but only to routing tables used for 
forwarding.


>   * Change "Path Throughput is adopted if its lower than the link
>     throughput to the neighbor, otherwise the link throuput is
>     adopted" to:
>     "If the link throughput to the neighbor this OGMv2 was
>     received from is lower than the Path Throughput of the OGMv2
>     then set the Path Throughput of the OGMv2 to this link throughput."

Good suggestion! We changed it to:

If the link throughput to the neighbor this OGMv2 was forwarded by is lower 
than the path throughput of the OGMv2, then this lower link throughput is 
adopted.


>   * Remove "The Path throughput for the considered outoging
>     interface is adopted" from section 4.

Forward penalties are applied on a per-outgoing interface basis. This can not 
be done in a global manner.

Thanks again for the thorough review!

Cheers,
Marek


--nextPart25069273.OyzIShGTl6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJWmNDaAAoJEFNVTo/uthzA4P8H+gNWRrOUCXcfoL381J4ItGEE
2MyaYEAmosrn0h64QfbIqNbJ5f/m1sEy3hVES1AqNhZxc+zXBkJ2ovTNi3BgmZjb
2+XsmWzHwyiao1kTzEheQQoYejjSzNnbZZf/+CD8rmMiLJ+Dm8L/krLD4xlu8QGO
/TBxNz138tHal0goQRb3r5SVnJKsSZgaMFGUg87sXmP6qhMlA9OKRJONhHwCKyw2
pe7fQODJ9WIbtDwSoIgqa/G6OwF2RjCaWwDDEz6qtfqrwGces2WHZgvQfQoDS/5W
KnLRheNvoZ2mBdylj3wzpSJAJI0+1YPcTF9UkafKbwJjD/vnyqg13D1Li9JrvYo=
=v3tX
-----END PGP SIGNATURE-----

--nextPart25069273.OyzIShGTl6--


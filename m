Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sat, 20 Oct 2018 14:20:54 +0200
Message-ID: <8862805.a4Yc4RlQzm@sven-edge>
In-Reply-To: <9849012d-6cee-9877-0dbf-65348cb7c593@blastwaveinc.com>
References: <babe56e8-b12c-8236-7012-20bb91d400fa@blastwaveinc.com>
 <20181006121445.GA1471@otheros>
 <9849012d-6cee-9877-0dbf-65348cb7c593@blastwaveinc.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2425864.JGXJIatOob";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] B.A.T.M.A.N. port to ESP32
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: b.a.t.m.a.n@lists.open-mesh.org

--nextPart2425864.JGXJIatOob
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Montag, 8. Oktober 2018 18:43:37 CEST John Gorkos wrote:
[...]
> > This sounds wrong. You should not rebroadcast any OGM. You should
> > only rebroadcast from the best candidate. I'm wondering whether
> > this could cause issues. Or are you testing with a single
> > EspressIF and a single Pi only for now?
> I must have a misunderstanding of the BATMAN IV OGM mechanism.  My
> understanding is that ALL 1-hop (direct) neighbors will rebroadcast the
> heard OGM, and beyond that, only best-hop candidates.

Yes, single hop neighbors have special rules. But it is also important to 
check for the incoming+outgoing interface [1].

[...]
> So, to be clear, I'm working on BATMAN IV and not BATMAN V.  Based on
> the open-mesh docs, BATMAN V networks don't rebroadcast OGMs but instead
> use the Echo Location Packets.  Am I reading that wrong?

Yes, you are wrong. ELP are used in a link-local context (detecting neighbors 
and announcing itself to neighbors). OMG2 are used to inform the complete 
mesh.

> If there's a
> compelling reason to move to BATMAN V, I'd be happy to take a look at
> it.

B.A.T.M.A.N. V is using a different metric. IV is using one which is basically 
packet loss based for direct neighbors and V is using the expected throughput
for direct neighbors. Unfortunately, the ELP documentation [2] in the wiki is
outdated [3].

Kind regards,
	Sven

[1] https://git.open-mesh.org/batman-adv.git/blob/6f6cc4f54909127b236069207fe5691d31c29b24:/net/batman-adv/bat_iv_ogm.c#l1411
[2] https://www.open-mesh.org/projects/batman-adv/wiki/ELP
[3] https://www.open-mesh.org/issues/363
--nextPart2425864.JGXJIatOob
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAlvLHaYACgkQXYcKB8Em
e0by5xAAzUx5fp4EFba6E6n7cPVfhC0aAfQB2RvSL6CuUNfNVzIDU4ZOQ7RPvIak
qQYRA51AW67FvlLC/e6qPl6ulSUtdKTVg81Nj31GdbwZd32UT5EsFzOcFVk+Wl06
Zk7mh6zPAw2yaWLVQ+NHQyQ0n/Hu/DDGB9L4baA2L+q3FPHVJST24ees6SJsHY9Q
VdMREeI+ycZzAHQUXjZxLdeXFw7NHRWSb4XdoB+C6s80RGaJ7Pp8GSYzV7FyCD5+
ywNz6YjjOdrg4bPHE3AfZSZCVjqRP9NvLjKu3gnQLHR9LsVWjH+pG0feAqB0VrRM
qpbNkdFwF56zQdhDL91GBgsR51alJCOb8FbrQ9JKhofOOGl1B9JsVQhsUsJb5bd/
/suExagN+JK1s4OJRaiJsEe9g2yRXFsV4xUtrluo8DgiKBab03Wg+J2T+yIjiOgI
vf9DBn7OAWcFxdO9dreKBmjHV0pK/242ckpxFVmBPyYOQzrVmRJdjTRGR+fpkZOd
rJfJ7ka4u04Ck/pqlfIZo7TIZ447RxXGaLtwm2p+aHDlJ1TnOel/HKgs84fDqSZ7
W2eSA1EQXGYf+hN2Qc/kQrTCECOQosQ6KG7KkqvU4bVNxTo5Q7rUOJ5U2f5qbQDW
glVranWrD9+UG6OAcn0G64TxBKUXbiJvK03VP5KX1KI6ciGL+q8=
=UqUj
-----END PGP SIGNATURE-----

--nextPart2425864.JGXJIatOob--




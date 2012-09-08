Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sat, 08 Sep 2012 17:37:15 +0200
Message-ID: <2606499.OtDZNs5MDJ@sven-laptop.home.narfation.org>
In-Reply-To: <A677A9FB362B2F499BEFD6F80687FE972AF15A15@umechphe.easf.csd.disa.mil>
References: <A677A9FB362B2F499BEFD6F80687FE972AF159C4@umechphe.easf.csd.disa.mil>
 <1522799.RKjDCIBmI1@bentobox>
 <A677A9FB362B2F499BEFD6F80687FE972AF15A15@umechphe.easf.csd.disa.mil>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1735758.4G2hbROnvD";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7Bit
Subject: Re: [B.A.T.M.A.N.] Batman, TTL, broadcast, etc. (UNCLASSIFIED)
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
To: "Karan, Cem F CIV (US)" <cem.f.karan.civ@mail.mil>
Cc: "b.a.t.m.a.n@lists.open-mesh.org" <b.a.t.m.a.n@lists.open-mesh.org>


--nextPart1735758.4G2hbROnvD
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="ISO-8859-1"

On Wednesday 05 September 2012 13:32:29 you wrote:
> Classification: UNCLASSIFIED
> Caveats: NONE
> 
> OK, based on the answers below, I have a few more questions.
> 
> 1) Is there any way for a user program to communicate with batman if certain
> packets need special handling?  I don't mind if I have to mark each packet
> individually, or if I have to do something else interesting, but if I can
> mark a packet as special, then I can hack code into batman to set the TTL
> field the way I need it.

How would you signal other layers you don't interact with directly? There is 
no special socket API that allows you do modify the batman-adv stuff. But you 
can for example do things like the gateway handling which checks different 
layer 3/4 things and modifies the behaviour slightly.

So it is (depending on the problem) doable, but there is no general solution 
available.

> 2) Does batman rely on multicast in any way for its own operation?  That is,
> for something that keeps the network running well.  If not, I can force all
> multicast packets to have a TTL of 1.  This still requires some way of
> marking my own IP packets as multicast packets in a manner that batman can
> recognize, but I'm willing to do that, if it will help.

Multicast on ethernet... yes. Because it does broadcasts to send OGMs. But on 
IP level - no, batman-adv doesn't work on top of layer 3.

And marking the packets. This could be done using special multicast addresses.

Kind regards,
	Sven
--nextPart1735758.4G2hbROnvD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAABCgAGBQJQS2YrAAoJEF2HCgfBJntGA30P/Rmw1Yhsq3SU1jI1hNYOwKbZ
jIa2tWj7F5X3EbCTJrt1LAdKYNyl1ZNBzhwiKQxBPYO7JYvyE8sL6C8QF/odREkY
MWN4CoAGhY+o58IjnkWBS9hanxb2Hs/cS1Curvm5XfZaYK76CN3cla8+KzGsRBUh
X20oca9T1/ZOdNrbdGdTeyfkwrmTfFi5oAuZdsnQqakEqdOhIv0SEXk0CRzj9dfk
vJcDxH6i58KKsYT6WF5KdS0bkQ6ODgod4bxHXcdqKLwPWtMnnxvGduVEcA3lynPb
FoWF8CROWxZ3s5la1rUA7kV9kOxijbs/KN5zDtRzqYSBa+DSkQqJXDtAaZBKmhUN
WXPfAI/gtaNxmZUjO1zKvcl2/S1xoJRHDkYHOMdKzpT6A6s2ATLjQOATfSKTTVhv
UMwEX9N2MzEb68Map00LXdJ4cxBBr5T1Cgyx7cwe8gcO8ac+fdhO284gAN0N1k/B
cqI0bxk3zh7h9N8+TRnL2EeQ+TtHLpkYmdAvMZYifOme28FbBiE56qQ1dzOOtOjr
As7frC/EGlkd0x4p1p2zweii6aPbUBQ4r2NqM4lFY1LBgsljBW4A2VeBeqsEKzAu
DGA5fMfxYhSUf3sjk3zlt9jd04o8jJA6WkfyBZLO6CEb1OqbKX9M5i3RmAFZP+NO
/vRdbkamDVpFa3zixC+V
=7P9J
-----END PGP SIGNATURE-----

--nextPart1735758.4G2hbROnvD--


Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Tue, 20 Nov 2012 09:27:39 +0100
Message-ID: <75191138.5RcUHhBkvt@bentobox>
In-Reply-To: <CAG_HyLz9B9r=u5jSw8xy+4rfG9anB6vqK+ggMGSmRossMCx4CQ@mail.gmail.com>
References: <CAG_HyLz9B9r=u5jSw8xy+4rfG9anB6vqK+ggMGSmRossMCx4CQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1431390.KTE2t8CW4G";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7Bit
Subject: Re: [B.A.T.M.A.N.] batman over 802.15.4 .
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
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Randy Graham <surfbytes@gmail.com>


--nextPart1431390.KTE2t8CW4G
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Monday 19 November 2012 20:25:34 Randy Graham wrote:
[...]
> 1. Will batman-adv work over 802.15.4 ?
[...]
> 2. Can batman-adv work with either of these interfaces ?
> 
> I tried configuring these interfaces using 'batctl' but it complains
> that they are an unsupported type.
> 'iwconfig' reports these interfaces as having 'no wireless extensions'
> which I suspect is the issue.

No, batman-adv works on 802.3 compatible interfaces (aka ARPHRD_ETHER) which 
provide special mac behaviour. This has nothing to do with the wireless 
extensions (which are deprecated anyway).

> Please let me know if running b.a.t.m.a.n. over 802.15.4 is feasible.

802.15.4 has the type ARPHRD_IEEE802154 for its fake hard interfaces. So you 
need an "ethernet emulation" layer on top of it to use it with batman-adv. I 
don't know whether the mac layer works well enough in theory to be used with 
batman-adv.

Kind regards,
	Sven

--nextPart1431390.KTE2t8CW4G
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAABCgAGBQJQqz77AAoJEF2HCgfBJntG4kYQAKMIRX0SoG/2LLXBIRC/ufkk
wE5zvAwMprZPQqXX7hXovdzyG7dH9uGL8ivF8VbprtRkDGi+ep6vfRPFlkB5qyWs
ldPaA3a7Dic12MpJaNEwWUwmUCbzj2vYl1Z9gL5VLRToQLq0/t8YLWjDm0w08CcM
KX9cnlLinJpoYn23fuNlOZ+YpJIgev8QfvW61vCrvPlCdmoyDu5nfagafA5ifKIN
lCUUpmg2XNwE4dk1CxBBIQHpRE8zYgNdQO3jnmo9iGvueyhCxdxlzQ4+cMhRVVbS
W+uk1Mh0qYi57N3kNkY9A5msol7lBdmHvy+QEKSdenQ/7uaejiYff6eNPFVJhhdg
6MLOaOC7VCMsVRUjex7MALhGHS9cYbR7DxjaQ8d7nqHO13cD+ACeNodsD8P4gWrl
zu0furRUEkQPuZFgxjk4uG/TsSBZ9uoUSTOpQWF0k2LpPNHyTw0demGps7fV09av
o/0hKoS0njJMM2n9YKr46KhwRpwTDBnNwmrfyyMwW9PvC18/C55PnwnxTkUmD/Fv
krX1XLk0RuVEE1dQPo6RmgkklqFiTG1c9726S4g4SLBA+THIRENFwgHhTJ0e5O7F
4j++GnuncALnZNh6Tx6k6N+mbYNb0SWIVNjYEiEbJDaobMNOYCuk0uWbxYv/Lfop
KNBnitZVxU5eADgmmK0H
=N1cr
-----END PGP SIGNATURE-----

--nextPart1431390.KTE2t8CW4G--


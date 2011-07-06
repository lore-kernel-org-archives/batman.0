Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Wed, 06 Jul 2011 09:31:11 +0200
Message-ID: <1903541.vB6FKW9Psn@sven-laptop.home.narfation.org>
In-Reply-To: <1309879385-21224-2-git-send-email-ordex@autistici.org>
References: <1309879385-21224-1-git-send-email-ordex@autistici.org>
	<1309879385-21224-2-git-send-email-ordex@autistici.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart7160454.XG3KhJV1Re";
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


--nextPart7160454.XG3KhJV1Re
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="ISO-8859-1"

On Tuesday 05 July 2011 17:23:00 Antonio Quartulli wrote:
> Now the three starting fields of the tt_local/global_entry structures are
> unified. This allows to write generalised functions that operate on the
> flags and refcount field.
> 
> Signed-off-by: Antonio Quartulli <ordex@autistici.org>
> ---


Ehrm, this is wrong (or at least undefined behaviour). Please read C99 6.5.2.3 
point 5

Kind regards,
	Sven
--nextPart7160454.XG3KhJV1Re
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABCgAGBQJOFA8/AAoJEF2HCgfBJntGV04QAKAHShotR0N1ZzmiWdL6yFcD
NOA7jih9SLPVDjyHdzLT1MziQ0CsODndS4RiTppmtULM6dz0xG9XuGR7CycFCS85
gsI1NCPHKtO4/6D3faCQ85KKkLOc8t3d4fANFrQiAlwbxPidPF6vfSIxCbbtrY+m
Jd0H009GDafWbGnd5mnM2lULO5mmeF8pLldHqvDRjHvK9V3n5LC2D+zSiRCichX5
G77QBRiJfLINEUZ7MPALXsXbq3AWRPeG/4dUBrKkZdvH6f4BS6maRbMqf+f1x9Kk
qD/ITQo2LR4MwQ8zMzaYo8llgeuS4s2Xyb0INo/q1W5XjLiArWS6Pfc/PXQdTY11
vLM7pAln7jm3MZKHdG3iH+bcpEPBCi+mip/dxrzC8ZUGQhVHM0hdkUtMLNSTC4X8
JjvRTTFWThlcpo1QWFoHcAJq+qOvqro45Mapv0TzGDGljEfEGL6dmrHJZV8RAHzn
kyJxJjyI60Smzt9V59YHEg6vBcBIyEW+BxRmRcBexjefvBpnSnx0QizyEVq3KSxq
rAIjVoRONJMrUmUq2CcZcA2wExhaWiIesf3RzC3XU8iguAvO0S4TgRRqjIV1bgeG
HgH/cHmv4chGFzZAD9Z1M2J+YVvpPY3kSBskaow19kdKlQeHpDxdCYVRCWDdLWu+
I7gqktk/QbnodTNtZ6yz
=gSzK
-----END PGP SIGNATURE-----

--nextPart7160454.XG3KhJV1Re--


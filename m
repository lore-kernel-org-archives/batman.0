Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Thu, 10 May 2018 16:12:19 +0200
Message-ID: <2686715.pRiCnA5Fud@sven-edge>
In-Reply-To: <fa30c030-a38d-904a-dd2d-a337614460ee@unstable.cc>
References: <20180509190740.11465-1-sven@narfation.org>
 <fa30c030-a38d-904a-dd2d-a337614460ee@unstable.cc>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart3236156.iECjp2MO8i";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH maint v2] batman-adv: Avoid race in TT
 TVLV allocator helper
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

--nextPart3236156.iECjp2MO8i
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Donnerstag, 10. Mai 2018 15:27:34 CEST Antonio Quartulli wrote:
[...]
> > Fixes: 21a57f6e7a3b ("batman-adv: make the TT CRC logic VLAN specific")
> > Signed-off-by: Sven Eckelmann <sven@narfation.org>
> 
> Acked-by: Antonio Quartulli <a@unstable.cc>

Thanks, applied in 286be89a3349 [1].

Kind regards,
	Sven

[1] https://git.open-mesh.org/batman-adv.git/commit/286be89a33497ba9000aa5c2960f1f4114953522
--nextPart3236156.iECjp2MO8i
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAlr0U0MACgkQXYcKB8Em
e0ZdYBAA1jFs6LXLx6Eu+LCvD8rUb2wKSh7+tRb1NuGz/yibzXWXluJBS54NdTff
//I01qEaLqA72tI9+xi1uDPFQRWTZFZPJp+PVP39t1pMavg0lmFK1OrEpby2k6tG
XjvMs1GymHxA6GGn4a9eJsm9Ew1iMoDIKYGUmj4J9Iz+wGnAehmPQ7FUT6cg/30E
QLILHAhE99I0iAeLebQpUk0FWZwnVf8hqebQbYavWcbL9iogy6Mq4CrD2Ro+G8a/
Z4jd1lAUOb3SN87ouzMrSeNWVqzQgGdyt20N6Wqu4iOlqFdzTz2ymYAFOVLrJ18r
qZrgRW3CaIUcKshioE/cdaS+mvz/jOLVCTjFjkTUSWxB6JRQGIl3eGQyY0dvZXZc
OK5dvNpO/zxtUc5rFVkhppRfR8nrWjgvPGSQW/DTODimpg3GTY8hAS8gKySJCVsY
OS/C3+YrltbDncCN0EEcG0oewzWMoS+Sjvae3XnCdJUYrj5948oTPKryo6AI36Y5
tWa+yKhGNI02Om56ysbFC4iJFxAFtcF4hHzAlX9qI9oiRDRBQ9TcqiAq0CGRbZWf
q0mO+if8qOzi0krl2nStAIP306Ly6FzfstTCKMRuqAy7o1Inyt736tMId/JxOuYS
p3Uf9mEHV0S3auYtmCsQwxsr0lxH3ncymtxLbpkcupxX84vheio=
=jCp6
-----END PGP SIGNATURE-----

--nextPart3236156.iECjp2MO8i--




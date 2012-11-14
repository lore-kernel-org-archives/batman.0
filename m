Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Wed, 14 Nov 2012 14:21:49 +0100
Message-ID: <2956255.z7DH3qRPMN@bentobox>
In-Reply-To: <201211142113.37050.lindner_marek@yahoo.de>
References: <1352886828-24651-1-git-send-email-siwu@hrz.tu-chemnitz.de>
 <20121114115907.GA29879@ritirata.org>
 <201211142113.37050.lindner_marek@yahoo.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2355195.eee4oKOR6V";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7Bit
Subject: Re: [B.A.T.M.A.N.] [RFC] batman-adv: pass value in batadv_hash_bytes
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
Cc: Marek Lindner <lindner_marek@yahoo.de>, Simon Wunderlich <siwu@hrz.tu-chemnitz.de>


--nextPart2355195.eee4oKOR6V
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Wednesday 14 November 2012 21:13:36 Marek Lindner wrote:
> On Wednesday, November 14, 2012 19:59:07 Antonio Quartulli wrote:
> >   On Wed, Nov 14, 2012 at 10:53:48 +0100, Simon Wunderlich wrote:
> > > Passing the hash value by reference creates unneeded overhead. Pass by
> > > value instead.
> > > 
> > > 
> > > 
> > > Reported-by: David Miller <davem@davemloft.net>
> > > Signed-off-by: Simon Wunderlich <siwu@hrz.tu-chemnitz.de>
> > 
> > I think this was not meant to be an RFC :-)
> > And I suppose this patch should be applied to next and no to master,
> > because it should be merged with the next pull request.
> 
> Aren't we supposed to remove the inline tag as well ?

Not in the header -- only in the c file

Kind regards,
	Sven
--nextPart2355195.eee4oKOR6V
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAABCgAGBQJQo5rtAAoJEF2HCgfBJntGU8EP/2Gschji/97NjjjrUnv8LX8o
Plx+nGJA1zcRk+ruUYshUrVcZfJ69Enol+HxeFVgien6Y/D9T3Jg4iRD6jD1XtvR
j8ecE02SKqw+k8Da4B9S0LqtWJd2RkVxCvsYCEMt2Nj7zeDfvlgECeQNtX7ph7UQ
zBwaG9IgYINhpRZxIQXwsIvo7VYLMTlNGllo+N4i2FhfRneB0v6mgYoHVmtpYCfW
d6X4oxzx9ib3eLhvopb8W2Z4UI/QmNcGvjHDjVtLVXsHDX8hGOUTITVZ0Iofg77G
FIwFjyqkg2wlsepO9TvyRExcjz+gzgUKrxsB9LZhd4ScLQXh0AA+vRiCXvn8kFCd
+cq4jJs1CmEg6hRPALo6gVGlsTnVeaXpbW+vE0PwlJf8KvE5kEcuEXQqvVsEfQXE
HbWIcIylCdGD38wcGx4BzzTd53DGzs9BmrmgVwxalhdeFviB2ZDEWtd64awX9mWT
DGe2DROurpiJO5+5fMvAW9ayj/4jHAT3meKRlvHkq1u6akTgAlWi2PpWDDbQOE5m
eoX+oh73oNsERILrCeZiEqFiM8VTd9ZEViiBxx+drm9K96EbJsX/HFmOPNbVq9RJ
9FwXszEyHVc3LkLwCL4SqTiiImaNi2IuIX2Npb0f/aQhod3bZk4NFZKuSo4EYutG
jhLyzuI8YNq3/y9Pqcac
=fSLK
-----END PGP SIGNATURE-----

--nextPart2355195.eee4oKOR6V--


Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Subject: Re: [PATCH net] batadv: fix for leaked TVLV handler.
Date: Fri, 24 May 2019 09:56:47 +0200
Message-ID: <3325808.M3JPgbICzP@bentobox>
In-Reply-To: <2234850.c0QxkmldC6@sven-edge>
References: <00000000000017d64c058965f966@google.com>
 <20190521195857.14639-1-jeremy@azazel.net> <2234850.c0QxkmldC6@sven-edge>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart779344695.vhicoALKBS";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
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
Cc: Jeremy Sowden <jeremy@azazel.net>, Marek Lindner <mareklindner@neomailbox.ch>, netdev@vger.kernel.org, syzbot+d454a826e670502484b8@syzkaller.appspotmail.com, Antonio Quartulli <a@unstable.cc>, "David S. Miller" <davem@davemloft.net>

--nextPart779344695.vhicoALKBS
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Tuesday, 21 May 2019 22:48:32 CEST Sven Eckelmann wrote:
> Fixes: 122edaa05940 ("batman-adv: tvlv - convert roaming adv packet to use tvlv unicast packets")

This patch was queued up [1] for submission but it is the only queued patch at 
the moment. And I already saw that David marked this patch as "Under review" 
in patchwork [2]. May I ask whether this means that you (David) would directly 
apply it (unless there are objections)? If so then we could save ourselves an 
extra PR for just this patch. Just depends on what you (David) prefers.

Reviewed-by: Sven Eckelmann <sven@narfation.org>

The only adjustments I personally would like to see when it is applied:

* the Fixes: line
* prefix "batman-adv:" (at least this still seems the one which is usually 
  used for net/batman-adv/ related code)
  But this isn't really a hard  requirement and I also use the shorter 
  "batadv" all the time in other contexts

Kind regards,
	Sven

[1] https://git.open-mesh.org/linux-merge.git/commit/17f78dd1bd624a4dd78ed5db3284a63ee807fcc3
[2] https://patchwork.ozlabs.org/patch/1102982/
--nextPart779344695.vhicoALKBS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAlzno78ACgkQXYcKB8Em
e0aPtw/+O0SulpXspnbKNveVpmmTL9ZVMCnwLGvkY6gxRKk/2Qm8dPsGVlhl9z2A
8CUhfYIoUtDO7fk+9RmezldlK+hvO0FJPDjKKIG2f0XteRBPncnxtnaTRliB87PX
yScD4ivUNQxbO+aYh3rbtWw9aPvjMAcgjS2Vmlf+i8IiXOp9EQVxQ8ffJuDMpBeH
Pc4TThVWBFymceZqjGUSJtiQvm9XXphfEH41sTqWra+HLv/YegHahRrJiBVLzV31
Rtje4Z1ggdQe0OuNeD5S4UrqDOTmCvnOgs4w7j5ts0o0YU3xeYIITClArT+OqkFx
NmZtgXHAO7nhaoc1Xdv+CttngZfvg2MGDp+AS/mhOtDNCdYkDlLFfl1McuOmxXHv
5HnD1/LZnpR+mVNs4kPfqRN3UDU/JF6OGN9XrJKTGxWzvoT4Q71K+OL8MSmrqzzZ
WMeGtgVbHwrV0O+R9P5VDeIqlCnCM0c1t9QVVruhLK1fVghkgyaKEe6+PetWobqW
CGtUGT2/gVVAS6c6bq4RCcVXmGqh66HsbIDvhYgUzRSNRQ7+v78FPuJFcZRNXpcX
RCQCWWmAZSjw30uW2pvRYe7aA/HMJVIY8D4wAnlfddMVhvdXvaVnkUVJYZUswsoF
kcZBHph3OyzKoLzUj9W/ySN1oeYFL/zPx+aeG3STXQs+/i+A2CQ=
=ec3e
-----END PGP SIGNATURE-----

--nextPart779344695.vhicoALKBS--




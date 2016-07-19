Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Tue, 19 Jul 2016 16:42:26 +0800
Message-ID: <1914127.jNGRZROWUb@voltaire>
In-Reply-To: <1468597173-25378-14-git-send-email-sven@narfation.org>
References: <1468597173-25378-1-git-send-email-sven@narfation.org>
 <1468597173-25378-14-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart3993098.BS6uffsGou";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH v2 14/18] batman-adv: Place kref_get for
	softif_vlan near use
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

--nextPart3993098.BS6uffsGou
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Friday, July 15, 2016 17:39:29 Sven Eckelmann wrote:
> It is hard to understand why the refcnt is increased when it isn't done
> near the actual place the new reference is used. So using kref_get right
> before the place which requires the reference and in the same function
> helps to avoid accidental problems causedy incorrect reference counting.
> 
> Signed-off-by: Sven Eckelmann <sven@narfation.org>
> ---
> v2:
>  - split patch based on type
> 
>  net/batman-adv/soft-interface.c | 4 ++++
>  1 file changed, 4 insertions(+)

Applied in revision 67694d5.

Thanks,
Marek

--nextPart3993098.BS6uffsGou
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJXjefyAAoJEFNVTo/uthzAuScH/iNVBYDfhEGc/BiMjJjriggf
wflcX/6JksYrge5hqS0VeLhxZXz/lMrl1a6cel9zs+7bDr869mIQMg0gAqc/s4/e
LKpb/FOxG3wwJF/4HZdMcQYEwvE1KqkUQ35EZTE0VUNTOFz764+I0LNPoQrEttYa
tTlzv72mcsw6ZgHnSN7Wiw+peSrCZpJ1QhKTwe/sTXYaXgkG/oP9TntxhTuSqLvH
uVDl5wa/oNvmr2Hdl2/wLaDYkaZbx6BcveH0oTR4E8TpAMxH2ML6s8Rs+TrTmmAI
bXlS8rh8YIXSVBsF9O1MuuBeBxNROCvLqJm2RYVw27YCHHV4vbZqbdS5EEPS3yc=
=oufF
-----END PGP SIGNATURE-----

--nextPart3993098.BS6uffsGou--


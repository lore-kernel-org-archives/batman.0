Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Thu, 10 Mar 2016 15:58:19 +0100
Message-ID: <1795256.iASzEfpiZA@prime>
In-Reply-To: <1456492768-29861-1-git-send-email-apape@phoenixcontact.com>
References: <1456492768-29861-1-git-send-email-apape@phoenixcontact.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart3376488.G4uuK2VgWY";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCHv2 6/7] batman-adv: bugfix for dat
	optimiziation patch
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

--nextPart3376488.G4uuK2VgWY
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"

On Friday 26 February 2016 14:19:28 Andreas Pape wrote:
> Make sure that claiming of devices due to dat handling is only done
> for non-local mac addresses. As dat is handled after the normal bla
> code this does not break the roaming client scenario for bla.
> 
> Signed-off-by: Andreas Pape <apape@phoenixcontact.com>

I believe this should actually be squashed into your PATCH 1/7? 

But this change is under discussion anyway ...

For future patches, please don't send bugfixes for your own patches within the 
same series separately but squash them in the right patches. :)

Thanks,
     Simon
--nextPart3376488.G4uuK2VgWY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCgAGBQJW4YuMAAoJEKEr45hCkp6hYggP/11/qEApYB6RFLm8Nj4RcLN1
FBlnTc49gARzSQ+W3VZkR7j/KdPOiajo2Vwy9NGCTww6yl5loTeGWgumI8j1ZLxr
gJhBYDvekJZxC7KwfQCgVh07BCI0Dv1AEy6sJIGIaeDP5uCnJuPKWkcah189xJ9F
1qr6yolOmGeXGfFX7lOwOO7wr1qarmRY+J7V69w269U70Hrpea0X6IEQe3oBa+On
VfFOYu/XuUR/51Dh1PbddK5YusFyqFE31A+Syop4uPJQ3iPaMEBt27zJRpu7bQLW
IHHFfggCnAKc6YFvtTBo/MDsoQUZk9tO39whMFdNDashRKAxLvWCjOSNdR5HyErd
Mfdwxbi5IJhHijVSTjYskd/z7t/zI6e8tK04p7zGchmYfauwBZm7zTAJEvyOC8mN
49cydRbvC5MxdPJOebLCCm4RxHt3H6Xpt88w8JepwckAOe8NiC/7T83UlaIFmDal
qKLgG3zZfOQfHu0LBjuF/xIU4hqvsCCmC3PFzzS5BhFeiDj2AAyljPwsBvk4abJj
PIP0odwpEhQ0+YImJEYdyNNJFXS2EzuFNU/APDR4A8wu7Eso1+gzIWOsLK96QVzv
ohPHdMbDSv+JdJBxTmEeus9ZqfNymKVxvfL8fFTAS58RYVfUiqNMgwz6i7SUekZD
/bElN0H+8sPBaWDDjlbm
=JSDj
-----END PGP SIGNATURE-----

--nextPart3376488.G4uuK2VgWY--


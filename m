Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Fri, 01 Jul 2016 15:52:14 +0200
Message-ID: <2959979.HSCOgA5Hin@prime>
In-Reply-To: <1465557064-24406-2-git-send-email-apape@phoenixcontact.com>
References: <1465557064-24406-1-git-send-email-apape@phoenixcontact.com>
 <1465557064-24406-2-git-send-email-apape@phoenixcontact.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart36686078.4EFdiTvbJo";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH v5 1/6] batman-adv: prevent multiple ARP
	replies sent by gateways if dat enbled
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

--nextPart36686078.4EFdiTvbJo
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"

On Friday 10 June 2016 13:10:59 Andreas Pape wrote:
> If dat is enabled it must be made sure that only the backbone gw which has
> claimed the remote destination for the ARP request answers the ARP request
> directly if the MAC address is known due to the local dat table. This
> prevents multiple ARP replies in a common backbone if more than one
> gateway already knows the remote mac searched for in the ARP request.
> 
> Signed-off-by: Andreas Pape <apape@phoenixcontact.com>

Acked-by: Simon Wunderlich <sw@simonwunderlich.de>

Please add my Acked-by on resend.

Thanks!
     Simon
--nextPart36686078.4EFdiTvbJo
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCgAGBQJXdnWOAAoJEKEr45hCkp6hj3wQAJKwzqiSyQVl5oT6mgGGF0hX
oOS28OMsweWCjA8eXvQ2vtk1YJ2mfBKqVGxKKF79GOKVfxm2pxlpsp0SZOYxrCdi
0GYCAQimBFxRc3AyD/2SVKYetzWuQY87uh4zfk+6gQ9Yn1olDKs+WscmSigcqkBV
aFRTJZgSvTjM4bgXpVYOEk9Bgh0s7+Mo/MhUHPH9Hug2RPlNKKWXMSDxIKB4wMGn
thEGeY+3nEHHVA4vpdwPygqgU+m/Ko/3V0X2E4dzyTf1nmBtMN6HUBjGavgG1I39
X29LgipfU2+lh90h10hUgkxBMh4+SQyJ5ffHsvHE5ShJ6DjML79MO9qfy0eU+NxY
ynY8lbJxq5BkS67/sp2uvYFQCmmW+/UC3FCIKT2wZbahS2u1qCeA8UoFskWyO3Qn
jwSla4sBY/FyDVBs3iBYFFvxcl7bKTYWH3JvK91g19Q+E9wvATfzWhOk4QIV2u6l
mxGhbTh8L0Q0VNPWvoxtEPz0xMBrQZlINf6XNqONIGpOeyATcP7bnOKMpl4YWveP
0FtjcDYMWVknpSMzrYGGiBC9QYHYXMfTEqyzJPTStvSaphozw1lUk1sayaCHxgLM
OCSHd6Q21GZ27OrIujm2Kb+UdKPv4jSgqn0eyHGTBqDbRB+n7B1lUPjCWSrlvjZW
JgF2/N9t/YKLIz58Uv96
=cKeY
-----END PGP SIGNATURE-----

--nextPart36686078.4EFdiTvbJo--


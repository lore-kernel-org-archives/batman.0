Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Fri, 18 Mar 2016 13:04:50 +0100
Message-ID: <2088697.nI9sVi8cPN@bentobox>
In-Reply-To: <56EBEDF6.50704@universe-factory.net>
References: <cover.1458231707.git.mschiffer@universe-factory.net>
 <1648365.zDTnRIsh0N@bentobox> <56EBEDF6.50704@universe-factory.net>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart3046901.XybEUyxZmp";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [RFC v2 0/5] batman-adv netlink query API
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: Matthias Schiffer <mschiffer@universe-factory.net>
Cc: b.a.t.m.a.n@lists.open-mesh.org, Antonio Quartulli <a@unstable.cc>

--nextPart3046901.XybEUyxZmp
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Friday 18 March 2016 13:00:54 Matthias Schiffer wrote:
[...]
> > What about the "socket" file?
[...]
> 
> Ah, I forgot about that one because it is very different from the others.
> 
> I think it should be possible to convert "socket" as well by wrapping the
> BATADV_ICMP packets in netlink packets. Or maybe it would be possible to
> drop that altogether and just do ping/traceroute in userspace with
> AF_PACKET or similar?

The latter could be problematic for TP meter implementation [1,2,3,4,5].
Antonio, do you have an opinion about that?

Kind regards,
	Sven

[1] https://patchwork.open-mesh.org/patch/15807/
[2] https://patchwork.open-mesh.org/patch/15808/
[3] https://patchwork.open-mesh.org/patch/15809/
[4] https://patchwork.open-mesh.org/patch/15810/
[5] https://patchwork.open-mesh.org/patch/15811/

--nextPart3046901.XybEUyxZmp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCgAGBQJW6+7iAAoJEF2HCgfBJntGM2wP/1gnkEtEpFJaYnT32BKiwRa4
WsjJwNTVV/Ar/YlFoifCM+gpoPkmimr/Cq5cVXokXsTDWyeLvu5ylPou0nzYTljP
0t+4v8LfuCLPsnYm6e5MOv4KbDewiR5wYllebbt6wEfX/S5n6nWQSC45i4+g7BAs
bcLXOCO1NiUTZw0YHQYm+UBWCgYy1NCPnBiSHC8vhOFBHGSKjaYTXrX5VwlZFd0l
NrLOA2LliZhhgcfA+bsVlaAgXSECDAKocLFghbiP65Bs1NiXJL0UL10XQpFp0hhe
JNHKEpFKjXFfxaRrb38zrfS3tJgZb1pXNkGADazdqOMGFc2VNLmhSfNk5+LcDIM+
3BbpfTeTnRptcwdxY1wZ3p4mLnFUGel5pouO5r43eqOto3QAhlHnzO3guBOWS1b2
pEBohaW/pdn8feTuQQC+IG6oHCC4h/3MSzhYD8u0GzNxflWMviKSSPwhBf9Wt8sy
C6lAHISWcvwFGV1PP2C5ei5FedsiXKu+AK9CUX/8FOoz3/w5NSQE+jX9Wydyivr5
WKgsp3nYWbDUidKO53t9DVjhmtcbcpREC2n0theh/Ui2H0b4VWf99vk7ty8QLTA/
h2sIG5Qztz57c1FN0BWNMKjal9shtjzH4WTBtY2dh9nizETlboxOvu+V/UhGIGb3
Kzwc+2MbhelUNP2Gslt1
=9hAL
-----END PGP SIGNATURE-----

--nextPart3046901.XybEUyxZmp--


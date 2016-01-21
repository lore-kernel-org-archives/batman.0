Return-Path: <sven@open-mesh.com>
From: Sven Eckelmann <sven@open-mesh.com>
Date: Thu, 21 Jan 2016 15:03:10 +0100
Message-ID: <1664897.xQoZSmslHn@bentobox>
In-Reply-To: <56A0E335.8040207@openwrt.org>
References: <8047297.0qIFjkW2bL@voltaire> <4178376.2Vigxs1Xtt@bentobox>
 <56A0E335.8040207@openwrt.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1945014.Aq5KYOeGMn";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] OpenWrt cfg80211.h station_info incompatibility
	with kernel+mac80211 [was: B.A.T.M.A.N. V leaves the nest v2]
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: Felix Fietkau <nbd@openwrt.org>
Cc: openwrt-devel@lists.openwrt.org, b.a.t.m.a.n@lists.open-mesh.org, Marek Lindner <mareklindner@neomailbox.ch>

--nextPart1945014.Aq5KYOeGMn
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Thursday 21 January 2016 14:55:01 Felix Fietkau wrote:
> > @Felix, would it be ok for you when I propose a
> > "*-sync-cfg80211-station_info.patch" for the 3.18 generic kernel patches?
> > Or do you have a good idea how to force the openwrt-routing batman-adv package
> > against the cfg80211.h of compat-wireless?
> The openwrt mac80211 package exports its headers to
> $(STAGING_DIR)/usr/include/mac80211
> 
> You could just make the batman-adv package use those includes.

Thanks, missed that. I will prepare a pull request for openwrt-routing.

Regards,
	Sven
--nextPart1945014.Aq5KYOeGMn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCgAGBQJWoOUfAAoJEF2HCgfBJntGHOUQAKyNdWX/brBsjPCd4oyel7Cw
wOi01MDu5Z1uqfcT4xawKr3qpW83KD/zmcO6mO2W75CA+LTASduWzYAMHUGKpdY7
2W3OW8YiSaNKDq/RKVeuGNlt6mR4Gon/zxTVCm4G+Aqp8iGv7ZGk7Qs3Zfs2vd46
gs6QJDl/IRAIU53EODbXhps1XVxZhVeApKsyZh91rJY8fsu+fUDyTyk/PCMiVCRU
aRDfXwqseznK1GQfd/s9/YjzOrSMNMZ8ZljTY+Idaauu25zn2prxvEnYgJNE29Yy
Vsks8sGF27Brc0OubhJeLDxfeas/5jzkdA1zUjHqRljy7UsqXY71A+2n6cEGnOxY
AbPpbwRgkMiyaSy8/Jt8pYNXRYlzlzChsNf63GA7tsocOBXwXIGGI2YhY/X7NQDQ
dkbp71UV4wmK7ZUnJBOcUvAxpB0nSgfLBTh/zHSYaEW2Ly7GdVj5+9FqjKxcTTBK
CZ26uhNyVso/xDtLB5M6lMRiIOOpJp7QjLr3EXaKqs6fiKUXD9xGyKeW0wTf7q/x
3KU1pxZDxUNS1u6NSLPLn17sQY6vaLQMnUbvgtdBrHFhYawrIkqDuxL2WlFVhUwT
5pJDvEsl7T/cMhhq5BpCy7rTU6+CrCx0pSjZU/zfB7inon2fBGzGBTQnIqS+Ii0U
GwfW8yyo8pceisLJuUC6
=Dcz/
-----END PGP SIGNATURE-----

--nextPart1945014.Aq5KYOeGMn--


Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Wed, 06 Jun 2012 14:37:57 +0200
Message-ID: <6725381.buXcpkeOMp@bentobox>
In-Reply-To: <!&!AAAAAAAAAAAYAAAAAAAAAOJK0u4CH31Kl5v1RPAzyrZCgQAAEAAAAF6fjKGT24hLtxfi+jpGMQMBAAAAAA==@gmail.com>
References: <!&!AAAAAAAAAAAYAAAAAAAAAOJK0u4CH31Kl5v1RPAzyrZCgQAAEAAAAPvMiqao58dPrVwIXxeghf4BAAAAAA==@gmail.com>
	<1794568.t7tZJ9NAC6@bentobox>
	<!&!AAAAAAAAAAAYAAAAAAAAAOJK0u4CH31Kl5v1RPAzyrZCgQAAEAAAAF6fjKGT24hLtxfi+jpGMQMBAAAAAA==@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart12905318.DfrBZUfb2k";
	micalg="pgp-sha512"; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7Bit
Subject: Re: [B.A.T.M.A.N.] bridging problem
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
To: Walter Robert Ditzler <ditwal001@gmail.com>
Cc: b.a.t.m.a.n@lists.open-mesh.org


--nextPart12905318.DfrBZUfb2k
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Wednesday 06 June 2012 14:26:12 Walter Robert Ditzler wrote:
> 
> (with nl80211)
> ***
> root@srv-ldeb-basic1:/etc/hostapd# hostapd hostapd.conf
> Configuration file: hostapd.conf
> ioctl[SIOCSIFFLAGS]: Name not unique on network
> nl80211 driver initialization failed.
> ELOOP: remaining socket: sock=5 eloop_data=0x9141a30 user_data=(nil)
> handler=0x80863e0
> root@srv-ldeb-basic1:/etc/hostapd#
> ***


You must make sure that each Vif/VAP device has a different mac address.

sudo ifconfig wlan0 down hw ether 02:34:56:78:9a:bc up

Kind regards,
	Sven
--nextPart12905318.DfrBZUfb2k
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAABCgAGBQJPz08lAAoJEF2HCgfBJntG6EAP/2ac+jVrfM7clIRpuYFLLOFf
4mQxQVghoLSvq7XAVWrlpwqW9C3e3xeg/qMNFqtme0orBOg/UoXiipM/rhM2iujp
DlwN5JiZ5IktX5OVmqql8UEjMINEqKo+hU2pafn525+rgIZT9Dg+gW9A3EBTqeYL
PAF1FCViiSVg+8LmxICsHO9RlX4NcsTX03ZsR35IAI/zpoYWq8Rx6qDQZgla1cYY
6aj6U33lW+a7752yXStB28M3ICGJaeGlZ/QTwYLI+glevEl6FOZU70/FYG6B3l1x
GZAKMWGUFbfA/jlagR1I+F93NU+8MWs1aWaemwqL13eYBd311pD3xsAdzkIDA4Zu
DmDMBdH94A83lUdTCMi2hS8Rnoih461FrrPBjeIdWzvsIdkOXgdBlD3utXDTVpXx
0uJbim6knB9EBf/1UqDzyzfVPcbGFIv15jwBnNZzJpBJoxrZNc4LGFlGs4BDrvHb
nkwoF4DmZTHdcDO0YtK/dn/LJ1bbANJU25hCw1/qMANACXTp2bvauz8teejSwGGc
5KOxHEKYCyk+P6r+cqkOqbbm2bFDVrdNX6eoscprnkpuNGVCFDk7YQ3qkvOPB6c6
Lbc/O6tFLfSqeVUgqHHlXox7XYQjZ8jipQD5aaN3drbDLYhHVdc07UNDmIBUGcXR
dLxAe00gGU15UnMczlw3
=0xQB
-----END PGP SIGNATURE-----

--nextPart12905318.DfrBZUfb2k--


Return-Path: <b.a.t.m.a.n-bounces@lists.open-mesh.org>
From: Sven Eckelmann <sven@narfation.org>
Subject: Re: BATMAN-adv Debug options
Date: Wed, 24 Jun 2020 23:32:16 +0200
Message-ID: <1986026.lAXmxmQttu@sven-edge>
In-Reply-To: <CADg1mwL07UQqmUctQexAFCgFMrXBiF=rB1EdRqb3agveSEkckQ@mail.gmail.com>
References: <CADg1mwL07UQqmUctQexAFCgFMrXBiF=rB1EdRqb3agveSEkckQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart4150699.2y9b4eNgFs"; micalg="pgp-sha512"; protocol="application/pgp-signature"
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n.lists.open-mesh.org>
List-Archive: <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Mark Birss <markbirss@gmail.com>

 
--nextPart4150699.2y9b4eNgFs
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Wednesday, 24 June 2020 23:13:50 CEST Mark Birss wrote:
> What other debug  information are available to troubleshoot connection issues?

The first question you have to answer: Is the lower layer working or did the 
lower layer break? Can be tested easily with multicast/broadcast and unicast 
pings on the lower device. Don't assume that the driver/firmware didn't break 
the connection because you see entries in the originator table. And also don't 
assume that the link is working just because you've only tested unicast 
packets on the lower device. WiFi drivers/firmware started to only partially 
(and "accidentally") kill links for only unicast OR for broadcast.

> I have enabled for OpenWRT
> echo "CONFIG_BATMAN_ADV_DEBUG=y" >> .config
> echo "CONFIG_BATMAN_ADV_DEBUGFS=y" >> .config
> echo "CONFIG_BATMAN_ADV_BLA=y" >> .config
> echo "CONFIG_BATMAN_ADV_DAT=y" >> .config
> echo "CONFIG_BATMAN_ADV_MCAST=y" >> .config
> echo "CONFIG_BATMAN_ADV_NC=n" >> .config
> echo "CONFIG_BATMAN_ADV_BATMAN_V=y" >> .config
> echo "CONFIG_BATMAN_ADV_SYSFS=y" >> .config
> echo "CONFIG_BATMAN_ADV_TRACING=y" >> .config
> 
> 
> echo 255 > /sys/class/net/bat0/mesh/log_level
> cat /sys/kernel/debug/batman_adv/bat0/log

Seems about right from the batman-adv perspective. Of course, also check the 
originator/neighbor and local/global translation tables. Use this information 
to check whether the packets are routed correctly through the lower 
interfaces. Just use tools like (batctl) tcpdump to capture this traffic. You 
can also use a recent wireshark to dissect pcaps from the lower interfaces.

You could also start to trace packets using trace-cmd and similar tools to 
figure out where your packets end up inside the kernel.

> since i want to understand also why on wifi mesh seems to crash for me ath10k

I've heard multiple persons complain in recent months about stability problems
of ath10k. So maybe it is the same problem here. But unfortunately, I don't 
have more information than various threads [1] on this mailing list.

Kind regards,
	Sven

[1] https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/thread/PZK7RS5CACYDJIW4SH7R6UF7BIQI5OYR/#LZX2PNOX3FLG6L4D3WLRZYEULKD5IEF5
--nextPart4150699.2y9b4eNgFs
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAl7zxmAACgkQXYcKB8Em
e0ZntxAAlGnt2X+KRtP29tc6NskFy1GA+vDUzItC4X7iJpL6mI6FUiAwNcdecGCN
F9o/biIEiNV7D4400iqsaWJCdlRZkUuoDiRAbut1hCArO+zs0xS+E/u3LvgAm0hX
k9+F3Tg1mxcaxc6L5WpiUVexZXbDCFvwBlqB9GzMgBm6gkhKkjfOeJODqNFTff8F
bibUf2MrGOOXJo0ZkJPmWlp7oc1COgx95AswToFhD+tXJLKWWhaOs2ioRDVugjsu
OYhj1fRHUCAd71hJNbz0x+czxJxudgYUyKRSCxqsD3RvT16x/0bK8t5XEB1ImDd+
UmynpSbssXW96WmT/is3fHaC09dPqFW/uIFCY4NlFEHk9ktkmtMHNA3zHafq9i/I
UeMLjqG0RxN9Iz1DWUDg2X0rYFb9mcm/rcXYjNmwf6yptrEPOzVoU2rT9R/aVoko
z5kozHdiAN6SSpssHe3IaTn8dRd+QlL66QaYf9H5ll6ma64Txo6hsD3i9Wog58VD
8xOm6gSdzUSQrWwpJ1nd2boFNJHu0w8RaQUaQ/MATSSXNoaKQcfwBl+TYmIhXEWQ
SY1YCoHMg49r4qb8lz68JGdIjFrZIC3ziiYUYgwu1gJmacq0SwRoMDPg4i4NBfju
ZFLf2A2RsjM2ZUPAp308TBFep8AxbjukVt5EfXxLyyAtIjye0qM=
=Mohr
-----END PGP SIGNATURE-----

--nextPart4150699.2y9b4eNgFs--



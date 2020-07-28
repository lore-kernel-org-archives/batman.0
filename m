Return-Path: <b.a.t.m.a.n-bounces@lists.open-mesh.org>
From: Sven Eckelmann <sven@narfation.org>
Subject: Re: batadv gw_mode client 0?
Date: Tue, 28 Jul 2020 07:06:06 +0200
Message-ID: <1997151.jcLF785M7x@sven-edge>
In-Reply-To: <1C0C87FF-C97B-4118-BCC6-DF1163BAB05F@xecoenergy.com>
References: <927533E5-C265-44BF-B271-1A7A9A084447@xecoenergy.com> <3573996.TXEB8fxZsQ@sven-edge> <1C0C87FF-C97B-4118-BCC6-DF1163BAB05F@xecoenergy.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2164744.kCo4vZI0ly"; micalg="pgp-sha512"; protocol="application/pgp-signature"
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n.lists.open-mesh.org>
List-Archive: <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>
To: Rob Cowart <rob.cowart@xecoenergy.com>
Cc: b.a.t.m.a.n@lists.open-mesh.org

 
--nextPart2164744.kCo4vZI0ly
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Tuesday, 28 July 2020 01:07:09 CEST Rob Cowart wrote:
> So we have a new problem.  In BATMAN 2018 logging worked, but on BATMAN 2019 it doesn't - should I update to 2020?

What does this have to do with gw_mode client 0? At least you posted in the 
thread [0] with the subject "batadv gw_mode client 0". And you mail also has
the subject "batadv gw_mode client 0"

And please stop posting HTML messages [1]

> pi@raspberrypi:~ $ sudo batctl -v
> batctl 2019.4-1-g6046cf9 [batman-adv: 2019.4-9-g890c6748-dirty]
[...]
> pi@raspberrypi:~ $ sudo batctl log
> Error - no valid command or debug table specified: log

The log command was removed from batctl on purpose [2]. Please either get the 
data via trace-cmd [3] or build your batman-adv with DEBUGFS support and 
manually fetch the data from the deprecated log file
/sys/kernel/debug/batman_adv/log (tail -f, cat, ...).

Kind regards,
	Sven

[0] https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/thread/FG4ZGHSHFHISJUKZ4XQH56ACBV4ASSSZ/
[1] https://www.open-mesh.org/projects/open-mesh/wiki/MailingList
[2] https://www.open-mesh.org/news/90
[3] https://www.open-mesh.org/projects/batman-adv/wiki/Understand-your-batman-adv-network#Logging

--nextPart2164744.kCo4vZI0ly
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAl8fsj4ACgkQXYcKB8Em
e0Y9pw//WQJ66nnTjYN4hFlEuWKC+gdIobNsrDCdh3P2EXHk7IcvPgsv4VGgRKhQ
C2BB9smwKD5EpQFJF+OJOdUfhIOKo2a/b6uDwy+UgSzQviiqmXnxJibgwOZo2B0S
sv+YxoV4995gmBqRsumTb6Q0L1LQA6ZQf5On3YlM1bsMYa7dL+AtnIJAmpE328hf
GabrIn0O88zvPX7xKvAA8muCmZcYgnjvNScOUD/kBGCS+r2rGrWYbN7A3GXg7P0L
jiKWAiR+GK21OdvkdJXSPAS3MjJLGztORlD4oUefOs+zG4yqjVU7adfAH5rnf+IG
7IWP5AHIcTAzqoIy0EH0oF/UFPnOnYFsrdRPUdUxR2m4T0fGwaMBjgWKNIO4Z47/
uqKfLQjJtt/pngtb8QWIG82PwG8gH2byR2ShUVCJWHMEVDjF+lB56t5tOjO6PX7g
JA0Yzr7PENLB2SGv5FE092mM1bgy4MHpbjAaAYF2fKNeEm4ymeWq+Z10AuCkmalz
B8I9Mh/AyShSOdZ801K0wXnMCd/dSmSTiiVchJch//bnutJl5dliLjcSkmiSzXBt
CcY7nPuz/sD89Dy2bbzk+9aI2nTVriXIOnujBNx5yUctuxMM/bwLWJYXr6mG3bgM
0ed7EKyJv7OQXlUPokpeVy41q6lFi83Itna0Xbs4j+dGOUtI8jM=
=wEV+
-----END PGP SIGNATURE-----

--nextPart2164744.kCo4vZI0ly--



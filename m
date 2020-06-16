Return-Path: <b.a.t.m.a.n-bounces@lists.open-mesh.org>
From: Sven Eckelmann <sven@narfation.org>
Subject: Re: batadv gw_mode client 0?
Date: Tue, 16 Jun 2020 09:01:26 +0200
Message-ID: <20687769.zqcOZmODRP@bentobox>
In-Reply-To: <927533E5-C265-44BF-B271-1A7A9A084447@xecoenergy.com>
References: <927533E5-C265-44BF-B271-1A7A9A084447@xecoenergy.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2296441.xZy9kG0TSa"; micalg="pgp-sha512"; protocol="application/pgp-signature"
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n.lists.open-mesh.org>
List-Archive: <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Rob Cowart <rob.cowart@xecoenergy.com>

 
--nextPart2296441.xZy9kG0TSa
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Monday, 15 June 2020 22:45:34 CEST Rob Cowart wrote:
[...]
>but something we found was all of our nodes were using gw_mode client 0, and we realized this isn't listed in the spec.  Do you know what it does in that case, does it use the default of 20?

I have no idea where "client 0" is coming from. This is not a valid output 
from batctl or the sysfs files. I must now assume that 0 refers to the 
selection class.

selection class 0 is not valid for B.A.T.M.A.N. IV and will also be rejected 
by the netlink and sysfs code for B.A.T.M.A.N. IV.

If you were really able to set this somehow(tm) then it should (mis)behave 
like gw class 2 (when I remember correctly).

Kind regards,
	Sven
--nextPart2296441.xZy9kG0TSa
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAl7obkYACgkQXYcKB8Em
e0a4ohAAzqUmDvAgRpboRv8EmErgohKe7CR9uBX78RzfX9If6uUkqoqPIPTljdAh
Cb1U8yKLaCbyFk2v3IW56UV822IXcUUQwAArIy/7X+d41s671CdLWDzfj1tVP523
xqVwiqAKsBG63QDlQ53Qxj9l3m+lVMM4VYHbgOqDMBxXDEp+FANvWe9rU1v2SRIw
+GgwmpfkSq2vHDMSSmO6thEzVr8QVZ0OH0cPVoU5X+gVkFRGV031m+TAk9eNWnrI
Jr8qSxGukBw+J6VXG+JjIcOimDJ4Bq0Wv0nr+0CPIn00pgBlv2v3W4aQ+ojoRAKc
5xsjh27PXqDwIJfmPxd3qdiujhHCJ8EKY58b7BZGQblLn85dN9NLKtJlQS4WdGnS
9GT8kTMrxmELT2qfxh2LJrDCUNeKXe0c15/lxdfjXAKqXWzdkTrcrFf3843hOHL0
4QRm5oRNsY8yfbIreKLhYGAdmwxgbn9np4h4WqM/fNo2cFFTsKBn09eMY8auBn7g
jgbPk1+w5UfViH8xfPkwD6KAHDwY6DDQhNBM1s464QjuVE2mSONoeO5UrzS6p21D
2rxhggklWCyHRfeHVZ7b8Y7IRa/ak7IXsO0KmOrLu86J6ZRswASVBzh3n3hstx/f
NX7sVNNWbDQ2EKqowrEHKv7o1AGzdrIbUC8/vkpj0DJjpmJSac0=
=TTtX
-----END PGP SIGNATURE-----

--nextPart2296441.xZy9kG0TSa--



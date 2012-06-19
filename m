Return-Path: <ben@decadent.org.uk>
Message-ID: <1340107811.6871.32.camel@deadeye.wl.decadent.org.uk>
From: Ben Hutchings <ben@decadent.org.uk>
Date: Tue, 19 Jun 2012 13:10:11 +0100
In-Reply-To: <2579267.utmNKQaN8a@bentobox>
References: <1340090430-356-1-git-send-email-ordex@autistici.org>
	<1371147.SQlum5V1iP@bentobox>
	<20120619.020227.393422018169766346.davem@davemloft.net>
	<2579267.utmNKQaN8a@bentobox>
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-WaC3Xt2s7nAEaSbBZm05"
Mime-Version: 1.0
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: fix skb->data assignment
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
To: Sven Eckelmann <sven@narfation.org>
Cc: stable@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org, David Miller <davem@davemloft.net>


--=-WaC3Xt2s7nAEaSbBZm05
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2012-06-19 at 11:51 +0200, Sven Eckelmann wrote:
> On Tuesday 19 June 2012 02:02:27 David Miller wrote:
> [....]
> > Patches you want to end up in -stable should be submitted for 'net'
> > not 'net-next'.
> >=20
> > There is no other valid submission scheme.
>=20
> I know that. This is also completely right and not contested by me. I did=
 not=20
> submit/create the pull request and don't want to talk about that part too=
=20
> much. At least I am not very good in speaking for other people and don't =
want=20
> to create more hiccups than I already caused :)
>=20
> The part that was more interesting for me is the backporting (+ submissio=
n of=20
> these patches) or annotation to which kernel that patch should be backpor=
ted.=20
> The stable_kernel_rules.txt gives a nice overview about how to say which =
other=20
> patches should be cherry-picked to get this fix applied. But we could als=
o=20
> have the problem with kernel version that are not obvious (since the patc=
h=20
> doesn't apply directly on that version) and a backported patch is a bette=
r=20
> choice than cherry-picking many other things.
>=20
> Is it correct as Antonio did it (submitting more than one patch, but with=
 a=20
> special "# 3.x" for each one after the Cc: )?
[...]

There's not much sense in a 'cc' if you're sending a new message (the
backport) specificaly to stable.  Instead, use a subject like
'[PATCH 3.x] original commit summary'.  You do need to make clear that
this is a backport and not just a request to cherry-pick the upstream
commit.

Also, you should wait and send it after the original goes upstream,
because stable maintainers will usually want to either apply or reject
immediately rather than storing things up.  Greg's scripts will tell you
when this happens, or at least when he next checks.

Ben.

--=20
Ben Hutchings
If more than one person is responsible for a bug, no one is at fault.

--=-WaC3Xt2s7nAEaSbBZm05
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIVAwUAT+BsI+e/yOyVhhEJAQpLzg//Vvb4sLPB9abZFIdyiNrc6DzYVcE0Vcfk
YbqKzja/UtObprY70p68atUs5PZInLKf/wACo314o+Zg+wH7hqHnjJY9L3ff8cyK
pqkLBgPOIfa8izFWgFiViSR0ghL/SzQZUQL2Gu40SHXKmb8pDjRqTnrlpADIwGKP
Ol6FwXf7f+MFpUk10KvjX8k6zNRGd4be/FO9AFXpxw1ebeiAdPXU2xRmF/MWUId2
R3pTolRWlM9o1/gNlLc4da2FctA99krGzIwJaghOugd1I02tZP0EZBR0H8/0IZ/K
OvFhM8PxbbmClbcwtpcbJe/3jDbDJdKoPbCD687ysVt+VtYs9YSeMTPCVf36W8PA
s8lDxhJya7MD1Mzgg1WKWIZamgoA4sHmtxMu2bAV2jd029z7agBSnxw/NeB4Y0bf
uckDazRG2ucvV7pOGJsvnh1dkQJt/jBHkSWxj48s7cdwCi32ApIf2Bu9LtY3uOVb
ahli6Yz0H3LTAHLVsHGfX65el6rtIlZYJ2zPFV4QYR1grrpObc3iIQcSkj9ebRPE
2QJlHlShtA3qfUjcBHrQimxTxnRrhAaD5ga/fYnetbKqThR7zWkW3JeV9TGqjjnV
QWbxw8jfgjrATtPuUtwMM6Jt8jrAbXtvhux28JlVrkB/MxIvlqpKsQC+oSg1VvIi
FRifFlL81qg=
=bw/U
-----END PGP SIGNATURE-----

--=-WaC3Xt2s7nAEaSbBZm05--

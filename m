Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sun, 06 Nov 2011 20:37:53 +0100
Message-ID: <2996120.ojn5ldFmOZ@sven-laptop.home.narfation.org>
In-Reply-To: <CAKeC-QG96YqJ7pygkcALZPfTYe7406DEx0GZqwh4GT6Ye1azpw@mail.gmail.com>
References: <CAKeC-QFhm8CgyT8HwGqPwtS=E2g_2Haq3bUK2p+GZnppnwUBgQ@mail.gmail.com>
	<201111070127.27769.lindner_marek@yahoo.de>
	<CAKeC-QG96YqJ7pygkcALZPfTYe7406DEx0GZqwh4GT6Ye1azpw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1823072.VEjg5IETC9";
	micalg="pgp-sha512"; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7Bit
Subject: Re: [B.A.T.M.A.N.] MTU issue
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
To: b.a.t.m.a.n@lists.open-mesh.org


--nextPart1823072.VEjg5IETC9
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="ISO-8859-1"

On Sunday 06 November 2011 20:05:23 Wayne Abroue wrote:
[...]
> To answer your first question, Sorry for the confusion, When I tried a
> trunk on a new UBNT , a few weeks ago I got the no comms result, so I
> promptly compiled with Backfire and all was well.
> 
> However , a member of the VT-DEV list has the same problem while
> trying to run from precompiled  trunk, on a new tp-link wr703 unit.
> 
> Unfortunately the wr703 is only supported on trunk, so with the
> pre-compiled version he gets the same results I had.

We are currently a little bit confused about your mail. It doesn't provide a 
good view on the actual problematic. There are small chunks of information 
here and there, but nothing which could help us to understand what it going 
on. Also references are only made as "somebody else said something" and not as 
link or citation. This makes it quite hard for us to help you.

So what we would need is a clear and consistent description:
 * what hardware/software is used?
 * what are the versions/revisions of everything (including branch
   informations)?
 * how looks the hardware (including network infrastructure) configuration?
 * how looks the software configuration?
 * can it be reproduced with the newest version? (include enough information
   to define "newest version")
 * do you know a version where it works and what is this version?
 * what tests did you use?
 * what result did you expect?
 * what was the actual result of the test?
 * when a workaround is known: what exact steps are necessary to work around
   the problem?
 * ...

Please also provide relevant information from the batman-adv debug(fs) 
interface [1] and packet dumps (please be aware that only relevant parts are 
interesting and that we have a limit of 200 KiB for mails).

Be aware that pre-compiled trunk of openwrt doesn't mean that you get the 
newest stuff in trunk or anything stable at all.

> I took this to be related, But if a patch is out, I reckon the only
> way is to   build from a new svn update to solve?

I cannot give a good answer to this question, but it would be a good idea to 
test the patches for batman-adv 2011.3.1 that are integrated in the openwrt 
trunk since r28779 [2].

Kind regards,
	Sven

[1] http://www.open-mesh.org/wiki/batman-adv/Understand-your-batman-adv-
network
[2] https://dev.openwrt.org/changeset/28575/packages/net/batman-adv

--nextPart1823072.VEjg5IETC9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABCgAGBQJOtuIRAAoJEF2HCgfBJntGh5sQAJfaHcKs/x18AVC67y8SuJdk
lkxr5JeR9QEWfVhNxWeNh0/vR05YqhDrO5QTpaOfmi6meOcPLqUXYLX6v56rR/yJ
qoBrJVHPr6dYDEXDpTzZIojGOxscIeBDIUyv9WnDRN6MhZ+2uc4oGa67M4PzkwoE
B5wTMnT7cjQII+ZkIGnvs6z5yeIGkRnE9jCnbn3+pGh4CzWEMl58xzlJUy2rzCeb
w9N+bgX46rQotcyD3bRDx5IL8SyXAc8cykfd+F+981uYVpn1VAd2nN9a7L6nZSKN
bOut4m4++4rf0APR72eD9imV4dwhgu0avUQaseuM+vD5JhZCb5s8JWBEGKflGQW9
bfDLRiVwPVbyAP9TGdIxW2AUDq4undllikA/9rmh5+3m+Vu0VjrQRixKrEE67lfH
wKn3HRLoJ9UM+DqJLYSp2mswAyFq6T3GvReAG8+I5WFshekbb39CBzuRoe2fE+gC
SkBodlY4PEJOMspkT00P/H+uZOc4QeLfBivN1oCBP6HMouKsAOXPm2MiT3etA0gl
za6lb+lm6QNmgHn59JBj6ChkfMyyeM0W2ud5WHxjAcCdJTtG5fdDbDqjo6t+6usK
cxJcISstZT3nQsMU+1hFu59tdoVFkhlm5OAWFJbeqddRcnfDtnQX31UjYTn1Cv7Z
wvW2BZ10/E6Twt0ryA+Y
=sByu
-----END PGP SIGNATURE-----

--nextPart1823072.VEjg5IETC9--


Return-Path: <linus.luessing@web.de>
Date: Sat, 20 Mar 2010 10:36:15 +0100
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@web.de>
Message-ID: <20100320093615.GA3753@Linus-Debian>
References: <1269055908-20369-1-git-send-email-linus.luessing@web.de>
	<1269055908-20369-2-git-send-email-linus.luessing@web.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="DocE+STaALJfprDB"
Content-Disposition: inline
In-Reply-To: <1269055908-20369-2-git-send-email-linus.luessing@web.de>
Sender: linus.luessing@web.de
Subject: Re: [B.A.T.M.A.N.] [PATCH 2/2] batman-adv: Fix aggregation
	direct-link bug
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


--DocE+STaALJfprDB
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

And there are two more things I'm wondering about:
- Why should primary interface OGMs from a different originator
  which already travelled over 49 hops not be aggregated to other
  primary interface OGMs?
- Why should secondary interface OGMs from neighbours not be
  aggregated on our own, neighboring secondary interface OGMs?
As far as I can tell, those two combinations are not being
aggregated at the moment. Is there a reason why they shouldn't?

Cheers, Linus

--DocE+STaALJfprDB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQIcBAEBAgAGBQJLpJcOAAoJEBKw7u43QNpfeJsP/j8YINV7BTDepNwuroc4mdLq
uHur3BI7Lk6WMs/JvmxbttajMrWfhEud8a+sS88CTs95RTRTXgvhsva2WxLLCBHX
BE+Dn7TV05g302bEDqYvLc9Mo4FMj44YjCrv3+qXSIuxvQfKKNvb2u9ZEQQ3oAgK
tKElNJBt3fBPuRTb/gvwkxe7ykjiVvite2IJ9JILaGYPlULr9BYhYrB4AQ8W/Npj
QSpg74PrQPwDXC1XQ+wxH/nBLTSB28q0+yU5pwABEqNbmVDNpi/7qPLd9ZFASVEP
liCFXQreImSAVKfhLsPvY2jdJiRlPxsz4YIVtBwLUL5ramjF8os8dh8tiwMXKn9i
qt8Ja1zh3Vo36Uda2JBcUtenUkJaMgOcBkM8ScELvjJ6jgqZWDe2vglBARLMbFlv
FxO/M+PUzdAppRaQ9t1SUsT+nLVJkX7sxKhXSsBa8AZ/AcIr2UM/opiOQW02PejC
zw0rPtBLNrl73BB8atoUkXCIMDFi0x/KNeGC1rKYzZManCflDK4ttqa+ng4ITwAc
gewimaZF8O1dqcRmSW08jpimMW2ijJ/WwjsLxoa5WFF8FSVN8XXiv0zQF0yciVNp
bAfSC82KhapZ9t6NmLC8JWY5kisYQHA0kqnsoCjV5IadW4U6gRIAOwaF333rmP2j
yGpLoGPMXFYyC50pdLnm
=4hCK
-----END PGP SIGNATURE-----

--DocE+STaALJfprDB--

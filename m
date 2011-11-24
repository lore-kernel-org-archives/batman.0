Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Thu, 24 Nov 2011 15:38:02 +0100
Message-ID: <3164615.DFmizAk306@sven-laptop.home.narfation.org>
In-Reply-To: <CAG7VhQSf-YN5wQA0iuAQa3LqDkKFb=j1f5QfqsNuDVZWeehDYQ@mail.gmail.com>
References: <1322139961-12706-1-git-send-email-daniele.furlan@gmail.com>
	<1848153.OCba6IfGej@sven-laptop.home.narfation.org>
	<CAG7VhQSf-YN5wQA0iuAQa3LqDkKFb=j1f5QfqsNuDVZWeehDYQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2624892.yj8LHp4AyI";
	micalg="pgp-sha512"; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7Bit
Subject: Re: [B.A.T.M.A.N.] [PATCH] Remove useless condition
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
To: Daniele Furlan <daniele.furlan@gmail.com>
Cc: b.a.t.m.a.n@lists.open-mesh.org


--nextPart2624892.yj8LHp4AyI
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="ISO-8859-1"

On Thursday 24 November 2011 15:25:40 Daniele Furlan wrote:
> 2011/11/24 Sven Eckelmann <sven@narfation.org>:
> > On Thursday 24 November 2011 14:06:01 Daniele Furlan wrote:
> >> ---
> > 
> > What do you think about some information, reasoning, examples,....
> 
> Ok, using letter a,b,c,k instead of:
> 
> c = total_count
> a = neigh_rq_count
> b = orig_eq_count
> k = TQ_LOCAL_BIDRECT_SEND_MINIMUM

what about l = TQ_LOCAL_BIDRECT_RECV_MINIMUM?

> 
> then the code do the following:
> 
> c = min (a,b)
> and then check this condition:
> (c<k OR a<k)

no, it compares (c<k || a<l)

[snip]
Wrong proof using wrong assumptions. You just cannot say that 
TQ_LOCAL_BIDRECT_SEND_MINIMUM has always the same value as 
TQ_LOCAL_BIDRECT_RECV_MINIMUM just because it is in this particular example.

And just as reminder: Such things belong in the commit message.

Kind regards,
	Sven
--nextPart2624892.yj8LHp4AyI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABCgAGBQJOzlbKAAoJEF2HCgfBJntGmq0QAJWjcdUT9r73DnS5DR///GmD
QRmfQDG44651PcT1DbsiHm289IL5DXNWbauW6+BOxedbY0UMFSnv6XRKEDW+HivJ
HW3FzXiv4s8jsiNxKxBUE7LliW9OlsapmI72vLRtw/lyvwkdblpN3HO6fCtfJ25z
emMIZTVVMAGNBLUg0XwIIF40J7G8VCq+XFAA6qYcCqmrxHSpg5DgLclZfjFrhlKV
lFPlinYmDmvlITsspwcuMq4ckHtNTdA0PZ1uq0a3wiWS6xrprF+3fSaxHWEULRUn
j7iS6BF7hkCJF5gZ7aI72Mzxci8u9bcyzMrmsrb02xPTiUIfoYS2oB60XCKAmf3a
RKZ1Or8WhCjPU9fZWF4bzhBKOIsCzgvzpJBDlY8gOLQnBqk0Ls5iwI0Kq9A0R2Xe
2m2IzkFdI39CnS5GrT8fSsRJsVqUGnMxPYgAoDrezTodIi0ID9251n4aLy1LcR2l
0mXmzW46jqm/JHutATRn30jwOMw218tR1cSIFuxtuYg5w9qR9CI97e3KfcnvxAiB
Lp8So94sJAh8cqm/VMZewLXnBGCGo3aqwHCa+cGDOu62YQQ1WNUPHUFJ0dz+TlCE
Lqey8KdzwqMPdk/zU3J1kDDOuL1MORlB5ejMfPq7oszlAtsqmgtqLRrjNShS5TpP
4+DlxO1OT9ieD0PwZWqh
=+D6N
-----END PGP SIGNATURE-----

--nextPart2624892.yj8LHp4AyI--


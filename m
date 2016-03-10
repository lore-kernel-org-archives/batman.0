Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Thu, 10 Mar 2016 18:53:02 +0100
Message-ID: <9529699.VdKDay9AJr@bentobox>
In-Reply-To: <1383809091-3887-1-git-send-email-antonio@meshcoding.com>
References: <1383809091-3887-1-git-send-email-antonio@meshcoding.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart3020562.zQs9lr46ud";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: use static string for table
	headers
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Antonio Quartulli <a@unstable.cc>

--nextPart3020562.zQs9lr46ud
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Thursday 07 November 2013 08:24:51 Antonio Quartulli wrote:
> Use a static string when showing table headers rather then
> a nonsense parametric one with fixed arguments.
> 
> It is easier to grep and it does not need to be recomputed
> at runtime each time.
> 
> Reported-by: Joe Perches <joe@perches.com>
> Signed-off-by: Antonio Quartulli <antonio@meshcoding.com>
> ---

It looks like this patch doesn't apply anymore. Can you please resent it or
mark it correctly in patchwork [1].

Thanks,
        Sven

[1] https://patchwork.open-mesh.org/patch/3599/

--nextPart3020562.zQs9lr46ud
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCgAGBQJW4bR+AAoJEF2HCgfBJntGAtcQAKTBMO0eAvCwjP7fhBveTcza
fXZR5iWnjaASdwyd8jsCmJE8v1nxIdmngEGux0x9PtI97uk51X30h3fmjOKIomk9
qv1XbqZSwR2tWiqg8A9yxp+n+kLhyJLVr/zKLdzBslZ5lDKDMeAm7dimXij9Avp2
HipvKWd/2VXyOb9+4ddcGOghyUd8dmJCa5IlbpUZP8+mBI8wBw76W0SWAz9aY1nd
0NyqurtyloNpjcxZg/sw9ZjGXLnOXc/XnphnMdUUE56/8Xui1GgyImvGCdI411UV
LZ4v7S9E4223NMevpyyGjHN9cFVxNaeheRuWKIJ8JI5GxCkG0TKFaRL06xPTfKRI
KGw9s4Hw2pZfIvXVS0Ize6UVw5fQG80lmGaBDS5mL9K2Vl05kPJ6cIf5e+LILX6I
yZWfZh4qj1+EOYz4EVtSQFoBv7yjtXThfIttOrL3arSXCDh//hMyqH9aa6lCSRQv
sj3R+nL6ageXAK4E2/Wfbv97DqUYmQd3VmKCoOZTRLSY1HSMqJ+gEnDvT8eNmE8w
lMypGNQN+fkCj4CEvKtnGM/UMNVBWFznahmhRa1mYxt0O+UOs65RlfsKb1pErdj8
6q1lurSpi0NZzA2BI1ldbutKa4aph/084oFvJYirqQCNTP7eTVUn0a7+zkMSWY8V
eHTNak/N/3PRnU3tTtqr
=QmNm
-----END PGP SIGNATURE-----

--nextPart3020562.zQs9lr46ud--


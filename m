Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Mon, 27 Jan 2014 14:22:02 +0800
Message-ID: <4624683.mBIvnjSfqg@diderot>
In-Reply-To: <1389037044-27530-3-git-send-email-sven@narfation.org>
References: <6312194.LhI8hzXjyH@bentobox>
 <1389037044-27530-1-git-send-email-sven@narfation.org>
 <1389037044-27530-3-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart5751195.q11qrElokV";
 micalg="pgp-sha1"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH 3/3] batctl: Use libnl to implement vlan
	parent device resolver
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n@lists.open-mesh.org>
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
Cc: Sven Eckelmann <sven@narfation.org>


--nextPart5751195.q11qrElokV
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Monday 06 January 2014 20:37:24 Sven Eckelmann wrote:
> It is not necessary to have code duplicated which is already available in
> libraries like libnl-3.0 or libnl-tiny. This is done to reduce maintenance
> and security risks.
> 
> Signed-off-by: Sven Eckelmann <sven@narfation.org>
> ---
>  functions.c | 274
> ++++++++++++++++++++++++------------------------------------ 1 file
> changed, 110 insertions(+), 164 deletions(-)

Applied in revision b8eaea8.

Thanks,
Marek

--nextPart5751195.q11qrElokV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQEcBAABAgAGBQJS5fsOAAoJEFNVTo/uthzAH0IIAJMGD4TK4wIpCBM2NR6VK9Uz
ZRlRlkllUI4Vq+CObVs8V1DTQ9hTw/a9IYVbWOJsWcn8kxN/TTqHfUgcL+7WDqoE
6mkdKn07IUEQm+LK1kqIXe+eoRAH4Hd/1yuMZuezm4eDbYiheZGAM+92VjkL4ZRE
jGb2hYNIVdOQt69B4sd3WoEbB5c3dkGY5QY4vvqe8o33e6SCqfowX1eLgRmqBhT+
5csFBsdDsytlMvTAMwqzUCga1VJLI8303Muj5nASAmaSkvf4LehkYJTLnyAgg1kv
JSO3Xshmmi46jfctEEe4nM/mH4h0zogiT2ZBPqznmFY/T1aAU5cRPTUX1FSXRtg=
=QX24
-----END PGP SIGNATURE-----

--nextPart5751195.q11qrElokV--


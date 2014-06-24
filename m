Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Tue, 24 Jun 2014 23:31:14 +0800
Message-ID: <30521554.OoFrEXheTJ@diderot>
In-Reply-To: <1403000163-8148-1-git-send-email-sw@simonwunderlich.de>
References: <1403000163-8148-1-git-send-email-sw@simonwunderlich.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart4898667.KPlocqWRq1";
 micalg="pgp-sha1"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: increase default hop penalty
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
Cc: Simon Wunderlich <simon@open-mesh.com>


--nextPart4898667.KPlocqWRq1
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Tuesday 17 June 2014 12:16:03 Simon Wunderlich wrote:
> From: Simon Wunderlich <simon@open-mesh.com>
> 
> The default hop penalty is currently set to 15, which is applied like
> that for multi interface devices (e.g. dual band APs). Single band
> devices will still use an effective penalty of 30 (hop penalty + wifi
> penalty).
> 
> After receiving reports of too long paths in mesh networks with dual
> band APs which were fixed by increasing the hop penalty, we'd like to
> suggest to increase that default value in the default setting as well.
> We've evaluated that increase in a handful of medium sized mesh
> networks (5-20 nodes) with single and dual band devices, with changes
> for the better (shorter routes, higher throughput) or no change at all.
> 
> This patch changes the hop penalty to 30, which will give an effective
> penalty of 60 on single band devices (hop penalty + wifi penalty).
> 
> Signed-off-by: Simon Wunderlich <simon@open-mesh.com>
> ---
>  soft-interface.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied in revision 7644650.

Thanks,
Marek

--nextPart4898667.KPlocqWRq1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABAgAGBQJTqZnCAAoJEFNVTo/uthzASeAH/2sHx9MHRw+VBhR1UjKJZ2Z+
e6wt//xhjpBHrSCqHVXeq6sqMk8pQa2zCbZRhoDB8RtZh2dqp3Rch4Mw9D3hXOY4
Lu+5KUeaJb1pzZ8xSdU6k0k5Yy3CjlajkE/dkD0RZYHmnZ1KSMGYTgPoBq1d8Srl
f1j8qwRnoyoMPBG/5tg3xncni80+aEKji9ZY/w+xp8a9gAsZVMYBVLoB8p9b7S4a
UJNKH+B4krxFSKD6YTJbnGSyU4CVgxgJrmPvMNTZvNiYXFU6DXqrPVjG9AvRmsHL
I/xqT/O1zbiqrp+k4vrKkDNp1dGx7DiMtuAO/GcSceCr78G1GLFHaNv7xu2lG0w=
=hq7/
-----END PGP SIGNATURE-----

--nextPart4898667.KPlocqWRq1--


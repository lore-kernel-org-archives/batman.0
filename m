Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Mon, 20 Apr 2015 14:12:12 +0200
Message-ID: <7605822.cxC5KnHP44@bentobox>
In-Reply-To: <5534EB7E.2060809@meshcoding.com>
References: <13114664.Eg4ODy7KEo@bentobox> <28031511.vQmOOoKVTs@voltaire>
 <5534EB7E.2060809@meshcoding.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1687697.a61UiaMTR0";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH-next 0/6] Patches for batman-adv 2015.0
	release
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
To: Antonio Quartulli <antonio@meshcoding.com>
Cc: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>, Marek Lindner <mareklindner@neomailbox.ch>


--nextPart1687697.a61UiaMTR0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Monday 20 April 2015 14:05:18 Antonio Quartulli wrote:
> On 20/04/15 08:30, Marek Lindner wrote:
> > I hope Antonio is going to shed some light on the question whether that
> > patch made it upstream or not. Depending on that question we can pick the
> > appropriate solution.
> 
> This patch was never sent upstream, probably because it looked like some
> change made for "compat.* only" and therefore it got accidentally discarded.
> 
> By the way, when I created this patch I thought that the name of the
> function was supposed to match the type of the object to free because I
> observed a compilation failure - this is why I created this change.
> 
> But if this is not really required then I am ok with Sven's patch.

Ok, also thought that this was the reason why this patch was never sent
upstream/should not be sent upstream.

Can you also check the "weird" patch which is in the release since 2014.2.0
but doesn't seem to be in net-next.git/linux.git?

http://git.open-mesh.org/batman-adv.git/commit/31f391475cc08724e96ab060ef4aa6503d11da8e

Thanks,
	Sven
--nextPart1687697.a61UiaMTR0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCgAGBQJVNO0fAAoJEF2HCgfBJntGl6QQANk4e8Zgf8j8dnhXYKtrMHnV
3uqdX9l6jr/O1OymOLxEINGklwmIouAWTddkH2Y0qSKbuwJC7MP35IRpntExQjt1
1s460oWGpoopflMhWKbTuAEV8xQG5BJK+CN6YNINtH7W/kIyJPAfrcupZJe/Inmo
mWUd7oU0QTKZ5qXSh2hzwL/E7+xVtDohIYwl/ou8AHjsDD+MfgewNEVzbjBVe1Jy
Fp1ZIy0Fc6YILXg54NtrDMJcNiWksUsn/TPlxfpyUEwfh/jMlfZlsWTAgiehcpla
p8PcrfiUaTG28FUm1O717eKlnJMmm2IONv31XGx2RRdJx3mhsbA5rdRNbpk8QSAq
Xrm8Qve6TmSEYSLB2F+PAgbAvtAXrEmD5K6ItztAz3bCNzWOtEtflhXLzQSbzLwp
4Pg/i6Ec6UALCFOPAH+K6K/IUwtUdH5gKpuN+bP06mZ2PnNMTXYQfz0GQhSjbZ1B
tnqlUpKJX5X33gKIv7/rXrYNKEb0oAzlYFj+eesz3DUmfu2LFO3ZpQ4sY7wQTUMS
KUfpIzOePW+1QUNplqI1W0Y7FQfx4yf3pFmLxi0+PlEzT+vCYC8u4/GNI1kJZRPx
bijyTQAguuwG0fA615lN3n5l3Jj4JPloCr+YvvJUjBZBmiV4i8cxMYiWQFadEZXb
y1BYYJpKueak1/SCEE/G
=iGKi
-----END PGP SIGNATURE-----

--nextPart1687697.a61UiaMTR0--


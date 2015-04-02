Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Thu, 02 Apr 2015 08:39:32 +0200
Message-ID: <4593170.BoRA6mpdPI@sven-edge>
In-Reply-To: <20150401215302.GA25434@vostro>
References: <20150401171821.GA21008@vostro> <1834234.ImvpviMFU3@sven-edge>
 <20150401215302.GA25434@vostro>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart5830065.sTdFWDhpqk";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] musl build fixes
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
To: Alex Suykov <alex.suykov@gmail.com>
Cc: b.a.t.m.a.n@lists.open-mesh.org


--nextPart5830065.sTdFWDhpqk
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Thursday 02 April 2015 00:53:02 Alex Suykov wrote:
> Wed, Apr 01, 2015 at 10:02:14PM +0200, Sven Eckelmann wrote:
> > The linux/if_ether.h -> netinet/if_ether.h seems to be understandable (but
> > rather unfortunate).
> > 
> > I am  not sure why why you include linux/types.h to the different source
> > files. Most likely because this include should actually be in packet.h as
> > mentioned in
> > 
> >  https://lists.open-mesh.org/pipermail/b.a.t.m.a.n/2015-March/012930.html
> >  https://lists.open-mesh.org/pipermail/b.a.t.m.a.n/2015-March/012942.html
> 
> I assume any changes in packet.h must be done in batman-adv first, then
> ported to batctl, and preferably not the other way around.
> And since I was only concerned with batctl, I saw packet.h as read-only.

Yes, this is the preferable way to modify packet.h. I was asking to understand
if these are needed for something else which I may have missed.

Maybe you can remove the type.h stuff and ask to get it queued in after my
patches are in. At least if this would work

> Moving linux/types.h to packet.h does make sense I think.
> However, it also brings linux/if_ether.h there, which immediately
> makes musl support difficult. Maybe even impractical.

The maintainers rejected the use of __KERNEL__ checks when Markus Pargmann
wanted to use them [1]. So I may have to modify my patch to move bitops and
if_ether.h back to main.h. Maybe you can try to modify your packet.h as seen
in the new version of "[PATCHv3 2/4] batman-adv: Add required to includes to
all files" which I will send in some minutes. Would be nice when this version
+ your linux/if_ether.h -> netinet/if_ether.h would work with musl.

> I'm not saying that's wrong, because I'm not trying to say batctl needs
> musl support in the first place. Just another point to consider.

We can at least try to get support in. But when we have two problems to solve
then it may takes some more rounds and extra discussion :)

Kind regards,
	Sven

[1] https://lists.open-mesh.org/pipermail/b.a.t.m.a.n/2014-December/012699.html
--nextPart5830065.sTdFWDhpqk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCgAGBQJVHOQnAAoJEF2HCgfBJntGAHQQAJNL7RdsiHGdbRz48rZbDJgx
NqMf5FWZGas4F6a3giagF1DBYs9w6ezQ0yEhE+F/1iQGiRkzh1pVzs5ZQGnMfHJc
NiZdQxIvyLLeyQezaTIuMMEIoE0guopDoKz+rGUUQ9s7MwDE/w7MCJ0XvBZH7aGz
HrK0m3M0We+UsBcT0bCwZuJ7yl0yt9qLjhu/bjhsM7aiL9CYgq3hZOH531BurLBS
fqiah1gd+5FPSSU15WJXKKMps/xp1/PUdBLw0sanl/adfNdjG7XSu++deOrvooxr
xdOr3SwQt8/tJ4N2X4f/iifRh5kbx+upeTDA5VabXzihnDuBXNQWKzQCL8UNKC4w
jnUglVqj8MfA/BD/XflVT7hp+zhlqXPPOjSDrnKrGQaZqPVuLD79N2CJGDQIA5vG
QSTzgH4No0v1wjlmiSuo2DOBUgR32ln/bDlhTJZF0YsEnFeen7jeLu037SAiUm9p
V5DSOPl8GQkDOb5nUgGdfSmVB0cFxpiPL0yCIJq5LmmwRct2KhZ4D2Ef4XrJfhea
gjePig73ByICOK89uXuAo59TieNplXixb48f38bN1Se6J9owVz/Ut5rl3w6iRIAu
fL3mh0bg0BGUl6VABZyaZH4bP+EmRZ0tuCEg60f8SOpuD8Minp/8vt4f9r18cqaf
CDeH/0obNItqCfwihq0R
=vWYJ
-----END PGP SIGNATURE-----

--nextPart5830065.sTdFWDhpqk--


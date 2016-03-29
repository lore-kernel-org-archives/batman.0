Return-Path: <are@lihas.de>
Date: Tue, 29 Mar 2016 19:59:57 +0200
From: Adrian Reyer <are@lihas.de>
Message-ID: <20160329175957.GA6539@r2d2.s.lihas.de>
Reply-To: b.a.t.m.a.n@lists.open-mesh.org
References: <56F5AF2F.6060904@t-online.de> <20160328235247.GA4528@otheros>
 <20160329083717.GA32035@r2d2.s.lihas.de>
 <3883397.RfpiZdWGix@bentobox>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="wac7ysb48OaltWcw"
Content-Disposition: inline
In-Reply-To: <3883397.RfpiZdWGix@bentobox>
Subject: Re: [B.A.T.M.A.N.] No rebroadcast on mesh links
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: Sven Eckelmann <sven@narfation.org>
Cc: b.a.t.m.a.n@lists.open-mesh.org


--wac7ysb48OaltWcw
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 29, 2016 at 11:50:47AM +0200, Sven Eckelmann wrote:
> We still need at least one person interested in this patch who rebases the
> patch and resubmit its with a convincing commit message.

Well, I am a system administrator, no kernel developer. I have limited
knowledg about C and verious version control systems. If noone else is
willing to do it, I can try.

> It would also be interesting if it should be a simple flag or some if
> exporting the num_bcasts via $something would be sufficient. Or if the
> num_bcasts should be split into num_bcasts_otherif and
> num_bcasts_sameif and then exported.

It is two different things, the num_bcasts in my understanding is about
how many times the originator sends out its packets to assume everyone
has received it.
The flag we talk about is about if anyone receiving that packet on an
interface has to send it out on that very interface at all, e.g. it is
about everyone reachable via that interface sees the same neighbours
(e.g. switch) or a different group (e.g. wlan adhoc)

> Just keep in mind that this "flag" may has to be kept there until the end
> of time. So if there is a need for a new setting then it should at least
> be discussed if this is done right and not that someone else needs to add
> additional things shortly after it reached the Linux kernel.

Well, someone *might* want to be able to adjust the num_bcasts. However,
this is a different thing and neither adressed in that patch, nor a
problem I think that needs to be addressed as it seems the automatism does
a reasonable decent job here.

Regards,
	Adrian
--=20
LiHAS - Adrian Reyer - Hessenwiesenstra=C3=9Fe 10 - D-70565 Stuttgart
Fon: +49 (7 11) 78 28 50 90 - Fax:  +49 (7 11) 78 28 50 91
Mail: lihas@lihas.de - Web: http://lihas.de
Linux, Netzwerke, Consulting & Support - USt-ID: DE 227 816 626 Stuttgart

--wac7ysb48OaltWcw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQEUAwUBVvrCnXn8862ZCBs9AQL/4Af3Qz/Ykqlcdf3WaEutiOSNthnlzmp3aASF
qQ3Xn9CyvmdIeRmyWtHxkG17EqWVx3Q17wwIyoyb5iN0GqtWxw1RlS5sDIrvLfgr
mH4IPd/Dhz12mwLW3k2qoNNDn6NibpbK2nQ1sX78+Zj2Eu8EgRiHGjLWZzMhoGCC
3JS76MQBHRcRyprkoWz3Ru/FdiVPuYze+ReB+7wbY8cX+GFArIifwkE2mQQdmVj0
WU7PK3AYWBRqnP0ce3Neu6asdBAYdcCGXDl9jUR/4Di4D8bwu8v5zX9QG2wvJwMQ
yG3oN5FBtxNnWdZX2zXYElbfESdvYzMBYrK6ygKuFC1OZxVubFSH
=aWYI
-----END PGP SIGNATURE-----

--wac7ysb48OaltWcw--

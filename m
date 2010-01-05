Return-Path: <linus.luessing@web.de>
Date: Tue, 5 Jan 2010 05:20:58 +0100
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@web.de>
Message-ID: <20100105042058.GA3102@Linus-Debian>
References: <20091231033752.GA18781@Sellars>
	<201001030326.02365.lindner_marek@yahoo.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="envbJBWh7q8WU6mo"
Content-Disposition: inline
In-Reply-To: <201001030326.02365.lindner_marek@yahoo.de>
Sender: linus.luessing@web.de
Subject: Re: [B.A.T.M.A.N.] [PATCH 1/3] batman-adv: atomic variable for
 vis-srv activation
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.net>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.net>
List-Unsubscribe: <https://lists.open-mesh.net/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.net/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.net>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=help>
List-Subscribe: <https://lists.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.net>


--envbJBWh7q8WU6mo
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jan 03, 2010 at 03:26:02AM +0800, Marek Lindner wrote:
>=20
> Hi,
>=20
> > This fixes the bug discovered by Marek which did not allow turning on
> > the vis-server before an interface has been added. This is now being
> > done in a similar way as for (de)activating the aggregation mode with an
> > atomic variable.
>=20
> great that you work on this!  :)
>=20
> I'm no expert on the vis code but here my 2 cents:
> * You hard-coded integer values instead of using the existing defines. An=
y=20
> reason for that ?
Hmm, so far we are having too modes only, vis server being enabled
or disabled. But in those packet functions we are talking about
types (two ones only so far again) instead. In the second one I found it
ok to use the defines, but for the proc.c switching, I found a
simple 0 or 1 more intuitive, as you already know that this
function is for enabling/disabling the vis server and you don't
have to wonder about a certain vis-types field in the vis-packet
format. Hmm, I'm also wondering, are there any plans for
introducing other vis_types? (What would you think about changing
the 8 bits vis_type field to flags instead?)
> * my_vis_info->packet.vis_type never gets updated ?
Damn it, you are right :). I assume, that it'd be ok to remove the default
value being set in vis_init and explicitly setting this field
every time a new vis packet gets generated in generate_vis_packet()
(instead of updating this variable from proc.c too)?
> * This patch removes functionality from the /proc parsing function althou=
gh=20
> this is not related to the patch-topic.
Yes, sorry, you're right I'd removed the
server/client/enabled/disabled things and added just 0/1 as input
values for proc to make the syntax similar to the aggregation
stuff and simple in general for the kernel module. I'm going to put
that in a seperate patch.
> * checkpatch reports 8 errors & 8 warnings
Ehm, just got 1 error at the else part... (sorry, never used
checkpatch before, hope that I'm not handling it wrong in any
way...)
>=20
> Regards,
> Marek
> _______________________________________________
> B.A.T.M.A.N mailing list
> B.A.T.M.A.N@lists.open-mesh.net
> https://lists.open-mesh.net/mm/listinfo/b.a.t.m.a.n
>=20

--envbJBWh7q8WU6mo
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQIcBAEBAgAGBQJLQr4qAAoJEBKw7u43QNpf4ScQAJCPLAgTaOWkdYFuQ4arYpHx
0QNGe9F7eWqH0lC7ogo3PEBqVa+xpMzN0EVUp3ZWfGyz9hVDKZQBWp19KOjdRs8+
Rr2XtMPbMf8J5x336D3clOsNJCY4yL84iH/GKBa9q11/VD5/N386eRY2doienudo
8KryvKIMM60Po5VlxhY++kNo+V066EoyQ8U6voM0Bud6feACZ+aeErWQ+i6I7V73
7ymdDTVjsnenJYAgajEhm57+CidSvGAqAh6CqcuQsDHii2N35zYbcJycK0cSzOFA
0hBG1Lq4zVtUKYFn87YZHVS8Z2ItU/1oP8WxKvdceZabtUH8a7xSUTRYxOdvTidI
4PZggRM0f6in0I94RuK6VmO8sjfbXZeC3z6OombPNteLWCGKThjODXrHX98xEu23
v5xpv1ECenjYlPSIWKHFjl7XQlUepWtFYQPCeNq1jYz9Tv9QNFEorhGfmAYYqleZ
LThCuC4qVtH8H1V1amge14YIGITgeDo9BD5LbP2TIcRuhWVHYgObfHa6rVVOcV6f
Yz478RFsuy4Kvz2P6t4ZLUJUYBfniUDY/Lj8Z5y2PBqeuRpJbGfilbdmYygsTCUG
BZDPS1yQSx7pGzkLmk2I8q4KA6l5bmddOksd1ire/aMRvIPnpeezFZAggeBpi0Yd
etUYRgCIhTykONm9oC+d
=kDLj
-----END PGP SIGNATURE-----

--envbJBWh7q8WU6mo--

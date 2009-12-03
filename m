Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Thu, 3 Dec 2009 10:45:40 +0800
References: <20091203002407.GA10048@Linus-Debian>
In-Reply-To: <20091203002407.GA10048@Linus-Debian>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Message-Id: <200912031045.40789.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH] Updating orig_str for debug
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

On Thursday 03 December 2009 08:24:07 Linus L=FCssing wrote:
> In commit 1488 the orig_str has been removed from
> purge_orig_neighbours(). Apparently, this breaks compilation when
> enabling debug-flags, as bat_dbg() is expecting this variable as a
> parameter. Actually, this variable has never been initialised also
> before commit 1488 (which was probably the reason for mistakenly
> removing it).
> This tiny patch adds the orig_str again, but initialises it now as
> well.
>=20
> Signed-off-by: Linus L=FCssing <linus.luessing@web.de>

Thanks for your patch - I just applied it.
By the way, it was a bit troublesome - somehow patch did not like your emai=
l.=20
I got malformed patch error messages. Not sure what the issue is.

Regards,
Marek

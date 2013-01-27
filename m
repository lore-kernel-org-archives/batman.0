Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Sun, 27 Jan 2013 13:26:43 +0800
References: <1358118740-10458-1-git-send-email-martin@hundeboll.net>
 <1358119232-14781-1-git-send-email-martin@hundeboll.net>
 <20130116055904.GB5243@ritirata.org>
In-Reply-To: <20130116055904.GB5243@ritirata.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Message-Id: <201301271326.43961.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCHv3] batman-adv: Return reason for failure
	in batadv_check_unicast_packet()
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
Cc: Martin =?iso-8859-15?q?Hundeb=F8ll?= <martin@hundeboll.net>

On Wednesday, January 16, 2013 14:01:07 Antonio Quartulli wrote:
>   On Mon, Jan 14, 2013 at 12:20:32AM +0100, Martin Hundeb=F8ll wrote:
> > batadv_check_unicast_packet() is changed to return a value based on the
> > reason to drop the packet, which will be useful information for
> > future users of batadv_check_unicast_packet().
> >
> > ---
> >
> > v2:
> >  * Changed return values to defined error codes.
> >  * Send as separate patch
> >=20
> >
> > v3:
> >  * Fixed typo in kernel doc
> >=20
> >
> > Signed-off-by: Martin Hundeb=F8ll <martin@hundeboll.net>
>=20
> uhm...This signed-off should be part of the commit message.
> But other than this this:
>=20
> Acked-by: Antonio Quartulli <ordex@autistici.org>

Applied in revision ff41008.

Thanks,
Marek

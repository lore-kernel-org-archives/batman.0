Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Tue, 20 Mar 2012 13:53:54 +0100
References: <1331830115-16407-1-git-send-email-ordex@autistici.org>
	<20120315172157.GE2990@ritirata.org>
In-Reply-To: <20120315172157.GE2990@ritirata.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Message-Id: <201203201353.54516.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: add BAT_UNICAST_4ADDR
	handler in the packet-handlers array
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
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

On Thursday, March 15, 2012 18:21:58 Antonio Quartulli wrote:
> On Thu, Mar 15, 2012 at 05:48:35PM +0100, Antonio Quartulli wrote:
> > Commit 1887248c268928ebb434edab611978f51e2a4b8f introduced the
> > packet-handlers array but it forgot to set a proper handler for the
> > BAT_UNICAST_4ADDR packet type. This patch fixes it.
> >
> >=20
> >
> > Signed-off-by: Antonio Quartulli <ordex@autistici.org>
>=20
> Sorry, but I forgot to say that this bug has been:
>=20
> Reported-By: Martin Hundeb=F8ll <martin@hundeboll.net>

Applied in revision 7de96f5.

Thanks,
Marek

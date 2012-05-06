Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Sun, 6 May 2012 20:22:26 +0800
References: <1335984651-15385-1-git-send-email-martin@hundeboll.net>
	<1336032907-5215-1-git-send-email-martin@hundeboll.net>
In-Reply-To: <1336032907-5215-1-git-send-email-martin@hundeboll.net>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Message-Id: <201205062022.26545.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [[PATCHv2]] batman-adv: Change "make install"
	path and run depmod
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

On Thursday, May 03, 2012 16:15:07 Martin Hundeb=C3=B8ll wrote:
> Currently, when installing the out-of-tree module on distributions that
> use gzipped modules, batman-adv.ko will be installed next to
> batman-adv.ko.gz, which is selected by kmod.
>=20
> By changing the install path to
> /lib/modules/`uname -r`/updates/net/batman-adv/
> and running "depmod -ae", we make the newly installed module used by
> kmod.

Applied in revision 515bdd0.

Thanks,
Marek

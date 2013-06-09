Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Sun, 9 Jun 2013 12:05:49 +0800
References: <1369583768-15280-1-git-send-email-linus.luessing@web.de>
In-Reply-To: <1369583768-15280-1-git-send-email-linus.luessing@web.de>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Message-Id: <201306091205.49780.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCHv2] batman-adv: Add dummy soft-interface
	rx mode handler
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

On Sunday, May 26, 2013 23:56:07 Linus L=C3=BCssing wrote:
> We do not actually need to set any rx filters for the virtual batman
> soft interface. However a dummy handler enables a user to set static
> multicast listeners for instance.
>=20
> Signed-off-by: Linus L=C3=BCssing <linus.luessing@web.de>
> ---
> * Fixes issue #171
>=20
> v2: added kernel doc
>=20
>  soft-interface.c |   13 +++++++++++++
>  1 file changed, 13 insertions(+)

Applied in revision 1cfaca7.

Thanks,
Marek

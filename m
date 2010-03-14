Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Mon, 15 Mar 2010 01:51:40 +0800
References: <201003122009.02956.sven.eckelmann@gmx.de>
	<1268581588-5153-1-git-send-email-linus.luessing@web.de>
In-Reply-To: <1268581588-5153-1-git-send-email-linus.luessing@web.de>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Message-Id: <201003150151.41143.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: Fixing wrap-around bug in vis
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

On Sunday 14 March 2010 23:46:28 Linus L=C3=BCssing wrote:
> When the seqno for a vis packet had a wrap around from i.e. 255 to 0,
> add_packet() would falsely claim the older packet with the seqno 255 as
> newer as the one with the seqno of 0 and would therefore ignore the new
> packet. This happens with all following vis packets until the old vis
> packet expires after 180 seconds timeout. This patch fixes this issue
> and gets rid of these highly undesired 3min. breaks for the vis-server.

Applied in rev 1597.

Thanks,
Marek

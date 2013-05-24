Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Fri, 24 May 2013 17:33:22 +0800
References: <1369382549-8787-1-git-send-email-linus.luessing@web.de>
In-Reply-To: <1369382549-8787-1-git-send-email-linus.luessing@web.de>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Message-Id: <201305241733.22283.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] Basic Multicast Optimizations
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
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>


Hi,

On Friday, May 24, 2013 16:02:25 Linus L=C3=BCssing wrote:
> * for_each_pmc_rcu() was not moved to a commen net header file,
> only a TODO was added. Will do that after this code might have
> landed in net.

we discussed this further and concluded that we can't simply make that=20
decision. The order in which patches are going to be merged into net has to=
 be=20
decided by David Miller. So, please prepare a patch destined for net, send =
it=20
to netdev (cc the batman ml if you like) to explain what we are planning to=
 do=20
and ask for advice.

Cheers,
Marek

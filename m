Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Sat, 20 Nov 2010 21:04:53 +0100
References: <201011170226.09739.lindner_marek@yahoo.de>
	<1289957194-5455-1-git-send-email-lindner_marek@yahoo.de>
	<20101120182701.GA16511@Sellars>
In-Reply-To: <20101120182701.GA16511@Sellars>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Message-Id: <201011202104.54322.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH 1/8] batman-adv: protect neighbor nodes
	with reference counters
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

On Saturday 20 November 2010 19:27:01 Linus L=C3=BCssing wrote:
> I guess you meant "kref_put(&neigh_node_tmp,... instead of
> neigh_node (without tmp) here, as neigh_node_tmp won't be used anymore, n=
ot
> neigh_node, right? Otherwise it also does not seem to make sense to first
> increase the refcount and then decreasing it right again after the
> additional check.

Yes, you are right. I'll fix that.

Thanks,
Marek

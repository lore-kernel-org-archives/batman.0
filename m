Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Mon, 25 Oct 2010 14:44:37 +0200
References: <clang@gateworks.com>
	<1287988488-10533-1-git-send-email-clang@gateworks.com>
In-Reply-To: <1287988488-10533-1-git-send-email-clang@gateworks.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201010251444.38251.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: Re-Enable Interface
	alternating and bonding
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

On Monday 25 October 2010 08:34:48 Chris Lang wrote:
> r1765 incidentally disabled bonding of packets first entering the
> mesh along with also disabling interface alternating regardless
> of where the packet came from. This re-enables these options.

Wow - what a catch! :-)
We might have to reword your commit message to get your patch accepted by the 
Linux stable maintainers. I offer to do the job if you don't mind.

Cheers,
Marek

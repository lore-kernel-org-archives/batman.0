Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Sat, 23 Oct 2010 03:41:15 +0200
References: <1286626600-23439-1-git-send-email-sven.eckelmann@gmx.de>
In-Reply-To: <1286626600-23439-1-git-send-email-sven.eckelmann@gmx.de>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201010230341.15802.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] Polishing of the hash implementation
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

On Saturday 09 October 2010 14:16:35 Sven Eckelmann wrote:
> David S. Miller wasn't amused[1] by our hash implementation. Instead he
> proposed some changes we should make. I tried to implement most of them,
> but don't think we should really manually inline every functionality
> currently provided by the hash implementation. I would rather keep the
> heavily used functions as compiler inlineable functions and do the rest
> using standard kernel hlist_*.

Applied in revision 1838-1842.

Thanks,
Marek

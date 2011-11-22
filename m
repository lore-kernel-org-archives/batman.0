Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Tue, 22 Nov 2011 18:22:14 +0800
References: <1321800459-15975-1-git-send-email-sven@narfation.org>
	<1321800459-15975-2-git-send-email-sven@narfation.org>
In-Reply-To: <1321800459-15975-2-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201111221822.14777.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH 2/2] batctl: Explicitly mark the common
	header structure
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

On Sunday, November 20, 2011 22:47:39 Sven Eckelmann wrote:
> All batman-adv packets have a common 3 byte header. It can be used to share
> some code between different code paths, but it was never explicit stated
> that this header has to be always the same for all packets. Therefore, new
> code changes always have the problem that they may accidently introduce
> regressions by moving some elements around.
> 
> A new structure is introduced that contains the common header and makes it
> easier visible that these 3 bytes have to be the same for all on-wire
> packets.

Applied in revision 4c81da2.

Thanks,
Marek

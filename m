Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Thu, 18 Oct 2012 01:56:28 +0800
References: <1350478385-676-1-git-send-email-linus.luessing@web.de>
 <1350478385-676-2-git-send-email-linus.luessing@web.de>
 <20121017141705.GA30441@pandem0nium>
In-Reply-To: <20121017141705.GA30441@pandem0nium>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201210180156.28869.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCHv2 2/2] batman-adv: Fix potential
	broadcast BLA-duplicate-check race condition
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

On Wednesday, October 17, 2012 22:17:05 Simon Wunderlich wrote:
> Looks good, although I don't think this will happen very often - it
> is only called when receiving packets, and AFAIK there can only be
> multiple threads when using multiple interfaces.
> 
> Anyway, doing the spinlock shouldn't hurt and might save us some pain
> when this function is used more often, or with multiple interfaces, or
> cases I don't see now. :)
> 
> Acked-by: Simon Wunderlich <siwu@hrz.tu-chemnitz.de>

Applied in revision 4c1721b.

Thanks,
Marek

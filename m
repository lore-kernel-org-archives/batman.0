Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Tue, 17 Jul 2012 12:43:52 +0200
References: <1341524310-26740-1-git-send-email-ordex@autistici.org>
 <1341524310-26740-2-git-send-email-ordex@autistici.org>
In-Reply-To: <1341524310-26740-2-git-send-email-ordex@autistici.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201207171243.52926.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCHv5 3/3] batman-adv: change interface_rx to
	get orig node
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

On Thursday, July 05, 2012 23:38:30 Antonio Quartulli wrote:
> In order to understand  where a broadcast packet is coming from and use
> this information to detect not yet announced clients, this patch modifies
> the interface_rx() function by passing a new argument: the orig node
> corresponding to the node that originated the received packet (if known).
> This new argument if not NULL for broadcast packets only (other packets
> does not have source field).
> 
> Signed-off-by: Antonio Quartulli <ordex@autistici.org>
> ---
> 
> Changes since v4:
>  - noop
> 
>  routing.c        |   10 ++++++----
>  soft-interface.c |    6 +++++-
>  soft-interface.h |    5 +++--
>  3 files changed, 14 insertions(+), 7 deletions(-)

Applied in revision 9cbc67d.

Thanks,
Marek

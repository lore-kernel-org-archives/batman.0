Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Fri, 22 Jun 2012 20:09:00 +0200
References: <20120618104108.GA17473@sven-atom.home.narfation.org>
	<1340037566-24081-1-git-send-email-siwu@hrz.tu-chemnitz.de>
In-Reply-To: <1340037566-24081-1-git-send-email-siwu@hrz.tu-chemnitz.de>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201206222009.01365.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCHv5] batman-adv: Add the backbone gateway
	list to debugfs
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

On Monday, June 18, 2012 18:39:26 Simon Wunderlich wrote:
> This is especially useful if there are no claims yet, but we still want
> to know which gateways are using bridge loop avoidance in the network.
> 
> Signed-off-by: Simon Wunderlich <siwu@hrz.tu-chemnitz.de>
> ---
> [EDITv2: forgot to rename the function ...]
> [EDITv3: add README entry]
> [EDITv4: fix style]
> [EDITv5: some more style fixes]
> ---
>  README                  |    7 ++---
>  bridge_loop_avoidance.c |   65
> +++++++++++++++++++++++++++++++++++++++++++++++ bridge_loop_avoidance.h
> |    8 ++++++
>  debugfs.c               |   12 +++++++++
>  4 files changed, 89 insertions(+), 3 deletions(-)

Applied in revision 500ab9a.

Thanks,
Marek

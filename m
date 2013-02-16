Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Sat, 16 Feb 2013 17:11:01 +0800
References: <201302111710.04911.lindner_marek@yahoo.de>
 <1360573828-24399-1-git-send-email-lindner_marek@yahoo.de>
In-Reply-To: <1360573828-24399-1-git-send-email-lindner_marek@yahoo.de>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201302161711.02194.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCHv3 1/6] batman-adv: Move soft-interface
	initialization to ndo_init
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
Cc: Sven Eckelmann <sven@narfation.org>

On Monday, February 11, 2013 17:10:22 Marek Lindner wrote:
> From: Sven Eckelmann <sven@narfation.org>
> 
> The initialization of an net_device object should be done in the
> init/constructor function and not from the outside after the
> register_netdevice was done to avoid race conditions.
> 
> Signed-off-by: Sven Eckelmann <sven@narfation.org>
> ---
>  hard-interface.c |    5 ++
>  soft-interface.c |  169
> ++++++++++++++++++++++++++---------------------------- 2 files changed, 86
> insertions(+), 88 deletions(-)

Applied in revision 03522f0.

Thanks,
Marek

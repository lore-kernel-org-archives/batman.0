Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Sun, 3 Jan 2010 03:26:02 +0800
References: <20091231033752.GA18781@Sellars>
In-Reply-To: <20091231033752.GA18781@Sellars>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <201001030326.02365.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH 1/3] batman-adv: atomic variable for
	vis-srv activation
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.net>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.net>
List-Unsubscribe: <https://lists.open-mesh.net/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.net/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.net>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=help>
List-Subscribe: <https://lists.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.net>


Hi,

> This fixes the bug discovered by Marek which did not allow turning on
> the vis-server before an interface has been added. This is now being
> done in a similar way as for (de)activating the aggregation mode with an
> atomic variable.

great that you work on this!  :)

I'm no expert on the vis code but here my 2 cents:
* You hard-coded integer values instead of using the existing defines. Any 
reason for that ?
* my_vis_info->packet.vis_type never gets updated ?
* This patch removes functionality from the /proc parsing function although 
this is not related to the patch-topic. 
* checkpatch reports 8 errors & 8 warnings

Regards,
Marek

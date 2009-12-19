Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Sun, 20 Dec 2009 01:01:55 +0800
References: <20091130211445.GN4150@lunn.ch>
In-Reply-To: <20091130211445.GN4150@lunn.ch>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <200912200101.55746.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] /proc vis rework
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


Hey,

> A while back i suggested we re-work the /proc/net/batman/vis format.
> Attached are two patches to achieve this. One patch is for the kernel
> model sources and the second extends batctl so that it can read from
> the /proc file and output dot or json format as before. The patch
> includes documentation for the new new batctl command in the man page.

I reviewed the patches & fixed some issues:
* vis raw data (kernel): I upgraded the patch to make it apply on the latest 
trunk and added a descriptive commit message
* vis raw data (batctl): I did not change anything but I'd like to suggest we 
adapt the coding style to match the rest of batctl (maybe using Lindent?). 
Also, all other batctl modules follow the same behaviour regarding the "-h" 
option. To be consistent we may want to adapt that as well.
* vis_format remove: This patch removed the vis_format initializations but not 
the corresponding free calls. I fixed that.
* I added an additional patch (splitting /proc vis file into vis_server and 
vis_data) to follow the roadmap we layed out in Brussels.
* Last but not least: the mandatory batctl vis data path change

Please give it some more testing,
Marek

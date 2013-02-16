Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Sat, 16 Feb 2013 17:20:41 +0800
References: <201302111710.04911.lindner_marek@yahoo.de>
 <1360573828-24399-1-git-send-email-lindner_marek@yahoo.de>
 <1360573828-24399-6-git-send-email-lindner_marek@yahoo.de>
In-Reply-To: <1360573828-24399-6-git-send-email-lindner_marek@yahoo.de>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201302161720.42144.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCHv3 6/6] batman-adv: Allow to modify slaves
	of soft-interfaces through rntl_link
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

On Monday, February 11, 2013 17:10:27 Marek Lindner wrote:
> From: Sven Eckelmann <sven@narfation.org>
> 
> The sysfs configuration interface of batman-adv to add/remove slaves of an
> soft-iface is not deadlock free and doesn't follow the currently common way
> to modify slaves of an interface.
> 
> An additional configuration interface though rtnl_link is introduced which
> provides easy device adding/removing with tools like "ip":
> $ ip link set dev eth0 master bat0
> $ ip link set dev eth0 nomaster
> 
> Signed-off-by: Sven Eckelmann <sven@narfation.org>
> ---
>  compat.h         |    3 +++
>  hard-interface.c |   11 +++++++++--
>  soft-interface.c |   56
> +++++++++++++++++++++++++++++++++++++++++++++++++++++- 3 files changed, 67
> insertions(+), 3 deletions(-)

Applied in revision edd0853.

Thanks,
Marek

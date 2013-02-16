Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Sat, 16 Feb 2013 17:18:44 +0800
References: <201302111710.04911.lindner_marek@yahoo.de>
 <1360573828-24399-1-git-send-email-lindner_marek@yahoo.de>
 <1360573828-24399-5-git-send-email-lindner_marek@yahoo.de>
In-Reply-To: <1360573828-24399-5-git-send-email-lindner_marek@yahoo.de>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201302161718.44571.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCHv3 5/6] batman-adv: Allow to use rntl_link
	for device creation/deletion
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

On Monday, February 11, 2013 17:10:26 Marek Lindner wrote:
> From: Sven Eckelmann <sven@narfation.org>
> 
> The sysfs configuration interface of batman-adv to add/remove
> soft-interfaces is not deadlock free and doesn't follow the currently
> common way to create new virtual interfaces.
> 
> An additional interface though rtnl_link is introduced which provides easy
> device creation/deletion with tools like "ip":
> 
> $ ip link add dev bat0 type batadv
> $ ip link del dev bat0
> 
> Signed-off-by: Sven Eckelmann <sven@narfation.org>
> ---
>  main.c           |    2 ++
>  main.h           |    1 +
>  soft-interface.c |   29 +++++++++++++++++++++++++++++
>  soft-interface.h |    1 +
>  4 files changed, 33 insertions(+)

Applied in revision 5317331.

Thanks,
Marek

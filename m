Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Sat, 16 Feb 2013 17:15:22 +0800
References: <201302111710.04911.lindner_marek@yahoo.de>
 <1360573828-24399-1-git-send-email-lindner_marek@yahoo.de>
 <1360573828-24399-3-git-send-email-lindner_marek@yahoo.de>
In-Reply-To: <1360573828-24399-3-git-send-email-lindner_marek@yahoo.de>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201302161715.22428.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCHv3 3/6] batman-adv: Don't always delete
	softif when last slave was removed
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

On Monday, February 11, 2013 17:10:24 Marek Lindner wrote:
> From: Sven Eckelmann <sven@narfation.org>
> 
> batman-adv has an unusual way to manage softinterfaces. These will be
> created automatically when a user writes to the batman-adv/mesh_iface file
> in sysfs and removed when no slave device exists anymore.
> 
> This behaviour cannot be changed without breaking compatibility with
> existing code. Instead other interfaces should be able to slightly reduce
> this behaviour and provide a more common reaction to a removal of a slave
> interface.
> 
> Signed-off-by: Sven Eckelmann <sven@narfation.org>
> ---
>  hard-interface.c |    8 +++++---
>  hard-interface.h |   13 ++++++++++++-
>  sysfs.c          |    6 ++++--
>  3 files changed, 21 insertions(+), 6 deletions(-)

Applied in revision c3c7e74.

Thanks,
Marek

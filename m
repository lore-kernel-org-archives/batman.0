Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Wed, 27 Feb 2013 14:28:07 +0800
References: <1361022160-25693-1-git-send-email-ordex@autistici.org>
In-Reply-To: <1361022160-25693-1-git-send-email-ordex@autistici.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201302271428.07984.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCHv3 1/2] batman-adv: free an hard-interface
	before adding it
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

On Saturday, February 16, 2013 21:42:39 Antonio Quartulli wrote:
> When adding a new hard interface (e.h. wlan0) to a soft interface (e.g.
> bat0) and the former is already enslaved in another virtual interface
> (e.g. a software bridge) batman-adv has to free the it first and then
> continue with the adding mechanism.
> 
> In this way the behaviour becomes consistent with what "ip link set master"
> does. At the moment batman-adv enslaves the hard interface without checking
> for the master device, possibly causing strange behaviours which are never
> wanted by the users.
> 
> Reported-by: Marek Lindner <lindner_marek@yahoo.de>
> Signed-off-by: Antonio Quartulli <ordex@autistici.org>
> ---
> v2:
>  - added compat code for netdev_master_upper_dev_get()
> v3:
>  - use #define instead of a static inline function in compat code
> 
>  compat.h         |  5 +++++
>  hard-interface.c | 14 ++++++++------
>  2 files changed, 13 insertions(+), 6 deletions(-)

Applied in revision 5e57e3b.

Thanks,
Marek

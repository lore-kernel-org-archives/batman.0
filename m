Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Wed, 3 Jul 2013 18:19:05 +0800
References: <1372755876-3969-1-git-send-email-ordex@autistici.org>
 <1372755876-3969-3-git-send-email-ordex@autistici.org>
In-Reply-To: <1372755876-3969-3-git-send-email-ordex@autistici.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201307031819.05516.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCHv11 2/3] batman-adv: add sysfs framework
	for VLAN
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
Cc: Antonio Quartulli <antonio@open-mesh.com>, Antonio Quartulli <ordex@autistici.org>

On Tuesday, July 02, 2013 17:04:35 Antonio Quartulli wrote:
> From: Antonio Quartulli <antonio@open-mesh.com>
> 
> Each VLAN can now have its own set of attributes.
> Export them through a new subfolder in the sysfs tree.
> Each VLAN created on top of a soft_iface will have its own
> subfolder.
> 
> The subfolder is named "vlan%VID" and it is created inside
> the "mesh" sysfs folder belonging to batman-adv.
> 
> Attributes corresponding to the untagged LAN are stored in
> the root sysfs folder as before.
> 
> Create all the needed macros and data structures to easily
> handle new VLAN spacific attributes.
> 
> Signed-off-by: Antonio Quartulli <antonio@open-mesh.com>
> ---
>  soft-interface.c |  13 ++++-
>  soft-interface.h |   3 +
>  sysfs.c          | 173
> +++++++++++++++++++++++++++++++++++++++++++++++++++++++
> sysfs.h          |  10 ++++
>  4 files changed, 196 insertions(+), 3 deletions(-)

Applied in revision e4ff5c1.

Thanks,
Marek

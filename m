Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Wed, 3 Jul 2013 18:21:21 +0800
References: <1372755876-3969-1-git-send-email-ordex@autistici.org>
 <1372755876-3969-4-git-send-email-ordex@autistici.org>
In-Reply-To: <1372755876-3969-4-git-send-email-ordex@autistici.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201307031821.21920.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCHv11 3/3] batman-adv: make the AP isolation
	attribute VLAN specific
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

On Tuesday, July 02, 2013 17:04:36 Antonio Quartulli wrote:
> From: Antonio Quartulli <antonio@open-mesh.com>
> 
> AP isolation has to be enabled on one VLAN interface only.
> This patch moves the AP isolation attribute to the per-vlan
> interface attribute set, enabling it to have a different
> value depending on the selected vlan.
> 
> Signed-off-by: Antonio Quartulli <antonio@open-mesh.com>
> ---
>  soft-interface.c     |  5 +++--
>  sysfs-class-net-mesh |  5 +++--
>  sysfs.c              |  5 +++--
>  translation-table.c  | 27 ++++++++++++++++++++-------
>  translation-table.h  |  2 +-
>  types.h              |  4 ++--
>  6 files changed, 32 insertions(+), 16 deletions(-)

Applied in revision b8160b9.

Thanks,
Marek

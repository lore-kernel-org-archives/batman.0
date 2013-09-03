Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Tue, 3 Sep 2013 16:47:57 +0800
References: <1378116909-551-1-git-send-email-ordex@autistici.org>
 <1378116909-551-2-git-send-email-ordex@autistici.org>
In-Reply-To: <1378116909-551-2-git-send-email-ordex@autistici.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201309031647.57498.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCHv7 1/9] batman-adv: make struct
	batadv_neigh_node algorithm agnostic
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

On Monday, September 02, 2013 18:15:01 Antonio Quartulli wrote:
> From: Antonio Quartulli <antonio@open-mesh.com>
> 
> some of the fields in struct batadv_neigh_node are strictly
> related to the B.A.T.M.A.N. IV algorithm. In order to
> make the struct usable by any routing algorithm it has to be
> split and made more generic
> 
> Signed-off-by: Antonio Quartulli <antonio@open-mesh.com>
> ---
>  bat_iv_ogm.c        | 60
> +++++++++++++++++++++++++++++------------------------
> gateway_client.c    | 16 +++++++-------
>  network-coding.c    |  8 ++++---
>  originator.c        | 33 +++++++++++++++++++----------
>  originator.h        |  3 ++-
>  routing.c           |  9 +++++---
>  translation-table.c |  4 ++--
>  types.h             | 41 ++++++++++++++++++++++--------------
>  8 files changed, 103 insertions(+), 71 deletions(-)

Applied in revision c82dc0d.

Thanks,
Marek

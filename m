Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Wed, 24 Apr 2013 22:28:18 +0800
References: <1366724403-29629-1-git-send-email-lindner_marek@yahoo.de>
 <1366724403-29629-5-git-send-email-lindner_marek@yahoo.de>
In-Reply-To: <1366724403-29629-5-git-send-email-lindner_marek@yahoo.de>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201304242228.18264.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCHv2 4/7] batman-adv: tvlv - add network
	coding container
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
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

On Tuesday, April 23, 2013 21:40:00 Marek Lindner wrote:
> Create network coding container to announce network coding
> capabilities (if enabled).
> 
> Signed-off-by: Marek Lindner <lindner_marek@yahoo.de>
> ---
>  network-coding.c |   63
> ++++++++++++++++++++++++++++++++++++++++++++++++++++++ network-coding.h
> |    6 ++++++
>  packet.h         |    2 ++
>  sysfs.c          |    4 +++-
>  types.h          |    2 ++
>  5 files changed, 76 insertions(+), 1 deletion(-)

Applied in revision 7dd9d89.

Regards,
Marek

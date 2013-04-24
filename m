Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Wed, 24 Apr 2013 22:22:22 +0800
References: <1366724403-29629-1-git-send-email-lindner_marek@yahoo.de>
 <1366724403-29629-2-git-send-email-lindner_marek@yahoo.de>
In-Reply-To: <1366724403-29629-2-git-send-email-lindner_marek@yahoo.de>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201304242222.22628.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCHv2 1/7] batman-adv: tvlv - basic
	infrastructure
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

On Tuesday, April 23, 2013 21:39:57 Marek Lindner wrote:
> The goal is to provide the infrastructure for sending, receiving and
> parsing information 'containers' while preserving backward
> compatibility. TVLV (based on the commonly known Type Length Value
> technique) was chosen as the format for those containers. Even if a
> node does not know the tvlv type of a certain container it can simply
> skip the current container and proceed with the next. Past experience
> has shown features evolve over time, so a 'version' field was added
> right from the start to allow differentiating between feature
> variants - hence the name: T(ype) V(ersion) L(ength) V(alue).
> 
> This patch introduces the basic TVLV infrastructure:
>  * register / unregister tvlv containers to be sent with each OGM
>    (on primary interfaces only)
>  * register / unregister callback handlers to be called upon
>    finding the corresponding tvlv type in a tvlv buffer
>  * unicast tvlv send / receive API calls
> 
> Signed-off-by: Marek Lindner <lindner_marek@yahoo.de>
> Signed-off-by: Spyros Gasteratos <morfeas3000@gmail.com>
> ---
>  bat_iv_ogm.c |   38 ++--
>  compat.c     |    8 +
>  compat.h     |    1 +
>  main.c       |  620
> ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
> main.h       |   35 ++++
>  packet.h     |   67 +++++++
>  routing.c    |   48 +++++
>  routing.h    |    2 +
>  types.h      |   73 +++++++
>  9 files changed, 875 insertions(+), 17 deletions(-)

Applied in revision 0b6aa0d.

Thanks,
Marek

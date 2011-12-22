Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Thu, 22 Dec 2011 20:20:41 +0800
References: <1323537357-9116-1-git-send-email-lindner_marek@yahoo.de>
	<1323537357-9116-2-git-send-email-lindner_marek@yahoo.de>
In-Reply-To: <1323537357-9116-2-git-send-email-lindner_marek@yahoo.de>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201112222020.41960.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCHv2 1/4] batman-adv: add infrastructure to
	change routing algorithm at runtime
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

On Sunday, December 11, 2011 01:15:54 Marek Lindner wrote:
> Signed-off-by: Marek Lindner <lindner_marek@yahoo.de>
> ---
>  bat_algo.h       |   27 ++++++++++++++++++++
>  bat_debugfs.c    |   23 +++++++++++++++++
>  bat_iv_ogm.c     |   10 +++++++
>  main.c           |   72
> ++++++++++++++++++++++++++++++++++++++++++++++++++++++
> main.h           |    4 +++
>  soft-interface.c |    4 +++
>  types.h          |    6 ++++
>  7 files changed, 146 insertions(+), 0 deletions(-)
>  create mode 100644 bat_algo.h

Applied in revision 27fa916.

Regards,
Marek

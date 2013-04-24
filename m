Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Wed, 24 Apr 2013 22:25:20 +0800
References: <1366724403-29629-1-git-send-email-lindner_marek@yahoo.de>
 <1366724403-29629-3-git-send-email-lindner_marek@yahoo.de>
In-Reply-To: <1366724403-29629-3-git-send-email-lindner_marek@yahoo.de>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201304242225.20881.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCHv2 2/7] batman-adv: tvlv - gateway
	download/upload bandwidth container
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

On Tuesday, April 23, 2013 21:39:58 Marek Lindner wrote:
> Prior to this patch batman-adv read the advertised uplink bandwidth
> from userspace and compressed this information into a single byte
> called "gateway class".
> Now the download & upload bandwidth information is sent as-is. No
> userspace change is necessary since the sysfs API always allowed
> to specify a bandwidth.
> 
> Signed-off-by: Marek Lindner <lindner_marek@yahoo.de>
> Signed-off-by: Spyros Gasteratos <morfeas3000@gmail.com>
> ---
>  bat_iv_ogm.c     |   23 +-----
>  gateway_client.c |  185 +++++++++++++++++++++++++++----------------
>  gateway_client.h |    2 +-
>  gateway_common.c |  232
> +++++++++++++++++++++++++++++++++++------------------- gateway_common.h
> |   14 +++-
>  main.c           |    7 ++
>  originator.c     |    4 +-
>  packet.h         |   21 ++++-
>  soft-interface.c |    3 +-
>  sysfs.c          |   17 ++--
>  types.h          |   12 ++-
>  11 files changed, 329 insertions(+), 191 deletions(-)

Applied in revision 0853ec7.

Regards,
Marek

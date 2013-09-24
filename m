Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Wed, 25 Sep 2013 00:17:50 +0800
Message-ID: <3176371.DjJ7IUOPmW@diderot>
In-Reply-To: <1376930399-1043-1-git-send-email-ordex@autistici.org>
References: <1376930399-1043-1-git-send-email-ordex@autistici.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: send GW_DEL event in case of
	soft-iface destruction
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

On Monday 19 August 2013 18:39:59 Antonio Quartulli wrote:
> From: Antonio Quartulli <antonio@open-mesh.com>
> 
> In case of soft_iface destruction send a GW DEL event to
> userspace so that applications which are listening for GW
> events are informed about the lost of connectivity and can
> react accordingly.
> 
> Signed-off-by: Antonio Quartulli <antonio@open-mesh.com>
> ---
>  hard-interface.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)

Applied in revision e65bb36.

Thanks,
Marek


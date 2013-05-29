Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Wed, 29 May 2013 15:41:21 +0800
References: <1369644920-1023-1-git-send-email-ordex@autistici.org>
In-Reply-To: <1369644920-1023-1-git-send-email-ordex@autistici.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201305291541.21214.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH] batctl: create common header for ICMP
	packets
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

On Monday, May 27, 2013 16:55:20 Antonio Quartulli wrote:
>  ping.c       | 24 ++++++++++++++----------
>  tcpdump.c    | 27 +++++++++++++++++----------
>  traceroute.c | 31 +++++++++++++++++++------------
>  3 files changed, 50 insertions(+), 32 deletions(-)

How about adding the packet.h changes to this patch ? That would make the code 
compile.  :)

Cheers,
Marek

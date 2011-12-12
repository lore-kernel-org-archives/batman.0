Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Mon, 12 Dec 2011 18:44:17 +0800
References: <4EE36653.4000504@gmail.com>
	<1323527316-15071-1-git-send-email-sven@narfation.org>
In-Reply-To: <1323527316-15071-1-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201112121844.17891.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCHv2 1/3] batman-adv: bat_socket_read
	missing checks
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

On Saturday, December 10, 2011 22:28:34 Sven Eckelmann wrote:
> From: Paul Kot <pawlkt@gmail.com>
> 
> Writing a icmp_packet_rr and then reading icmp_packet can lead to kernel
> memory corruption, if __user *buf is just below TASK_SIZE.
> 
> Signed-off-by: Paul Kot <pawlkt@gmail.com>
> [sven@narfation.org: made it checkpatch clean]
> Signed-off-by: Sven Eckelmann <sven@narfation.org>

Applied in revision 2013715.

Thanks,
Marek
